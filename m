Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263962AbTICQLk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 12:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263963AbTICQLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 12:11:40 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:21643 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263962AbTICQLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 12:11:31 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Patrick Mochel <mochel@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Message-Id: <1062605483.1780.30.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 03 Sep 2003 18:11:23 +0200
X-SA-Exim-Mail-From: benh@kernel.crashing.org
Subject: [PATCH] IDE: fix Power Management
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the "final" one hopefully, Bart, check out it's correct,
Andrew that I did no typo this time ;)

Spacing is a bit fucked up in setup_driver_defaults due to the
field name beeing too long (gah !) but that isn't too bad...

Ben.

diff -urN for-linus-ppc/drivers/ide/ide.c linuxppc-2.5-benh/drivers/ide/ide.c
--- for-linus-ppc/drivers/ide/ide.c	2003-09-03 18:07:14.000000000 +0200
+++ linuxppc-2.5-benh/drivers/ide/ide.c	2003-09-03 18:09:01.000000000 +0200
@@ -2406,6 +2406,12 @@
 	return ide_abort(drive, msg);
 }
 
+static int default_start_power_step(ide_drive_t *drive, struct request *rq)
+{
+	rq->pm->pm_step = ide_pm_state_completed;
+	return ide_stopped;
+}
+
 static void setup_driver_defaults (ide_driver_t *d)
 {
 	if (d->cleanup == NULL)		d->cleanup = default_cleanup;
@@ -2420,6 +2426,7 @@
 	if (d->capacity == NULL)	d->capacity = default_capacity;
 	if (d->special == NULL)		d->special = default_special;
 	if (d->attach == NULL)		d->attach = default_attach;
+	if (d->start_power_step == NULL)d->start_power_step = default_start_power_step;
 }
 
 int ide_register_subdriver (ide_drive_t *drive, ide_driver_t *driver, int version)


