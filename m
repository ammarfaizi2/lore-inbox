Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267499AbSLSBDj>; Wed, 18 Dec 2002 20:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267500AbSLSBDj>; Wed, 18 Dec 2002 20:03:39 -0500
Received: from dsl092-013-071.sfo1.dsl.speakeasy.net ([66.92.13.71]:64145 "EHLO
	pelerin.serpentine.com") by vger.kernel.org with ESMTP
	id <S267499AbSLSBDh>; Wed, 18 Dec 2002 20:03:37 -0500
Subject: Re: 3ware driver in 2.4.x and 2.5.x not compatible with 6x00
	series cards
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Nathan Neulinger <nneul@umr.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       uetrecht@umr.edu
In-Reply-To: <1040242085.24561.22.camel@irongate.swansea.linux.org.uk>
References: <20021218181052.GA26465@umr.edu>
	 <1040242085.24561.22.camel@irongate.swansea.linux.org.uk>
Content-Type: multipart/mixed; boundary="=-rzDn7ZGlTnuzxcuxIZSS"
Organization: 
Message-Id: <1040260298.800.7.camel@camp4.serpentine.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 18 Dec 2002 17:11:38 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rzDn7ZGlTnuzxcuxIZSS
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2002-12-18 at 12:08, Alan Cox wrote:

> Please give the name of your 3ware contact so someone competent in 3ware
> so they can be 're-educated'
> 
> I use the new driver with an old card, it works.

I've talked with some clue-enabled people at 3ware about this.  The
newest driver is indeed broken on cards with very old firmware, and the
next revision of the driver will fix that problem.

There's a trivial fix for 2.4.20: just get rid of the error case around
line 1016 of 3w-xxxx.c.  This is basically the fix 3ware is planning to
include in the next driver release.

Patch attached.

	<b

--=-rzDn7ZGlTnuzxcuxIZSS
Content-Disposition: attachment; filename=3ware.patch
Content-Type: text/x-patch; name=3ware.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

diff -u /home/bos/3w-xxxx.c.~1~ /home/bos/3w-xxxx.c
--- /home/bos/3w-xxxx.c.~1~	2002-12-18 17:09:20.000000000 -0800
+++ /home/bos/3w-xxxx.c	2002-12-18 17:09:20.000000000 -0800
@@ -1014,12 +1014,6 @@
 			error = tw_setfeature(tw_dev2, 2, 1, &c);
 			if (error) {
 				printk(KERN_WARNING "3w-xxxx: tw_setfeature(): Error setting features for card %d.\n", j);
-				scsi_unregister(host);
-				release_region((tw_dev->tw_pci_dev->resource[0].start), TW_IO_ADDRESS_RANGE);
-				tw_free_device_extension(tw_dev);
-				kfree(tw_dev);
-				numcards--;
-				continue;
 			}
 
 			/* Now setup the interrupt handler */

--=-rzDn7ZGlTnuzxcuxIZSS--

