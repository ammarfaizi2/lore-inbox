Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264925AbTL2To4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 14:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265117AbTL2Tn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 14:43:59 -0500
Received: from fep01-mail.bloor.is.net.cable.rogers.com ([66.185.86.71]:13996
	"EHLO fep01-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S264925AbTL2TmX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 14:42:23 -0500
Date: Mon, 29 Dec 2003 14:42:23 -0500
From: Omkhar Arasaratnam <omkhar@rogers.com>
To: axeboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/cdrom/isp16.c check_region() fix
Message-ID: <20031229194222.GA26019@omkhar.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at fep01-mail.bloor.is.net.cable.rogers.com from [24.192.237.88] using ID <omkhar@rogers.com> at Mon, 29 Dec 2003 14:40:25 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

check_region is depreciated in 2.6, this replaces it with request_region

As this is my first patch to the kernel, please let me know if I did anything wrong


--- /usr/src/linux/drivers/cdrom/isp16.c	2001-09-07 12:28:38.000000000 -0400
+++ drivers/cdrom/isp16.c	2003-12-29 14:07:24.000000000 -0500
@@ -121,11 +121,12 @@
 		return (0);
 	}
 
-	if (check_region(ISP16_IO_BASE, ISP16_IO_SIZE)) {
+	if (!request_region(ISP16_IO_BASE, ISP16_IO_SIZE,"isp16")) {
 		printk("ISP16: i/o ports already in use.\n");
 		return (-EIO);
 	}
-
+	release_region(ISP16_IO_BASE, ISP16_IO_SIZE);
+	
 	if ((isp16_type = isp16_detect()) < 0) {
 		printk("ISP16: no cdrom interface found.\n");
 		return (-EIO);

