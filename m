Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264976AbSK1A1C>; Wed, 27 Nov 2002 19:27:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264978AbSK1A1C>; Wed, 27 Nov 2002 19:27:02 -0500
Received: from mail.copper.net ([65.247.64.20]:40464 "EHLO bert.copper.net")
	by vger.kernel.org with ESMTP id <S264976AbSK1A1A>;
	Wed, 27 Nov 2002 19:27:00 -0500
Subject: [PATCH] README change
From: Thomas Molina <tmolina@copper.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 27 Nov 2002 18:26:05 -0600
Message-Id: <1038443167.2063.28.camel@lap>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A suggestion was made the other day that the README file needed to be
changed to delete the reference to make dep in line with the changes to
the make procedure.  Here is a patch to make that change in addition to
some other changes I thought would help.  While poking around in the
documentation I see some other files which could use some updating;
00-INDEX is next on the hitlist if no one objects.

--- README.orig	2002-11-27 16:10:48.000000000 -0600
+++ README	2002-11-27 17:43:47.000000000 -0600
@@ -40,8 +40,9 @@
    these typically contain kernel-specific installation notes for some 
    drivers for example. See ./Documentation/00-INDEX for a list of what
    is contained in each file.  Please read the Changes file, as it
-   contains information about the problems, which may result by upgrading
-   your kernel.
+   contains information about the version of software and utilities  
+   required to run 2.5 kernels as well as any "Gotchas" that could be
+   encountered.
 
  - The Documentation/DocBook/ subdirectory contains several guides for
    kernel developers and users.  These guides can be rendered in a
@@ -55,14 +56,18 @@
    directory where you have permissions (eg. your home directory) and
    unpack it:
 
-		gzip -cd linux-2.5.XX.tar.gz | tar xvf -
+		tar xvzf linux-2.5.XX.tar.gz
+
+or
+
+		tar xvjf linux-2.5.XX.tar.bz2
 
    Replace "XX" with the version number of the latest kernel.
 
-   Do NOT use the /usr/src/linux area! This area has a (usually
-   incomplete) set of kernel headers that are used by the library header
-   files.  They should match the library, and not get messed up by
-   whatever the kernel-du-jour happens to be.
+   Do NOT use /usr/src/linux! This directory should contain the source 
+   and headers of the kernel gcc was compile with.  They should match 
+   the compiler, and not get messed up by whatever the kernel-du-jour 
+   happens to be.
 
  - You can also upgrade between 2.5.xx releases by patching.  Patches are
    distributed in the traditional gzip and the new bzip2 format.  To
@@ -84,11 +89,15 @@
    process.  It determines the current kernel version and applies any
    patches found.
 
-		linux/scripts/patch-kernel linux
+   usage: patch-kernel [ sourcedir [ patchdir [ stopversion ] [ -acxx ] ] ]
+   
+   The source directory defaults to /usr/src/linux, and the patch
+   directory defaults to the current directory.
+
 
-   The first argument in the command above is the location of the
-   kernel source.  Patches are applied from the current directory, but
-   an alternative directory can be specified as the second argument.
+   The first argument is the location of the kernel source.  Patches 
+   are applied from the current directory, but an alternative directory 
+   can be specified as the second argument.
 
  - Make sure you have no stale .o files and dependencies lying around:
 
@@ -131,9 +140,9 @@
 	- having unnecessary drivers will make the kernel bigger, and can
 	  under some circumstances lead to problems: probing for a
 	  nonexistent controller card may confuse your other controllers
-	- compiling the kernel with "Processor type" set higher than 386
-	  will result in a kernel that does NOT work on a 386.  The
-	  kernel will detect this on bootup, and give up.
+	- compiling the kernel with an incorrect "Processor type" will 
+          result in a kernel that does NOT work.  The kernel will detect 
+          this on bootup, and give up.
 	- A kernel with math-emulation compiled in will still use the
 	  coprocessor if one is present: the math emulation will just
 	  never get used in that case.  The kernel will be slightly larger,
@@ -146,13 +155,20 @@
 	  should probably answer 'n' to the questions for
           "development", "experimental", or "debugging" features.
 
- - Check the top Makefile for further site-dependent configuration
-   (default SVGA mode etc). 
+ - Check the top Makefile for further site-dependent configuration 
+   information such as host compiler or cross-platform information.
 
- - Finally, do a "make dep" to set up all the dependencies correctly. 
+ - A "make dep" command was previously required at this point, but is
+   no longer necessary. 
 
 COMPILING the kernel:
 
+   The steps for compiling the kernel are:
+   make bzImage
+   make modules
+   make modules_install
+   make install
+
  - Make sure you have gcc 2.95.3 available.
    gcc 2.91.66 (egcs-1.1.2), and gcc 2.7.2.3 are known to miscompile
    some parts of the kernel, and are *no longer supported*.
@@ -163,12 +179,11 @@
 
  - Do a "make bzImage" to create a compressed kernel image.  If you want
    to make a boot disk (without root filesystem or LILO), insert a floppy
-   in your A: drive, and do a "make bzdisk".  It is also possible to do
-   "make install" if you have lilo installed to suit the kernel makefiles,
-   but you may want to check your particular lilo setup first. 
+   in your A: drive, and do a "make bzdisk". 
 
-   To do the actual install you have to be root, but none of the normal
-   build should require that. Don't take the name of root in vain.
+   To do the make modules_install and make install you have to be root, 
+   but none of the other build should require that. 
+   Don't take the name of root in vain.
 
  - In the unlikely event that your system cannot boot bzImage kernels you
    can still compile your kernel as zImage. However, since zImage support
@@ -190,9 +205,11 @@
    working kernel, make a backup of your modules directory before you
    do a "make modules_install".
 
- - In order to boot your new kernel, you'll need to copy the kernel
+ - In order to boot your new kernel you'll need to copy the kernel
    image (found in .../linux/arch/i386/boot/bzImage after compilation)
-   to the place where your regular bootable kernel is found. 
+   to the place where your regular bootable kernel is found.  The
+   "make install" step will do this for you as well as changing 
+   the lilo or grub configuration files.
 
    For some, this is on a floppy disk, in which case you can copy the
    kernel bzImage file to /dev/fd0 to make a bootable floppy.
@@ -213,6 +230,10 @@
    After reinstalling LILO, you should be all set.  Shutdown the system,
    reboot, and enjoy!
 
+   The other popular boot manager is grub.  If you use this boot 
+   manager, no additional actions are required beyond changing the
+   /boot/grub/grub.conf configuration file.
+
    If you ever need to change the default root device, video mode,
    ramdisk size, etc.  in the kernel image, use the 'rdev' program (or
    alternatively the LILO boot options when appropriate).  No need to
@@ -222,19 +243,23 @@
 
 IF SOMETHING GOES WRONG:
 
+ - Please read the file REPORTING-BUGS before forwarding any reports
+   of suspected kernel problems to maintainers or mailing lists.  It 
+   contains a suggested format for bug reports as well as what
+   information is most helpful to developers.
+
  - If you have problems that seem to be due to kernel bugs, please check
    the file MAINTAINERS to see if there is a particular person associated
    with the part of the kernel that you are having trouble with. If there
    isn't anyone listed there, then the second best thing is to mail
-   them to me (torvalds@transmeta.com), and possibly to any other
+   them to the linux-kernel mailing list and possibly to any other
    relevant mailing-list or to the newsgroup.  The mailing-lists are
-   useful especially for SCSI and networking problems, as I can't test
-   either of those personally anyway. 
+   useful especially for SCSI and networking problems
 
  - In all bug-reports, *please* tell what kernel you are talking about,
    how to duplicate the problem, and what your setup is (use your common
-   sense).  If the problem is new, tell me so, and if the problem is
-   old, please try to tell me when you first noticed it.
+   sense).  If the problem is new, say so, and if the problem is
+   old, please try to explain when you first noticed it.
 
  - If the bug results in a message like
 

