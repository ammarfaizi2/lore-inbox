Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261933AbUCLEY7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 23:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbUCLEY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 23:24:59 -0500
Received: from mail-09.iinet.net.au ([203.59.3.41]:37298 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261933AbUCLEY5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 23:24:57 -0500
Message-ID: <40513B8B.9010301@cyberone.com.au>
Date: Fri, 12 Mar 2004 15:24:43 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: "Nakajima, Jun" <jun.nakajima@intel.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1
References: <7F740D512C7C1046AB53446D37200173FEB851@scsmsx402.sc.intel.com> <20040312031452.GA41598@colin2.muc.de>
In-Reply-To: <20040312031452.GA41598@colin2.muc.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andi Kleen wrote:

>On Thu, Mar 11, 2004 at 07:04:50PM -0800, Nakajima, Jun wrote:
>
>>As we can have more complex architectures in the future, the scheduler
>>is flexible enough to represent various scheduling domains effectively,
>>and yet keeps the common scheduler code simple.
>>
>
>I think for SMT alone it's too complex and for NUMA it doesn't do
>the right thing for "modern NUMAs" (where NUMA factor is very low
>and you have a small number of CPUs for each node). 
>
>

For SMT it is a less complex than shared runqueues, it is actually
less lines of code and smaller object size.

It is also more flexible than shared runqueues in that you can still
have control over each sibling's runqueue. Con's SMT nice patch for
example would probably be more difficult to do with shared runqueues.
Shared runqueues also gives zero affinity to siblings. While current
implementations may not (do they?) care, future ones might.

For Opteron type NUMA, it actually balances much more aggressively
than the default NUMA scheduler, especially when a CPU is idle. I
don't doubt you aren't seeing great performance, but it should be
able to be fixed.

The problem is just presumably your lack of time to investigate
further, and my lack of problem descriptions or Opterons.

One thing you definitely want is a sched_balance_fork, is that right?
Have you been able to do any benchmarks on recent -mm kernels?

