Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752344AbWKQVkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752344AbWKQVkc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 16:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755945AbWKQVkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 16:40:32 -0500
Received: from monk.bluenotenetworks.com ([63.149.70.195]:5128 "EHLO
	monk.bluenotenetworks.com") by vger.kernel.org with ESMTP
	id S1752344AbWKQVkb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 16:40:31 -0500
X-SEF-Processed: 5_0_0_713__2006_11_17_16_40_33
X-SEF-6C9A4BC0-D50B-4DCA-88FB-91599F111D43: 1
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: Read/Write multiple network FDs in a single syscall context switch?
Date: Fri, 17 Nov 2006 16:40:30 -0500
Message-ID: <5A09CDB9FC09B1478DF679F4C698D1DB5CA2D5@johnleehooker.bluenote.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Read/Write multiple network FDs in a single syscall context switch?
Thread-index: AccKkGU/+/gxTaMaRvCLfNJafXDJaQAACzFQ
From: "Marc Snider" <msnider@bluenotenetworks.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've searched long and hard prior to posting here, but have been unable to locate a kernel mechanism providing the ability to read or write multiple FDs in a single userspace to kernel context switch.

We've got a userspace network application that uses epoll to wait for packet arrival and then reads a single frame off of dozens of separate FDs (sockets), operates on the payload and then forwards along by writing to dozens of other separate FDs (sockets).   At high loads we invariably have many dozens of socket FDs to read and write.

If 50 separate frames are received on 50 separate sockets then we are at present doing 50 separate reads and then 50 separate writes, thus resulting in over a hundred distinct (and seemingly unnecessary) user to kernel space and kernel to user space context switches.   Is there a mechanism I've missed which allows many network FDs to be read or written in a single syscall?   For example, something analogous to the recv() and send() calls but instead providing a vector for the parameters and return value?

I picture something like:

     ssize_t *recvMultiple(int *s, void **buf, size_t *len, int *flags)         and
     ssize_t *sendMultiple(int *s, void **buf, size_t *len, int *flags)


The user would have to be careful about not using blocking sockets with these types of multiple FD operations, but it seems to me that such a kernel mechanism would allow a user space process to eliminate dozens or even hundreds of unnecessary context switches when servicing multiple network FDs...    The cycle savings for an application like ours would be huge.   I am confused about why I've been unable to locate such a mechanism considering the perceived performance advantages and ubiquitous nature of user applications that service many network FDs...

If it's not too much trouble then I'd appreciate if those answering could CC: me on any responses.


Regards,

Marc Snider
msnider@bluenotenetworks.com


