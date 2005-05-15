Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261388AbVEOAEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbVEOAEG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 20:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbVEOAEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 20:04:06 -0400
Received: from ns1.g-housing.de ([62.75.136.201]:45232 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261388AbVEOAD6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 20:03:58 -0400
Message-ID: <428691E3.9040800@g-house.de>
Date: Sun, 15 May 2005 02:03:47 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050326)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>
Subject: probably NFS related Oops during shutdown with 2.6.12-rc3-mm3
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

hi,

i noticed that i get an Oops during shutdown and it says something about
rpciod/0 and i do have NFSv3 volumes mounted (and thus unmounted on
shutdown), full log, dmesg, .config here:

    http://nerdbynature.de/bits/prinz/2.6.12-rc3-mm3/

CPU:    0
EIP:    0060:[<00000000>]    Not tainted VLI
EFLAGS: 00010282   (2.6.12-rc3-mm3)
EIP is at _stext+0x3feffdd8/0x8
eax: c1628ec0   ebx: c1628ec0   ecx: 00000000   edx: dfa600b0
esi: 00000000   edi: c1628f34   ebp: de9327c0   esp: de413f24
ds: 007b   es: 007b   ss: 0068
Process rpciod/0 (pid: 8245, threadinfo=de412000 task=dfa600b0)

Stack:
c039942b
dfa600b0
dfa601d8
00000292
c1628f3c
00000297
c1628f40
c012b31e


00000000
00000000
dffc4550
de412000
de9327d8
de9327c8
de9327d0
de412000


c1628ec0
c0399560
de412000
ffffffff
ffffffff
00000001
00000000
c0117cf0


Call Trace:
[<c039942b>] __rpc_execute+0x14b/0x250
[<c012b31e>] worker_thread+0x1ae/0x280
[<c0399560>] rpc_async_schedule+0x0/0x10
[<c0117cf0>] default_wake_function+0x0/0x10
[<c0117d37>] __wake_up_common+0x37/0x60
[<c0117cf0>] default_wake_function+0x0/0x10
[<c012b170>] worker_thread+0x0/0x280
[<c012f615>] kthread+0x95/0xd0
[<c012f580>] kthread+0x0/0xd0
[<c010136d>] kernel_thread_helper+0x5/0x18


thank you,
Christian.

PS: i'm booting with netconsole which is *really* great for such things,
because the oops did not make it to the disk, as the local-filesystems are
already unmonted (shutdown!). but: the output is really odd. for example
the first line after the Call Trace looked like this:

Call Trace:
[<c039942b>]
 __rpc_execute+0x14b/0x250


ok, easy - just delete the linewrap. but i really wonder if the Stack:
above is readable at all (i haven't touched it)

- --
BOFH excuse #69:

knot in cables caused data stream to become twisted and kinked
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFChpHj+A7rjkF8z0wRAiSwAJ9LwFJT268TJMkNDEQ0asxMsxPfeACeKJzl
0aRaGxGJXfEsWBgjMJVQrHI=
=Vz3W
-----END PGP SIGNATURE-----
