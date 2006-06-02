Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751458AbWFBTqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbWFBTqJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 15:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbWFBTqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 15:46:09 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:21891 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751458AbWFBTqH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 15:46:07 -0400
Message-Id: <20060602194742.420464000@sous-sol.org>
References: <20060602194618.482948000@sous-sol.org>
Date: Fri, 02 Jun 2006 00:00:07 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgewood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Mark Lord <liml@rtr.ca>,
       Jens Axboe <axboe@suse.de>, Jeff Garzik <jeff@garzik.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 07/11] the latest consensus libata resume fix
Content-Disposition: inline; filename=the-latest-consensus-libata-resume-fix.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Mark Lord <liml@rtr.ca>

Okay, just to sum things up.

This forces libata to wait for up to 2 seconds for BUSY|DRQ to clear
on resume before continuing.

[jgarzik adds...]  During testing we never saw DRQ asserted, but
nonetheless (a) this works and (b) testing for DRQ won't hurt.

Signed-off-by:  Mark Lord <liml@rtr.ca>
Acked-by: Jens Axboe <axboe@suse.de>
Signed-off-by: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 drivers/scsi/libata-core.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.16.19.orig/drivers/scsi/libata-core.c
+++ linux-2.6.16.19/drivers/scsi/libata-core.c
@@ -4293,6 +4293,7 @@ static int ata_start_drive(struct ata_po
 int ata_device_resume(struct ata_port *ap, struct ata_device *dev)
 {
 	if (ap->flags & ATA_FLAG_SUSPENDED) {
+		ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 200000);
 		ap->flags &= ~ATA_FLAG_SUSPENDED;
 		ata_set_mode(ap);
 	}

--
