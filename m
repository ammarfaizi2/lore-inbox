Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbVDGHO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbVDGHO6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 03:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbVDGHO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 03:14:58 -0400
Received: from amazone.ujf-grenoble.fr ([193.54.238.254]:8322 "EHLO
	amazone.ujf-grenoble.fr") by vger.kernel.org with ESMTP
	id S261724AbVDGHOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 03:14:36 -0400
Message-ID: <4254DDCB.2070704@kde.org>
Date: Thu, 07 Apr 2005 09:14:19 +0200
From: Mickael Marchand <marchand@kde.org>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc2-mm1
References: <20050405000524.592fc125.akpm@osdl.org>
In-Reply-To: <20050405000524.592fc125.akpm@osdl.org>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm1/
> 
> - x86 NMI handling seems to be bust in 2.6.12-rc2.  Try using
>   `nmi_watchdog=0' if you experience weird crashes.
> 
> - The possible kernel-timer related hangs might possibly be fixed.  We
>   haven't heard yet.
> 
> - Nobody said anything about the PM resume and DRI behaviour in
>   2.6.12-rc1-mm4.  So it's all perfect now?
> 
> - Various fixes and updates.  Nothing earth-shattering.
> 

Hi,

-> compiling 2.6.12-rc2-mm1 on amd64 :

arch/x86_64/kernel/nmi.c:116: error: static declaration of
'check_nmi_watchdog' follows non-static declaration
include/asm/apic.h:102: error: previous declaration of
'check_nmi_watchdog' was here

I guess the fix is easy enough :)

-> while I am it, I got a soft lookup on a bi-opteron using
2.6.12-rc1-mm4 (while stressing reiser4 with rsync so I guess it is
reiser4's fault ;)
config at
http://www-fourier.ujf-grenoble.fr/~mmarcha/config-2.6.12-rc1-mm4.gz

I also got some "flushing like mad" warning messages from reiser4 (which
are safe apparently).

BUG: soft lockup detected on CPU#0!

Modules linked in: ipv6 parport_pc parport eth1394 ehci_hcd uhci_hcd
ohci1394 ieee1394 ohci_hcd usbcore snd_intel8x0 snd_ac97_codec snd_pcm
snd_timer snd snd_page_alloc i2c_amd756 i2c_amd8111 i2c_isa w83781d
i2c_sensor i2c_core e1000
Pid: 25291, comm: pdflush Not tainted 2.6.12-rc1-mm4
RIP: 0010:[<ffffffff8021f7de>] <ffffffff8021f7de>{protect_extent_nodes+382}
RSP: 0018:ffff81007df45678  EFLAGS: 00000202
RAX: ffff810015c7c5e0 RBX: ffff81007c609000 RCX: ffff81001074ba60
RDX: ffff81001074b220 RSI: ffff81001074b1c0 RDI: ffff81001074b210
RBP: 0000002000000000 R08: ffff81007df458a0 R09: ffff810044068e14
R10: 000000000000001c R11: ffffffff802119a0 R12: 00007fe07df455e0
R13: ffff81007c609004 R14: ffff81007df4565c R15: 00007fe000000001
FS:  00002aaaaadfeae0(0000) GS:ffffffff806e7840(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00002aaaaaac2000 CR3: 000000009bc83000 CR4: 00000000000006e0

Call Trace:<ffffffff8021f7da>{protect_extent_nodes+378}
<ffffffff8021c00e>{extent_size+30}
       <ffffffff801f5df9>{txnh_get_atom+41}
<ffffffff8021ffd2>{alloc_extent+562}
       <ffffffff8020a0bc>{plugin_by_unsafe_id+28}
<ffffffff80220bd1>{item_length_by_coord+17}
       <ffffffff801f8a4f>{handle_pos_on_twig+351}
<ffffffff801fabc6>{flush_current_atom+2022}
       <ffffffff801f7aca>{flush_some_atom+458}
<ffffffff801a2993>{generic_sync_sb_inodes+723}
       <ffffffff8014cc50>{keventd_create_kthread+0}
<ffffffff80203b85>{reiser4_sync_inodes+229}
       <ffffffff801a2bd9>{writeback_inodes+137}
<ffffffff8016012c>{background_writeout+124}
       <ffffffff80160c10>{pdflush+0} <ffffffff80160d4c>{pdflush+316}
       <ffffffff801600b0>{background_writeout+0}
<ffffffff8014cec9>{kthread+217}
       <ffffffff80133160>{schedule_tail+64} <ffffffff8010f59b>{child_rip+8}
       <ffffffff8014cc50>{keventd_create_kthread+0}
<ffffffff8014cdf0>{kthread+0}
       <ffffffff8010f593>{child_rip+0}

Cheers,
Mik
