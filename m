Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbTEMSk4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 14:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262638AbTEMSkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 14:40:55 -0400
Received: from newweb.speedscript.com ([66.139.78.154]:21138 "EHLO
	mail.speedscript.com") by vger.kernel.org with ESMTP
	id S262499AbTEMSku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 14:40:50 -0400
Subject: Small sound/core fix
From: Hal Duston <hduston@speedscript.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@diego.com, hch@lst.de
Content-Type: text/plain
Organization: 
Message-Id: <1052852017.11514.40.camel@ulysseus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4- 
Date: 13 May 2003 13:53:37 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a bug that appears to have crept in between 
2.5.69-mm1 and 2.5.69-mm2 with the "switch most remaining 
drivers over to devfs_mk_bdev" patch

Hal Duston

--- linux-2.5.69-mm2/sound/core/info.c
+++ linux-2.5.69-mm2-fix/sound/core/info.c
@@ -1080,7 +1080,7 @@
 	entry->p = p;
 	up(&info_mutex);
 
-	if (strncmp(name, "controlC", 8) == 0)	/* created in sound.c */
+	if (strncmp(name, "controlC", 8) != 0)	/* created in sound.c */
 		devfs_mk_cdev(MKDEV(_major, minor), mode, "snd/%s", name);
 	return entry;
 }



