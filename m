Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161040AbVKDA6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161040AbVKDA6K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 19:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161032AbVKDAyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 19:54:43 -0500
Received: from h-67-100-217-179.hstqtx02.covad.net ([67.100.217.179]:29332
	"EHLO mail.gnucash.org") by vger.kernel.org with ESMTP
	id S1161035AbVKDAyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 19:54:35 -0500
Date: Thu, 3 Nov 2005 18:54:34 -0600
From: Linas Vepstas <linas@linas.org>
To: paulus@samba.org, linuxppc64-dev@ozlabs.org
Cc: johnrose@austin.ibm.com, linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 35/42]: ppc64: bugfix: fill in un-initialzed field
Message-ID: <20051104005434.GA27122@mail.gnucash.org>
Reply-To: linas@austin.ibm.com
References: <20051103235918.GA25616@mail.gnucash.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

235-eeh-set-pcidev-bugfix.patch

The pci device field should be initialized to a valid value.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

Index: linux-2.6.14-git3/arch/powerpc/platforms/pseries/eeh_cache.c
===================================================================
--- linux-2.6.14-git3.orig/arch/powerpc/platforms/pseries/eeh_cache.c	2005-11-02 14:42:38.994154417 -0600
+++ linux-2.6.14-git3/arch/powerpc/platforms/pseries/eeh_cache.c	2005-11-02 14:46:23.687642815 -0600
@@ -307,6 +307,9 @@
 		/* Save the BAR's; firmware doesn't restore these after EEH reset */
 		dn = pci_device_to_OF_node(dev);
 		eeh_save_bars(dev, PCI_DN(dn));
+
+		pci_dev_get (dev);  /* matching put is in eeh_remove_device() */
+		PCI_DN(dn)->pcidev = dev;
 	}
 
 #ifdef DEBUG
