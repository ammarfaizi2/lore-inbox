Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266786AbUIAQHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266786AbUIAQHW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 12:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267323AbUIAP5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 11:57:38 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:61362 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S267314AbUIAPvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 11:51:44 -0400
Date: Wed, 1 Sep 2004 16:51:21 +0100
Message-Id: <200409011551.i81FpL6R000625@delerium.codemonkey.org.uk>
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Remove redundant freeing code from aic7770
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ahc_alloc already frees the 'name' if ahc=NULL

Spotted with the source checker from Coverity.com.

Signed-off-by: Dave Jones <davej@redhat.com>


diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/scsi/aic7xxx/aic7770_osm.c linux-2.6/drivers/scsi/aic7xxx/aic7770_osm.c
--- bk-linus/drivers/scsi/aic7xxx/aic7770_osm.c	2004-06-03 13:40:05.000000000 +0100
+++ linux-2.6/drivers/scsi/aic7xxx/aic7770_osm.c	2004-06-03 13:42:30.000000000 +0100
@@ -185,10 +185,8 @@ aic7770_linux_config(struct aic7770_iden
 		return (ENOMEM);
 	strcpy(name, buf);
 	ahc = ahc_alloc(&aic7xxx_driver_template, name);
-	if (ahc == NULL) {
-		free(name, M_DEVBUF);
+	if (ahc == NULL)
 		return (ENOMEM);
-	}
 	error = aic7770_config(ahc, entry, eisaBase);
 	if (error != 0) {
 		ahc->bsh.ioport = 0;
