Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133004AbQLJWBy>; Sun, 10 Dec 2000 17:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133107AbQLJWBo>; Sun, 10 Dec 2000 17:01:44 -0500
Received: from mail.cruzio.com ([165.227.128.37]:49090 "EHLO mail.cruzio.com")
	by vger.kernel.org with ESMTP id <S133004AbQLJWB1>;
	Sun, 10 Dec 2000 17:01:27 -0500
Message-ID: <3A33F620.21E322A6@cruzio.com>
Date: Sun, 10 Dec 2000 13:31:12 -0800
From: Bruce Korb <bkorb@cruzio.com>
Organization: Home
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.16 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        jmaurer@cck.uni-kl.de, mj@suse.cz
Subject: Patch to improve PCI consistency
Content-Type: multipart/mixed;
 boundary="------------7565C1996C86F9BD74A1CD5F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------7565C1996C86F9BD74A1CD5F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


Hi,

The information about PCI devices is scattered about the kernel
and, consequently, is inconsistent.  This patch puts the PCI/IDE
bridge information into a text database along with the data from
include/linux/pci_ids.h and drivers/pci/pci.ids.  I may have mis-
typed a few things, but the 2.4.0-test11 kernel seems to compile
and work for me.

Below is the README from the patch and the patch lives here:

  ftp://autogen.linuxave.net/pub/PCIDEV.tgz
--------------7565C1996C86F9BD74A1CD5F
Content-Type: text/plain; charset=us-ascii;
 name="README"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="README"


This patch will unify the PCI device information between the
PCI driver database (pci.ids), the PCI-IDE bridges (ide-pci.c)
and the header that should enumerate all pci devices (pci_ids.h).
It does this by putting all the data into a single file and
tagging the values with names.  These named values are then
inserted into the output files.  This will provide for guaranteed
consistency, which is not now the case.  In fact, there were some
unresolvable inconsistencies in the data that are marked with
``FIXME''  comments.

The patches are against linux-2.4.0-test11.

There are other PCI device tables that could be generated as well.
As it happens, though, I am only interested in PCI/IDE bridges.
The rest are left as exercises for the reader.  :-)

Hand edited files:

pci.def      --  replacement for drivers/pci/pci.ids
pci_ids.tpl  --  Template for producing generated files
:mkpcidev    --  Script for constructing files (read before use!)
PATCH        --  a patch for the following files:

    drivers/pci/gen-devlist.c -- obsolete
    arch/i386/kernel/pci-irq.c
    drivers/char/serial.c
    drivers/pci/names.c
    drivers/pci/Makefile
    drivers/ide/ide-pci.c
    drivers/parport/parport_pc.c

Generated files:

drivers/pci/devlist.h    replacement for devlist.h and classlist.h
drivers/ide/ide-pci.h    Replacement for hand-coded tables in ide-pci.c
include/linux/pci_ids.h  replacement


The patches mostly remove data that are now generated.
However, some were changed because it is no longer possible to
create #define-d values with mixed case (a lower case `x').

For the ide-pci.c file, however, it also renames macros that
are inconsistent with the device names already defined in
pci.ids (pci.def).

=============

The tool that makes this all happen is:

  http://AutoGen.SourceForge.net/

--------------7565C1996C86F9BD74A1CD5F--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
