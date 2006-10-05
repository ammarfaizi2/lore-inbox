Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751440AbWJEMob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbWJEMob (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 08:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbWJEMoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 08:44:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:46773 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751440AbWJEMoa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 08:44:30 -0400
From: Andreas Schwab <schwab@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Reenable SCSI=m
X-Yow: ..  If I had heart failure right now, I couldn't be a more fortunate man!!
Date: Thu, 05 Oct 2006 14:44:28 +0200
Message-ID: <jemz8bvsnn.fsf@sykes.suse.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since CONFIG_SCSI (a tristate) now depends on CONFIG_BLOCK (a bool) it is
no longer possible to set CONFIG_SCSI=m.  Fix that by putting `if
BLOCK/endif' around drivers/scsi/Kconfig instead of `depends on BLOCK' on
SCSI and RAID_ATTRS.

Signed-off-by: Andreas Schwab <schwab@suse.de>

---
 drivers/scsi/Kconfig |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: linux-2.6.19-rc1/drivers/scsi/Kconfig
===================================================================
--- linux-2.6.19-rc1.orig/drivers/scsi/Kconfig	2006-10-05 13:20:32.000000000 +0200
+++ linux-2.6.19-rc1/drivers/scsi/Kconfig	2006-10-05 13:49:03.000000000 +0200
@@ -1,15 +1,15 @@
+if BLOCK
+
 menu "SCSI device support"
 
 config RAID_ATTRS
 	tristate "RAID Transport Class"
 	default n
-	depends on BLOCK
 	---help---
 	  Provides RAID
 
 config SCSI
 	tristate "SCSI device support"
-	depends on BLOCK
 	---help---
 	  If you want to use a SCSI hard disk, SCSI tape drive, SCSI CD-ROM or
 	  any other SCSI device under Linux, say Y and make sure that you know
@@ -1739,3 +1739,5 @@ endmenu
 source "drivers/scsi/pcmcia/Kconfig"
 
 endmenu
+
+endif

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
