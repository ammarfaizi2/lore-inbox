Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130682AbQKHAFF>; Tue, 7 Nov 2000 19:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130565AbQKHAEz>; Tue, 7 Nov 2000 19:04:55 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:23050 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129940AbQKHAEm>;
	Tue, 7 Nov 2000 19:04:42 -0500
Message-ID: <3A089850.92EF0D4A@mandrakesoft.com>
Date: Tue, 07 Nov 2000 19:03:28 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
CC: davej@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Installing kernel 2.4
In-Reply-To: <Pine.LNX.4.21.0011072322120.8187-100000@neo.local> <3A089254.397115FE@timpanogas.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jeff V. Merkey" wrote:
> If the compiler always aligned all functions and data on 16 byte
> boundries (NetWare)
> for all i386 code, it would run a lot faster.

Are you saying that it isn't?  Have you look at gcc-generated assembly
from a recent 2.2.x or 2.4.x kernel?

2.2.x build command line, note use of "...align...":
/usr/bin/kgcc -D__KERNEL__ -I/spare/cvs/linux_2_2/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing
-D__SMP__ -pipe -fno-strength-reduce -m486 -malign-loops=2
-malign-jumps=2 -malign-functions=2 -DCPU=686   -c -o extable.o
extable.c

2.4.x, note "preferred-stack-boundary" and generated asm code...
gcc -D__KERNEL__ -I/spare/cvs/linux_2_4/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe
-mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include
/spare/cvs/linux_2_4/include/linux/modversions.h   -c -o emd.o emd.c


	Jeff


-- 
Jeff Garzik             | "When I do this, my computer freezes."
Building 1024           |          -user
MandrakeSoft            | "Don't do that."
                        |          -level 1
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
