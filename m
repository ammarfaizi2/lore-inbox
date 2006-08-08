Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965062AbWHHWnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965062AbWHHWnI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 18:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965063AbWHHWnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 18:43:08 -0400
Received: from iron.pdx.net ([207.149.241.18]:50321 "EHLO iron.pdx.net")
	by vger.kernel.org with ESMTP id S965062AbWHHWnH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 18:43:07 -0400
Subject: Re: [BUG] Kernel Panic from AHD when power cycling external
	Disk/Array
From: Sean Bruno <sean.bruno@dsl-only.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: James.Bottomley@SteelEye.com
In-Reply-To: <1155065394.3002.9.camel@home-desk>
References: <1155064973.3002.5.camel@home-desk>
	 <1155065394.3002.9.camel@home-desk>
Content-Type: text/plain
Date: Tue, 08 Aug 2006 15:43:05 -0700
Message-Id: <1155076985.3002.14.camel@home-desk>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-08 at 12:29 -0700, Sean Bruno wrote:
> On Tue, 2006-08-08 at 12:22 -0700, Sean Bruno wrote:
> > Running a 29320R with CentOS 4.3 and 2.6.17.8 installed.  
> > 
> > 
> > Got this interesting BUG from 2.6.17.8 today.  Each time I reset my
> > external SCSI Disk connected to my 29320R the kernel throws this error
> > and locks up:
> > 
> > scsi0: Someone reset channel A
> > BUG: soft lockup detected on CPU#0!
> >  <c013258b> softlockup_tick+0x7f/0x8e  <c011e6e4> update_process_times
> > +0x35/0x57 <c0104eda> timer_interrupt+0x3d/0x60  <c0132698>
> > handle_IRQ_event+0x21/0x4a
> >  <c0132739> __do_IRQ+0x78/0xcb  <c0103eb5> do_IRQ+0x6b/0x7a
> >  <c0102c4a> common_interrupt+0x1a/0x20  <c02d3a2a>
> > _spin_unlock_irqrestore+0xa/c <e08d0481> ahd_linux_isr+0x173/0x17f
> > [aic79xx]  <c0132698> handle_IRQ_event+0xa <c0132739> __do_IRQ+0x78/0xcb
> > <c0103ea8> do_IRQ+0x5e/0x7a
> >  =======================
> >  <c0102c4a> common_interrupt+0x1a/0x20  <c011b5bc> __do_softirq
> > +0x2c/0x7d
> >  <c0103f8c> do_softirq+0x38/0x3f
> >  =======================
> >  <c0103eba> do_IRQ+0x70/0x7a  <c0102c4a> common_interrupt+0x1a/0x20
> >  <c0101150> mwait_idle+0x1a/0x2a  <c01010bf> cpu_idle+0x40/0x5c
> >  <c038c618> start_kernel+0x184/0x186
> > 
> > 
> > 
> > H/W specs:
> > (lspci)
> > 00:00.0 Host bridge: Intel Corporation 82865G/PE/P DRAM
> > Controller/Host-Hub Interface (rev 02)
> > 00:01.0 PCI bridge: Intel Corporation 82865G/PE/P PCI to AGP Controller
> > (rev 02)
> > 00:1d.0 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB
> > UHCI Controller #1 (rev 02)
> > 00:1d.1 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB
> > UHCI Controller #2 (rev 02)
> > 00:1d.2 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB
> > UHCI Controller #3 (rev 02)
> > 00:1d.3 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB
> > UHCI Controller #4 (rev 02)
> > 00:1d.7 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB2
> > EHCI Controller (rev 02)
> > 00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev c2)
> > 00:1f.0 ISA bridge: Intel Corporation 82801EB/ER (ICH5/ICH5R) LPC
> > Interface Bridge (rev 02)
> > 00:1f.1 IDE interface: Intel Corporation 82801EB/ER (ICH5/ICH5R) IDE
> > Controller (rev 02)
> > 02:05.0 Ethernet controller: Marvell Technology Group Ltd. 88E8001
> > Gigabit Ethernet Controller (rev 13)
> > 02:09.0 VGA compatible controller: Silicon Integrated Systems [SiS]
> > 315PRO PCI/AGP VGA Display Adapter
> > 02:0c.0 SCSI storage controller: Adaptec ASC-29320A U320 (rev 10)
> > 
> FWIW, this error does not occur with the CentOS stock kernel
> 2.6.9-34.0.2.EL
> 
> Sean
> 
And finally, to double reply to my own post, it looks like the changes
made in 2.6.16 cause this issue to appear.  2.6.15 doesn't have any
issue with the array rebooting itself and issuing a reset.

Sean

