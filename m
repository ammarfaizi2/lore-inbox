Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265519AbUFCOm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265519AbUFCOm1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 10:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265428AbUFCOlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 10:41:21 -0400
Received: from 8.75.30.213.rev.vodafone.pt ([213.30.75.8]:29704 "EHLO
	odie.graycell.biz") by vger.kernel.org with ESMTP id S265552AbUFCOiS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 10:38:18 -0400
Subject: Oops accessing smbfs
From: Nuno Ferreira <nuno.ferreira@graycell.biz>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Graycell
Date: Thu, 03 Jun 2004 15:38:16 +0100
Message-Id: <1086273496.8873.7.camel@taz.graycell.biz>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.8 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Jun 2004 14:33:21.0123 (UTC) FILETIME=[B8105330:01C44977]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got this oops after mounting 2 different shares on /home/nmf/tmp by
mistake. The mounts were made calling smbmount by a regular user and did
not fail.
After calling ls on the dir (it hang) this I realised my mistake and
found this on the log.

Jun  2 17:57:52 taz kernel: smb_file_read: //pagefile.sys validation failed, error=4294967270
Jun  2 18:05:02 taz kernel: smb_lookup: find //.Trash-nmf failed, error=-5
Jun  2 18:05:02 taz kernel: Unable to handle kernel NULL pointer dereference at
virtual address 00000000
Jun  2 18:05:02 taz kernel:  printing eip:
Jun  2 18:05:02 taz kernel: 00000000
Jun  2 18:05:02 taz kernel: *pde = 00000000
Jun  2 18:05:02 taz kernel: Oops: 0000 [#1]
Jun  2 18:05:02 taz kernel: Modules linked in: smbfs twofish serpent aes blowfish sha256 crypto_null lp binfmt_misc 8139cp mii crc32 yenta_socket pcmcia_core snd_ali5451 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_page_alloc snd_timer snd ohci_hcd ati_agp br2684 atm parport_pc parport powernow_k7
Jun  2 18:05:02 taz kernel: CPU:    0
Jun  2 18:05:02 taz kernel: EIP:    0060:[<00000000>]    Not tainted VLI
Jun  2 18:05:02 taz kernel: EFLAGS: 00210246   (2.6.6-mm5)
Jun  2 18:05:02 taz kernel: EIP is at 0x0
Jun  2 18:05:02 taz kernel: eax: d2cc9ce0   ebx: d3809ed8   ecx: c0155fb0   edx: d546ffa0
Jun  2 18:05:02 taz kernel: esi: d546ff44   edi: c45e2024   ebp: d2cc9ce0   esp: d546ff10
Jun  2 18:05:02 taz kernel: ds: 007b   es: 007b   ss: 0068
Jun  2 18:05:02 taz kernel: Process nautilus (pid: 2247, threadinfo=d546f000 task=d544d930)
Jun  2 18:05:02 taz kernel: Stack: de96c2ff d546ff44 00000000 00000002 00000004
ca51e178 00000000 c108bc40
Jun  2 18:05:02 taz kernel:        c45e2000 dbbcb758 d21e8f58 c0155fb0 d546ffa0
00000000 01e41cee d2cc9ce0
Jun  2 18:05:02 taz kernel:        00000000 00000000 c45e2000 00000002 00000000
00000000 00000001 00000004
Jun  2 18:05:02 taz kernel: Call Trace:
Jun  2 18:05:02 taz kernel:  [pg0+509371135/1069907968] smb_readdir+0x37f/0x4d0
[smbfs]
Jun  2 18:05:02 taz kernel:  [filldir64+0/224] filldir64+0x0/0xe0
Jun  2 18:05:02 taz kernel:  [vfs_readdir+123/144] vfs_readdir+0x7b/0x90
Jun  2 18:05:02 taz kernel:  [sys_getdents64+102/160] sys_getdents64+0x66/0xa0
Jun  2 18:05:02 taz kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jun  2 18:05:02 taz kernel:
Jun  2 18:05:02 taz kernel: Code:  Bad EIP value.

-- 
Nuno Ferreira

