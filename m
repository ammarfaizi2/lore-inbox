Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264993AbUFMEC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264993AbUFMEC5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 00:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264997AbUFMEC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 00:02:57 -0400
Received: from dev.tequila.jp ([128.121.50.153]:20742 "EHLO dev.tequila.jp")
	by vger.kernel.org with ESMTP id S264993AbUFMECz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 00:02:55 -0400
Message-ID: <40CBD251.4000601@eunet.at>
Date: Sun, 13 Jun 2004 13:04:33 +0900
From: Clemens Schwaighofer <schwaigl@eunet.at>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: gullevek@gullevek.org, linux-kernel@vger.kernel.org, cs@tequila.co.jp
Subject: Re: compile error with 2.6.7-rc3-mm1
References: <40C9AF48.2040807@gullevek.org>	<20040611062829.574db94f.pj@sgi.com>	<40CA6835.2070405@eunet.at>	<20040612034430.72a8207e.pj@sgi.com>	<40CBC809.3000102@eunet.at> <20040612204207.0136b76f.pj@sgi.com>
In-Reply-To: <20040612204207.0136b76f.pj@sgi.com>
X-Enigmail-Version: 0.83.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Paul Jackson wrote:

| Try doing the make with V=1
|
|   make V=1 drivers/perfctr/x86.o
|
| Determine the exact compilation line (perhaps a couple hundred chars
| long) that issues the error, then manually repeat that line manually
| (cut+paste), adding the option "-save-temps".
|
| This will look something similar to the following, which I generated for
| a different file, different compilation environment (I added the wrapping
| and backslashes for display purposes here):
|
|     gcc -save-temps -Wp,-MD,kernel/.cpuset.o.d -nostdinc -iwithprefix \
|     include -D__KERNEL__ -Iinclude  -Wall -Wstrict-prototypes
- -Wno-trigraphs \
|     -fno-strict-aliasing -fno-common -pipe -msoft-float \
|     -mpreferred-stack-boundary=2  -march=pentium4 -mregparm=3 \
|     -Iinclude/asm-i386/mach-default -O2 -fomit-frame-pointer \
|     -DKBUILD_BASENAME=cpuset -DKBUILD_MODNAME=cpuset -c -o
kernel/cpuset.o \
|     kernel/cpuset.c
|
| Then look at the ./x86.i file (in top directory), which is the
| preprocessor output, to see if the (cpumask_t) cast is present.
|

yeah I have the cputmask_t here:

typedef struct { unsigned long bits[(((1)+32 -1)/32)]; } cpumask_t;
extern cpumask_t _unused_cpumask_arg_;

...
a lot of static .. cpu_set, call, etc
...
# 259 "include/linux/cpumask.h"
...
2 more cpumask_ ...
...
# 338 "include/linux/cpumask.h"
extern cpumask_t cpu_possible_map;
extern cpumask_t cpu_online_map;
extern cpumask_t cpu_present_map;

lg, clemens
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAy9JRJwwYX0IeBp8RAhV4AJ9HZdmP06+8xZYVqoYb8gGPzsfcOACcCoW5
/OEinuTlAEFiyTzXKyBmm6I=
=XgdM
-----END PGP SIGNATURE-----
