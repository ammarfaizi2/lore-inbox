Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933006AbWKQRiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933006AbWKQRiQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 12:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933022AbWKQRiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 12:38:15 -0500
Received: from 147.175.241.83.in-addr.dgcsystems.net ([83.241.175.147]:14611
	"EHLO tmnt04.transmode.se") by vger.kernel.org with ESMTP
	id S933006AbWKQRiO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 12:38:14 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: FW: RTC , ds1307 I2C driver and NTP does not work.
Date: Fri, 17 Nov 2006 18:38:10 +0100
Message-ID: <F6AD7E21CDF4E145A44F61F43EE6D939AF4560@tmnt04.transmode.se>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RTC , ds1307 I2C driver and NTP does not work.
Thread-Index: AccKaXO6/3yGVZ/FQb2FrmWWT3t0yQAAZzJA
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: <linux-kernel@vger.kernel.org>
Cc: <i2c@lm-sensors.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

switching to kernel/i2c list, see below for details.

 Jocke 

-----Original Message-----
From: Kumar Gala [mailto:galak@kernel.crashing.org] 
Sent: 17 November 2006 17:57
To: Joakim Tjernlund
Cc: linuxppc-dev@ozlabs.org
Subject: Re: RTC , ds1307 I2C driver and NTP does not work.


On Nov 17, 2006, at 10:38 AM, Joakim Tjernlund wrote:

> I get this when I activathte NTP and ntp "sync" the time the I2C HW  
> clock.

You may be better off posting this to lkml and copy the i2c list (and  
rtc if one exists).  Since its more a driver issue than anything  
really ppc specific.  Clearly we are doing schedules() in mpc_xfer()  
and maybe we shouldn't be.

- kumar

> BUG: scheduling while atomic: swapper/0x00010000/0
> Call Trace:^M
> [C0245C80] [C000860C] show_stack+0x48/0x194 (unreliable)
> [C0245CB0] [C01BEFF4] schedule+0x5d4/0x618
> [C0245CF0] [C01BF9C8] schedule_timeout+0x70/0xd0
> [C0245D30] [C014416C] i2c_wait+0x164/0x1d8
> [C0245D80] [C0144490] mpc_xfer+0x2b0/0x3a8
> [C0245DD0] [C01423E8] i2c_transfer+0x58/0x7c
> [C0245DF0] [C0141124] ds1307_set_time+0x1bc/0x234
> [C0245E00] [C013F82C] rtc_set_time+0xb0/0xb8^M
> [C0245E20] [C000BFC4] set_rtc_class_time+0x34/0x58
> [C0245E40] [C000C8D0] timer_interrupt+0x5a0/0x5fc
> [C0245EE0] [C000F7B0] ret_from_except+0x0/0x14
> --- Exception: 901 at cpu_idle+0xc8/0xf0
>     LR = cpu_idle+0xec/0xf0
> [C0245FC0] [C000388C] rest_init+0x28/0x38
> [C0245FD0] [C01F36E0] start_kernel+0x1d8/0x228
> [C0245FF0] [00003438] 0x3438
>
> I have activated RTC CLASS and have this in my board file:
> #ifdef CONFIG_RTC_CLASS
> late_initcall(rtc_class_hookup);
> #endif
>
> kernel 2.6.19-rc5
>
>  Jocke
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev



