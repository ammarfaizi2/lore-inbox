Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264463AbTGGVS3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 17:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264487AbTGGVS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 17:18:29 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:35749
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S264463AbTGGVS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 17:18:28 -0400
Message-ID: <3F09E6EF.8000806@redhat.com>
Date: Mon, 07 Jul 2003 14:32:31 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030703 Thunderbird/0.1a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: syscall __NR_mmap2
References: <Pine.LNX.4.53.0307071655470.22074@chaos>
In-Reply-To: <Pine.LNX.4.53.0307071655470.22074@chaos>
X-Enigmail-Version: 0.80.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Richard B. Johnson wrote:

> write(1, "Addr = 000b8000\n", 16)       = 16
> open("/dev/mem", O_RDWR)                = 3
> mmap2(0xb8000, 8192, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_FIXED, 3, 0xb8000) = 0xb8000

mmap64() (and if you compile glibc with an adequate minimal kernel
requirement mmap as well) is implemented using mmap2.  It works nicely.
 Admittedly, I haven't used the stock 2.4 kernel.  And I also haven't
used /dev/mem.  But at least for the first part I would expect to see
problem reports since the code is used and glibc wouldn't work.

In your code, assuming this is x86, do you really want to read the
memory starting at address 0xb8000000?  This is what your code does.  I
don't know enough about the kernel memory layout to say whether
something is supposed to be there or not.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/Cebv2ijCOnn/RHQRAukcAKCbI3cTMvmAsHxRWX2ralSqUlcp8ACfTBRU
PNoh4p0/XrWFWXk9JnbnNyk=
=DQ6S
-----END PGP SIGNATURE-----

