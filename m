Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265965AbUEUSaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265965AbUEUSaR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 14:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265966AbUEUSaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 14:30:17 -0400
Received: from ns1.g-housing.de ([62.75.136.201]:19126 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S265965AbUEUSaH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 14:30:07 -0400
Message-ID: <40AE4AAB.60008@g-house.de>
Date: Fri, 21 May 2004 20:30:03 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: de-de, de-at, de, en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: kernel BUG at fs/buffer.c:1270! [TAINTED]
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

hi,

last evening i put in a cd-rw in my cdrw-drive (IDE), and automount
(triggerd by some gnome-filemanager) was about to mount it. it did not
succeed, the drive-LED was on "busy", mounting was not possible, but the
system otherwise stable. "killall -9 mount" did not succeed, neiter did
"SYSRQ+S|U" after trying to reboot, ok, i had to "SYSRQ+B" then. i never
had this before, after reboot i could successfully access my cd-rw, so
the bug is probably not reproduceable. afterwards i saw this in my log
(appended). yes, the kernel is TAINTED (nvidia module), and since the
bug only occured one time, it's probaly not worth to mention it at all.
but perhaps not and that's why is post this :-)

system is x86(amd900), kernel is 2.6-BK (updated a few days before).
so, here's the log:

hdb: irq timeout: status=0x90 { Busy }
hdb: irq timeout: error=0x00
hdb: ATAPI reset timed-out, status=0x90
ide0: reset: success
hdb: irq timeout: status=0x90 { Busy }
hdb: irq timeout: error=0x00
- ------------[ cut here ]------------
kernel BUG at fs/buffer.c:1270!
invalid operand: 0000 [#1]
PREEMPT
Modules linked in: snd_pcm_oss snd_mixer_oss snd_ens1371 snd_rawmidi
snd_pcm snd_page_alloc snd_timer snd_ac97_codec snd soundcore ide_cd
cdrom isofs zlib_inflate nls_utf8 ntfs nls_iso8859_15 vfat fat nls_base
xfs agpgart autofs4 ipv6 8250 serial_core nvidia rtc
CPU:    0
EIP:    0060:[<c0151806>]    Tainted: P
EFLAGS: 00010286   (2.6.6)
EIP is at __getblk_slow+0x66/0xf0
eax: fffffe00   ebx: 00000000   ecx: 0000d200   edx: 0000d200
esi: 00000000   edi: dffe0740   ebp: 00008000   esp: c0d25dc8
ds: 007b   es: 007b   ss: 0068
Process mount (pid: 4585, threadinfo=c0d24000 task=dd3682b0)
Stack: dffe0740 00008000 00000000 00000000 00000000 00008000 dffe0740
00000000
~       c0151bff dffe0740 00008000 00000000 00000010 00008000 df718eb8
c0151c8f
~       dffe0740 00008000 00000000 e0ca3e79 dffe0740 00008000 00000000
00000000
Call Trace:
~ [<c0151bff>] __getblk+0x4f/0x60
~ [<c0151c8f>] __bread+0x1f/0x40
~ [<e0ca3e79>] isofs_fill_super+0x159/0x700 [isofs]
~ [<c0156235>] sb_set_blocksize+0x25/0x60
~ [<c0155c3d>] get_sb_bdev+0x11d/0x150
~ [<e0ca50ef>] isofs_get_sb+0x2f/0x40 [isofs]
~ [<e0ca3d20>] isofs_fill_super+0x0/0x700 [isofs]
~ [<c0155e8f>] do_kern_mount+0x5f/0xe0
~ [<c016b0c8>] do_add_mount+0x78/0x170
~ [<c016b3c4>] do_mount+0x144/0x190
~ [<c016b223>] copy_mount_options+0x63/0xc0
~ [<c016b7af>] sys_mount+0xbf/0x140
~ [<c01040c7>] syscall_call+0x7/0xb

Code: 0f 0b f6 04 09 32 32 c0 b9 ff ff ff ff 41 89 f0 d3 e0 3d ff
~ hdb: status timeout: status=0x90 { Busy }
hdb: status timeout: error=0x00
hdb: drive not ready for command
hdb: ATAPI reset timed-out, status=0x90
ide0: reset: success


Thank you,
Christian.
- --
BOFH excuse #150:

Arcserve crashed the server again.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFArkqr+A7rjkF8z0wRAijeAKC3eMmexVwOFv3wlhTBGu+b3Td2gwCcDU/j
1v32XsVRPWxxP0V7bJo1/lQ=
=So2R
-----END PGP SIGNATURE-----
