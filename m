Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270931AbTHLSCu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 14:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271038AbTHLSCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 14:02:50 -0400
Received: from mail.kroah.org ([65.200.24.183]:63633 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270931AbTHLSCp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 14:02:45 -0400
Date: Tue, 12 Aug 2003 11:01:58 -0700
From: Greg KH <greg@kroah.com>
To: Matthew Wilcox <willy@debian.org>, jgarzik@pobox.com, davem@redhat.com
Cc: linux-kernel@vger.kernel.org, kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: C99 Initialisers
Message-ID: <20030812180158.GA1416@kroah.com>
References: <20030812020226.GA4688@zip.com.au> <1060654733.684.267.camel@localhost> <20030812023936.GE3169@parcelfarce.linux.theplanet.co.uk> <20030812053826.GA1488@kroah.com> <20030812112729.GF3169@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030812112729.GF3169@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 12, 2003 at 12:27:29PM +0100, Matthew Wilcox wrote:
> On Mon, Aug 11, 2003 at 10:38:27PM -0700, Greg KH wrote:
> > On Tue, Aug 12, 2003 at 03:39:36AM +0100, Matthew Wilcox wrote:
> > > I don't think anyone would appreciate you converting that to:
> > > 
> > > static struct pci_device_id tg3_pci_tbl[] __devinitdata = {
> > > 	{
> > > 		.vendor		= PCI_VENDOR_ID_BROADCOM,
> > > 		.device		= PCI_DEVICE_ID_TIGON3_5700,
> > > 		.subvendor	= PCI_ANY_ID,
> > > 		.subdevice	= PCI_ANY_ID,
> > > 		.class		= 0,
> > > 		.class_mask	= 0,
> > > 		.driver_data	= 0,
> > > 	},
> > 
> > I sure would.  Oh, you can drop the .class, .class_mask, and
> > .driver_data lines, and then it even looks cleaner.
> > 
> > I would love to see that kind of change made for pci drivers.
> 
> I really strongly disagree.  For a struct that's as well-known as
> pci_device_id, the argument of making it clearer doesn't make sense.

It's not _that_ well known.  I often have to go look it up to mentally
match up the fields when looking at pci drivers again after a few weeks
away.  With the above change, I can instantly know what is going on.

> It's also not subject to change, unlike say file_operations, so the
> argument of adding new elements without breaking anything is also not
> relevant.

Who knows, it might change in the future, never say never :)

> In tg3, the table definition is already 32 lines long with 2 lines per
> device_id.  In the scheme you favour so much, that becomes 92 lines, for
> no real gain that I can see.

In the end, it's up to the maintainer of the driver what they want to
do.  So, Jeff and David, here's a patch against the latest 2.6.0-test3
tg3.c that converts the pci_device_id table to C99 initializers.  If you
want to, please apply it.

thanks,

greg k-h


# Convert tg3 pci_device_id table to C99 initializers

--- a/drivers/net/tg3.c	Mon Aug 11 09:21:41 2003
+++ b/drivers/net/tg3.c	Tue Aug 12 10:58:30 2003
@@ -128,36 +128,96 @@
 static int tg3_debug = -1;	/* -1 == use TG3_DEF_MSG_ENABLE as value */
 
 static struct pci_device_id tg3_pci_tbl[] = {
-	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5700,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
-	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5701,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
-	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5702,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
-	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5703,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
-	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5704,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
-	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5702FE,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
-	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5702X,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
-	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5703X,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
-	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5704S,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
-	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5702A3,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
-	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5703A3,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
-	{ PCI_VENDOR_ID_SYSKONNECT, 0x4400,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
-	{ PCI_VENDOR_ID_ALTIMA, PCI_DEVICE_ID_ALTIMA_AC1000,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
-	{ PCI_VENDOR_ID_ALTIMA, PCI_DEVICE_ID_ALTIMA_AC1001,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
-	{ PCI_VENDOR_ID_ALTIMA, PCI_DEVICE_ID_ALTIMA_AC9100,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
+	{
+		.vendor		= PCI_VENDOR_ID_BROADCOM,
+		.device		= PCI_DEVICE_ID_TIGON3_5700,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_BROADCOM,
+		.device		= PCI_DEVICE_ID_TIGON3_5701,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_BROADCOM,
+		.device		= PCI_DEVICE_ID_TIGON3_5702,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_BROADCOM,
+		.device		= PCI_DEVICE_ID_TIGON3_5703,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_BROADCOM,
+		.device		= PCI_DEVICE_ID_TIGON3_5704,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_BROADCOM,
+		.device		= PCI_DEVICE_ID_TIGON3_5702FE,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_BROADCOM,
+		.device		= PCI_DEVICE_ID_TIGON3_5702X,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_BROADCOM,
+		.device		= PCI_DEVICE_ID_TIGON3_5703X,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_BROADCOM,
+		.device		= PCI_DEVICE_ID_TIGON3_5704S,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_BROADCOM,
+		.device		= PCI_DEVICE_ID_TIGON3_5702A3,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_BROADCOM,
+		.device		= PCI_DEVICE_ID_TIGON3_5703A3,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_SYSKONNECT,
+		.device		= 0x4400,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_ALTIMA,
+		.device		= PCI_DEVICE_ID_ALTIMA_AC1000,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_ALTIMA,
+		.device		= PCI_DEVICE_ID_ALTIMA_AC1001,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_ALTIMA,
+		.device		= PCI_DEVICE_ID_ALTIMA_AC9100,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID
+	},
 	{ 0, }
 };
 

