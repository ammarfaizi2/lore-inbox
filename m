Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbUJZUFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbUJZUFZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 16:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbUJZUFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 16:05:11 -0400
Received: from out010pub.verizon.net ([206.46.170.133]:50584 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S261464AbUJZUDi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 16:03:38 -0400
From: james4765@verizon.net
To: linux-kernel@vger.kernel.org
Cc: james4765@verizon.net
Message-Id: <20041026200333.24275.42098.23134@localhost.localdomain>
In-Reply-To: <20041026200320.24275.17430.77560@localhost.localdomain>
References: <20041026200320.24275.17430.77560@localhost.localdomain>
Subject: [patch 2/2] ftape update
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [209.158.211.53] at Tue, 26 Oct 2004 15:03:33 -0500
Date: Tue, 26 Oct 2004 15:03:34 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: Cleanup and update to Documentation/ftape.txt.  Apply against 2.6.9.

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.9-original/Documentation/ftape.txt linux-2.6.9/Documentation/ftape.txt
--- linux-2.6.9-original/Documentation/ftape.txt	2004-10-18 17:53:11.000000000 -0400
+++ linux-2.6.9/Documentation/ftape.txt	2004-10-24 10:47:59.873014169 -0400
@@ -2,26 +2,21 @@
 =====
 
 This file describes some issues involved when using the "ftape"
-floppy tape device driver that comes with the Linux kernel. This
-document deals with ftape-3.04 and later. Please read the section
-"Changes" for the most striking differences between version 3.04 and
-2.08; the latter was the version of ftape delivered with the kernel
-until kernel version 2.0.30 and 2.1.57. ftape-3.x developed as the
-re-unification of ftape-2.x and zftape. zftape was developed in
-parallel with the stock ftape-2.x driver sharing the same hardware
-support but providing an enhanced file system interface. zftape also
-provided user transparent block-wise on-the-fly compression (regard it
-as a feature or bug of zftape).
+floppy tape device driver that comes with the Linux kernel.
 
 ftape has a home page at
 
-http://www-math.math.rwth-aachen.de/~LBFM/claus/ftape
+http://ftape.dot-heine.de/
 
 which contains further information about ftape. Please cross check
 this WWW address against the address given (if any) in the MAINTAINERS
 file located in the top level directory of the Linux kernel source
 tree.
 
+NOTE: This is an unmaintained set of drivers, and it is not guaranteed to work.
+If you are interested in taking over maintenance, contact Claus-Justus Heine
+<ch@dot-heine.de>, the former maintainer.
+
 Contents
 ========
 
@@ -31,9 +26,8 @@
    1. Goal
    2. I/O Block Size
    3. Write Access when not at EOD (End Of Data) or BOT (Begin Of Tape)
-   4. MTBSF - backspace over file mark and position at its EOT side
-   5. Formatting
-   6. Interchanging cartridges with other operating systems
+   4. Formatting
+   5. Interchanging cartridges with other operating systems
 
 B. Debugging Output
    1. Introduction
@@ -58,7 +52,7 @@
 versions of ftape and useful links to related topics can be found at
 the ftape home page at
 
-http://www-math.math.rwth-aachen.de/~LBFM/claus/ftape
+http://ftape.dot-heine.de/
 
 *******************************************************************************
 
@@ -70,7 +64,7 @@
    The goal of all that incompatibilities was to give ftape an interface
    that resembles the interface provided by SCSI tape drives as close
    as possible. Thus any Unix backup program that is known to work
-   with SCSI tape drives should also work with ftape-3.04 and above.
+   with SCSI tape drives should also work.
 
    The concept of a fixed block size for read/write transfers is
    rather unrelated to this SCSI tape compatibility at the file system
@@ -81,14 +75,8 @@
 
 2. I/O Block Size
    ~~~~~~~~~~~~~~
-   The probably most striking difference between ftape-2.x and
-   ftape-3.x with the zftape file system interface is the concept of a
-   fixed block size: data must be written to or read from the tape in
-   multiples of a fixed block size. The block size defaults to 10k
-   which is the default block size of GNU tar. While this is quite
-   usual for SCSI tapes (block size of 32k?) and the QIC-150 driver
-   `./drivers/char/tpqic02.c' ftape-2.x allowed data to be written in
-   arbitrary portions to the tape.
+   The block size defaults to 10k which is the default block size of
+   GNU tar.
 
    The block size can be tuned either during kernel configuration or
    at runtime with the MTIOCTOP ioctl using the MTSETBLK operation
@@ -109,53 +97,41 @@
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    zftape (the file system interface of ftape-3.x) denies write access
    to the tape cartridge when it isn't positioned either at BOT or
-   EOD. This inconvenience has been introduced as it was reported that
-   the former behavior of ftape-2.x which allowed write access at
-   arbitrary locations already has caused data loss with some backup
-   programs.
-
-4. MTBSF - backspace over file mark and position at its EOT side
-   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-   ftape-2.x didn't handle the MTBSF tape operation correctly. A MTBSF
-   call (i.e. "mt -f /dev/nqft0 bsf #COUNT") should space over #COUNT
-   file marks and then position at the EOT tape side of the file
-   mark. This has to be taken literally, i.e. "mt -f /dev/nqft0 bsf 1"
-   should simply position at the start of the current volume.
+   EOD.
 
-5. Formatting
+4. Formatting
    ~~~~~~~~~~
-   ftape-3.x DOES support formatting of floppy tape cartridges. You
-   need the `ftformat' program that is shipped with the modules version
-   of ftape-3.x. Please get the latest version of ftape from
+   ftape DOES support formatting of floppy tape cartridges. You need the
+   `ftformat' program that is shipped with the modules version of ftape.
+   Please get the latest version of ftape from
 
    ftp://sunsite.unc.edu/pub/Linux/kernel/tapes
 
    or from the ftape home page at
 
-   http://www-math.math.rwth-aachen.de/~LBFM/claus/ftape
+   http://ftape.dot-heine.de/
 
    `ftformat' is contained in the `./contrib/' subdirectory of that
    separate ftape package.
 
-6. Interchanging cartridges with other operating systems
+5. Interchanging cartridges with other operating systems
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
    The internal emulation of Unix tape device file marks has changed
-   completely. ftape-3.x now uses the volume table segment as specified
+   completely. ftape now uses the volume table segment as specified
    by the QIC-40/80/3010/3020/113 standards to emulate file marks. As
    a consequence there is limited support to interchange cartridges
    with other operating systems.
 
    To be more precise: ftape will detect volumes written by other OS's
    programs and other OS's programs will detect volumes written by
-   ftape-3.x.
+   ftape.
 
    However, it isn't possible to extract the data dumped to the tape
-   by some MSDOG program with ftape-3.x. This exceeds the scope of a
+   by some MSDOS program with ftape. This exceeds the scope of a
    kernel device driver. If you need such functionality, then go ahead
-   and write a user space utility that is able to do
-   that. ftape-3.x/zftape already provides all kernel level support
-   necessary to do that.
+   and write a user space utility that is able to do that. ftape already
+   provides all kernel level support necessary to do that.
 
 *******************************************************************************
 
@@ -200,7 +176,7 @@
 
    ii) trim the debugging output at module load time with
 
-       insmod ftape.o ft_tracing=#DBGLVL
+       modprobe ftape ft_tracing=#DBGLVL
 
        Of course, this applies only if you have configured ftape to be
        compiled as a module.
@@ -240,7 +216,7 @@
 2. Module load time parameters
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Module parameters can be specified either directly when invoking
-   the program 'insmod' at the shell prompt:
+   the program 'modprobe' at the shell prompt:
 
    modprobe ftape ft_tracing=4
 
@@ -277,6 +253,12 @@
 	line documentation provided during that kernel configuration
 	process.
 
+	ft_probe_fc10 is set to a non-zero value if you wish for ftape to
+	probe for a Colorado FC-10 or FC-20 controller.
+
+	ft_mach2 is set to a non-zero value if you wish for ftape to probe
+	for a Mountain MACH-2 controller.
+
         module                 |  kernel command line
         -----------------------|----------------------
         ft_fdc_base=BASE       |  ftape=BASE,ioport
@@ -316,10 +298,10 @@
    page to query for the most recent documentation, related work and
    development versions of ftape.
 
+   Changelog:
+   ==========
+
+~1996:		Original Document
 
- LocalWords:  ftape Linux zftape http www rwth aachen LBFM claus EOD config
- LocalWords:  datarate LocalWords BOT MTBSF EOT HOWTO QIC tpqic menuconfig
- LocalWords:  MTIOCTOP MTSETBLK mt dev qft setblk BLKSZ bsf zftape's xconfig
- LocalWords:  nqft ftformat ftp sunsite unc edu contrib ft MSDOG fdc
- LocalWords:  dma setdensity DBGLVL insmod lilo LI nux ader conf txt
- LocalWords:  modprobe IRQ BOOL ioport irq fc mach THR
+10-24-2004:	General cleanup and updating, noting additional module options.
+		James Nelson <james4765@gmail.com>
