Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030207AbWFVNEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030207AbWFVNEp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 09:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030210AbWFVNEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 09:04:45 -0400
Received: from sun-email.corp.avocent.com ([65.217.42.16]:43655 "EHLO
	sun-email.corp.avocent.com") by vger.kernel.org with ESMTP
	id S1030207AbWFVNEo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 09:04:44 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [RFC][PATCH 0/13] Equinox multi-port serial (SST) driver
Date: Thu, 22 Jun 2006 09:04:44 -0400
Message-ID: <4821D5B6CD3C1B4880E6E94C6E70913E01B710EF@sun-email.corp.avocent.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC][PATCH 0/13] Equinox multi-port serial (SST) driver
Thread-Index: AcaV/G3ddHwtgA7mT0qlu3VnU5cPVA==
From: "Straub, Michael" <Michael.Straub@avocent.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds the Equinox multi-port serial (SST) driver.  Later
versions of the board are manufactured and branded by Avocent
Corporation.

SST boards contain one or more ICP ASICs (intelligent communications 
processor).  There are two ICP types - a 4-channel ICP and a 64-channel
ICP.
SST boards are PCI boards that contain one or more of these ICP ASICs in
order
to support 4, 8, 16, 64 or 128 serial ports.  

This driver was derived from a previous version that has been in-use for
about 10 years.  The source for the previous driver is licensed under
the
GPL.  It is used to build an "out-of-tree" module.  

The version provided here has been substantially re-engineered to 
comply with the linux coding style and practices.  This driver has been
built and tested on x86 (single and dual processor) and ppc systems.

Note that the driver is somewhat large.  Seperated into several source
files (in its own directory in drivers/char) to make it more manageable.

This is the first attempt to mainline the driver.  Any comments would be

appreciated.

part 1: Provides a modification to the tty subsystem routine
tty_register_device in order to make the allocated class device
available
to tty drivers.
part 2: Adds the appropriate vendor and device ids to PCI id table.
part 3: Modifies existing drivers/char Kconfig and Makefile.
part 4: Adds new Kconfig and Makefile.  Note this driver is in its own
directory.
part 5: New header file.  General defines.
part 6: New header file.  Register definitions for ICP ASICs.
part 7: New header file.  Structures and constants used by driver
source.
part 8: New source file.  Driver "main". Does initialization and
cleanup.
part 9: New source file.  Provides standard TTY interface routines.
part 10: New source file. Provides support for standard TTY ioctl
routines.
part 11: New source file.  Timer based routines.
part 12: New source file.  Manages sysfs attribute files used for status
and
diagnostics.
part 13: New source file.  Miscellaneous routines.

Signed-off-by: Mike Straub <michael.straub@avocent.com>

---
 drivers/char/Kconfig          |    2 
 drivers/char/Makefile         |    1 
 drivers/char/eqnx/Kconfig     |   11 
 drivers/char/eqnx/Makefile    |    6 
 drivers/char/eqnx/eqnx.h      |  362 +++++++
 drivers/char/eqnx/eqnx_def.h  |   37 
 drivers/char/eqnx/icp.h       |  857 ++++++++++++++++++
 drivers/char/eqnx/sst.c       | 1626 ++++++++++++++++++++++++++++++++++
 drivers/char/eqnx/sst_ioctl.c |  440 +++++++++
 drivers/char/eqnx/sst_misc.c  |  758 ++++++++++++++++
 drivers/char/eqnx/sst_poll.c  | 1941
+++++++++++++++++++++++++++++++++++++++++
 drivers/char/eqnx/sst_sysfs.c | 1379 +++++++++++++++++++++++++++++
 drivers/char/eqnx/sst_tty.c   | 1961
++++++++++++++++++++++++++++++++++++++++++
 drivers/char/tty_io.c         |    8 
 include/linux/pci_ids.h       |   30 
 include/linux/tty.h           |    4 
 16 files changed, 9418 insertions(+), 5 deletions(-)
