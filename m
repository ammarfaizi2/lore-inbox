Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262426AbTDXJWh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 05:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262513AbTDXJWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 05:22:37 -0400
Received: from codepoet.org ([166.70.99.138]:5269 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S262426AbTDXJWg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 05:22:36 -0400
Date: Thu, 24 Apr 2003 03:34:43 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.21-rc1 pointless IDE noise reduction
Message-ID: <20030424093443.GA7180@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ide driver does not list whether drives support things like
write cache, SMART, SECURITY ERASE UNIT.  But for some silly
reason it tells us at boot whether each drive is capable of
supporting the Host Protected Area feature set.  If people want
to know the capabilites of their drive, they can run 'hdparm' 
and find out.

This patch removes this pointless noise.  Please apply,


--- linux/drivers/ide/ide-disk.c.orig	2003-04-24 03:23:53.000000000 -0600
+++ linux/drivers/ide/ide-disk.c	2003-04-24 03:24:54.000000000 -0600
@@ -1133,10 +1133,7 @@
  */
 static inline int idedisk_supports_host_protected_area(ide_drive_t *drive)
 {
-	int flag = (drive->id->cfs_enable_1 & 0x0400) ? 1 : 0;
-	if (flag)
-		printk("%s: host protected area => %d\n", drive->name, flag);
-	return flag;
+	return((drive->id->cfs_enable_1 & 0x0400) ? 1 : 0);
 }
 
 /*

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
