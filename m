Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269144AbUIHUuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269144AbUIHUuq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 16:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269133AbUIHUuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 16:50:46 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:17845 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S269144AbUIHUuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 16:50:35 -0400
Date: Wed, 8 Sep 2004 15:50:20 -0500
From: Erik Jacobson <erikj@subway.americas.sgi.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] sgiioc4 driver needs /proc/ide entries
In-Reply-To: <Pine.SGI.4.53.0409081323210.87183@subway.americas.sgi.com>
Message-ID: <Pine.SGI.4.53.0409081533420.98673@subway.americas.sgi.com>
References: <Pine.SGI.4.53.0409081059500.77854@subway.americas.sgi.com>
 <200409081940.13597.bzolnier@elka.pw.edu.pl>
 <Pine.SGI.4.53.0409081323210.87183@subway.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that I understand we don't need to create /proc/ide/sgiioc4, the patch
is very simple.

Below you will find the new patch.  I just tested it now and it works
properly - /proc/ide is properly populated with this patch (and not
populated on altix without it).



Add create_proc_ide_interfaces() call to sgiioc4_ide_setup_pci_device()
so /proc/ide gets populated properly.

Signed-off-by: Erik Jacobson <erikj@sgi.com>
---

 drivers/ide/pci/sgiioc4.c |    4 ++++
 1 files changed, 4 insertions(+)


diff -Naru linux-2.6.8-orig/drivers/ide/pci/sgiioc4.c linux-2.6.8/drivers/ide/pci/sgiioc4.c
--- linux-2.6.8-orig/drivers/ide/pci/sgiioc4.c	2004-08-14 01:36:58.000000000 -0400
+++ linux-2.6.8/drivers/ide/pci/sgiioc4.c	2004-09-08 16:12:29.677605262 -0400
@@ -702,6 +702,10 @@
 		       hwif->name, d->name);

 	probe_hwif_init(hwif);
+
+	/* Create /proc/ide entries */
+	create_proc_ide_interfaces();
+
 	return 0;
 }

