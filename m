Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265546AbSJXQpg>; Thu, 24 Oct 2002 12:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265549AbSJXQpg>; Thu, 24 Oct 2002 12:45:36 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:38620 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S265546AbSJXQp3>;
	Thu, 24 Oct 2002 12:45:29 -0400
Date: Thu, 24 Oct 2002 09:49:59 -0700
To: Alessandro Suardi <alessandro.suardi@oracle.com>
Cc: linux-kernel@vger.kernel.org, irda-users@lists.sourceforge.net
Subject: Re: 2.5.42: IrDA issues
Message-ID: <20021024164959.GB26173@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <7886757.1035409088586.JavaMail.nobody@web155> <20021023215513.GB24788@bougret.hpl.hp.com> <3DB7BA01.5010506@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DB7BA01.5010506@oracle.com>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2002 at 11:14:41AM +0200, Alessandro Suardi wrote:
> Jean Tourrilhes wrote:
> 
> [snip]
> 
> >>>    Stop ! Daniele Peri has just released a new version of the SMC
> >>>driver (smc-ircc2, link on my web page). I would like you to try this
> >>>new driver and report to me. I plan to push this new driver in the
> >>>kernel soon. So, don't waste too much time on the old driver.
> >>
> >>Unfortunately I can't compile the new driver. I modified the Makefile to
> >>comment out versioning (which i don't use) and change kernelversion
> >>to an appropriate 2.5.44, but it fails like this:
> >>
> >>In file included from /usr/src/linux-2.5.44/include/linux/irq.h:19,
> >>                from /usr/src/linux-2.5.44/include/asm/hardirq.h:6,
> >>                from /usr/src/linux-2.5.44/include/linux/interrupt.h:25,
> >>                from /usr/src/linux-2.5.44/include/linux/netdevice.h:454,
> >>                from smsc-ircc2.c:47:
> >>/usr/src/linux-2.5.44/include/asm/irq.h:16:25: irq_vectors.h: No such 
> >>file or directory
> >
> >
> >	Wow ! That's a weird one.
> >	The file in question is in .../arch/i386/mach-generic/. You
> >may be able to modify the compile directive to add that to the
> >compilation (a "-I" argument).
> 
> OK, this is a beginnning :)
> 
> I also had to replace all (mis)usages of __FUNCTION__ in printks,
>  ERROR and WARNING macros to get the driver to build, and finally
>  I built and loaded it.
> 
> So - with this driver the IrDA communication hangs as soon as the
>  first messages try to go from the PPP script to the phone, and I
>  have to kill irattach and restart it to see anything more from
>  irdadump.
> 
> Relevant info... from dmesg:
> 
> -------------------------------------------------------------------
> smsc_ircc_look_for_chips(): probing: 0x3f0 for: 0x0d
> smsc_ircc_probe(): cfgbase: 0x3f0, reg: 0x0d, type: FDC
> smsc_ircc_probe(): cfgbase: 0x3f0, reg: 0x20, type: FDC
> found SMC SuperIO Chip (devid=0x09 rev=08 base=0x03f0): FDC37N958FR
> SMsC IrDA Controller found
>  IrCC version 1.1, firport 0x290, sirport 0x3e8 dma=3, irq=4
> smsc_ircc_setup_io(): reading chip settings: dma: 255, irq: 255
>  Toshiba Satellite 1800 (GP data pin select) transceiver found
> IrDA: Registered device irda0
> smsc_ircc_look_for_chips(): probing: 0x370 for: 0x0d
> smsc_ircc_probe(): cfgbase: 0x370, reg: 0x0d, type: FDC
> smsc_ircc_probe(): cfgbase: 0x370, reg: 0x20, type: FDC
> smsc_ircc_look_for_chips(): probing: 0xe0 for: 0x0d
> smsc_ircc_probe(): cfgbase: 0xe0, reg: 0x0d, type: FDC
> smsc_ircc_probe(): cfgbase: 0xe0, reg: 0x20, type: FDC
> smsc_ircc_look_for_chips(): probing: 0x2e for: 0x0e
> smsc_ircc_probe(): cfgbase: 0x2e, reg: 0x0d, type: LPC
> smsc_ircc_probe(): cfgbase: 0x2e, reg: 0x20, type: LPC
> smsc_ircc_look_for_chips(): probing: 0x4e for: 0x0e
> smsc_ircc_probe(): cfgbase: 0x4e, reg: 0x0d, type: LPC
> smsc_ircc_probe(): cfgbase: 0x4e, reg: 0x20, type: LPC
> smsc_ircc_change_speed(): changing speed to: 9600
> smsc_ircc_sir_start()
> CSLIP: code copyright 1989 Regents of the University of California
> PPP generic driver version 2.4.2
> smsc_ircc_hard_xmit_sir(): changing speed.
> smsc_ircc_change_speed(): changing speed to: 1152000
> smsc_ircc_fir_start()
> smsc_ircc_set_fir_speed(): changing speed to: 1152000
> IrLAP, no activity on link!
> IrLAP, no activity on link!
> IrLAP, no activity on link!
> IrLAP, no activity on link!
> -------------------------------------------------------------------
> 
> 
> (1152000 should possibly be 115200 ?)
> 
> 
> And irdadump says:
> 
> --------------------------------------------------------
> 09:03:00.842829 xid:cmd 589c38b5 > ffffffff S=6 s=0 (14)
> 09:03:00.932819 xid:cmd 589c38b5 > ffffffff S=6 s=1 (14)
> 09:03:01.022788 xid:cmd 589c38b5 > ffffffff S=6 s=2 (14)
> 09:03:01.112789 xid:cmd 589c38b5 > ffffffff S=6 s=3 (14)
> 09:03:01.202787 xid:cmd 589c38b5 > ffffffff S=6 s=4 (14)
> 09:03:01.292756 xid:cmd 589c38b5 > ffffffff S=6 s=5 (14)
> 09:03:01.369859 xid:rsp 589c38b5 < bb700000 S=6 s=5 Nokia 6310 hint=b125 
> [ PnP Modem Fax Telephony IrCOMM IrOBEX ] (27)
> 09:03:01.382763 xid:cmd 589c38b5 > ffffffff S=6 s=* dolphin hint=0400 [ 
> Computer ] (23)
> 09:03:01.422691 snrm:cmd ca=fe pf=1 589c38b5 > bb700000 new-ca=66 (33)
> 09:03:01.524835 ua:rsp ca=66 pf=1 589c38b5 < bb700000 (31)
> 09:03:01.524997 rr:cmd > ca=66 pf=1 nr=0 (2)
> 09:03:01.774694 rr:cmd > ca=66 pf=1 nr=0 (2)
> 09:03:02.274609 rr:cmd > ca=66 pf=1 nr=0 (2)
> 09:03:02.774533 rr:cmd > ca=66 pf=1 nr=0 (2)
> --------------------------------------------------------
> 
> Then hangs (all this is with the 20021007 driver).
> 
> 
> Hope it's helpful, ciao,
> 
> --alessandro

	That's a speed problem (1152000 is MIR). You are supposed to
select the proper module parameters to get speed changes to MIR/FIR to
work properly (check IrDA mailing list messages from Daniele). Another
solution is to limit the speed of the stack to 115200 (115k - see my
web page for details).

	Good luck...

	Jean
