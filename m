Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261531AbVGTXTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbVGTXTl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 19:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbVGTXTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 19:19:41 -0400
Received: from torrent.CC.McGill.CA ([132.206.27.49]:13252 "EHLO
	torrent.cc.mcgill.ca") by vger.kernel.org with ESMTP
	id S261531AbVGTXTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 19:19:37 -0400
Subject: kernel oops with x64_86 crossing 4Gb boundary
From: Francois Pepin <fpepin@aei.ca>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 20 Jul 2005 19:18:48 -0400
Message-Id: <1121901528.5121.21.camel@elm.mcb.mcgill.ca>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am getting pseudo-random kernel oops on my Opteron box (Tyan Thunder
K8W) with 4Gb RAM. I am running RedHad FC3 with kernel
2.6.11-1.35_FC3smp.

It runs well with default BIOS settings, but only 3.5Gb RAM are visible.
Using the "Software Memory Hole" option in the BIOS (version 3.02)
remaps the last 2Gb to 4-6Gb. This causes kernel oops with various
applications, generally killing them.

I can reproduce it by loading lots of data into R (which caused the oops
below). Various other applications have caused it too.

Oops: 0000 [1] SMP
CPU 1
Modules linked in: nfs lockd parport_pc lp parport autofs4 sunrpc pcmcia
yenta_socket rsrc_nonstatic pcmcia_core dm_mod video button battery ac
nvidia(U) md5 ipv6 ohci1394 ieee1394 ohci_hcd uhci_hcd ehci_hcd
i2c_amd8111 i2c_core hw_random sata_sil libata scsi_mod snd_intel8x0
snd_ca0106 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer
snd soundcore snd_page_alloc e1000 floppy ext3 jbd
Pid: 5288, comm: R Tainted: P      2.6.11-1.35_FC3smp
RIP: 0010:[<ffffffff8016be0a>] <ffffffff8016be0a>{pte_alloc_map+170}
RSP: 0000:ffff8101553f5db8  EFLAGS: 00010293
RAX: ffffffff7fffffff RBX: 00002aaad0c00000 RCX: 0000000000000000
RDX: ffff810107c95000 RSI: ffff81000000f800 RDI: ffff81000000f000
RBP: ffff81012d20a430 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000007f71c R11: 0000000000000000 R12: 0000000000000000
R13: ffff810173270040 R14: ffff8101732700b8 R15: ffff81012d20a430
FS:  00002aaaaae6b900(0000) GS:ffffffff804dd680(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000002730 CR3: 0000000156775000 CR4: 00000000000006e0
Process R (pid: 5288, threadinfo ffff8101553f4000, task
ffff8101559f3810)
Stack: ffff8101567752a8 00002aaad0c00000 ffff810159fe9a68
ffff810173270040
       0000000000000001 ffffffff8016ed05 0000000000000000
ffff8101732700b8
       ffff81015a033a80 00002aaaad975000
Call Trace:<ffffffff8016ed05>{handle_mm_fault+293}
<ffffffff80122994>{do_page_fault+1172}
       <ffffffff8014f100>{autoremove_wake_function+0}
<ffffffff801b87be>{dnotify_parent+46}
       <ffffffff8018132c>{vfs_read+268} <ffffffff8010f0a1>{error_exit+0}


Code: 48 8b b1 30 27 00 00 76 0d b8 00 00 00 80 eb 10 66 66 90 66
RIP <ffffffff8016be0a>{pte_alloc_map+170} RSP <ffff8101553f5db8>
CR2: 0000000000002730

Please tell me if more information is necessary.

Francois

