Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265715AbUBQCIX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 21:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265729AbUBQCIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 21:08:23 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:63967 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S265715AbUBQCIL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 21:08:11 -0500
Message-ID: <40317785.3060509@g-house.de>
Date: Tue, 17 Feb 2004 03:08:05 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>, linux-crypto@nl.linux.org
Subject: 2.4.24 + cryptoloop: __alloc_pages: 5-order allocation failed
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

hi,

today i played around with some benchmarks i do from time to time [1]
this time with 2.4.24 and the cryptoloop patch
(patch-cryptoloop-jari-2.4.22.0, applies to 2.4.24 too) when using this
machine (powerpc)

http://www.nerdbynature.de/bits/sheep/2.4.24-benh/ver_linux

in short: i have a 700 MB file, losetup a loop device with a cipher
(aes,cast5,cast6,blowfish,serpent,twofish), create an ext3 fs on it.
then test with "tiobench" (size is only about 100MB). but the benchmarks
did not last very long, i have these messages in my syslog:

Dec 21 23:42:45 sheep kernel: __alloc_pages: 0-order allocation failed
(gfp=0x1d2/0)
Dec 21 23:42:45 sheep kernel: VM: killing process nmbd
Dec 21 23:43:07 sheep kernel: __alloc_pages: 0-order allocation failed
(gfp=0x1d2/0)
[...]
Dec 23 22:26:37 sheep kernel: __alloc_pages: 5-order allocation failed
(gfp=0x20/0)
Dec 23 22:26:39 sheep kernel: __alloc_pages: 5-order allocation failed
(gfp=0x20/0)
Dec 23 22:26:40 sheep kernel: __alloc_pages: 5-order allocation failed
(gfp=0x20/0)
Dec 23 22:26:41 sheep kernel: __alloc_pages: 5-order allocation failed
(gfp=0x20/0)
[...]
Feb 16 15:17:21 sheep kernel: __alloc_pages: 0-order allocation failed
(gfp=0x30/0)

full log excerpt on:
http://www.nerdbynature.de/bits/sheep/2.4.24/messages-alloc_pages

i am then able to sysrq-S, but not all partitions can be synced, then i
try sysrq-E / -I / -U with no luck, nothing seems to be written/read
to/from the disk, sysrq-B works :-)

i did manage to make earlier tests with different filesystems [2] and
linux 2.4.22 and have never had these messages.

Thanks for your hints,
Christian.

[1] http://www.nerdbynature.de/bench/
[2] http://www.nerdbynature.de/bench/sheep/
- --
BOFH excuse #62:

need to wrap system in aluminum foil to fix problem
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAMXeF+A7rjkF8z0wRAnpNAJ0evZDjZJdMorl60BfYCcogGWsYlwCgnU/B
ZICw1HmIv8Hnrh0D+W29l7A=
=o7Wu
-----END PGP SIGNATURE-----
