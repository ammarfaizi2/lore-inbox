Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261518AbVDSNbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbVDSNbh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 09:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261517AbVDSNbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 09:31:37 -0400
Received: from orb.pobox.com ([207.8.226.5]:44168 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261516AbVDSNb0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 09:31:26 -0400
Date: Tue, 19 Apr 2005 06:31:24 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] fix aic7xxx_osm.c compile failure (gcc 2.95.x only)
Message-ID: <20050419133123.GD8541@ip68-4-98-123.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get this compile error on linux-2.6 head
9d469ee9f21c680c41dbffe5b0f36ab5010ca8b1, but only with gcc 2.95.3, not
gcc 3.4.3:

  CC [M]  drivers/scsi/aic7xxx/aic7xxx_osm.o
drivers/scsi/aic7xxx/aic7xxx_osm.c: In function `ahc_linux_init':
drivers/scsi/aic7xxx/aic7xxx_osm.c:3608: parse error before `int'
drivers/scsi/aic7xxx/aic7xxx_osm.c:3609: `rc' undeclared (first use in
this function)
drivers/scsi/aic7xxx/aic7xxx_osm.c:3609: (Each undeclared identifier is
reported only once
drivers/scsi/aic7xxx/aic7xxx_osm.c:3609: for each function it appears
in.)
drivers/scsi/aic7xxx/aic7xxx_osm.c: At top level:
drivers/scsi/aic7xxx/aic7xxx_osm.c:744: warning: `ahc_linux_detect'
defined but not used
make[3]: *** [drivers/scsi/aic7xxx/aic7xxx_osm.o] Error 1
make[2]: *** [drivers/scsi/aic7xxx] Error 2
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2

This patch fixes the compile error. I've compile-tested this but I
haven't actually run it.

Signed-off-by: Barry K. Nathan <barryn@pobox.com>

--- linux-2.6.12-rc2-9d469ee9f21c680c41dbffe5b0f36ab5010ca8b1-bkn2/drivers/scsi/aic7xxx/aic7xxx_osm.c	2005-04-19 00:46:11.666064007 -0700
+++ linux-2.6.12-rc2-9d469ee9f21c680c41dbffe5b0f36ab5010ca8b1-bkn3/drivers/scsi/aic7xxx/aic7xxx_osm.c	2005-04-19 06:23:00.099780019 -0700
@@ -3602,10 +3602,12 @@
 ahc_linux_init(void)
 {
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
+	int rc;
+
 	ahc_linux_transport_template = spi_attach_transport(&ahc_linux_transport_functions);
 	if (!ahc_linux_transport_template)
 		return -ENODEV;
-	int rc = ahc_linux_detect(&aic7xxx_driver_template);
+	rc = ahc_linux_detect(&aic7xxx_driver_template);
 	if (rc)
 		return rc;
 	spi_release_transport(ahc_linux_transport_template);
