Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262311AbVAUIXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262311AbVAUIXE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 03:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbVAUIXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 03:23:03 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:19699 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262311AbVAUIWs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 03:22:48 -0500
Message-ID: <41F0BBD5.1010006@mvista.com>
Date: Fri, 21 Jan 2005 00:22:45 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       matthias@corelatus.se,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: patch to fix set_itimer() behaviour in boundary cases
References: <16872.55357.771948.196757@antilipe.corelatus.se>	 <20050115013013.1b3af366.akpm@osdl.org>	 <1105830384.16028.11.camel@localhost.localdomain>	 <1105877497.8462.0.camel@laptopd505.fenrus.org>	 <41EEF284.2010600@mvista.com>	 <1106208433.4192.0.camel@laptopd505.fenrus.org>	 <41F03AD2.4010803@mvista.com> <1106293769.4182.64.camel@laptopd505.fenrus.org>
In-Reply-To: <1106293769.4182.64.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>>>This one I meant to fix in the kernel fwiw; we can put that loop inside
>>>the kernel easily I'm sure
>>
>>Yes, but it will increase the data size of the timer...
>>
> 
> 
> eh how?
> the way I think it can be done is to just have multiple timers fire
> until the total time is up. It's not a performance issue (a timer firing
> every 24 days.. who cares, esp since such long delays are rare anyway)
> after all...

Sure that works, but you still need to keep info around on when the timer is 
supposed to expire.  This will be at least two words (u64)jiffies_expire_time. 
This would likly end up in the task struc along with the timer itself.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

