Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbUFBOjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbUFBOjS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 10:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbUFBOjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 10:39:18 -0400
Received: from ns1.g-housing.de ([62.75.136.201]:23172 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261184AbUFBOi6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 10:38:58 -0400
Message-ID: <40BDE67A.9030402@g-house.de>
Date: Wed, 02 Jun 2004 16:38:50 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040528)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: /bin/sh: line 1: defkeymap.c: Permission denied (2.4-BK)
X-Enigmail-Version: 0.83.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

hi,

every now and then i get an error when trying to compile 2.4 kernels.
to see what's going on i just moved drivers/char/defkeymap.* to
somewhere else and did the following:


- ---------------------------------
$ la drivers/char/defkeymap.*
ls: drivers/char/defkeymap.*: No such file or directory
$ bk co drivers/char/defkeymap.c
drivers/char/defkeymap.c 1.1: 262 lines
$ bk co drivers/char/defkeymap.map
drivers/char/defkeymap.map 1.1: 357 lines
$ la drivers/char/defkeymap.*
- -r--r--r--    1 evil users  11K Jun  2 16:26 drivers/char/defkeymap.c
- -r--r--r--    1 evil users  12K Jun  2 16:26 drivers/char/defkeymap.map

$ make bzImage 2>&1 | tail -n10
make[3]: Entering directory `/usr/src/linux-2.4-BK/drivers/char'
set -e ; loadkeys --mktable defkeymap.map | sed -e 's/^static *//' >
defkeymap.c
/bin/sh: line 1: defkeymap.c: Permission denied
make[3]: *** [defkeymap.c] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4-BK/drivers/char'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4-BK/drivers/char'
make[1]: *** [_subdir_char] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4-BK/drivers'
make: *** [_dir_drivers] Error 2
$ umask
0022
- ---------------------------------

i'll chmod drivers/char/defkeymap.c to 0644 then and it's compiling
then. i can also *ignore* the error ("make -i") and the kernel will
build fine. how comes? and why is the file 0444 at all?

Thanks,
Christian.

PS: this is debian/unstable (i386), with
$ gcc --version
gcc (GCC) 3.3.3 (Debian 20040422)
Copyright (C) 2003 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

$ ld -V
GNU ld version 2.14.90.0.7 20031029 Debian GNU/Linux
~  Supported emulations:
~   elf_i386
~   i386linux
~   elf_x86_64
- --
BOFH excuse #377:

Someone hooked the twisted pair wires into the answering machine.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAveZ6+A7rjkF8z0wRAooXAJwLyxauqZ6Sb8TN3r3W0pkOZ/uiLgCfaCOI
MGQkz3B3ilygOL9pA3alviw=
=cpN3
-----END PGP SIGNATURE-----
