Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267631AbUG3HGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267631AbUG3HGw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 03:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267644AbUG3HF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 03:05:56 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:2470 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S267631AbUG3HFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 03:05:41 -0400
Message-ID: <4109F38E.8010507@bull.net>
Date: Fri, 30 Jul 2004 09:06:54 +0200
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: ajoshi@shell.unixbox.com
CC: linux-kernel@vger.kernel.org
Subject: [Patch] fbdev.c: fix a warning "unused variable"
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 30/07/2004 09:10:01,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 30/07/2004 09:10:04,
	Serialize complete at 30/07/2004 09:10:04
Content-Type: multipart/mixed;
 boundary="------------010901050102050605040508"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010901050102050605040508
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

 When compiling file driver/video/riva/fbdev.c in Linux kernel 
2.6.8-rc2-mm1, there are warnings:

CC [M]  drivers/video/riva/fbdev.o
/home/guill/projects/elsa/linux-2.6.8-rc2-mm1/drivers/video/riva/fbdev.c: 
In function `riva_get_EDID':
/home/guill/projects/elsa/linux-2.6.8-rc2-mm1/drivers/video/riva/fbdev.c:1867: 
warning: unused variable `par'
/home/guill/projects/elsa/linux-2.6.8-rc2-mm1/drivers/video/riva/fbdev.c:1868: 
warning: unused variable `i'

Here is a trivial patch to remove those warning.

Hope this help

Guillaume


--------------010901050102050605040508
Content-Type: text/plain;
 name="patch-fbdev"
Content-Disposition: inline;
 filename="patch-fbdev"
Content-Transfer-Encoding: 7bit

--- fbdev.c.orig	2004-07-30 08:43:09.017841384 +0200
+++ fbdev.c	2004-07-30 08:44:00.615997272 +0200
@@ -1864,8 +1864,10 @@ static void riva_update_default_var(stru
 
 static void riva_get_EDID(struct fb_info *info, struct pci_dev *pdev)
 {
+#ifdef CONFIG_FB_RIVA_I2C
 	struct riva_par *par;
 	int i;
+#endif
 
 	NVTRACE_ENTER();
 #ifdef CONFIG_PPC_OF

--------------010901050102050605040508--
