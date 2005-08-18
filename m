Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750889AbVHRG7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbVHRG7E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 02:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750882AbVHRG7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 02:59:04 -0400
Received: from [202.125.80.34] ([202.125.80.34]:55661 "EHLO mail.esn.co.in")
	by vger.kernel.org with ESMTP id S1750890AbVHRG7D convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 02:59:03 -0400
Content-class: urn:content-classes:message
Subject: How to support partitions in driver?
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Thu, 18 Aug 2005 12:22:55 +0530
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Message-ID: <3AEC1E10243A314391FE9C01CD65429B3845@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: How to support partitions in driver?
Thread-Index: AcWjwXW4k4E899noRXOBkNEpDNx1eQ==
From: "Mukund JB`." <mukundjb@esntechnologies.co.in>
To: "linux-kernel-Mailing-list" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear all,

I have few basic queries regarding my partition implementation in my Sd
driver. 
Sorry for asking such petty things here. But, somehow it's not working &
I am made to ask it here.

I am working on 2.6.10 kernel(x86 architecture).
I have a working SD driver for my multimedia controller.
I have four interfaces for my board.
I call then tfa0, tfa1, tfa2, tfa3 respectively.

I defined then as below...

mknod /dev/tfa0 b 252 0	//device node for first partition of socket 0
mknod /dev/tfa0p1 b 252 1
mknod /dev/tfa0p2 b 252 2
.....
mknod /dev/tfa1 b 252 4	 //device node for first partition of socket 1
....
mknod /dev/tfa2 b 252 8	 //device node for first partition of socket 2
.....
mknod /dev/tfa3 b 252 12 //device node for first partition of socket 3
.....

I implemented the gendisk partition support with the following calls in
the driver.

#define MAX_PARTS 4 // maximum no partitions per device
alloc_disk (4);
gend.first_minor = (SockNo*MAX_PARTS); // SockNo: Current socket card is
// inserted 

Socket 0 & 3 support SD interfaces.
I am able to mount the SD with when inserted in socket 0.
At the same time, I am NOT able to mount the SD when inserted in socket
3. It fails as follows.

mount /dev/tfa3 /mnt 
/dev/tfa3: No such device or address
sfdisk: cannot open /dev/tfa3 for reading.

/proc/Partitions looks ok.
Cat/proc/partitions
252 0 14336 tfa3	// first inserted
252 0 14336 tfa0	 
252 0 14336 tfa2	

The updates to the /proc/partitions are done on and when the card is
inserted into that particular socket.

Can you please update me if I am missing anything that has to be
implemented in the driver apart from the above code?

Why am I not able to mount card in socket 3?

Regards,
Mukund Jampala

