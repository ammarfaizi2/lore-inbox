Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319484AbSIMCNJ>; Thu, 12 Sep 2002 22:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319493AbSIMCNI>; Thu, 12 Sep 2002 22:13:08 -0400
Received: from line106-15.adsl.actcom.co.il ([192.117.106.15]:21727 "EHLO
	www.veltzer.org") by vger.kernel.org with ESMTP id <S319484AbSIMCMu>;
	Thu, 12 Sep 2002 22:12:50 -0400
Message-Id: <200209130228.g8D2SJM07972@www.veltzer.org>
From: Mark Veltzer <mark@veltzer.org>
Organization: Meta Ltd.
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Patch to make shbang scripts a configuration option
Date: Fri, 13 Sep 2002 05:27:37 +0300
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_1UUCQFAOQLE6XBDZ0QGU"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_1UUCQFAOQLE6XBDZ0QGU
Content-Type: text/plain;
  charset="iso-8859-9"
Content-Transfer-Encoding: 8bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi!

This patch adds a tri state option in configuration so that kernels could be 
created without scripts support (shbang first line).

Why would you want that ? Embedded systems which only run a few binaries and 
would like to save a little RAM. The default is 'Y' and the configure.help 
states that you should put a 'Y' if unsure.

The patch is for 2.4.19.

This is my first patch to the kernel so please don't flame me too hard...

Any comments are welcome.

Mark
- -- 
Name: Mark Veltzer
Email: mailto:mark@veltzer.org
Homepage: http://www.veltzer.org
Get my public key at http://www.veltzer.org/ascx/public_key.asc
Add my public key using gpg --keyserver wwwkeys.pgp.net --recv-keys C71E5D38.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9gU0hxlxDIcceXTgRAhZYAJ9/L70P9jwiRu3+RkwiB0xsq6YW9wCg1GZ3
Sw8qCaI5zFyu8yRGrNi/WJo=
=Ia4L
-----END PGP SIGNATURE-----

--------------Boundary-00=_1UUCQFAOQLE6XBDZ0QGU
Content-Type: text/x-diff;
  charset="iso-8859-9";
  name="linux-2.4.19-shbang.patch"
Content-Transfer-Encoding: quoted-printable
Content-Description: Shbang patch
Content-Disposition: attachment; filename="linux-2.4.19-shbang.patch"

diff -urN linux-2.4.19/Documentation/Configure.help linux-2.4.19-shbang/D=
ocumentation/Configure.help
--- linux-2.4.19/Documentation/Configure.help=09Sat Aug  3 03:39:42 2002
+++ linux-2.4.19-shbang/Documentation/Configure.help=09Fri Aug 30 14:00:2=
1 2002
@@ -3813,6 +3813,15 @@
   Not necessary unless you're using a very out-of-date binutils
   version.  You probably want KCORE_ELF.
=20
+Kernel support for Shbang scripts
+CONFIG_BINFMT_SHBANG
+  Shbang scripts are text files which have a "#![interpreter]" prefix
+  and which can be run by the kernel. Most systems need this type of
+  support since a lot of the system is made up of these types of
+  scripts. Say N here only if you are making a very weird type of
+  system (embedded perhaps) and you are sure that your system doesnt
+  have any shbang script. If unsure - say Y here.
+
 Kernel support for ELF binaries
 CONFIG_BINFMT_ELF
   ELF (Executable and Linkable Format) is a format for libraries and
diff -urN linux-2.4.19/arch/alpha/config.in linux-2.4.19-shbang/arch/alph=
a/config.in
--- linux-2.4.19/arch/alpha/config.in=09Sat Aug  3 03:39:42 2002
+++ linux-2.4.19-shbang/arch/alpha/config.in=09Fri Aug 30 14:12:36 2002
@@ -288,6 +288,7 @@
 fi
=20
 tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
+tristate 'Kernel support for SHBANG binaries' CONFIG_BINFMT_SHBANG
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
 tristate 'Kernel support for Linux/Intel ELF binaries' CONFIG_BINFMT_EM8=
6
 source drivers/parport/Config.in
diff -urN linux-2.4.19/arch/alpha/defconfig linux-2.4.19-shbang/arch/alph=
a/defconfig
--- linux-2.4.19/arch/alpha/defconfig=09Tue Nov 20 01:19:42 2001
+++ linux-2.4.19-shbang/arch/alpha/defconfig=09Fri Aug 30 14:08:04 2002
@@ -71,6 +71,7 @@
 # CONFIG_KCORE_AOUT is not set
 # CONFIG_BINFMT_AOUT is not set
 CONFIG_BINFMT_ELF=3Dy
+CONFIG_BINFMT_SHBANG=3Dy
 # CONFIG_BINFMT_MISC is not set
 # CONFIG_BINFMT_EM86 is not set
=20
diff -urN linux-2.4.19/arch/arm/config.in linux-2.4.19-shbang/arch/arm/co=
nfig.in
--- linux-2.4.19/arch/arm/config.in=09Sat Aug  3 03:39:42 2002
+++ linux-2.4.19-shbang/arch/arm/config.in=09Fri Aug 30 14:12:52 2002
@@ -435,6 +435,7 @@
 =09 A.OUT=09=09CONFIG_KCORE_AOUT" ELF
 tristate 'Kernel support for a.out binaries' CONFIG_BINFMT_AOUT
 tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
+tristate 'Kernel support for SHBANG binaries' CONFIG_BINFMT_SHBANG
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
 dep_bool 'Power Management support (experimental)' CONFIG_PM $CONFIG_EXP=
ERIMENTAL
 dep_tristate 'RISC OS personality' CONFIG_ARTHUR $CONFIG_CPU_32
diff -urN linux-2.4.19/arch/arm/defconfig linux-2.4.19-shbang/arch/arm/de=
fconfig
--- linux-2.4.19/arch/arm/defconfig=09Sun May 20 03:43:05 2001
+++ linux-2.4.19-shbang/arch/arm/defconfig=09Fri Aug 30 14:08:12 2002
@@ -85,6 +85,7 @@
 # CONFIG_KCORE_AOUT is not set
 CONFIG_BINFMT_AOUT=3Dy
 CONFIG_BINFMT_ELF=3Dy
+CONFIG_BINFMT_SHBANG=3Dy
 # CONFIG_BINFMT_MISC is not set
 # CONFIG_PM is not set
 # CONFIG_ARTHUR is not set
diff -urN linux-2.4.19/arch/cris/config.in linux-2.4.19-shbang/arch/cris/=
config.in
--- linux-2.4.19/arch/cris/config.in=09Mon Feb 25 21:37:52 2002
+++ linux-2.4.19-shbang/arch/cris/config.in=09Fri Aug 30 14:13:07 2002
@@ -31,6 +31,7 @@
 bool 'Sysctl support' CONFIG_SYSCTL
=20
 tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
+tristate 'Kernel support for SHBANG binaries' CONFIG_BINFMT_SHBANG
=20
 bool 'Use kernel gdb debugger' CONFIG_ETRAX_KGDB
=20
diff -urN linux-2.4.19/arch/cris/defconfig linux-2.4.19-shbang/arch/cris/=
defconfig
--- linux-2.4.19/arch/cris/defconfig=09Sat Aug  3 03:39:42 2002
+++ linux-2.4.19-shbang/arch/cris/defconfig=09Fri Aug 30 14:08:19 2002
@@ -18,6 +18,7 @@
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_SYSCTL is not set
 CONFIG_BINFMT_ELF=3Dy
+CONFIG_BINFMT_SHBANG=3Dy
 # CONFIG_ETRAX_KGDB is not set
 # CONFIG_ETRAX_WATCHDOG is not set
=20
diff -urN linux-2.4.19/arch/i386/config.in linux-2.4.19-shbang/arch/i386/=
config.in
--- linux-2.4.19/arch/i386/config.in=09Sat Aug  3 03:39:42 2002
+++ linux-2.4.19-shbang/arch/i386/config.in=09Fri Aug 30 14:13:11 2002
@@ -268,6 +268,7 @@
 fi
 tristate 'Kernel support for a.out binaries' CONFIG_BINFMT_AOUT
 tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
+tristate 'Kernel support for SHBANG binaries' CONFIG_BINFMT_SHBANG
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
=20
 bool 'Power Management support' CONFIG_PM
diff -urN linux-2.4.19/arch/i386/defconfig linux-2.4.19-shbang/arch/i386/=
defconfig
--- linux-2.4.19/arch/i386/defconfig=09Sat Aug  3 03:39:42 2002
+++ linux-2.4.19-shbang/arch/i386/defconfig=09Fri Aug 30 14:07:43 2002
@@ -107,6 +107,7 @@
 CONFIG_BINFMT_AOUT=3Dy
 CONFIG_BINFMT_ELF=3Dy
 CONFIG_BINFMT_MISC=3Dy
+CONFIG_BINFMT_SHBANG=3Dy
 CONFIG_PM=3Dy
 # CONFIG_APM is not set
=20
diff -urN linux-2.4.19/arch/ia64/config.in linux-2.4.19-shbang/arch/ia64/=
config.in
--- linux-2.4.19/arch/ia64/config.in=09Sat Aug  3 03:39:42 2002
+++ linux-2.4.19-shbang/arch/ia64/config.in=09Fri Aug 30 14:13:13 2002
@@ -104,6 +104,7 @@
 bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
 bool 'Sysctl support' CONFIG_SYSCTL
 tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
+tristate 'Kernel support for SHBANG binaries' CONFIG_BINFMT_SHBANG
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
=20
 if [ "$CONFIG_IA64_HP_SIM" =3D "n" ]; then
diff -urN linux-2.4.19/arch/ia64/defconfig linux-2.4.19-shbang/arch/ia64/=
defconfig
--- linux-2.4.19/arch/ia64/defconfig=09Sat Aug  3 03:39:42 2002
+++ linux-2.4.19-shbang/arch/ia64/defconfig=09Fri Aug 30 14:08:28 2002
@@ -55,6 +55,7 @@
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=3Dy
 CONFIG_BINFMT_ELF=3Dy
+CONFIG_BINFMT_SHBANG=3Dy
 # CONFIG_BINFMT_MISC is not set
 # CONFIG_ACPI_DEBUG is not set
 # CONFIG_ACPI_BUSMGR is not set
diff -urN linux-2.4.19/arch/m68k/config.in linux-2.4.19-shbang/arch/m68k/=
config.in
--- linux-2.4.19/arch/m68k/config.in=09Sat Aug  3 03:39:43 2002
+++ linux-2.4.19-shbang/arch/m68k/config.in=09Fri Aug 30 14:13:16 2002
@@ -99,6 +99,7 @@
 fi
 tristate 'Kernel support for a.out binaries' CONFIG_BINFMT_AOUT
 tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
+tristate 'Kernel support for SHBANG binaries' CONFIG_BINFMT_SHBANG
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
=20
 if [ "$CONFIG_AMIGA" =3D "y" ]; then
diff -urN linux-2.4.19/arch/m68k/defconfig linux-2.4.19-shbang/arch/m68k/=
defconfig
--- linux-2.4.19/arch/m68k/defconfig=09Mon Jun 19 22:56:08 2000
+++ linux-2.4.19-shbang/arch/m68k/defconfig=09Fri Aug 30 14:08:38 2002
@@ -46,6 +46,7 @@
 # CONFIG_KCORE_AOUT is not set
 CONFIG_BINFMT_AOUT=3Dy
 CONFIG_BINFMT_ELF=3Dy
+CONFIG_BINFMT_SHBANG=3Dy
 # CONFIG_BINFMT_MISC is not set
 CONFIG_ZORRO=3Dy
 # CONFIG_AMIGA_PCMCIA is not set
diff -urN linux-2.4.19/arch/mips/config.in linux-2.4.19-shbang/arch/mips/=
config.in
--- linux-2.4.19/arch/mips/config.in=09Sat Aug  3 03:39:43 2002
+++ linux-2.4.19-shbang/arch/mips/config.in=09Fri Aug 30 14:13:54 2002
@@ -458,6 +458,7 @@
 define_bool CONFIG_BINFMT_AOUT n
 define_bool CONFIG_BINFMT_ELF y
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
+tristate 'Kernel support for SHBANG binaries' CONFIG_BINFMT_SHBANG
=20
 dep_bool 'Power Management support (EXPERIMENTAL)' CONFIG_PM $CONFIG_EXP=
ERIMENTAL $CONFIG_MIPS_AU1000
 endmenu
diff -urN linux-2.4.19/arch/mips/defconfig linux-2.4.19-shbang/arch/mips/=
defconfig
--- linux-2.4.19/arch/mips/defconfig=09Sat Aug  3 03:39:43 2002
+++ linux-2.4.19-shbang/arch/mips/defconfig=09Fri Aug 30 14:08:55 2002
@@ -106,6 +106,7 @@
 # CONFIG_KCORE_AOUT is not set
 # CONFIG_BINFMT_AOUT is not set
 CONFIG_BINFMT_ELF=3Dy
+CONFIG_BINFMT_SHBANG=3Dy
 # CONFIG_BINFMT_MISC is not set
 # CONFIG_PM is not set
=20
diff -urN linux-2.4.19/arch/mips64/config.in linux-2.4.19-shbang/arch/mip=
s64/config.in
--- linux-2.4.19/arch/mips64/config.in=09Sat Aug  3 03:39:43 2002
+++ linux-2.4.19-shbang/arch/mips64/config.in=09Fri Aug 30 14:13:25 2002
@@ -183,6 +183,7 @@
 define_bool CONFIG_KCORE_ELF y
 define_bool CONFIG_KCORE_AOUT n
 tristate 'Kernel support for 64-bit ELF binaries' CONFIG_BINFMT_ELF
+tristate 'Kernel support for SHBANG binaries' CONFIG_BINFMT_SHBANG
 bool 'Kernel support for Linux/MIPS 32-bit binary compatibility' CONFIG_=
MIPS32_COMPAT
 define_bool CONFIG_BINFMT_ELF32 $CONFIG_MIPS32_COMPAT
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
diff -urN linux-2.4.19/arch/mips64/defconfig linux-2.4.19-shbang/arch/mip=
s64/defconfig
--- linux-2.4.19/arch/mips64/defconfig=09Sat Aug  3 03:39:43 2002
+++ linux-2.4.19-shbang/arch/mips64/defconfig=09Fri Aug 30 14:08:46 2002
@@ -72,6 +72,7 @@
 CONFIG_KCORE_ELF=3Dy
 # CONFIG_KCORE_AOUT is not set
 CONFIG_BINFMT_ELF=3Dy
+CONFIG_BINFMT_SHBANG=3Dy
 CONFIG_MIPS32_COMPAT=3Dy
 CONFIG_BINFMT_ELF32=3Dy
 # CONFIG_BINFMT_MISC is not set
diff -urN linux-2.4.19/arch/parisc/config.in linux-2.4.19-shbang/arch/par=
isc/config.in
--- linux-2.4.19/arch/parisc/config.in=09Wed Apr 18 03:19:25 2001
+++ linux-2.4.19-shbang/arch/parisc/config.in=09Fri Aug 30 14:13:59 2002
@@ -67,6 +67,7 @@
 bool 'Sysctl support' CONFIG_SYSCTL
 tristate 'Kernel support for SOM binaries' CONFIG_BINFMT_SOM
 tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
+tristate 'Kernel support for SHBANG binaries' CONFIG_BINFMT_SHBANG
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
 if [ "$CONFIG_EXPERIMENTAL" =3D "y" ]; then
   tristate 'Kernel support for JAVA binaries (obsolete)' CONFIG_BINFMT_J=
AVA
diff -urN linux-2.4.19/arch/parisc/defconfig linux-2.4.19-shbang/arch/par=
isc/defconfig
--- linux-2.4.19/arch/parisc/defconfig=09Tue Dec  5 22:29:39 2000
+++ linux-2.4.19-shbang/arch/parisc/defconfig=09Fri Aug 30 14:09:03 2002
@@ -39,6 +39,7 @@
 CONFIG_SYSCTL=3Dy
 CONFIG_BINFMT_SOM=3Dy
 CONFIG_BINFMT_ELF=3Dy
+CONFIG_BINFMT_SHBANG=3Dy
 # CONFIG_BINFMT_MISC is not set
 # CONFIG_BINFMT_JAVA is not set
=20
diff -urN linux-2.4.19/arch/ppc/config.in linux-2.4.19-shbang/arch/ppc/co=
nfig.in
--- linux-2.4.19/arch/ppc/config.in=09Sat Aug  3 03:39:43 2002
+++ linux-2.4.19-shbang/arch/ppc/config.in=09Fri Aug 30 14:14:36 2002
@@ -167,6 +167,7 @@
 define_bool CONFIG_BINFMT_ELF y
 define_bool CONFIG_KERNEL_ELF y
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
+tristate 'Kernel support for SHBANG binaries' CONFIG_BINFMT_SHBANG
=20
 source drivers/pci/Config.in
=20
diff -urN linux-2.4.19/arch/ppc/defconfig linux-2.4.19-shbang/arch/ppc/de=
fconfig
--- linux-2.4.19/arch/ppc/defconfig=09Mon Feb 25 21:37:55 2002
+++ linux-2.4.19-shbang/arch/ppc/defconfig=09Fri Aug 30 14:09:18 2002
@@ -54,6 +54,7 @@
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_KCORE_ELF=3Dy
 CONFIG_BINFMT_ELF=3Dy
+CONFIG_BINFMT_SHBANG=3Dy
 CONFIG_KERNEL_ELF=3Dy
 CONFIG_BINFMT_MISC=3Dm
 CONFIG_PCI_NAMES=3Dy
diff -urN linux-2.4.19/arch/ppc64/config.in linux-2.4.19-shbang/arch/ppc6=
4/config.in
--- linux-2.4.19/arch/ppc64/config.in=09Sat Aug  3 03:39:43 2002
+++ linux-2.4.19-shbang/arch/ppc64/config.in=09Fri Aug 30 14:14:09 2002
@@ -71,6 +71,7 @@
 fi
=20
 bool 'Kernel Support for 64 bit ELF binaries' CONFIG_BINFMT_ELF
+tristate 'Kernel support for SHBANG binaries' CONFIG_BINFMT_SHBANG
=20
 tristate 'Kernel support for 32 bit binaries' CONFIG_BINFMT_ELF32
=20
diff -urN linux-2.4.19/arch/ppc64/defconfig linux-2.4.19-shbang/arch/ppc6=
4/defconfig
--- linux-2.4.19/arch/ppc64/defconfig=09Sat Aug  3 03:39:43 2002
+++ linux-2.4.19-shbang/arch/ppc64/defconfig=09Fri Aug 30 14:09:11 2002
@@ -47,6 +47,7 @@
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_KCORE_ELF=3Dy
 CONFIG_BINFMT_ELF=3Dy
+CONFIG_BINFMT_SHBANG=3Dy
 CONFIG_BINFMT_ELF32=3Dy
 # CONFIG_BINFMT_MISC is not set
 CONFIG_PCI_NAMES=3Dy
diff -urN linux-2.4.19/arch/s390/config.in linux-2.4.19-shbang/arch/s390/=
config.in
--- linux-2.4.19/arch/s390/config.in=09Sat Aug  3 03:39:43 2002
+++ linux-2.4.19-shbang/arch/s390/config.in=09Fri Aug 30 14:14:45 2002
@@ -51,6 +51,7 @@
 bool 'Sysctl support' CONFIG_SYSCTL
 define_bool CONFIG_KCORE_ELF y
 tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
+tristate 'Kernel support for SHBANG binaries' CONFIG_BINFMT_SHBANG
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
 bool 'Show crashed user process info' CONFIG_PROCESS_DEBUG
 bool 'Pseudo page fault support' CONFIG_PFAULT
diff -urN linux-2.4.19/arch/s390/defconfig linux-2.4.19-shbang/arch/s390/=
defconfig
--- linux-2.4.19/arch/s390/defconfig=09Sat Aug  3 03:39:43 2002
+++ linux-2.4.19-shbang/arch/s390/defconfig=09Fri Aug 30 14:09:28 2002
@@ -41,6 +41,7 @@
 CONFIG_SYSCTL=3Dy
 CONFIG_KCORE_ELF=3Dy
 CONFIG_BINFMT_ELF=3Dy
+CONFIG_BINFMT_SHBANG=3Dy
 # CONFIG_BINFMT_MISC is not set
 # CONFIG_PROCESS_DEBUG is not set
 CONFIG_PFAULT=3Dy
diff -urN linux-2.4.19/arch/s390x/config.in linux-2.4.19-shbang/arch/s390=
x/config.in
--- linux-2.4.19/arch/s390x/config.in=09Sat Aug  3 03:39:43 2002
+++ linux-2.4.19-shbang/arch/s390x/config.in=09Fri Aug 30 14:14:59 2002
@@ -52,6 +52,7 @@
 bool 'Sysctl support' CONFIG_SYSCTL
 define_bool CONFIG_KCORE_ELF y
 tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
+tristate 'Kernel support for SHBANG binaries' CONFIG_BINFMT_SHBANG
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
 bool 'Show crashed user process info' CONFIG_PROCESS_DEBUG
 bool 'Pseudo page fault support' CONFIG_PFAULT
diff -urN linux-2.4.19/arch/s390x/defconfig linux-2.4.19-shbang/arch/s390=
x/defconfig
--- linux-2.4.19/arch/s390x/defconfig=09Sat Aug  3 03:39:43 2002
+++ linux-2.4.19-shbang/arch/s390x/defconfig=09Fri Aug 30 14:09:35 2002
@@ -42,6 +42,7 @@
 CONFIG_SYSCTL=3Dy
 CONFIG_KCORE_ELF=3Dy
 CONFIG_BINFMT_ELF=3Dy
+CONFIG_BINFMT_SHBANG=3Dy
 # CONFIG_BINFMT_MISC is not set
 # CONFIG_PROCESS_DEBUG is not set
 CONFIG_PFAULT=3Dy
diff -urN linux-2.4.19/arch/sh/config.in linux-2.4.19-shbang/arch/sh/conf=
ig.in
--- linux-2.4.19/arch/sh/config.in=09Mon Feb 25 21:37:56 2002
+++ linux-2.4.19-shbang/arch/sh/config.in=09Fri Aug 30 14:15:06 2002
@@ -211,6 +211,7 @@
 =09 A.OUT=09=09CONFIG_KCORE_AOUT" ELF
 fi
 tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
+tristate 'Kernel support for SHBANG binaries' CONFIG_BINFMT_SHBANG
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
=20
 source drivers/parport/Config.in
diff -urN linux-2.4.19/arch/sh/defconfig linux-2.4.19-shbang/arch/sh/defc=
onfig
--- linux-2.4.19/arch/sh/defconfig=09Mon Oct 15 22:36:48 2001
+++ linux-2.4.19-shbang/arch/sh/defconfig=09Fri Aug 30 14:09:44 2002
@@ -48,6 +48,7 @@
 CONFIG_KCORE_ELF=3Dy
 # CONFIG_KCORE_AOUT is not set
 CONFIG_BINFMT_ELF=3Dy
+CONFIG_BINFMT_SHBANG=3Dy
 # CONFIG_BINFMT_MISC is not set
=20
 #
diff -urN linux-2.4.19/arch/sparc/config.in linux-2.4.19-shbang/arch/spar=
c/config.in
--- linux-2.4.19/arch/sparc/config.in=09Sat Aug  3 03:39:43 2002
+++ linux-2.4.19-shbang/arch/sparc/config.in=09Fri Aug 30 14:15:21 2002
@@ -70,6 +70,7 @@
 fi
 tristate 'Kernel support for a.out binaries' CONFIG_BINFMT_AOUT
 tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
+tristate 'Kernel support for SHBANG binaries' CONFIG_BINFMT_SHBANG
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
 bool 'SunOS binary emulation' CONFIG_SUNOS_EMUL
 source drivers/parport/Config.in
diff -urN linux-2.4.19/arch/sparc/defconfig linux-2.4.19-shbang/arch/spar=
c/defconfig
--- linux-2.4.19/arch/sparc/defconfig=09Sat Aug  3 03:39:43 2002
+++ linux-2.4.19-shbang/arch/sparc/defconfig=09Fri Aug 30 14:10:01 2002
@@ -51,6 +51,7 @@
 CONFIG_KCORE_ELF=3Dy
 CONFIG_BINFMT_AOUT=3Dy
 CONFIG_BINFMT_ELF=3Dy
+CONFIG_BINFMT_SHBANG=3Dy
 CONFIG_BINFMT_MISC=3Dm
 CONFIG_SUNOS_EMUL=3Dy
=20
diff -urN linux-2.4.19/arch/sparc64/config.in linux-2.4.19-shbang/arch/sp=
arc64/config.in
--- linux-2.4.19/arch/sparc64/config.in=09Sat Aug  3 03:39:43 2002
+++ linux-2.4.19-shbang/arch/sparc64/config.in=09Fri Aug 30 14:15:18 2002
@@ -73,6 +73,7 @@
    bool '  Kernel support for 32-bit (ie. SunOS) a.out binaries' CONFIG_=
BINFMT_AOUT32
 fi
 tristate 'Kernel support for 64-bit ELF binaries' CONFIG_BINFMT_ELF
+tristate 'Kernel support for SHBANG binaries' CONFIG_BINFMT_SHBANG
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
 bool 'SunOS binary emulation' CONFIG_SUNOS_EMUL
 if [ "$CONFIG_EXPERIMENTAL" =3D "y" ]; then
diff -urN linux-2.4.19/arch/sparc64/defconfig linux-2.4.19-shbang/arch/sp=
arc64/defconfig
--- linux-2.4.19/arch/sparc64/defconfig=09Sat Aug  3 03:39:43 2002
+++ linux-2.4.19-shbang/arch/sparc64/defconfig=09Fri Aug 30 14:09:51 2002
@@ -55,6 +55,7 @@
 CONFIG_BINFMT_ELF32=3Dy
 # CONFIG_BINFMT_AOUT32 is not set
 CONFIG_BINFMT_ELF=3Dy
+CONFIG_BINFMT_SHBANG=3Dy
 CONFIG_BINFMT_MISC=3Dm
 # CONFIG_SUNOS_EMUL is not set
 CONFIG_SOLARIS_EMUL=3Dm
diff -urN linux-2.4.19/fs/Makefile linux-2.4.19-shbang/fs/Makefile
--- linux-2.4.19/fs/Makefile=09Mon Feb 25 21:38:07 2002
+++ linux-2.4.19-shbang/fs/Makefile=09Fri Aug 30 14:01:13 2002
@@ -73,8 +73,7 @@
 obj-$(CONFIG_BINFMT_EM86)=09+=3D binfmt_em86.o
 obj-$(CONFIG_BINFMT_MISC)=09+=3D binfmt_misc.o
=20
-# binfmt_script is always there
-obj-y=09=09=09=09+=3D binfmt_script.o
+obj-$(CONFIG_BINFMT_SHBNAG)=09+=3D binfmt_script.o
=20
 obj-$(CONFIG_BINFMT_ELF)=09+=3D binfmt_elf.o
=20

--------------Boundary-00=_1UUCQFAOQLE6XBDZ0QGU--
