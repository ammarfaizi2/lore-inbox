Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750854AbVLLUW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbVLLUW6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 15:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbVLLUW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 15:22:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:42136 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750854AbVLLUW5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 15:22:57 -0500
Date: Mon, 12 Dec 2005 12:22:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
Subject: Re: oops on shutdown.
Message-Id: <20051212122226.4d47dde8.akpm@osdl.org>
In-Reply-To: <20051212114246.09c4b172@unknown-222.office.pdx.osdl.net>
References: <20051212114246.09c4b172@unknown-222.office.pdx.osdl.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger <shemminger@osdl.org> wrote:
>
> This is a 2 CPU Opteron box.  It hung on a basic shutdown reboot
>  running 2.6.15-rc5. It doesn't look related to the sky2 driver.
>  I had a couple of nfs client mounts.
> 
> 
>  [264357.575968] nfsd: last server has exited
>  [264357.589641] nfsd: unexporting all filesystems
>  [264357.605047] RPC: failed to contact portmap (errno -5).
>  [264362.028736] sky2 eth1: disabling interface
>  [264369.044649] Unable to handle kernel NULL pointer dereference at 0000000000000001 RIP: 
>  [264369.063676] <ffffffff8015bdc7>{find_get_pages+87}
>  [264369.088376] PGD 7d698067 PUD 7dc0a067 PMD 0 
>  [264369.103310] Oops: 0000 [1] SMP 
>  [264369.114347] CPU 0 
>  [264369.121489] Modules linked in: nfsd exportfs binfmt_misc video thermal processor fan button battery ac ohci_hcd ehci_hcd i2c_amd8111 i2c_amd756 i2c_core snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc sky2 tg3 usbcore
>  [264369.180541] Pid: 11776, comm: umount Not tainted 2.6.15-rc5 #1
>  [264369.180544] RIP: 0010:[<ffffffff8015bdc7>] <ffffffff8015bdc7>{find_get_pages+87}
>  [264369.180553] RSP: 0018:ffff81007d9d9c48  EFLAGS: 00010002
>  [264369.180556] RAX: 000000000000086c RBX: 0000000000000002 RCX: ffff81007d9d9ce0
>  [264369.180558] RDX: 0000000000000001 RSI: 0000000000000001 RDI: 0000000000000002
>  [264369.180561] RBP: ffff81007d9d9c78 R08: 0000000000000000 R09: 0000000000000040
>  [264369.180564] R10: ffff8100005ef4b0 R11: 0000000000000002 R12: 000000000000000e
>  [264369.180567] R13: 0000000000000000 R14: ffff81007d9d9cd8 R15: ffff8100006cd6c0
>  [264369.180571] FS:  00002aaaaaac5e80(0000) GS:ffffffff805ae800(0000) knlGS:0000000000000000
>  [264369.180574] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
>  [264369.180577] CR2: 0000000000000001 CR3: 000000007c2d8000 CR4: 00000000000006e0
>  [264369.180580] Process umount (pid: 11776, threadinfo ffff81007d9d8000, task ffff81005aa300c0)
>  [264369.180583] Stack: ffff81007d9d9c58 ffff81007d9d9cc8 0000000000000000 ffff81007d9d9dc8 
>  [264369.180588]        0000000000006fb4 ffff8100006cd6a8 ffff81007d9d9c98 ffffffff8016657f 
>  [264369.180594]        0000000000000018 ffff8100006cd558 
>  [264369.180597] Call Trace:<ffffffff8016657f>{pagevec_lookup+31} <ffffffff8016718c>{truncate_inode_pages+252}
>  [264369.180611]        <ffffffff8019b21a>{dispose_list+90} <ffffffff8019b661>{invalidate_inodes+257}
>  [264369.180624]        <ffffffff80185bfa>{generic_shutdown_super+154} <ffffffff80185d00>{kill_block_super+48}
>  [264369.180635]        <ffffffff80185fbc>{deactivate_super+108} <ffffffff8019d468>{mntput_no_expire+88}
>  [264369.180643]        <ffffffff8018d94d>{path_release_on_umount+29} <ffffffff8019e91f>{sys_umount+639}
>  [264369.180651]        <ffffffff8010dd1e>{system_call+126} 


Damn, that's a weird place to be oopsing.  NFS doesn't call
kill_block_super(), so it might be a different fs.

Is it repeatable?
