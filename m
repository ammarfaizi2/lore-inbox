Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264774AbUD1Nc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264774AbUD1Nc4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 09:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264775AbUD1Nc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 09:32:56 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:62992 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S264774AbUD1Ncx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 09:32:53 -0400
Date: Wed, 28 Apr 2004 21:34:11 +0800 (WST)
From: raven@themaw.net
To: Dave Airlie <airlied@linux.ie>
cc: Paul Jackson <pj@sgi.com>, Erdi Chen <erdi.chen@digeo.com>,
       davem@redhat.com, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sparc64 2.6.6-rc2-mm2 build busted: usb/core/hub.c hubstatus
In-Reply-To: <Pine.LNX.4.58.0404280325340.2125@skynet>
Message-ID: <Pine.LNX.4.58.0404282128440.2727@donald.themaw.net>
References: <20040426204947.797bd7c2.pj@sgi.com>
 <Pine.LNX.4.58.0404271248250.8094@wombat.indigo.net.au>
 <Pine.LNX.4.58.0404272234320.1547@donald.themaw.net> <Pine.LNX.4.58.0404280111430.2125@skynet>
 <Pine.LNX.4.58.0404281025060.651@wombat.indigo.net.au>
 <Pine.LNX.4.58.0404280325340.2125@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-1.7, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, NO_REAL_NAME, QUOTED_EMAIL_TEXT,
	REFERENCES, REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Apr 2004, Dave Airlie wrote:

> > >
> >
> > I'll investigate but I think that, either I need the fb device or
> > X -configure has it wrong. It thinks I have devices fb0 and fb1.
> 
> leave in the "fb" device but don't enable direct rendering "ffb" device,
> not the extra f, if it still crashes with just the framebuffer and not the
> DRM then there is a framebuffer issue ...
> 
> CONFIG_DRM_FFB should be n is probably the most straightforward way to
> check it isn't in there..

Did that and got simmilar oops.

X -configure still insists I have BusID "SBUS:fb0" and "SBUS:fb1" devices.
If I configure BusID "sbus@1f,0/cgsix@0.0" and "sbus@1f,0/cgsix@2,0" as I 
would in 2.4 X complains that it can't find the "SBUS:fbn" devices.

Opps:

Apr 28 20:06:31 donald Unable to handle kernel paging request at virtual address 00000000408f8000
Apr 28 20:06:31 donald tsk->{mm,active_mm}->context = 0000000000000625
Apr 28 20:06:31 donald tsk->{mm,active_mm}->pgd = fffff800302c5000
Apr 28 20:06:31 donald \|/ ____ \|/
Apr 28 20:06:31 donald "@'/ .. \`@"
Apr 28 20:06:31 donald /_| \__/ |_\
Apr 28 20:06:31 donald \__U_/
Apr 28 20:06:31 donald X(5651): Oops [#1]
Apr 28 20:06:31 donald TSTATE: 0000009980009602 TPC: 00000000004201ac TNPC: 00000000004201b0 Y: 00000000    Not tainted
Apr 28 20:06:31 donald TPC: <kernel_unaligned_trap+0x26c/0x364>
Apr 28 20:06:31 donald g0: 0000000000000000 g1: 0000000000002000 g2: 000000000614a100 g3: 0000000000000080
Apr 28 20:06:31 donald g4: fffff80033712ad0 g5: 0000000000000000 g6: fffff8003208c000 g7: 0000000000000003
Apr 28 20:06:31 donald o0: fffff8003208f4c8 o1: fffff8003208f4c0 o2: 0000000000000001 o3: fffff800337220e0
Apr 28 20:06:31 donald o4: 0000000000000000 o5: 0000000000000000 sp: fffff8003208e9f1 ret_pc: 0000000000420160
Apr 28 20:06:31 donald RPC: <kernel_unaligned_trap+0x220/0x364>
Apr 28 20:06:31 donald l0: 0000000000000002 l1: 0000000000000001 l2: 0000000000000001 l3: 0000000000000002
Apr 28 20:06:31 donald l4: 0000000000000000 l5: 00000000408f9e47 l6: 0000000000000000 l7: 0000000000000000
Apr 28 20:06:31 donald i0: fffff8003208f4c0 i1: 00000000c2942000 i2: 00000000408f9e47 i3: 0000000000800009
Apr 28 20:06:31 donald i4: 00000000004bcf24 i5: 00000000004bcf04 i6: fffff8003208eac1 i7: 0000000000419a48
Apr 28 20:06:31 donald I7: <mem_address_unaligned+0x28/0x80>
Apr 28 20:06:31 donald Caller[0000000000419a48]: mem_address_unaligned+0x28/0x80
Apr 28 20:06:31 donald Caller[0000000000410a00]: do_mna+0x3c/0x4c
Apr 28 20:06:31 donald Caller[000000000032022c]: 0x32022c
Apr 28 20:06:31 donald Caller[0000000000582c40]: sbusfb_ioctl_helper+0x300/0x340
Apr 28 20:06:31 donald Caller[000000000057e254]: fb_ioctl+0x94/0x380
Apr 28 20:06:31 donald Caller[00000000004994f8]: sys_ioctl+0x118/0x2e0
Apr 28 20:06:31 donald Caller[0000000000434a98]: fbiogetputcmap+0xf8/0x1e0
Apr 28 20:06:31 donald Caller[00000000004b0558]: compat_sys_ioctl+0xf8/0x280
Apr 28 20:06:31 donald Caller[0000000000410cb4]: linux_sparc_syscall32+0x34/0x40
Apr 28 20:06:31 donald Caller[000000000005abec]: 0x5abec
Apr 28 20:06:31 donald Instruction DUMP: 16400019  80a4e004  0248000a <e28d6000> e48d6001  a32c6008  02c94004  a2044012  a32c7030 

