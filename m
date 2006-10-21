Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423362AbWJURTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423362AbWJURTd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 13:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423360AbWJURTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 13:19:32 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:65194 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1423356AbWJURTb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 13:19:31 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: tg3 kernel bug in 2.6.18-mm3 and 2.6.19-rc2-mm2
Date: Sat, 21 Oct 2006 19:18:29 +0200
User-Agent: KMail/1.9.1
Cc: Norbert Preining <preining@logic.at>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, Michael Chan <mchan@broadcom.com>
References: <20061021132239.GA29288@gamma.logic.tuwien.ac.at> <20061021100207.fdc240e0.akpm@osdl.org>
In-Reply-To: <20061021100207.fdc240e0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610211918.30616.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 21 October 2006 19:02, Andrew Morton wrote:
> 
> cc's added.
> 
> On Sat, 21 Oct 2006 15:22:39 +0200
> Norbert Preining <preining@logic.at> wrote:
> 
> > Hi all!
> > 
> > I get the same bug again and again, always when ifplugd is started:
> > 
> > tg3: eth0: No firmware running.
> > BUG: soft lockup detected on CPU#0!
> >  [<c0103ec7>] dump_trace+0x68/0x1b4
> >  [<c010402b>] show_trace_log_lvl+0x18/0x2c
> >  [<c010463a>] show_trace+0xf/0x11
> >  [<c010469d>] dump_stack+0x12/0x14
> >  [<c0141cb3>] softlockup_tick+0xaa/0xc1
> >  [<c0129bad>] update_process_times+0x3b/0x5e
> >  [<c01362a1>] handle_update_profile+0x14/0x1e
> >  [<c0115956>] smp_apic_timer_interrupt+0x49/0x5b
> >  [<c0103998>] apic_timer_interrupt+0x28/0x30
> > DWARF2 unwinder stuck at apic_timer_interrupt+0x28/0x30
> > Leftover inexact backtrace:
> >  [<c01d03af>] delay_tsc+0xb/0x13
> >  [<c01d03e0>] __delay+0x6/0x7
> >  [<c022ce12>] tg3_readphy+0x6e/0xd5
> >  [<c022e0d1>] tg3_setup_copper_phy+0x30b/0xa15
> >  [<c01064d9>] profile_pc+0x24/0x53
> >  [<c022f475>] tg3_setup_phy+0xc9a/0xd1f
> >  [<c0103998>] apic_timer_interrupt+0x28/0x30
> >  [<c022c240>] _tw32_flush+0x3f/0x51
> >  [<c022dc4a>] tg3_write_mem+0xcf/0xe7
> >  [<c0231683>] tg3_reset_hw+0x10ab/0x13a0
> >  [<c01d03e0>] __delay+0x6/0x7
> >  [<c01d03e0>] __delay+0x6/0x7
> >  [<c022c240>] _tw32_flush+0x3f/0x51
> >  [<c01d03e0>] __delay+0x6/0x7
> >  [<c022da97>] tg3_switch_clocks+0x8f/0x93
> >  [<c0237673>] tg3_open+0x250/0x520
> >  [<c02d3263>] dev_open+0x2b/0x62
> >  [<c02d1dd8>] dev_change_flags+0x47/0xe4
> >  [<c0307fcc>] devinet_ioctl+0x252/0x556
> >  [<c02d2e5a>] dev_ifsioc+0x113/0x38d
> >  [<c02d29c4>] dev_load+0x24/0x4b
> >  [<c02c90c7>] sock_ioctl+0x0/0x1c2
> >  [<c02c9265>] sock_ioctl+0x19e/0x1c2
> >  [<c02ca151>] sock_map_fd+0x41/0x4a
> >  [<c02c90c7>] sock_ioctl+0x0/0x1c2
> >  [<c01684bb>] do_ioctl+0x1f/0x62
> >  [<c0168743>] vfs_ioctl+0x245/0x257
> >  [<c0168788>] sys_ioctl+0x33/0x4b
> >  [<c0102f40>] syscall_call+0x7/0xb
> >  =======================
> > 
> > With  2.6.19-rc2 (no -mm) it does not happen.
> > 
> > Normal dmesg gives:
> > tg3.c:v3.66 (September 23, 2006)
> > PCI: Enabling device 0000:03:00.0 (0000 -> 0002)
> > ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 17 (level, low) -> IRQ 18
> > PCI: Setting latency timer of device 0000:03:00.0 to 64
> > eth0: Tigon3 [partno(BCM95789) rev 4101 PHY(5750)] (PCI Express) 10/100/1000Base
> > T Ethernet 00:16:36:1e:27:ad
> > eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
> > eth0: dma_rwctrl[76180000] dma_mask[64-bit]
> > 
> 
> 
> There are tg3 changes in -mm, but I doubt it they caused this hang.

FWIW, I have a tg3 running just fine with 2.6.19-rc2-mm2, on x86-64.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
