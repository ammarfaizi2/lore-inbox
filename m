Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbTJ1V36 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 16:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbTJ1V35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 16:29:57 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:54771 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261598AbTJ1V3z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 16:29:55 -0500
Message-ID: <3F9EDFCB.4090107@mvista.com>
Date: Tue, 28 Oct 2003 13:29:47 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
CC: Pavel Machek <pavel@suse.cz>, Patrick Mochel <mochel@osdl.org>,
       John stultz <johnstul@us.ibm.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [pm] fix time after suspend-to-*
References: <Pine.LNX.4.44.0310271535160.13116-100000@cherise>	 <1067329994.861.3.camel@teapot.felipe-alfaro.com>	 <20031028093233.GA1253@elf.ucw.cz>	 <1067351431.1358.11.camel@teapot.felipe-alfaro.com>	 <20031028172818.GB2307@elf.ucw.cz> <1067372182.864.11.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1067372182.864.11.camel@teapot.felipe-alfaro.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana wrote:
> On Tue, 2003-10-28 at 18:28, Pavel Machek wrote:
> 
> 
>>You are not asking userspace whether to reboot or not, and you should
>>not ask them about suspend, either.
> 
> 
> OK, so how should the system behave when a real-time-like process is
> running? I talked about the CD burning example. Should the kernel simply
> ignore the process and suspend?
> 
> 
>>>1. Network connections must be reestablished. A userspace program can't
>>>try to automatically reestablish a broken TCP connection for no apparent
>>>reason. A broken TCP connection could be the cause of an overloaded or
>>>broken server/service. If we do not inform userspace processes that the
>>>system is going to sleep (or that the system has been brought up from
>>>standby), they will blindly try to restore TCP connections back, even
>>>when the remote server is broken, generating a lot of unnecesary
>>>traffic.
>>
>>gettimeofday(), if I slept for too long, oops, something strange
>>happened (maybe there was heavy io load and I was swapped out? or
>>suspend? Did machine sleep for 20 minutes in cli?) try to reconnect.
> 
> 
> Does "gettimeofday()" have into account the effect of adjusting the time
> twice a year, once to make time roll forward one hour and another one to
> roll it back?

Actually gettimeofday() does NOT do that.  It always returns GMT since 1970. 
The daylight savings thing is really a timezone shift, not a time shift.

My suggestion, which I admit may rely on a particular distro, is to define two 
new run levels.  One for going to sleep and one to wake up.  This is how the 
system boots and powers down already.  The new levels would allow applications 
which have special needs to put the proper notifier stuff in the runlevel 
directory, just as is done for boot/ shutdown.  It is this code which should 
tell the system to sleep, just as the shutdown run level shuts off the machine.
> 
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

