Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751201AbWGRHjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbWGRHjx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 03:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbWGRHjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 03:39:53 -0400
Received: from wr-out-0506.google.com ([64.233.184.235]:61838 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751201AbWGRHjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 03:39:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:reply-to:to:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=p5kWBFAzBl9wlU82SDhT8oS/YpvtbaNQCMbHDobAMr63cQ6tS1ENKiKBMa7ke7iVHVvgRXbVo+ufaHu/9MvoVxvT7zHlvkxIhO4rGwoVxVrEA9aFbm5miwo1XpjrU2nEqdplvqtHBjYDFKJBoFrMCw8p4FcInF4YyToqnuj5tes=
Subject: kernel panic related to ReiserFS (v3)
From: Chris Largret <largret@gmail.com>
Reply-To: largret@gmail.com
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 18 Jul 2006 00:39:48 -0700
Message-Id: <1153208388.8074.18.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 Dropline GNOME 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


First, the disclaimer: I've been watching the arguments and accusations
about reiser4, and am not trying to add fuel to either side ;)

This kernel panic happened a few minutes ago, and it is probably related
to a firefox bug, but it shouldn't cause the kernel to panic. I'm
running the 2.6.16.16 kernel with the latest squashfs (CVS) patch which
supported this kernel series. The distro is Slamd64, and is on a 64-bit
AMD X2 system. As you can probably guess, my main filesystem is
ReiserFS. It is on an SATA drive. If more information is needed, let me
know.

Before sending this in I did a search on the release announcements. It
looks to me like the last reiserfs change was well before the .16
series. If I'm wrong, feel free to tell me.

Here is the relevant section from /var/log/syslog:

Jul 17 23:42:49 localhost kernel: Unable to handle kernel paging request
at ffff81023dfaf8b0 RIP: 
Jul 17 23:42:49 localhost kernel: <ffffffff8016285b>{cache_alloc_refill
+250}
Jul 17 23:42:49 localhost kernel: PGD 8063 PUD 0 
Jul 17 23:42:49 localhost kernel: Oops: 0000 [1] SMP 
Jul 17 23:42:49 localhost kernel: CPU 1 
Jul 17 23:42:49 localhost kernel: Modules linked in: usb_storage vmnet
parport_pc parport vmmon snd_pcm_oss snd_mixer_oss md5 ipv6 ipt_recent
ipt_REJECT xt_state iptable_filter nfs lockd nfs_acl sunrpc r8169
ohci1394 ieee1394 emu10k1_gp gameport snd_emu10k1 snd_rawmidi
snd_ac97_codec snd_ac97_bus snd_pcm snd_seq_device snd_timer
snd_page_alloc snd_util_mem snd_hwdep snd 8250_pci 8250 serial_core
tda9887 tuner cx8800 cx88xx video_buf ir_common tveeprom compat_ioctl32
v4l1_compat v4l2_common btcx_risc videodev nvidia forcedeth i2c_nforce2
pcmcia firmware_class yenta_socket rsrc_nonstatic pcmcia_core
Jul 17 23:42:49 localhost kernel: Pid: 7770, comm: firefox-bin Tainted:
P      2.6.16.16 #1
Jul 17 23:42:49 localhost kernel: RIP: 0010:[<ffffffff8016285b>]
<ffffffff8016285b>{cache_alloc_refill+250}
Jul 17 23:42:49 localhost kernel: RSP: 0018:ffff8100b9f7fa78  EFLAGS:
00010082
Jul 17 23:42:49 localhost kernel: RAX: 0000000080000e00 RBX:
ffff810004174940 RCX: 0000000000000016
Jul 17 23:42:49 localhost kernel: RDX: ffff81003e2450c8 RSI:
ffff81003dfac080 RDI: ffff81000417498c
Jul 17 23:42:49 localhost kernel: RBP: 0000000000000004 R08:
0000000000000001 R09: 000000000000000a
Jul 17 23:42:49 localhost kernel: R10: 0000000000000002 R11:
ffff8100b9f7fbc8 R12: ffff810004173800
Jul 17 23:42:49 localhost kernel: R13: ffff8100bfe4abc0 R14:
ffff8100b9f7fb50 R15: ffffffff801adb4c
Jul 17 23:42:49 localhost kernel: FS:  00002af9c9c25ec0(0000)
GS:ffff810004079440(0000) knlGS:00000000f44afbb0
Jul 17 23:42:49 localhost kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Jul 17 23:42:49 localhost kernel: CR2: ffff81023dfaf8b0 CR3:
000000004b950000 CR4: 00000000000006e0
Jul 17 23:42:49 localhost kernel: Process firefox-bin (pid: 7770,
threadinfo ffff8100b9f7e000, task ffff81007d4282c0)
Jul 17 23:42:49 localhost kernel: Stack: 0000000000203246
0000000000203296 000000d0911857c0 00000000000000d0 
Jul 17 23:42:49 localhost kernel:        ffff8100bfe4abc0
ffff8100bf87d800 ffff810003e6cd38 ffff8100b9f7fb50 
Jul 17 23:42:49 localhost kernel:        ffffffff801adb4c
ffffffff80162756 
Jul 17 23:42:49 localhost kernel: Call Trace:
<ffffffff801adb4c>{reiserfs_init_locked_inode+0}
Jul 17 23:42:49 localhost kernel:
<ffffffff80162756>{kmem_cache_alloc+75}
<ffffffff801ae02b>{reiserfs_find_actor+0}
Jul 17 23:42:49 localhost kernel:
<ffffffff801b7131>{reiserfs_alloc_inode+18}
<ffffffff8017b526>{alloc_inode+18}
Jul 17 23:42:49 localhost kernel:        <ffffffff8017c3d3>{iget5_locked
+120} <ffffffff801ae07a>{reiserfs_iget+52}
Jul 17 23:42:49 localhost kernel:
<ffffffff801aae31>{reiserfs_lookup+204} <ffffffff80171cb0>{do_lookup
+194}
Jul 17 23:42:49 localhost kernel:
<ffffffff8017281f>{__link_path_walk+2386}
<ffffffff80172cf2>{link_path_walk+80}
Jul 17 23:42:49 localhost kernel:
<ffffffff80165357>{get_unused_fd+108} <ffffffff80172fc8>{do_path_lookup
+604}
Jul 17 23:42:49 localhost kernel:
<ffffffff8017311d>{__path_lookup_intent_open+78}
<ffffffff80173988>{open_namei+127}
Jul 17 23:42:49 localhost kernel:        <ffffffff801651f6>{do_filp_open
+25} <ffffffff80165357>{get_unused_fd+108}
Jul 17 23:42:49 localhost kernel:        <ffffffff801654e8>{do_sys_open
+68} <ffffffff8010a93e>{system_call+126}
Jul 17 23:42:49 localhost kernel: 
Jul 17 23:42:49 localhost kernel: Code: 8b 44 86 30 89 46 24 49 89 54 cc
18 41 8b 45 5c 39 46 20 72 
Jul 17 23:42:49 localhost kernel: RIP
<ffffffff8016285b>{cache_alloc_refill+250} RSP <ffff8100b9f7fa78>
Jul 17 23:42:49 localhost kernel: CR2: ffff81023dfaf8b0
Jul 17 23:42:49 localhost kernel:  BUG: firefox-bin/7770, lock held at
task exit time!
Jul 17 23:42:49 localhost kernel:  [ffff8100a97edd60] {inode_init_once}
Jul 17 23:42:49 localhost kernel: .. held by:       firefox-bin: 7770
[ffff81007d4282c0, 116]
Jul 17 23:42:49 localhost kernel: ... acquired at:
do_lookup+0x81/0x179


(sorry for the line-wrap, it looks bad even as I click "Send." :)

Thanks

--
Chris Largret <http://www.largret.com>

