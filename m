Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263173AbSJWJ1i>; Wed, 23 Oct 2002 05:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263207AbSJWJ1i>; Wed, 23 Oct 2002 05:27:38 -0400
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:62276 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S263173AbSJWJ1g>; Wed, 23 Oct 2002 05:27:36 -0400
Date: Wed, 23 Oct 2002 02:42:04 -0700 (PDT)
From: "Matt D. Robinson" <yakker@aparity.com>
To: linux-kernel@vger.kernel.org
cc: lkcd-devel@lists.sourceforge.net
Subject: [ANNOUNCE] LKCD for 2.5.44 - full patch set (2002.10.23)
Message-ID: <Pine.LNX.4.44.0210230241050.27315-100000@nakedeye.aparity.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are the latest LKCD patches for 2.5.44.  We have incorporated
just about every fix (with a few exceptions) from all users who have
made requests up through yesterday.  We ask that these be included
in the kernel tree.  If they are incorporated, please copy me on the
check-in.

In terms of what has changed since the last patch set:

- fixed DUMP_MODULE_NAME defintions
- removed DUMP_PRINT{,N,F} calls
- changed to C99 initializers
- removed all typedefs from dump structures
- fixed a few formatting problems
- removed DUMP_DEBUG capabilities
- removed casting problems
- converted to atomic_t, then back to volatile (per Keith Owens,
  which is the right thing to do) for various dump configurable
  variables.
- added option to turn off gzip (which turns off zlib) for
  gzip dump compression
- removed the last CONFIG_CRASH_DUMP{,_MODULE} definitions
- removed LINUX_VERSION_CODE calls
- cleaned up and added MODULE_AUTHOR() and MODULE_DESCRIPTION()
- updated MAINTAINERS
- corrected all applicable install.sh scripts
- fixed a couple of kmap_atomic()/kunmap_atomic() problems
- changed to u{16,32,64} types
- added more static types for real static variables
- cleaned up mbank code
- cleaned up some extra ifdefs for DISCONTIGMEM and arch specific stuff
- discontinued the use of mem_map, using pfn_to_page instead
- bio initialization now done in dump_open() instead of dump_ioctl()
- moved arch specific code (like page_is_ram) to arch files
- removed DUMP_KIOBUF_NUMBER
- added Config.help information

We have tested again on multiple kernels with various types of
dumping devices.  The diffstat output is now at the top of each
patch.  These patches have been well tested, and crash dumps can
be generated pretty easily.  Feel free to give them a try.  Let
us know if you have any problems.

With all this said, please incorporate these patches into the
kernel tree.  We feel that we've done what has been requested
in as many ways as possible to get the code in line with what
other kernel maintainers have asked.

Thanks,

--Matt

P.S.  The patches can be downloaded from the web at:

      http://lkcd.sourceforge.net/download/latest

The full diffstat for LKCD in 2.5.44 tree (the majority of the
changes are the addition of the dump modules and headers):

 Makefile                             |   15 
 arch/i386/boot/Makefile              |    2 
 arch/i386/boot/install.sh            |   24 
 arch/i386/config.in                  |   11 
 arch/i386/kernel/Makefile            |    2 
 arch/i386/kernel/irq.c               |    5 
 arch/i386/kernel/nmi.c               |    9 
 arch/i386/kernel/smp.c               |   15 
 arch/i386/kernel/traps.c             |   28 
 arch/i386/mach-generic/irq_vectors.h |    1 
 arch/i386/mm/Makefile                |    2 
 arch/i386/mm/init.c                  |    5 
 arch/s390/boot/install.sh            |   24 
 arch/s390x/boot/install.sh           |   24 
 drivers/Makefile                     |    1 
 drivers/char/sysrq.c                 |   13 
 include/asm-i386/smp.h               |    1 
 include/linux/major.h                |    2 
 include/linux/page-flags.h           |    5 
 init/Makefile                        |    5 
 init/kerntypes.c                     |   24 
 init/main.c                          |   10 
 kernel/Makefile                      |    2 
 kernel/panic.c                       |   16 
 kernel/sched.c                       |   30 
 kernel/sys.c                         |   36 
 lib/Config.in                        |    2 
 mm/page_alloc.c                      |   22 

As far as new changes are concerned, the majority of changes to
the release are contained in the dump driver code itself.

 drivers/dump/Makefile                |   26 
 drivers/dump/dump_base.c             | 1641 +++++++++++++++++++++++++++++++++++
 drivers/dump/dump_blockdev.c         |  361 +++++++
 drivers/dump/dump_gzip.c             |  119 ++
 drivers/dump/dump_i386.c             |  322 ++++++
 drivers/dump/dump_rle.c              |  176 +++
 include/asm-i386/dump.h              |  101 ++
 include/linux/dump.h                 |  349 +++++++

 36 files changed, 3398 insertions(+), 33 deletions(-) total.

