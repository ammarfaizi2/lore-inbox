Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <155133-19608>; Mon, 25 Jan 1999 17:33:21 -0500
Received: by vger.rutgers.edu id <154396-19608>; Mon, 25 Jan 1999 17:26:27 -0500
Received: from wsdw01.win.tue.nl ([131.155.70.5]:3672 "EHLO wsdw01.win.tue.nl" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <154411-19608>; Mon, 25 Jan 1999 17:20:00 -0500
Date: Mon, 25 Jan 1999 23:26:48 +0100 (MET)
From: dwguest@win.tue.nl (Guest section DW)
Message-Id: <199901252226.XAA20449@wsdw01.win.tue.nl>
To: alan@lxorguk.ukuu.org.uk, dhamm@itserve.com, torvalds@transmeta.com
Subject: The Linux 64 GiB Limit - was: Re: oops! Should be fdisk broken?
Cc: linux-kernel@vger.rutgers.edu
Sender: owner-linux-kernel@vger.rutgers.edu

> 	From: David Hamm <dhamm@itserve.com>
> 
> 	 I have an 84g raid unit I'm trying to fdisk.  When the computer boots I get
> 	the  following info on the drive. 
> 	SCSI device sdb: hdwr sector= 512 bytes. Sectors= 164659200 [80400 MB] [80.4 GB] 
> 	When I fdisk it I get different info and after partitioning and mke2fs the 
> 	dirve only mounts with 14g of space.  I know this is a geometry issue but why 
> 	is it an issue?  Can fdisk be fixed? 
> 
> Not if you do not provide any detail at all.

	From dhamm@itserve.com Mon Jan 25 16:48:31 1999
	From: David Hamm <dhamm@itserve.com>

	Disk /dev/sdb: 64 heads, 32 sectors, 14864 cylinders

Aha! Very good. You lost precisely 2^27 sectors, that is 64 GiB,
or, more relevant, 2^16 cylinders.

No surprise, since cylinders is a short.

So, the following should improve things. (Unverified, untested.)

Andries


--- hdreg.h~    Fri Jan 22 16:49:34 1999
+++ hdreg.h     Mon Jan 25 23:13:06 1999
@@ -114,7 +114,7 @@
 struct hd_geometry {
       unsigned char heads;
       unsigned char sectors;
-      unsigned short cylinders;
+      unsigned long cylinders;
       unsigned long start;
 };

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
