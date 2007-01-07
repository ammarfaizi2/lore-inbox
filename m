Return-Path: <linux-kernel-owner+w=401wt.eu-S932593AbXAGQEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593AbXAGQEX (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 11:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932597AbXAGQEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 11:04:23 -0500
Received: from emerald.lightlink.com ([205.232.34.14]:13060 "EHLO
	emerald.lightlink.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932595AbXAGQEW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 11:04:22 -0500
X-Greylist: delayed 1145 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Jan 2007 11:04:21 EST
Date: Sun, 7 Jan 2007 10:44:41 -0500
From: "Mark M. Hoffman" <mhoffman@lightlink.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: Adrian Bunk <bunk@stusta.de>, greg@kroah.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] drivers/pci/quirks.c: cleanup
Message-ID: <20070107154441.GB22558@jupiter.solarsys.private>
References: <20061219041315.GE6993@stusta.de> <20070105095233.4ce72e7e.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070105095233.4ce72e7e.khali@linux-fr.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean, Adrian:

> On Tue, 19 Dec 2006 05:13:15 +0100, Adrian Bunk wrote:
> > @@ -1122,6 +1123,14 @@ static void quirk_sis_96x_smbus(struct p
> >  	pci_write_config_byte(dev, 0x77, val & ~0x10);
> >  	pci_read_config_byte(dev, 0x77, &val);
> >  }
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_961,		quirk_sis_96x_smbus );
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_962,		quirk_sis_96x_smbus );
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_963,		quirk_sis_96x_smbus );
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_LPC,		quirk_sis_96x_smbus );
> > +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_961,		quirk_sis_96x_smbus );
> > +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_962,		quirk_sis_96x_smbus );
> > +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_963,		quirk_sis_96x_smbus );
> > +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_LPC,		quirk_sis_96x_smbus );
> >  
> >  /*
> >   * ... This is further complicated by the fact that some SiS96x south
> > @@ -1158,6 +1167,8 @@ static void quirk_sis_503(struct pci_dev
> >  	 */
> >  	dev->device = devid;
> >  }
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_503,		quirk_sis_503 );
> > +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_503,		quirk_sis_503 );

* Jean Delvare <khali@linux-fr.org> [2007-01-05 09:52:33 +0100]:
> Was this patch tested on the SiS-based boards which need these quirks?
> I think you broke them. If I remember correctly, quirk_sis_503() must
> be called before quirk_sis_96x_smbus() for some boards to work
> properly, and we currently rely on the linking order to guarantee that.
> Likewise, quirk_sis_96x_compatible() should be called before
> quirk_sis_503() otherwise the warning message in quirk_sis_503() will
> no longer be correct.
> 
> So if you want to put the calls right after the quirk functions, you
> need to reorder the functions themselves as well. Feel free to add a
> comment explaining the order requirement so that nobody breaks it
> accidentally again in the future.

It is fragile for this code to depend on link order; Adrian's obvious and
trivial cleanups broke it.  Not only that, but some FC kernels had/have the
link order reversed such that this quirk is broken anyway.

I sent a patch for this back in May:
http://lists.lm-sensors.org/pipermail/lm-sensors/2006-May/016113.html

There was some discussion on the linux-pci mailing list as well; can't seem to
find an archive of that though.  Basically, it was not understood how the FC
kernels could have a reversed link order.  I never followed up on it, my bad.

At any rate, can we please get the patch above applied?  I will send a new one
if necessary.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

