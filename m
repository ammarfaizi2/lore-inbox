Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272563AbRIKUxN>; Tue, 11 Sep 2001 16:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272565AbRIKUxE>; Tue, 11 Sep 2001 16:53:04 -0400
Received: from cliff.mcs.anl.gov ([140.221.9.17]:60800 "EHLO mcs.anl.gov")
	by vger.kernel.org with ESMTP id <S272563AbRIKUwx>;
	Tue, 11 Sep 2001 16:52:53 -0400
Date: Tue, 11 Sep 2001 15:53:10 -0500 (CDT)
From: "Daniel C. Nurmi" <nurmi@mcs.anl.gov>
To: linux-kernel@vger.kernel.org
Subject: 2.4.9-ac9 modversion problem
Message-ID: <Pine.LNX.4.21.0109111532360.8400-100000@shakey.mcs.anl.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I am attempting to compile a kernel module under linux-2.4.9-ac9.  This
code was last known to work under linux-2.4.2.  The kernel module in
question part of the PVFS package available from
ftp://ftp.parl.clemson.edu/pub/pvfs.  I am using the egcs-2.91.66 that
comes with redhat 7.1.  My kernel is compiled with modversions enabled.

The compilation problem I'm seeing follows:

kgcc -O2 -Wall -Wstrict-prototypes -DMODULE -D__KERNEL__ -DLINUX
-I. -Ipvfs-includes -I../pvfs/include  -c ./pvfs_mod.c -o pvfs_mod.o
/usr/include/linux/dcache.h: In function `dget':
In file included from /usr/include/linux/fs.h:19,
                 from /usr/include/linux/capability.h:17,
                 from /usr/include/linux/binfmts.h:5,
                 from /usr/include/linux/sched.h:9,
                 from /usr/include/linux/mm.h:4,
                 from pvfs_linux.h:39,
                 from ./pvfs_mod.c:26:
/usr/include/linux/dcache.h:247: warning: implicit declaration of function
`do_BUG_Rsmp_577f4bff'
/usr/include/asm/pgalloc.h: In function `get_pgd_fast':
In file included from /usr/include/linux/highmem.h:5,
                 from /usr/include/linux/pagemap.h:16,
                 from pvfs_linux.h:50,
                 from ./pvfs_mod.c:26:
/usr/include/asm/pgalloc.h:74: `cpu_data_Rsmp_5fa2f521' undeclared (first
use in this function)
/usr/include/asm/pgalloc.h:74: (Each undeclared identifier is reported
only once
/usr/include/asm/pgalloc.h:74: for each function it appears in.)
/usr/include/asm/pgalloc.h: In function `free_pgd_fast':
/usr/include/asm/pgalloc.h:85: `cpu_data_Rsmp_5fa2f521' undeclared (first
use in this function)
/usr/include/asm/pgalloc.h: In function `pte_alloc_one_fast':
/usr/include/asm/pgalloc.h:117: `cpu_data_Rsmp_5fa2f521' undeclared (first
use in this function)
/usr/include/asm/pgalloc.h: In function `pte_free_fast':
/usr/include/asm/pgalloc.h:127: `cpu_data_Rsmp_5fa2f521' undeclared (first
use in this function)
make: *** [pvfs_mod.o] Error 1


I may have boiled the problem down further by showing that the above error
can be shown by trying to compile the following simple program:

#include <linux/config.h>
#include <linux/version.h>
#include <linux/module.h>
#include <linux/modversions.h>
#include <linux/pagemap.h>

main() {
	printf("flaah\n");
	return(0);
}


This program compiles under 2.4.2 (modversions enabled) and fails under
2.4.5++ (modversions enabled).

Any suggestions would be greatly appreciated!

Thank You,
-Dan Nurmi


