Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261363AbVDBXRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbVDBXRq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 18:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbVDBXRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 18:17:46 -0500
Received: from 213-0-213-55.dialup.nuria.telefonica-data.net ([213.0.213.55]:15026
	"EHLO dardhal.24x7linux.com") by vger.kernel.org with ESMTP
	id S261363AbVDBXRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 18:17:33 -0500
Date: Sun, 3 Apr 2005 01:17:37 +0200
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: video4linux-list@redhat.com
Subject: [2.6.11.6] Oops trying to remove module "bttv"
Message-ID: <20050402231737.GA4773@localhost>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>,
	video4linux-list@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi all:

I am getting the following stack dump in the logs when I try to unload the
"bttv" kernel module ("rmmod bttv" ends with SIGSEGV). I have tried with
other kernel versions keeping "module-init-tools" version the same (Debian
3.1-rel-2), and realized that:
- - 2.6.10-rc3-bk15: OK
- - 2.6.11-rc-bk3: OK
- - 2.6.11-rc3: FAILS
- - 2.6.11.6: FAILS

So it seems the bug was introduced somewhere 2.6.11-rc-bk3 and 2.6.11-rc3.
Looking at the 2.6.11-rc2 to 2.6.11-rc3 Changelog there seems to be
several changesets related to video4linux, but apparently just one related
to the bttv.ko kernel module (changeset number 1.1966.2.154). I am,
however, not qualified to tell if the problem is there:


bttv0: unloading
Unable to handle kernel NULL pointer dereference at virtual address 00000224
 printing eip:
e0c3d95d
*pde = 00000000
Oops: 0000 [#1]
Modules linked in: md5 ipv6 snd_via82xx uhci_hcd usbcore i2c_viapro tuner tvaudio bttv video_buf v4l2_common btcx_risc tveeprom videodev snd_ymfpci snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_opl3_lib snd_timer snd_hwdep snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore skystar2 dvb_core mt352 stv0299 nxt2002 firmware_class mt312 8139too 8139cp mii via_agp agpgart reiserfs xfs exportfs dm_mod it87 i2c_sensor i2c_isa rtc
CPU:    0
EIP:    0060:[<e0c3d95d>]    Not tainted VLI
EFLAGS: 00010206   (2.6.11.6) 
EIP is at bttv_i2c_info+0x3d/0x80 [bttv]
eax: 000001a0   ebx: df8df77c   ecx: df8df6c0   edx: 00000004
esi: e0c4dba0   edi: 00000000   ebp: deaf7800   esp: de42be38
ds: 007b   es: 007b   ss: 0068
Process rmmod (pid: 2448, threadinfo=de42a000 task=df908a40)
Stack: e0c4da64 c01b3c70 c01b4719 deaf7800 df683920 e0c4d9e4 00000000 e0c3d2f4 
       e0c4d9e0 deaf7800 00000000 c024e89e deaf7800 deaf743c c0351350 c034e0e8 
       c034e100 df8df6e4 c034e0e8 00000286 deaf7800 df683920 e0c4db44 e0c4d9e4 
Call Trace:
 [<c01b3c70>] kobject_release+0x0/0x10
 [<c01b4719>] kref_put+0x39/0xa0
 [<e0c3d2f4>] detach_inform+0x24/0x30 [bttv]
 [<c024e89e>] i2c_detach_client+0x2e/0x100
 [<e0c16bad>] tuner_detach+0x1d/0x40 [tuner]
 [<c024e327>] i2c_del_adapter+0xd7/0x220
 [<c01b3c9e>] kobject_put+0x1e/0x30
 [<c01b3c9e>] kobject_put+0x1e/0x30
 [<c01b3c70>] kobject_release+0x0/0x10
 [<e0c37084>] bttv_remove+0xa4/0x160 [bttv]
 [<c01bcd3b>] pci_device_remove+0x3b/0x40
 [<c022212f>] device_release_driver+0x7f/0x90
 [<c0222160>] driver_detach+0x20/0x30
 [<c02225cc>] bus_remove_driver+0x4c/0x90
 [<c0222b83>] driver_unregister+0x13/0x30
 [<c01bcf86>] pci_unregister_driver+0x16/0x30
 [<e0c374df>] bttv_cleanup_module+0xf/0x1f [bttv]
 [<c0129137>] sys_delete_module+0x167/0x1a0
 [<c013f5a8>] do_munmap+0x118/0x150
 [<c013f624>] sys_munmap+0x44/0x70
 [<c0102543>] syscall_call+0x7/0xb
Code: 28 8b 98 c0 01 00 00 8b 13 0f 18 02 90 8d b0 c0 01 00 00 39 f3 74 2b 8d b4 26 00 00 00 00 8d 8b 44 ff ff ff 8b 41 70 85 c0 74 09 <83> b8 84 00 00 00 00 75 1a 8b 02 89 d3 89 c2 0f 18 00 90 39 f3 


Hope it helps, greetings,

- -- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.11.6)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCTygRao1/w/yPYI0RAhpYAJ9mfzp3BqTYKFu7jk8n8denOqJyqQCdG+b4
8KvyhUg8GnOdnSQ3jspBqPs=
=ZaVX
-----END PGP SIGNATURE-----
