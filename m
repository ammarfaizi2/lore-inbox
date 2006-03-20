Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbWCTSf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWCTSf7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 13:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWCTSf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 13:35:59 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:61702 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751252AbWCTSf6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 13:35:58 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
x-originalarrivaltime: 20 Mar 2006 18:35:54.0528 (UTC) FILETIME=[1F23F200:01C64C4D]
Content-class: urn:content-classes:message
Subject: lstat returns bogus values.
Date: Mon, 20 Mar 2006 13:35:54 -0500
Message-ID: <Pine.LNX.4.61.0603201312320.23345@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: lstat returns bogus values.
Thread-Index: AcZMTR9KGewz0sF5T9qh/Vj0fq1T3Q==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,
I need to determine the total number of 512-byte sectors on
a physical media. lstat() returns bad data. With this defective
implimentation, how is one supposed to obtain this information?
Maybe some ioctl()

Boot device is /dev/hda
st_blksize = 4096
st_blocks = 0
st_size = 0

Here is what Linux `fisk` does to get the info...

open("/dev/hda", O_RDWR|O_LARGEFILE)    = 3
ioctl(3, BLKSSZGET, 0xbff46b04)         = 0
fstat64(3, {st_mode=S_IFBLK|0660, st_rdev=makedev(3, 0), ...}) = 0
ioctl(3, 0x301, 0xbff46b00)             = 0
ioctl(3, 0x80041272, 0xbff46b30)        = 0
_llseek(3, 0, [0], SEEK_SET)            = 0

Anybody know what the ioctls() names are? I don't see any
user-mode ioctls defined for this like BLKGETSIZE, which
exists only in kernel ioctls. Of course I could cheat
and copy some kernel-headers, but that's what created
this problem in the first place. Old code made some
assumptions that are no longer true, so how is somebody
supposed to get the total size of a block device??? The
"kernelly-corrected" stuff should have been returned by
lstat(), not by peeking at kernel headers.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.48 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
