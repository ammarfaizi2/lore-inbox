Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310464AbSCLU4o>; Tue, 12 Mar 2002 15:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311238AbSCLU4g>; Tue, 12 Mar 2002 15:56:36 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:41955 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S310464AbSCLU4Z>; Tue, 12 Mar 2002 15:56:25 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 12 Mar 2002 12:56:21 -0800
Message-Id: <200203122056.MAA05893@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: linux-2.5.6 scsi DMA mapping and compilation fixes (not yet working)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Warning: these drivers do not work yet.

	ftp://ftp.yggdrasil.com/private/adam/scsi-linux-2.5.6-diff.gz

	This patch allows all of the SCSI drivers that are available on
x86 to build, except for these:
		o The NCR53c80-based drivers (according to Alan Cox, there
		  is a new driver in the 2.4.x tree, and I don't want to
		  add a port of that driver to this already huge patch).

		o 53c7,8xx - I believe we have other scsi drivers that
		  cover the same hardware, so I have skipped this driver.

		o dpt_i2o - I need to understand the i2o system a little more
		  to determine whether all of the similar looking code in
		  drivers/messages/i2o and dpt_i2o is redundant or necessary.

	The patch adds a little code to scsi.c to allow scsi drivers
to tell the mid-level code to automatically map and unmap gather/scatter
lists.  This has simplified the porting process immensely.

	The patch also adds a routine for using the SCSI request
scratchpad area for accessing scsi requests in memory (primarily
for non-DMA drivers).  This eliminated some code replicated in
a multiple scsi drivers and basically enabled me to the need to
add very many calls to kmap and kunmap in each driver.

	There are also a few patches that juat add PCI or ISAPnP
device ID's, so that the boards will work with automatic
module loading based on device ID's.

	I owe an email to Tim Sullivan who tried my BusLogic and found
that it paniced at initialization.  So, these drivers probably do not
work yet.  Nevertheless, I would be interested in people looking
at the patch or even trying it just to see how it fares on other
hardware.  All that I know is that the code compiles and has no undefined
symbols, except for scsi_reset_host in BusLogic.c (I guess you can
comment it out for now, which is I told Tim to try).

	I want to emphasize that this patch is just a snapshot of
work in progress at this point.  I just finished getting the drivers
to compile and link.  I am going to step away from this for a while,
perhaps until tomorrow, but I thought I should post this in case
anyone is interested.


Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
