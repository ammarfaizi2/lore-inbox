Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263514AbTIDM5O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 08:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264974AbTIDM5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 08:57:13 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:1943 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263514AbTIDM5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 08:57:04 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Patrick Mochel <mochel@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <1062605483.1780.30.camel@gaston>
References: <1062605483.1780.30.camel@gaston>
Message-Id: <1062680175.1780.85.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 04 Sep 2003 14:56:15 +0200
X-SA-Exim-Mail-From: benh@kernel.crashing.org
Subject: Re: [PATCH] IDE: fix Power Management
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-09-03 at 18:11, Benjamin Herrenschmidt wrote:
> This is the "final" one hopefully, Bart, check out it's correct,
> Andrew that I did no typo this time ;)
> 
> Spacing is a bit fucked up in setup_driver_defaults due to the
> field name beeing too long (gah !) but that isn't too bad...

And it's even better with the proper return type... go figure
why I didn't see the gcc warning yesterday...

===== drivers/ide/ide.c 1.94 vs edited =====
--- 1.94/drivers/ide/ide.c	Tue Sep  2 16:18:29 2003
+++ edited/drivers/ide/ide.c	Thu Sep  4 14:54:13 2003
@@ -2406,6 +2406,12 @@
 	return ide_abort(drive, msg);
 }
 
+static ide_startstop_t default_start_power_step(ide_drive_t *drive, struct request *rq)
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


