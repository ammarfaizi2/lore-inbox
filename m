Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbTEHWOj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 18:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbTEHWOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 18:14:38 -0400
Received: from [198.70.193.2] ([198.70.193.2]:3390 "EHLO AVEXCH01.qlogic.org")
	by vger.kernel.org with ESMTP id S262170AbTEHWOd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 18:14:33 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [ANNOUNCE] QLogic FC Driver for Linux kernel 2.5 available.
Date: Thu, 8 May 2003 15:25:52 -0700
Message-ID: <B179AE41C1147041AA1121F44614F0B05989EA@AVEXCH02.qlogic.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ANNOUNCE] QLogic FC Driver for Linux kernel 2.5 available.
Thread-Index: AcMVsUen4WtRv4AGEde2IwCw0FRShg==
From: "Andrew Vasquez" <andrew.vasquez@qlogic.com>
To: <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
X-OriginalArrivalTime: 08 May 2003 22:25:53.0363 (UTC) FILETIME=[C962D230:01C315B0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

QLogic is pleased to announce the availability of a completely new
version of the QLogic FC driver (8.00.00b1) for its
ISP21xx/ISP22xx/ISP23xx chips and HBAs.  Our desire after community
review and continued driver development is inclusion of this work into
the Linux 2.5 kernel tree.

This driver contains support for Linux kernels 2.5.x and above *only*
(all 2.4.x support has been removed).  It's based on the QLogic 6.x
driver which is qualified with a number of OEMs and is functionally
equivalent to the 6.05.00b9 driver.

The new driver contains a number of key functional changes,
initialization (device scanning), I/O handling -- command queuing
refinements (front-end), ISR rewrite (backend).  The last two notables
should assist in a reasonable performance improvement.  Details
pertaining to the these changes and the development direction of this
work can be found towards the end of this email.

Driver tar-balls are available in two-forms from our SourceForge site:

	http://sourceforge.net/projects/linux-qla2xxx/

   o Kernel tree drop-in tarball (synced with 2.5.69):

	qla2xxx-kernel-v8.00.00b1.tar.bz2

	Extract the contents directly in the kernel tree:

		# cd /usr/src/linux-2.5.69
		# tar xvfj /tmp/qla2xxx-kernel-v8.00.00b1.tar.bz2
		# make config
		# ...

   o External build tarball:

	qla2xxx-src-v8.00.00b1.tar.bz2

	Extract the contents to your build directory:

		# mkdir /tmp/qla-8.00.00b1
		# cd /tmp/qla-8.00.00b1
		# tar xvfj /tmp/qla2xxx-src-v8.00.00b1.tar.bz2
		# make -C /usr/src/linux-2.5.69 SUBDIRS=$PWD modules

Please note, this is a (pre)beta release.  Testing has been performed
against a number of storage devices (JBODs, and FC raid boxes), but
certainly has not received the level of test coverage present with the
6.x series code -- basic error injection (cable-pulls and recovery).

NOTE: The driver group will try to address any issues with this work
within the linux-scsi and linux-kernel mailing lists.  Please do not 
contact QLogic technical support regarding this driver.

Details:

This driver is and will continue to be in a very fluid state.  Changes
thus far include basic infrastructure and semantic rewrites of some core
components of the driver:

	o Initialization:
	  - pci_driver scanning.
	  - Fabric scanning:
	    - GID_PT (if not supported, fallback to GA_NXT).
	    - SNS registration - RFT_ID, RFF_ID RNN_ID, RSNN_ID.
	  - ISP abstractions:
	    - Firmware loading mechanism.
	    - NVRAM configuration.
	  - 2k port login support (ISP23xx only).
	  - SRB pool allocations.

	o Queuing mechanisms:
	  - Rewrite command IOCB handling.

	o Command response handling:
	  - Rewrite ISR -- simplification.
	  - Bottom-half handling via work queues.

	o Code restructuring.

	o Kernel 2.5 support -- currently in sync with 2.5.69.
	
Additional work to be done include:

	o Further fabric scanning refinements:
	  - Minimizing SNS queries.
	  - Asynchronous fabric logins.

	o Review Locking mechanisms -- there are still a number of
	  structures which depend on our high-level hardware lock for
	  mutual exclusion.

	o Internal device-list management unification.

	o Rework mailbox and IOCTL request handling:
	  - To use wait queues.

	o Logging mechanisms.  The current debugging requirement is to
	  recompile the driver in 'debug' mode.  Once included in the
	  kernel tree, recompilation is not a guaranteed option.
	  Make use of 'Extended error logging' NVRAM parameter to enable
	  additional debug statements.
	
	o Kernel 2.5 support:
	  - module_param() interface.

Any feedback (comments, suggestions, criticisms) would be appreciated.

Regards,
Andrew Vasquez
QLogic Corporation
