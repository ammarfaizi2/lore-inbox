Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbUDHMVI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 08:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbUDHMVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 08:21:08 -0400
Received: from mail3.codesense.com ([213.132.104.154]:57526 "EHLO
	mail3.codesense.com") by vger.kernel.org with ESMTP id S261693AbUDHMVA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 08:21:00 -0400
Subject: Re: Failing back to INSANE timesource :) Time stopped today.
From: Niclas Gustafsson <niclas.gustafsson@codesense.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1081416100.6425.45.camel@gmg.codesense.com>
References: <1081416100.6425.45.camel@gmg.codesense.com>
Content-Type: text/plain
Message-Id: <1081426855.6425.64.camel@gmg.codesense.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 08 Apr 2004 14:20:56 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running multiple date commands ( ~ 1s apart ), shows that something is
going on...

[root@s151 root]# date "+%X %N"
03:51:21 AM 262889000
[root@s151 root]# date "+%X %N"
03:51:21 AM 263185000
[root@s151 root]# date "+%X %N"
03:51:21 AM 262383000
[root@s151 root]# date "+%X %N"
03:51:21 AM 263328000
[root@s151 root]# date "+%X %N"
03:51:21 AM 263237000
[root@s151 root]# date "+%X %N"
03:51:21 AM 263049000
[root@s151 root]# date "+%X %N"
03:51:21 AM 262941000


... And a couple of hours later:

[root@s151 root]# date "+%X  %N"
03:51:21 AM  348003000

Regards,

Niclas

tor 2004-04-08 klockan 11.21 skrev Niclas Gustafsson:
> Hi,
> 
> I'm running Linux 2.6.5  on a IBM xSeries 305 with a Intel P4 2.8Ghz.
> 
> And something is very very wrong, I'm getting the following last
> messages in dmesg:
> 
> ------
> set_rtc_mmss: can't update from 52 to 0
> set_rtc_mmss: can't update from 53 to 1
> set_rtc_mmss: can't update from 54 to 2
> set_rtc_mmss: can't update from 55 to 3
> set_rtc_mmss: can't update from 56 to 4
> set_rtc_mmss: can't update from 57 to 5
> set_rtc_mmss: can't update from 58 to 6
> Losing too many ticks!
> TSC cannot be used as a timesource.  <4>Possible reasons for this are:
>   You're running with Speedstep,
>   You don't have DMA enabled for your hard disk (see hdparm),
>   Incorrect TSC synchronization on an SMP system (see dmesg).
> ------
> 
> The problem seesm to be related to heavy loads.
> I experienced a similar problem yesterday. The machine completly hung
> after that and i had to cut the power to reboot it. Now however it is
> responsive and I can log on to it through ssh.
> 
> Problem is that the clock stopped completly! - I've never seen anything
> like this before. 
> 
> Local time is about 11 am here and a time gives me:
> 
> [root@s151 root]# date
> Thu Apr  8 03:51:21 CEST 2004
> 
> ...10 s later, using my wristwatch, not sleep 10 ;)
> 
> [root@s151 root]# date
> Thu Apr  8 03:51:21 CEST 2004
> 
> 
> Any ideas anyone, I'd really like to know why it is behaving this way.
> 
> 
> Other usful(?) info from dmesg:
> ---
> Detected 2800.731 MHz processor.
> Using tsc for high-res timesource
> ...
> init IO_APIC IRQs
>  IO-APIC (apicid-pin) 1-0, 2-0, 2-1, 2-2, 2-3, 2-4, 2-5, 2-6, 2-7, 2-8,
> 2-9, 2-10, 2-11, 2-12, 2-13, 2-14, 2-15, 3-0, 3-1, 3-2, 3-3, 3-4, 3-5,
> 3-6, 3-7, 3-8, 3-9, 3-10, 3-11, 3-12, 3-13, 3-14, 3-15 not connected.
> ..TIMER: vector=0x31 pin1=2 pin2=-1
> ..MP-BIOS bug: 8254 timer not connected to IO-APIC
> ...trying to set up timer (IRQ0) through the 8259A ...  failed.
> ...trying to set up timer as Virtual Wire IRQ... works.
> Using local APIC timer interrupts.
> calibrating APIC timer ...
> ..... CPU clock speed is 2798.0750 MHz.
> ...
> ----
> 
> Oh, yeah, I'm running NTP on the machine, however the client seems to be
> sleeping for the next time-poll.
> I'm also using this machine as a ntp server and one client has the
> following to say:
> 
> [root@s131 tmp]# ntpdc
> ntpdc> peers
>      remote           local      st poll reach  delay   offset    disp
> =======================================================================
> *time2 192.168.4.131  2 1024  377 0.00067  0.004991 0.01482
> =time1 192.168.4.131  2 1024  377 0.00085  0.000558 0.01485
> =s151  192.168.4.131  3 1024  377 0.00021 -25494.16 0.01482
> 
> Where s151 is the machine that is on freeze.
> 
> 
> 
> Cheers,
> 
> Niclas
> 
> 
> 
> 
> 

