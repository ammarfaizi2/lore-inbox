Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbTIYSBe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 14:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbTIYSBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 14:01:30 -0400
Received: from [212.57.164.72] ([212.57.164.72]:25605 "EHLO mail.ward.six")
	by vger.kernel.org with ESMTP id S261732AbTIYSA7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 14:00:59 -0400
Date: Thu, 25 Sep 2003 15:16:18 +0600
From: Denis Zaitsev <zzz@anda.ru>
To: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, gibbs@scsiguy.com, dledford@redhat.com
Subject: [PATCH][TRIVIAL] (2.4.22) Allow aic7xxx_osm.c to be compiled without CONFIG_PCI
Message-ID: <20030925151618.C15849@natasha.ward.six>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the trivial #ifdef patch for CONFIG_PCI/EISA.  In my case it
allows the Adaptec SCSI driver (the "new" one) to be compiled for
non-PCI (EISA) system.  Else there are an <undefined symbol> errors.
The 2.6 branch needs the same patch, as I understand.

Please, apply it.  (I don't know who is the maintainer for now!)


--- drivers/scsi/aic7xxx/aic7xxx_osm.c.orig	2003-09-15 01:56:14.000000000 +0600
+++ drivers/scsi/aic7xxx/aic7xxx_osm.c	2003-09-16 22:57:11.000000000 +0600
@@ -1552,6 +1552,7 @@ ahc_softc_comp(struct ahc_softc *lahc, s
 
 	/* Still equal.  Sort by BIOS address, ioport, or bus/slot/func. */
 	switch (rvalue) {
+#ifdef CONFIG_PCI
 	case AHC_PCI:
 	{
 		char primary_channel;
@@ -1584,6 +1585,8 @@ ahc_softc_comp(struct ahc_softc *lahc, s
 			value = 1;
 		break;
 	}
+#endif
+#ifdef CONFIG_EISA
 	case AHC_EISA:
 		if ((rahc->flags & AHC_BIOS_ENABLED) != 0) {
 			value = rahc->platform_data->bios_address
@@ -1593,6 +1596,7 @@ ahc_softc_comp(struct ahc_softc *lahc, s
 			      - lahc->bsh.ioport; 
 		}
 		break;
+#endif
 	default:
 		panic("ahc_softc_sort: invalid bus type");
 	}
