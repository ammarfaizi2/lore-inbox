Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267406AbTBNTnu>; Fri, 14 Feb 2003 14:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267409AbTBNTnu>; Fri, 14 Feb 2003 14:43:50 -0500
Received: from franka.aracnet.com ([216.99.193.44]:11741 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267406AbTBNTnq>; Fri, 14 Feb 2003 14:43:46 -0500
Date: Fri, 14 Feb 2003 11:53:33 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 357] New: ext3 compile failure if #define EXT3FS_DEBUG
Message-ID: <73740000.1045252413@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=357

           Summary: ext3 compile failure if #define EXT3FS_DEBUG
    Kernel Version: 2.5.60-bk4
            Status: NEW
          Severity: low
             Owner: akpm@digeo.com
         Submitter: bwindle-kbt@fint.org


Distribution: Debian Testing
Hardware Environment: x86
Software Environment: 

Linux razor 2.5.60bk4 #5 Fri Feb 14 11:17:29 EST 2003 i686 Pentium II
(Klamath)  GenuineIntel GNU/Linux

Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
e2fsprogs              1.30-WIP
reiserfsprogs          3.6.3
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 100.
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               4.5.2


CONFIG_EXT3_FS=y
# CONFIG_EXT3_FS_XATTR is not set
CONFIG_JBD=y
CONFIG_JBD_DEBUG=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_IOVIRT=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_KALLSYMS=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_FRAME_POINTER=y


Problem Description:
If you change include/linux/ext3_fs.h to #define EXT3FS_DEBUG, then 
fs/ext3/balloc.c fails to compile. It compiles if EXT3FS_DEBUG is #undef.

  gcc -Wp,-MD,fs/ext3/.balloc.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-
prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -
mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -
nostdinc -iwithprefix include    -DKBUILD_BASENAME=balloc -
DKBUILD_MODNAME=ext3 -c -o fs/ext3/balloc.o fs/ext3/balloc.c
fs/ext3/balloc.c: In function `ext3_new_block':
fs/ext3/balloc.c:506: `i' undeclared (first use in this function)
fs/ext3/balloc.c:506: (Each undeclared identifier is reported only once
fs/ext3/balloc.c:506: for each function it appears in.)
fs/ext3/balloc.c: In function `ext3_count_free_blocks':
fs/ext3/balloc.c:662: warning: long unsigned int format, unsigned int arg
(arg  2)
make[2]: *** [fs/ext3/balloc.o] Error 1
make[1]: *** [fs/ext3] Error 2
make: *** [fs] Error 2


Steps to reproduce:

change include/linux/ext3_fs.h:33 from #undef EXT3FS_DEBUG to #define 
EXT3FS_DEBUG, then recompile.


