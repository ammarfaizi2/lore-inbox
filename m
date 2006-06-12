Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751752AbWFLKMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751752AbWFLKMU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 06:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751760AbWFLKMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 06:12:20 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:7441 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S1751752AbWFLKMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 06:12:18 -0400
In-Reply-To: <20060612095008.21733.qmail@www.wolff-online.nl>
References: <20060612095008.21733.qmail@www.wolff-online.nl>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <FEBBD28D-B00D-42DB-A2EB-13A501D7FBC2@oxley.org>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Felix Oxley <lkml@oxley.org>
Subject: Re: Good performance (hard realtime ??) on 2.6.16 patched with patch-2.6.16-rt29 from Ingo Molnar
Date: Mon, 12 Jun 2006 11:12:08 +0100
To: kernel@wolff-online.nl
X-Mailer: Apple Mail (2.750)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 12 Jun 2006, at 10:50, kernel@wolff-online.nl wrote:

> Hello,
> I have tested 2.6.16 patched with 2.6.16-rt29 on two ordinary boxes  
> (Dell PIII, 780 Mhz, IDE disks) connected back to back with  
> ethernet cross at 100Mbit, one broadcasting small udp messages  
> @50Hz, the other receiving those messages. Distro Mandriva 2006.0,  
> used .config from them.
> Conditions:
> * Sending and receiving process @RT priority, FIFO, prio 99
> * Sending box is almost idle, receiving box heavily loaded (cpu /  
> mem).
> * Watchdog/0 non RT (this setting is critical!)
> * IRQ from network card on RT prio, rx thread from softirq-net-rx  
> on RT prio (FIFO)
> * posix_cpu_timer on RT
> * kernel compiled without preemption debugging, complete realtime,  
> scheduler@100Hz
> * receiving process memory locked MCL_CURRENT|MCL_FUTURE
> * Heavily loaded (continuously compiling kernel, with 100 jobs in  
> parallel)
> I see following figures:
> max latency 512 microseconds on receiving box, during 24 hours of  
> heavily testing.
> ** this looks like hard realtime, am I correct, or is this  
> coincidence ?
> Thanks
> Carl.
>

Could you explain to me, in nice easy steps, how you got the  
measurement?
Specifically what triggered the 'start' of your time slice?
BTW, where you using hi resolution timers?
You say the max latency was 512usecs. What were the mean and mode?

(Regarding Hard Real Time, my understanding is that that depends on a  
_guarantee_ that the system will always be able to produce the  
'result' within the required interval. Ingo's -rt patches may give  
exceedingly good responsiveness but they offer no guarantees, so they  
cannot be considered Hard Real Time)

//felix
