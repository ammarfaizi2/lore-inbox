Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271628AbTGQXZo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 19:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271626AbTGQXZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 19:25:44 -0400
Received: from [198.70.193.2] ([198.70.193.2]:22618 "EHLO AVEXCH01.qlogic.org")
	by vger.kernel.org with ESMTP id S271625AbTGQXZj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 19:25:39 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b4).
Date: Thu, 17 Jul 2003 16:40:00 -0700
Message-ID: <B179AE41C1147041AA1121F44614F0B0598B10@AVEXCH02.qlogic.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b4).
Thread-Index: AcNMvLyU3vcyuvN+R5y85pB8nwmzEw==
From: "Andrew Vasquez" <andrew.vasquez@qlogic.com>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>,
       "Linux-SCSI" <linux-scsi@vger.kernel.org>
X-OriginalArrivalTime: 17 Jul 2003 23:40:00.0523 (UTC) FILETIME=[BD0415B0:01C34CBC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

A new version of the 8.x series driver for Linux 2.6.x kernels has
been uploaded to SourceForge:

	http://sourceforge.net/projects/linux-qla2xxx/

This beta contains a large rewrite of some fundamental structures used
throughout the driver.  This change sets the stage for some of the
more interesting and useful updates such as asynchronous mailbox
commands and a less intrusive discovery processes.

Additionally, the beta includes several performance related changes:

	o An initial merge of performance patches from Arjan van de
	  Ven.  Read the revision notes for details:
	  - Lock contention fixes.
	  - RIO support.
	o SCSI command --> IOCB formation speedup.

BTW: future driver drops *will* come out at a more spirited pace.

Changes include:

 *	- IOCB staging fixups.
 *	- Full support for 2k port logins (~2000 fabric devices).
 *	- Resync with 6.06.00b12.
 *	- Resync with Linux Kernel 2.6.0-test1.

Finally, regarding some of the more interesting (if not the) question(s)
pertaining to the development of qla2xxx:

  o Creation of a single driver module rather than three distinct
	drivers for each ISP type (21xx, 22xx, and 23xx).

  From the technical side, there aren't many compelling reasons for
  the change to not occur.  Support for 2k logins on 2300s did
  introduce a rather large, but manageable (through the compile-time
  preprocessor), interface change between the host driver and
  firmware.  The driver could of course manage this during run-time
  with some creative structure overlays, etc.  Secondly, bundling
  firmware for all ISP types can lead to a rather large binary
  module (21xx - ~64kbytes, 22xx - ~90kbytes, 23xx - ~110kbytes).
  Also, when formal support for the ISP2322 chip is added, an
  additional firmware image (again ~110kbytes) will need to be
  compiled with the driver.  The new user-space firmware-load
  interface could address the size concerns, but at the same time it
  also calls into question the larger issue of support.

  Unfortunately, it is support that ultimately becomes the
  overriding factor in maintaining the three-module build process.
  By building distinct modules (i.e. qla2300.ko to support ISP2300,
  ISP2312, and ISP2322 chips) our DVT group would focus their time and
  efforts on testing 23xx HBAs and not on regressing support with
  EOL'd products.

Until a policy change, the 8.x driver in its current form will have
the limitation of only one driver, qla2100, qla2200, or qla2300, can
be built as part of the kernel at any given time.  Please note, all
three binaries built as modules *can* be loaded without incident.  For
example:

  The following combinations will NOT work:

	- 2100 and 2200 support built as part of the kernel.
	- 2200 and 2300 support built as part of the kernel.
	- 2100 and 2300 support built as part of the kernel.

  The following combinations will work:

	- 2100, 2200 and 2300 support built as modules.
	- 2100 support build as part of the kernel, 2200 and 2300
	  support built as modules.
	- 2300 support build as part of the kernel, 2100 and 2200
	  support built as modules.
	- etc...

Regards,
Andrew Vasquez
