Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262154AbVBJPpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262154AbVBJPpW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 10:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbVBJPpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 10:45:22 -0500
Received: from sd291.sivit.org ([194.146.225.122]:8166 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262148AbVBJPos (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 10:44:48 -0500
Date: Thu, 10 Feb 2005 16:46:25 +0100
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 3/5] sonypi: use MISC_DYNAMIC_MINOR in miscdevice.minor assignment.
Message-ID: <20050210154624.GH3493@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===================================================================

Use MISC_DYNAMIC_MINOR in miscdevice.minor assignment.

Patch-from: Olaf Hering <olh@suse.de>
Signed-off-by: Stelian Pop <stelian@popies.net>

===================================================================

 sonypi.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

===================================================================

Index: drivers/char/sonypi.c
===================================================================
--- a/drivers/char/sonypi.c	(revision 26556)
+++ b/drivers/char/sonypi.c	(revision 26557)
@@ -646,7 +646,7 @@ static struct file_operations sonypi_mis
 };
 
 struct miscdevice sonypi_misc_device = {
-	.minor		= -1,
+	.minor		= MISC_DYNAMIC_MINOR,
 	.name		= "sonypi",
 	.fops		= &sonypi_misc_fops,
 };
@@ -755,7 +755,8 @@ static int __devinit sonypi_probe(void)
 		goto out_pcienable;
 	}
 
-	sonypi_misc_device.minor = (minor == -1) ? MISC_DYNAMIC_MINOR : minor;
+	if (minor != -1)
+		sonypi_misc_device.minor = minor;
 	if ((ret = misc_register(&sonypi_misc_device))) {
 		printk(KERN_ERR "sonypi: misc_register failed\n");
 		goto out_miscreg;
-- 
Stelian Pop <stelian@popies.net>
