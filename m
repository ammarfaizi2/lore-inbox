Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264663AbUDWCSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264663AbUDWCSq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 22:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264696AbUDWCSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 22:18:46 -0400
Received: from port-195-158-170-17.dynamic.qsc.de ([195.158.170.17]:3845 "EHLO
	gw.localnet") by vger.kernel.org with ESMTP id S264663AbUDWCSj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 22:18:39 -0400
Message-ID: <40887BE3.9080502@trash.net>
Date: Fri, 23 Apr 2004 04:13:55 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: jim.hague@acm.org
CC: jsimmons@infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH]: Fix NULL-ptr dereference in pm2fb_probe
Content-Type: multipart/mixed;
 boundary="------------000901010605090906010905"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000901010605090906010905
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes a NULL-pointer dereference in pm2fb_probe.
The memset sets info->par to 0, it is dereferenced shortly
afterwards. framebuffer_alloc already initializes the memory
to 0, so it can simply be removed.

Regards
Patrick



--------------000901010605090906010905
Content-Type: text/x-patch;
 name="pm2fb_probe.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pm2fb_probe.diff"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/04/23 04:05:58+02:00 kaber@trash.net 
#   Fix NULL-ptr dereference in pm2fb_probe
# 
# drivers/video/pm2fb.c
#   2004/04/23 03:59:41+02:00 kaber@trash.net +0 -2
#   Fix NULL-ptr dereference in pm2fb_probe
# 
diff -Nru a/drivers/video/pm2fb.c b/drivers/video/pm2fb.c
--- a/drivers/video/pm2fb.c	Fri Apr 23 04:06:53 2004
+++ b/drivers/video/pm2fb.c	Fri Apr 23 04:06:53 2004
@@ -1035,8 +1035,6 @@
 	info = framebuffer_alloc(size, &pdev->dev);
 	if ( !info )
 		return -ENOMEM;
-	memset(info, 0, size);
-    
 	default_par = info->par;
  
 	switch (pdev->device) {

--------------000901010605090906010905--
