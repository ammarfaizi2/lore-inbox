Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288058AbSBUX5i>; Thu, 21 Feb 2002 18:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288102AbSBUX52>; Thu, 21 Feb 2002 18:57:28 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:62991 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S288058AbSBUX5M>; Thu, 21 Feb 2002 18:57:12 -0500
Date: Thu, 21 Feb 2002 18:57:12 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: linux-kernel@vger.kernel.org
Subject: 2.4.18-rc2 doesn't compile on ia64
Message-ID: <Pine.LNX.4.44.0202211828370.25435-100000@marabou.research.att.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I'm trying to compile Linux for ia64 and it doesn't compile:

$ gcc -D__KERNEL__ -I/home/proski/linux/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-pipe  -ffixed-r13 -mfixed-range=f10-f15,f32-f127 -falign-functions=32 
-frename-registers --param max-inline-insns=400 -mconstant-gp  
-DKBUILD_BASENAME=main -c -o init/main.o init/main.c
In file included from /home/proski/linux/include/linux/pagemap.h:16,
                 from /home/proski/linux/include/linux/locks.h:8,
                 from 
/home/proski/linux/include/linux/devfs_fs_kernel.h:6,
                 from init/main.c:16:
/home/proski/linux/include/linux/highmem.h: In function 
`clear_user_highpage':
/home/proski/linux/include/linux/highmem.h:49: warning: passing arg 2 of 
`clear_user_page' makes pointer from integer without a cast
/home/proski/linux/include/linux/highmem.h: In function 
`copy_user_highpage':
/home/proski/linux/include/linux/highmem.h:81: too few arguments to 
function `copy_user_page'
make: *** [init/main.o] Error 1

Indeed, clear_user_page() is defined with 3 arguments for ia-64
(include/asm-ia64/pgalloc.h) and with 2 arguments for other platforms
(include/asm-i386/page.h)

clear_user_page() is used with 2 arguments in include/linux/highmem.h, it 
is also documented with 2 arguments in Documentation/cachetlb.txt

The problem is fixed in the ia-64 patch at
http://www.kernel.org/pub/linux/kernel/ports/ia64/v2.4/ but it's still not 
in the official kernel, which means that 2.4.18 won't compile for ia-64 
unless this problem is taken care of.

-- 
Regards,
Pavel Roskin

