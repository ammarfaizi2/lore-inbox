Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267325AbUIAQVC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267325AbUIAQVC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 12:21:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267327AbUIAP5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 11:57:21 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:62898 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S267325AbUIAPvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 11:51:44 -0400
Date: Wed, 1 Sep 2004 16:51:21 +0100
Message-Id: <200409011551.i81FpLHl000640@delerium.codemonkey.org.uk>
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Remove possible reuse of stale pointer in aic7xxx
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spotted with the source checker from Coverity.com.

Signed-off-by: Dave Jones <davej@redhat.com>


diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/scsi/aic7xxx_old.c linux-2.6/drivers/scsi/aic7xxx_old.c
--- bk-linus/drivers/scsi/aic7xxx_old.c	2004-08-28 21:57:23.000000000 +0100
+++ linux-2.6/drivers/scsi/aic7xxx_old.c	2004-09-01 13:31:11.000000000 +0100
@@ -9243,6 +9243,7 @@ aic7xxx_detect(Scsi_Host_Template *templ
 	    {
               /* duplicate PCI entry, skip it */
 	      kfree(temp_p);
+	      temp_p = NULL;
               continue;
 	    }
 	    current_p = current_p->next;
