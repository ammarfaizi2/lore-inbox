Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292289AbSCMEMn>; Tue, 12 Mar 2002 23:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292291AbSCMEMe>; Tue, 12 Mar 2002 23:12:34 -0500
Received: from gate.tuxia.com ([213.209.134.221]:46075 "EHLO
	exchange1.win.agb.tuxia") by vger.kernel.org with ESMTP
	id <S292289AbSCMEMY> convert rfc822-to-8bit; Tue, 12 Mar 2002 23:12:24 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.4418.65
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: 2.4.1 Block Driver and mmap
Date: Wed, 13 Mar 2002 05:12:23 +0100
Message-ID: <A16915712C18BD4EBD97897F82DA08CD409F56@exchange1.win.agb.tuxia>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: SCSI errors with Philips MOs
Thread-Index: AcHKPT0ZWt7w9vZOTYi2JNvzuCBT2AABiY2w
From: "Tim McDaniel" <tim.mcdaniel@tuxia.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm porting a working 2.2 driver to 2.4 .   Unfortunately, the mmap
entry point is not defined in the block_device_operations.   I've tried
forcing filp->f_op to an initialized file operations structure while
also registering the driver with block operations (as does the ramdisk
driver).   My mmap routine is entered and appears to work, but now the
rest of the driver is experiencing strange failures such as:
 
1) errno 25 (decimal) on an ioctl that used to work even in 2.4
2) fsck fails with a short read error

Without the change for filep->f_op, the mmap fails with errno 19
decimal.

My driver sits between the file system and the low level block driver
and funnels ata commands in a manner that is more fair and thus more
appropriate for a PVR implementation.

Any help would be greatly appreciated.

Thanks,
Tim
