Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318283AbSHDVfE>; Sun, 4 Aug 2002 17:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318284AbSHDVfE>; Sun, 4 Aug 2002 17:35:04 -0400
Received: from qix.net ([207.40.214.9]:50194 "EHLO qix.net")
	by vger.kernel.org with ESMTP id <S318283AbSHDVfC>;
	Sun, 4 Aug 2002 17:35:02 -0400
From: "dave" <dave@qix.net>
To: linux-kernel@vger.kernel.org
Subject: Compile error in SMP / IO-Apic code
Date: Sun, 4 Aug 2002 17:33:58 +0900
Message-Id: <20020804173358.M38976@qix.net>
X-Mailer: Open WebMail 1.62 20020221
X-OriginatingIP: 207.40.214.125 (dave)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've found a compile error during compilation of mpparse.c.  Note that I have
not configured the kernel to use IO-Apic, nor is my machine an SMP machine. 
The bug affects 2.4.19-ac1 and -ac2 but not 2.4.19-rc3 (my running kernel.) 
Also, both gcc 2.95 and 3.0 fail to compile the affected file.

The text of the compiler failure follows:

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe
-mpreferred-stack-boundary=2 -march=athlon    -nostdinc -I
/usr/lib/gcc-lib/i386-linux/3.0.4/include -DKBUILD_BASENAME=mpparse  -c -o
mpparse.o mpparse.c
mpparse.c:74: `dest_LowestPrio' undeclared here (not in a function)
mpparse.c: In function `smp_read_mpc':
mpparse.c:609: `dest_Fixed' undeclared (first use in this function)
mpparse.c:609: (Each undeclared identifier is reported only once
mpparse.c:609: for each function it appears in.)
mpparse.c:609: `dest_LowestPrio' undeclared (first use in this function)
make[2]: *** [mpparse.o] Error 1
make[2]: Leaving directory `/usr/src/linux/arch/i386/kernel'
make[1]: *** [_dir_arch/i386/kernel] Error 2
make[1]: Leaving directory `/usr/src/linux'
make: *** [stamp-build] Error 2
hell:/usr/src/linux#

Thanks,
Dave Maietta
