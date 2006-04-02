Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbWDBAcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbWDBAcY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 19:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbWDBAcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 19:32:24 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:44466 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S932337AbWDBAcX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 19:32:23 -0500
Message-ID: <442F1A0F.2000303@freenux.org>
Date: Sun, 02 Apr 2006 02:25:51 +0200
From: Mickael Marchand <mikmak@freenux.org>
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: reiser4 bug on 2.6.16 (and reiser4 patches from mm1)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

config at http://www-fourier.ujf-grenoble.fr/~mmarcha/config-2.6.16-reiser4

this is a bi-opteron 244 with 4Go using software raid6

it seems it did that while it was starting a (cron-ed) rsync command.

stack trace :

> BUG: soft lockup detected on CPU#0!
> CPU 0:
> Modules linked in: ipv6 iptable_filter ip_tables w83781d hwmon_vid hwmon i2c_isa eth1394 ohci1394 ieee1394 ehci_hcd ohci_hcd uhci_hcd e1000 usbcore snd_intel8x0 snd_ac97_codec snd_ac97_bus
> i2c_amd8111 i2c_amd756 parport_pc parport snd_pcm snd_timer snd snd_page_alloc i2c_core
> Pid: 27760, comm: pdflush Not tainted 2.6.16 #1
> RIP: 0010:[<ffffffff802276ec>] <ffffffff802276ec>{protect_extent_nodes+460}
> RSP: 0018:ffff81003246f9b8  EFLAGS: 00000202
> RAX: 0000000000000000 RBX: 00007fe0424f582e RCX: ffff8100babf3720
> RDX: ffff8100babf37e0 RSI: ffff8100babf3780 RDI: ffff81003246fb08
> RBP: ffff8100c5767004 R08: ffff81003246fba0 R09: ffff810095021b7c
> R10: 0000000000000026 R11: ffffffff80218b80 R12: ffff81003246f9ac
> R13: 00007fe000000001 R14: 000120cc801eaa9f R15: 0000000000008000
> FS:  00002ace10456ae0(0000) GS:ffffffff806cc000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> CR2: 00002b91fad66000 CR3: 00000000a052a000 CR4: 00000000000006e0
> 
> Call Trace: <ffffffff802276d0>{protect_extent_nodes+432}
>        <ffffffff801edc9b>{longterm_unlock_znode+91} <ffffffff80223b0e>{extent_size+30}
>        <ffffffff80223cbf>{unit_key_extent+47} <ffffffff801f3699>{txnh_get_atom+41}
>        <ffffffff80227fea>{alloc_extent+650} <ffffffff80228ce1>{item_body_by_coord_hard+17}
>        <ffffffff80223b0e>{extent_size+30} <ffffffff80228d01>{item_length_by_coord+17}
>        <ffffffff801f6d4d>{handle_pos_on_twig+413} <ffffffff801f8f57>{flush_current_atom+2231}
>        <ffffffff801f5c83>{flush_some_atom+739} <ffffffff80144350>{keventd_create_kthread+0}
>        <ffffffff8020361f>{writeout+271} <ffffffff8019d87f>{generic_sync_sb_inodes+735}
>        <ffffffff801ffe7a>{reiser4_sync_inodes+170} <ffffffff8019db09>{writeback_inodes+121}
>        <ffffffff8015842c>{background_writeout+124} <ffffffff80158ea0>{pdflush+0}
>        <ffffffff80158ff4>{pdflush+340} <ffffffff801583b0>{background_writeout+0}
>        <ffffffff80144519>{kthread+217} <ffffffff8010bcd2>{child_rip+8}
>        <ffffffff80144350>{keventd_create_kthread+0} <ffffffff80144440>{kthread+0}
>        <ffffffff8010bcca>{child_rip+0}

Cheers,
Mik
