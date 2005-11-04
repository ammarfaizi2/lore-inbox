Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161031AbVKDBAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161031AbVKDBAH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 20:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161037AbVKDAyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 19:54:37 -0500
Received: from h-67-100-217-179.hstqtx02.covad.net ([67.100.217.179]:24724
	"EHLO mail.gnucash.org") by vger.kernel.org with ESMTP
	id S1161031AbVKDAyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 19:54:24 -0500
Date: Thu, 3 Nov 2005 18:54:23 -0600
From: Linas Vepstas <linas@linas.org>
To: paulus@samba.org, linuxppc64-dev@ozlabs.org
Cc: johnrose@austin.ibm.com, linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 33/42]: ppc64: remove bogus printk
Message-ID: <20051104005423.GA27106@mail.gnucash.org>
Reply-To: linas@austin.ibm.com
References: <20051103235918.GA25616@mail.gnucash.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

233-eeh-buid-fix.patch

Remove un-desired warning print from EEH code. 

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>


Index: linux-2.6.14-git3/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6.14-git3.orig/arch/powerpc/platforms/pseries/eeh.c	2005-11-02 14:43:49.212307192 -0600
+++ linux-2.6.14-git3/arch/powerpc/platforms/pseries/eeh.c	2005-11-02 14:45:00.429319560 -0600
@@ -824,12 +824,10 @@
 	if (!dn || !PCI_DN(dn))
 		return;
 	phb = PCI_DN(dn)->phb;
-	if (NULL == phb || 0 == phb->buid) {
-		printk(KERN_WARNING "EEH: Expected buid but found none for %s\n",
-		       dn->full_name);
-		dump_stack();
+
+	/* USB Bus children of PCI devices will not have BUID's */
+	if (NULL == phb || 0 == phb->buid)
 		return;
-	}
 
 	info.buid_hi = BUID_HI(phb->buid);
 	info.buid_lo = BUID_LO(phb->buid);
