Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265663AbUAHUaI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 15:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265690AbUAHUaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 15:30:08 -0500
Received: from lightning.hereintown.net ([141.157.132.3]:29626 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id S265663AbUAHUaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 15:30:01 -0500
Subject: Re: [PATCH] LSI Logic MegaRAID3 PCI ID [Was: MegaRAID on AMD64
	under 2.6.1]
From: Chris Meadors <clubneon@hereintown.net>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <1073582360.8870.65.camel@clubneon.priv.hereintown.net>
References: <1073512887.8211.39.camel@clubneon.priv.hereintown.net>
	 <20040108121227.B8987@infradead.org>
	 <1073580718.8870.45.camel@clubneon.priv.hereintown.net>
	 <20040108165545.A12313@infradead.org>
	 <1073582360.8870.65.camel@clubneon.priv.hereintown.net>
Content-Type: multipart/mixed; boundary="=-xV9OzE6WlKyMtSiPiZDC"
Message-Id: <1073593799.9027.46.camel@clubneon.priv.hereintown.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 08 Jan 2004 15:29:59 -0500
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1Aegn1-0001u1-VC*0jVpIBg8BIg*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xV9OzE6WlKyMtSiPiZDC
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2004-01-08 at 12:19, Chris Meadors wrote:
> On Thu, 2004-01-08 at 11:55, Christoph Hellwig wrote:
> > On Thu, Jan 08, 2004 at 11:51:58AM -0500, Chris Meadors wrote:
> > > i.e. PCI_VENDOR_ID_LSI_LOGIC, PCI_DEVICE_ID_AMI_MEGARAID3
> > > 
> > > When I added the lines for that combination to megaraid_pci_tbl[], the
> > > driver found the card.  So, I'm cool now.
> > 
> > Care to send a patch to Linus to add it?  And my apologies for losing
> > that entry. 
> 
> Sure thing, it is attatched, as I fear the white space mangling
> abilities of my MUA.

(Replying to myself with an updated version of the patch, apply this one
instead.)

I was wondering how the ID got lost.  I noticed that the file was pretty
much rewriten (the -rc patch is just a huge number of removes, followed
by an equally large number of adds).  So I started looking at the two
files side by side, wondering if any other IDs were missed.  Then I
think I spotted what happened.  In the -rc patch, there is an ID pair
for, "PCI_VENDOR_ID_LSI_LOGIC, PCI_DEVICE_ID_AMI_MEGARAID".  Since LSI
just starting making MegaRAID cards, there would have never been a
device produced with that ID.  The line I added in my patch was for the
MEGARAID3.  Looking at the older version of the file showed just as I
guessed, there wasn't an LSI_LOGIC MEGARAID.  I'm thinking the '3' got
dropped in the conversion between the old and new files.

So, attached is a second version of this patch.  Instead of adding a
totally new PCI ID, I'm just removing the incorrect LSI MEGARAID, and
replacing it with the LSI MEGARAID3.  I've also diffed against 2.6.1-rc3
this time (but megaraid.c wasn't touched between -rc2 and 3).

-- 
Chris

--=-xV9OzE6WlKyMtSiPiZDC
Content-Disposition: attachment; filename=LSI_MEGARAID3-2.patch
Content-Type: text/x-patch; name=LSI_MEGARAID3-2.patch; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

--- linux-2.6.1-rc3.orig/drivers/scsi/megaraid.c	2004-01-08 12:14:51.000000000 -0500
+++ linux-2.6.1-rc3/drivers/scsi/megaraid.c	2004-01-08 12:01:24.000000000 -0500
@@ -5093,7 +5093,7 @@
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_AMI_MEGARAID3,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{PCI_VENDOR_ID_LSI_LOGIC, PCI_DEVICE_ID_AMI_MEGARAID,
+	{PCI_VENDOR_ID_LSI_LOGIC, PCI_DEVICE_ID_AMI_MEGARAID3,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{0,}
 };

--=-xV9OzE6WlKyMtSiPiZDC--

