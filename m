Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265127AbUBORa2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 12:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265137AbUBORa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 12:30:28 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:47041 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265127AbUBORaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 12:30:05 -0500
Date: Sun, 15 Feb 2004 18:29:58 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [2.4 patch] disallow modular BINFMT_ELF (fwd)
Message-ID: <20040215172958.GB1308@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

the patch forwarded below is still required in 2.4.25-rc2.

Please apply
Adrian



----- Forwarded message from Adrian Bunk <bunk@fs.tum.de> -----

Date:	Fri, 30 Jan 2004 20:43:23 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [2.4 patch] disallow modular BINFMT_ELF (fwd)

Hi Marcelo,

the patch forwarded below is still required in 2.4.25-pre8.

Please apply
Adrian



----- Forwarded message from Adrian Bunk <bunk@fs.tum.de> -----

Date:	Wed, 7 Jan 2004 20:47:59 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [2.4 patch] disallow modular BINFMT_ELF

Hi Marcelo,

with no 2.4 kernel BINFMT_ELF=m actually worked, you always get a

<--  snip  -->

depmod: *** Unresolved symbols in /lib/modules/2.4.25-pre4/kernel/fs/binfmt_elf.o
depmod:         smp_num_siblings
depmod:         put_files_struct
depmod:         steal_locks

<--  snip  -->


Since BINFMT_ELF=m is a very unusual case, the patch below simply
disallows modular BINFMT_ELF.

A similar patch I sent was already accepted into 2.6.

diffstat output:

 Documentation/Configure.help |    6 ------
 arch/alpha/config.in         |    2 +-
 arch/arm/config.in           |    2 +-
 arch/cris/config.in          |    2 +-
 arch/i386/config.in          |    2 +-
 arch/ia64/config.in          |    2 +-
 arch/m68k/config.in          |    2 +-
 arch/mips/config-shared.in   |    2 +-
 arch/parisc/config.in        |    2 +-
 arch/s390/config.in          |    2 +-
 arch/s390x/config.in         |    2 +-
 arch/sh/config.in            |    2 +-
 arch/sh64/config.in          |    2 +-
 arch/sparc/config.in         |    2 +-
 arch/sparc64/config.in       |    2 +-
 arch/x86_64/config.in        |    2 +-
 16 files changed, 15 insertions(+), 21 deletions(-)


Please apply
Adrian


--- linux-2.4.25-pre4-modular/arch/sh64/config.in.old	2004-01-07 20:19:34.000000000 +0100
+++ linux-2.4.25-pre4-modular/arch/sh64/config.in	2004-01-07 20:20:14.000000000 +0100
@@ -152,7 +152,7 @@
 	"ELF		CONFIG_KCORE_ELF	\
 	 A.OUT		CONFIG_KCORE_AOUT" ELF
 fi
-tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
+bool 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
 
 bool 'Select task to kill on out of memory condition' CONFIG_OOM_KILLER
--- linux-2.4.25-pre4-modular/arch/x86_64/config.in.old	2004-01-07 20:19:34.000000000 +0100
+++ linux-2.4.25-pre4-modular/arch/x86_64/config.in	2004-01-07 20:20:26.000000000 +0100
@@ -106,7 +106,7 @@
    define_bool CONFIG_KCORE_ELF y
 fi
 #tristate 'Kernel support for a.out binaries' CONFIG_BINFMT_AOUT
-tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
+bool 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
 
 bool 'Power Management support' CONFIG_PM
--- linux-2.4.25-pre4-modular/arch/i386/config.in.old	2004-01-07 20:19:34.000000000 +0100
+++ linux-2.4.25-pre4-modular/arch/i386/config.in	2004-01-07 20:21:07.000000000 +0100
@@ -326,7 +326,7 @@
 	 A.OUT		CONFIG_KCORE_AOUT" ELF
 fi
 tristate 'Kernel support for a.out binaries' CONFIG_BINFMT_AOUT
-tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
+bool 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
 bool 'Select task to kill on out of memory condition' CONFIG_OOM_KILLER
 
--- linux-2.4.25-pre4-modular/arch/alpha/config.in.old	2004-01-07 20:19:34.000000000 +0100
+++ linux-2.4.25-pre4-modular/arch/alpha/config.in	2004-01-07 20:21:26.000000000 +0100
@@ -314,7 +314,7 @@
 	bool '  OSF/1 v4 readv/writev compatibility' CONFIG_OSF4_COMPAT
 fi
 
-tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
+bool 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
 tristate 'Kernel support for Linux/Intel ELF binaries' CONFIG_BINFMT_EM86
 source drivers/parport/Config.in
--- linux-2.4.25-pre4-modular/arch/sparc/config.in.old	2004-01-07 20:19:34.000000000 +0100
+++ linux-2.4.25-pre4-modular/arch/sparc/config.in	2004-01-07 20:21:38.000000000 +0100
@@ -73,7 +73,7 @@
    define_bool CONFIG_KCORE_ELF y
 fi
 tristate 'Kernel support for a.out binaries' CONFIG_BINFMT_AOUT
-tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
+bool 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
 bool 'SunOS binary emulation' CONFIG_SUNOS_EMUL
 bool 'Select task to kill on out of memory condition' CONFIG_OOM_KILLER
--- linux-2.4.25-pre4-modular/arch/mips/config-shared.in.old	2004-01-07 20:19:34.000000000 +0100
+++ linux-2.4.25-pre4-modular/arch/mips/config-shared.in	2004-01-07 20:21:57.000000000 +0100
@@ -930,7 +930,7 @@
 define_bool CONFIG_KCORE_ELF y
 define_bool CONFIG_KCORE_AOUT n
 define_bool CONFIG_BINFMT_AOUT n
-tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
+bool 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
 dep_bool 'Kernel support for Linux/MIPS 32-bit binary compatibility' CONFIG_MIPS32_COMPAT $CONFIG_MIPS64
 dep_bool 'Kernel support for o32 binaries' CONFIG_MIPS32_O32 $CONFIG_MIPS32_COMPAT
 dep_bool 'Kernel support for n32 binaries' CONFIG_MIPS32_N32 $CONFIG_MIPS32_COMPAT
--- linux-2.4.25-pre4-modular/arch/m68k/config.in.old	2004-01-07 20:19:34.000000000 +0100
+++ linux-2.4.25-pre4-modular/arch/m68k/config.in	2004-01-07 20:22:10.000000000 +0100
@@ -98,7 +98,7 @@
 	 A.OUT		CONFIG_KCORE_AOUT" ELF
 fi
 tristate 'Kernel support for a.out binaries' CONFIG_BINFMT_AOUT
-tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
+bool 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
 
 if [ "$CONFIG_AMIGA" = "y" ]; then
--- linux-2.4.25-pre4-modular/arch/sparc64/config.in.old	2004-01-07 20:19:34.000000000 +0100
+++ linux-2.4.25-pre4-modular/arch/sparc64/config.in	2004-01-07 20:22:20.000000000 +0100
@@ -76,7 +76,7 @@
    tristate '  Kernel support for 32-bit ELF binaries' CONFIG_BINFMT_ELF32
    bool '  Kernel support for 32-bit (ie. SunOS) a.out binaries' CONFIG_BINFMT_AOUT32
 fi
-tristate 'Kernel support for 64-bit ELF binaries' CONFIG_BINFMT_ELF
+bool 'Kernel support for 64-bit ELF binaries' CONFIG_BINFMT_ELF
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
 bool 'SunOS binary emulation' CONFIG_SUNOS_EMUL
 if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
--- linux-2.4.25-pre4-modular/arch/arm/config.in.old	2004-01-07 20:19:34.000000000 +0100
+++ linux-2.4.25-pre4-modular/arch/arm/config.in	2004-01-07 20:22:40.000000000 +0100
@@ -498,7 +498,7 @@
 	"ELF		CONFIG_KCORE_ELF	\
 	 A.OUT		CONFIG_KCORE_AOUT" ELF
 tristate 'Kernel support for a.out binaries' CONFIG_BINFMT_AOUT
-tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
+bool 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
 dep_bool 'Power Management support (experimental)' CONFIG_PM $CONFIG_EXPERIMENTAL
 dep_tristate 'RISC OS personality' CONFIG_ARTHUR $CONFIG_CPU_32
--- linux-2.4.25-pre4-modular/arch/sh/config.in.old	2004-01-07 20:19:34.000000000 +0100
+++ linux-2.4.25-pre4-modular/arch/sh/config.in	2004-01-07 20:22:49.000000000 +0100
@@ -282,7 +282,7 @@
 	"ELF		CONFIG_KCORE_ELF	\
 	 A.OUT		CONFIG_KCORE_AOUT" ELF
 fi
-tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
+bool 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
 
 bool 'Select task to kill on out of memory condition' CONFIG_OOM_KILLER
--- linux-2.4.25-pre4-modular/arch/ia64/config.in.old	2004-01-07 20:19:34.000000000 +0100
+++ linux-2.4.25-pre4-modular/arch/ia64/config.in	2004-01-07 20:23:06.000000000 +0100
@@ -99,7 +99,7 @@
 bool 'System V IPC' CONFIG_SYSVIPC
 bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
 bool 'Sysctl support' CONFIG_SYSCTL
-tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
+bool 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
 
 if [ "$CONFIG_IA64_HP_SIM" = "n" ]; then
--- linux-2.4.25-pre4-modular/arch/s390/config.in.old	2004-01-07 20:19:35.000000000 +0100
+++ linux-2.4.25-pre4-modular/arch/s390/config.in	2004-01-07 20:23:20.000000000 +0100
@@ -57,7 +57,7 @@
 bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
 bool 'Sysctl support' CONFIG_SYSCTL
 define_bool CONFIG_KCORE_ELF y
-tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
+bool 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
 bool 'Show crashed user process info' CONFIG_PROCESS_DEBUG
 bool 'Pseudo page fault support' CONFIG_PFAULT
--- linux-2.4.25-pre4-modular/arch/parisc/config.in.old	2004-01-07 20:19:35.000000000 +0100
+++ linux-2.4.25-pre4-modular/arch/parisc/config.in	2004-01-07 20:23:30.000000000 +0100
@@ -88,7 +88,7 @@
 bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
 bool 'Sysctl support' CONFIG_SYSCTL
 define_bool CONFIG_KCORE_ELF y
-tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
+bool 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
 tristate 'Kernel support for SOM binaries' CONFIG_BINFMT_SOM
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
 
--- linux-2.4.25-pre4-modular/arch/cris/config.in.old	2004-01-07 20:19:35.000000000 +0100
+++ linux-2.4.25-pre4-modular/arch/cris/config.in	2004-01-07 20:23:44.000000000 +0100
@@ -30,7 +30,7 @@
 bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
 bool 'Sysctl support' CONFIG_SYSCTL
 
-tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
+bool 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
 
 string 'Kernel command line' CONFIG_ETRAX_CMDLINE "root=/dev/mtdblock3"
 
--- linux-2.4.25-pre4-modular/arch/s390x/config.in.old	2004-01-07 20:19:35.000000000 +0100
+++ linux-2.4.25-pre4-modular/arch/s390x/config.in	2004-01-07 20:23:55.000000000 +0100
@@ -60,7 +60,7 @@
 bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
 bool 'Sysctl support' CONFIG_SYSCTL
 define_bool CONFIG_KCORE_ELF y
-tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
+bool 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
 bool 'Show crashed user process info' CONFIG_PROCESS_DEBUG
 bool 'Pseudo page fault support' CONFIG_PFAULT
--- linux-2.4.25-pre4-modular/Documentation/Configure.help.old	2004-01-07 20:19:35.000000000 +0100
+++ linux-2.4.25-pre4-modular/Documentation/Configure.help	2004-01-07 20:24:18.000000000 +0100
@@ -4553,12 +4553,6 @@
   ld.so (check the file <file:Documentation/Changes> for location and
   latest version).
 
-  If you want to compile this as a module ( = code which can be
-  inserted in and removed from the running kernel whenever you want),
-  say M here and read <file:Documentation/modules.txt>.  The module
-  will be called binfmt_elf.o. Saying M or N here is dangerous because
-  some crucial programs on your system might be in ELF format.
-
 Kernel support for a.out binaries
 CONFIG_BINFMT_AOUT
   A.out (Assembler.OUTput) is a set of formats for libraries and
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

