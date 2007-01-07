Return-Path: <linux-kernel-owner+w=401wt.eu-S932598AbXAGQEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932598AbXAGQEf (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 11:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932597AbXAGQEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 11:04:35 -0500
Received: from emerald.lightlink.com ([205.232.34.14]:13060 "EHLO
	emerald.lightlink.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932598AbXAGQEX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 11:04:23 -0500
X-Greylist: delayed 1145 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Jan 2007 11:04:21 EST
Date: Sun, 7 Jan 2007 10:40:49 -0500
From: "Mark M. Hoffman" <mhoffman@lightlink.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: Adrian Bunk <bunk@stusta.de>, greg@kroah.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [-mm patch] drivers/pci/quirks.c: cleanup
Message-ID: <20070107154049.GA22558@jupiter.solarsys.private>
References: <20061219041315.GE6993@stusta.de> <20070105095233.4ce72e7e.khali@linux-fr.org> <20070105232913.GU20714@stusta.de> <20070107123013.097c1f23.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070107123013.097c1f23.khali@linux-fr.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean, Adrian, et. al.:

* Jean Delvare <khali@linux-fr.org> [2007-01-07 12:30:13 +0100]:
> Hi Adrian,
> 
> On Sat, 6 Jan 2007 00:29:13 +0100, Adrian Bunk wrote:
> > While looking at the code, I also noted the following:
> > 
> > quirk_sis_96x_compatible() is pretty useless since all it does is to set 
> > a static variable that is only used in a printk().
> > 
> > quirk_sis_96x_compatible() was added with:
> > 
> > 
> >     2003/05/13 13:48:50-07:00 mhoffman
> >     [PATCH] i2c: Add SiS96x I2C/SMBus driver
> >     
> >     This patch adds support for the SMBus of SiS96x south
> >     bridges.  It is based on i2c-sis645.c from the lm sensors
> >     project, which never made it into an official kernel and
> >     was anyway mis-named.
> >     
> >     This driver works on my SiS 645/961 board vs w83781d.
> > 
> > 
> > It's usage in
> > 
> > 
> > static void __init quirk_sis_503_smbus(struct pci_dev *dev)
> > {
> >        if (sis_96x_compatible)
> >                quirk_sis_96x_smbus(dev);
> > }
> > 
> > 
> > Was removed in
> > 
> > 
> > Author: torvalds <torvalds>
> > Date:   Thu Oct 30 19:03:38 2003 +0000
> > 
> >     Stop SIS 96x chips from lying about themselves.
> >     
> >     Some machines with the SIS 96x southbridge have it set up
> >     to claim it is a SIS 503 chip. That breaks irq routing logic
> >     among other things. Fix it properly by making everybody aware
> >     of the duplicity.
> > 
> > 
> > Was this intentional (and quirk_sis_96x_compatible() should be removed), 
> > or is this a bug that should be fixed?
> 
> I noticed this too in April 2006, see:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2006-April/016016.html
> 
> Quoting myself back then:
> "The whole sis_96x_compatible stuff looks superfluous now. It was used
> before 2.6.0-test10, but we could certainly get rid of it now."
> 
> I do not think there is a bug here, or someone would have complained by
> now. Note though that I do not have a SiS-based motherboard to test on.
> Mark may be able to help with testing.

It's just cruft from the original quirk.  The "compatible" printk could have
had value as a diagnostic in case the new quirk didn't work for some reason,
but I never saw any complaints about it (apart from the link order problem,
which is something different.)  It's safe to remove by now.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

