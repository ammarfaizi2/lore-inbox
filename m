Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbUABAwm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 19:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbUABAwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 19:52:42 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:50056 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262055AbUABAwf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 19:52:35 -0500
Message-ID: <3FF4C0B7.30308@colorfullife.com>
Date: Fri, 02 Jan 2004 01:52:07 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: linux-kernel@vger.kernel.org, rusty@au1.ibm.com,
       lhcs-devel@lists.sourceforge.net
Subject: Re: [lhcs-devel] Re: in_atomic doesn't count local_irq_disable?
References: <3FF044A2.3050503@colorfullife.com> <20031230185615.A9292@in.ibm.com> <20031231190553.B9041@in.ibm.com>
In-Reply-To: <20031231190553.B9041@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:

>More debugging reveals that the page fault happens
>always while doing a prefetch. The prefetch is
>present inside list_for_each_entry macros.
>
>For now I have disabled the x86 prefetch function
>to do nothing.
>
>The test seems to run fine so far w/o any of the 
>page faults I was experiencing. Will update
>at the end of the overnight run if I hit the problem again.
>
>Wonder if prefetch has some issues on Intel x86 (P3) SMP systems?
>  
>
Hmm. Perhaps prefetch updates CR2?
We know already that the CR2 is not directly linked to the page fault 
interrupt - if a page fault happens at the same time as a higher 
priority event (iirc hw interrupt), then CR2 is updated and the higher 
priority event is handled. That prevents Linux from using CR2 to store 
the cpu number - only netware can do that, because netware never causes 
paging faults.

Could you write a test module that reads cr2, executes a few prefetch 
instructions and then checks if cr2 changed? I won't have access to my 
P3 SMP system in the next few days.

--
    Manfred


