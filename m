Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135489AbQL3U2y>; Sat, 30 Dec 2000 15:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135170AbQL3U2p>; Sat, 30 Dec 2000 15:28:45 -0500
Received: from front2m.grolier.fr ([195.36.216.52]:9682 "EHLO
	front2m.grolier.fr") by vger.kernel.org with ESMTP
	id <S131418AbQL3U2g> convert rfc822-to-8bit; Sat, 30 Dec 2000 15:28:36 -0500
Date: Sat, 30 Dec 2000 19:57:44 +0100 (CET)
From: Gérard Roudier <groudier@club-internet.fr>
To: Linux <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
Subject: SYM-2 driver released (:=sym53c8xx+ncr53c8xx).
Message-ID: <Pine.LNX.4.10.10012301952070.886-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just released sym-2.1.0 driver, that, according to my personnal QA 
plan :-), is the first Beta-release of this major driver version.

People interested in either using or just trying it can found the
reference tarball at the following URL:

ftp://ftp.tux.org/roudier/drivers/portable/sym-2.1.x/sym-2.1.0-20001230.tar.gz

This driver replaces functionnaly both sym53c8xx and ncr53c8xx.
It is in fact the FreeBSD sym driver that got portable and that, for now, 
also supports Linux.

The driver reference sources layout is the following:

Common:
    sym_conf.h   sym_defs.h  sym_fw.c    sym_fw.h
    sym_fw1.h    sym_fw2.h   sym_hipd.c  sym_hipd.h
    sym_malloc.c sym_misc.h  sym_nvram.c

FreeBSD:
    sym_glue.c   sym_glue.h

Linux:
    sym53c8xx.h  sym_glue.c  sym_glue.h

All the files can also be clicked/clipped :) individually from the 
the following directory:

   ftp://ftp.tux.org/roudier/drivers/portable/sym-2.1.x/current/

Given the genealogy of this driver, I have decided to maintain a high 
level of compatibility with the sym53c8xx driver under Linux.
But, due to the number of sources files (14 under Linux), the driver 
sources will now own a separate directory instead of being dropped in 
the huge drivers/scsi/ directory.

The installation procedure supplied in the tarball moves the files to:

       /usr/linux/drivers/scsi/sym53c8xx/

As a result, a tiny patch is needed for the related kernel files to 
be aware of the new driver files location. And, as I have limited 
time, only patches for 2.2.16, 2.2.17 and 2.2.18 are supplied for now.

People who will succeed installing the driver on other Linux kernel 
releases, especially recent ones, can send me the corresponding tiny 
kernel patch. Btw, this driver does not support Linux-2.0.X kernels.

The major improvements against sym53c8xx driver can be summarized 
as follows:

- Don't use the scsi_obsolete interface anymore.
  I could word it as 'use the new error handling interface', but the best 
  advantage, in my opinion, is that driver entry points are not called 
  recursively as does the old scsi code.

- Support for the entire NCR/SYMBIOS/LSILOGIC 53C[8XX|1010] in a single 
  driver without significant bloat of the object code.
  The driver with all options enabled is about 73K not stripped and 59K 
  stripped under Linux-2.2.18.

- Refining of a couple of work-arounds that let me claim that the driver 
  supports the best possible all chips of all revisions, even very early 
  revisions of recent chips.

I am highly interested in receiving reports, either success or problem, 
about this driver version, especially when the driver is tried on non Intel 
IA32 platforms.

  Gérard.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
