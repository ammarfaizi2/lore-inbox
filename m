Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbTJ2UnI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 15:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbTJ2UnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 15:43:08 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:41467 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261601AbTJ2UnE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 15:43:04 -0500
Message-ID: <3FA0264B.4080505@mvista.com>
Date: Wed, 29 Oct 2003 12:42:51 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Patrick Mochel <mochel@osdl.org>, John stultz <johnstul@us.ibm.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [pm] fix time after suspend-to-*
References: <Pine.LNX.4.44.0310271535160.13116-100000@cherise> <1067329994.861.3.camel@teapot.felipe-alfaro.com> <20031028093233.GA1253@elf.ucw.cz> <1067351431.1358.11.camel@teapot.felipe-alfaro.com> <20031028172818.GB2307@elf.ucw.cz> <1067372182.864.11.camel@teapot.felipe-alfaro.com> <20031029093802.GA757@elf.ucw.cz>
In-Reply-To: <20031029093802.GA757@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 
>>>You are not asking userspace whether to reboot or not, and you should
>>>not ask them about suspend, either.
>>
>>OK, so how should the system behave when a real-time-like process is
>>running? I talked about the CD burning example. Should the kernel simply
>>ignore the process and suspend?
> 
> 
> Yes.
> 
> 
>>>>1. Network connections must be reestablished. A userspace program can't
>>>>try to automatically reestablish a broken TCP connection for no apparent
>>>>reason. A broken TCP connection could be the cause of an overloaded or
>>>>broken server/service. If we do not inform userspace processes that the
>>>>system is going to sleep (or that the system has been brought up from
>>>>standby), they will blindly try to restore TCP connections back, even
>>>>when the remote server is broken, generating a lot of unnecesary
>>>>traffic.
>>>
>>>gettimeofday(), if I slept for too long, oops, something strange
>>>happened (maybe there was heavy io load and I was swapped out? or
>>>suspend? Did machine sleep for 20 minutes in cli?) try to reconnect.
>>
>>Does "gettimeofday()" have into account the effect of adjusting the time
>>twice a year, once to make time roll forward one hour and another one to
>>roll it back?
> 
> 
> Not sure how it is supposed to work, but here I just have ntpd
> step-setting by one hour...

It is really a time zone change....

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

