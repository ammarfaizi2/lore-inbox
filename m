Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266771AbSKOUib>; Fri, 15 Nov 2002 15:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266774AbSKOUib>; Fri, 15 Nov 2002 15:38:31 -0500
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:53486 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S266771AbSKOUia>; Fri, 15 Nov 2002 15:38:30 -0500
From: jordan.breeding@attbi.com
To: linux-kernel@vger.kernel.org
Subject: use of drm on pci radeons in 2.5.x
Date: Fri, 15 Nov 2002 20:45:17 +0000
X-Mailer: AT&T Message Center Version 1 (Nov  5 2002)
X-Authenticated-Sender: am9yZGFuLmJyZWVkaW5nQGF0dGJpLmNvbQ==
Message-Id: <20021115204520.GNOV1052.rwcrmhc52.attbi.com@rwcrwbc70>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that ATI now has quite a few PCI based Radeons.  I also notcied that 
the current drm code in the kernel as well as the dri code in the CVS Xfree86 
tree has code like:

#if defined(__alpha__) || defined(__powerpc__)
# define PCIGART_ENABLED
#else
# undef PCIGART_ENABLED
#endif

which could also be easily modified to allow for its use on x86, however in 
drivers/char/drm/Kconfig we have this currently:

config DRM_RADEON
    tristate "ATI Radeon"
    depends on DRM && AGP
    help
  Choose this option if you have an ATI Radeon graphics card.  There
  are both PCI and AGP versions.  You don't need to choose this to
  run the Radeon in plain VGA mode.  There is a product page at
  <http://www.ati.com/na/pages/products/pc/radeon32/index.html>.
  If M is selected, the module will be called radeon.o.

My question is that if someone was running on PPC or Alpha or an x86 chipset 
(and modifying the test mentioned above) with no AGP like the Intel E7500 and 
was using a Radeon with PCI (like the PCI 7500) why should they have to enable 
AGP in Kconfig just to get the Radeon DRM driver?  Thanks.

Jordan
