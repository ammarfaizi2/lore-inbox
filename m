Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbWAIPQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbWAIPQF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 10:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWAIPQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 10:16:04 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:13224 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932374AbWAIPQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 10:16:01 -0500
Date: Mon, 9 Jan 2006 16:16:00 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Greg KH <greg@kroah.com>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       pcihpd-discuss@lists.sourceforge.net
Subject: Re: Thinkpad docking station: pci hotplug questions
Message-ID: <20060109151600.GE717@atrey.karlin.mff.cuni.cz>
References: <20060108191159.GA1880@elf.ucw.cz> <20060109035716.GB2824@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060109035716.GB2824@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I'm trying to get PCI hotplug to work on thinkpad x32 -- it is
> > apparently neccessary for proper docking station support. What needs
> > to be done to get it running?
> > 
> > I noticed some strangenesses:
> > 
> > pcihpfs is mentioned in Kconfig, but I can't find it anywhere in
> > kernel
> 
> Yeah, that's 2.4 stuff, you don't need that anymore, everything shows up
> in sysfs now.

Here's a fix. Where in sysfs should I find that?

root@amd:/sys# find . -name "*hot*"
./module/"pci_hotplug"

> > CONFIG_HOTPLUG_PCI_PCIE exists in Makefile but not in Kconfig.
> 
> Did you look in drivers/pci/pcie/Kconfig?

No, oops, you are right.

--- snip here ---

Remove reference to pcihpfs that no longer exists.

Signed-off-by: Pavel Machek <pavel@suse.cz>

--- a/drivers/pci/hotplug/Kconfig
+++ b/drivers/pci/hotplug/Kconfig
@@ -11,8 +11,7 @@ config HOTPLUG_PCI
 	---help---
 	  Say Y here if you have a motherboard with a PCI Hotplug controller.
 	  This allows you to add and remove PCI cards while the machine is
-	  powered up and running.  The file system pcihpfs must be mounted
-	  in order to interact with any PCI Hotplug controllers.
+	  powered up and running.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called pci_hotplug.



-- 
Thanks, Sharp!
