Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264686AbUESXXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264686AbUESXXw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 19:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264685AbUESXXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 19:23:52 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:59065 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264682AbUESXXt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 19:23:49 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
Subject: [PATCH] make Linux IDE more CELF-conforming ;)
Date: Thu, 20 May 2004 01:24:17 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, hch@lst.de
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405200124.17585.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I want to push it to Linus soon...

Noticed by Christoph Hellwig <hch@lst.de>.

Fix ide_delay_50ms() in ide.c to always sleep.

Probably somebody got the logic wrong while adding
#ifndef CONFIG_BLK_DEV_IDECS back in 2.4.0-test2.

 linux-2.6.6-bk3-bzolnier/drivers/ide/ide.c |    4 ----
 1 files changed, 4 deletions(-)

diff -puN drivers/ide/ide.c~ide_delay_50ms drivers/ide/ide.c
--- linux-2.6.6-bk3/drivers/ide/ide.c~ide_delay_50ms	2004-05-20 00:42:24.017922320 +0200
+++ linux-2.6.6-bk3-bzolnier/drivers/ide/ide.c	2004-05-20 00:42:38.945652960 +0200
@@ -1396,12 +1396,8 @@ void ide_add_generic_settings (ide_drive
  */
 void ide_delay_50ms (void)
 {
-#ifndef CONFIG_BLK_DEV_IDECS
-	mdelay(50);
-#else
 	__set_current_state(TASK_UNINTERRUPTIBLE);
 	schedule_timeout(1+HZ/20);
-#endif /* CONFIG_BLK_DEV_IDECS */
 }
 
 EXPORT_SYMBOL(ide_delay_50ms);

_

