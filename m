Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263366AbSKIAvh>; Fri, 8 Nov 2002 19:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263377AbSKIAvh>; Fri, 8 Nov 2002 19:51:37 -0500
Received: from sproxy.gmx.net ([213.165.64.20]:43675 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S263366AbSKIAvg>;
	Fri, 8 Nov 2002 19:51:36 -0500
Message-ID: <3DCC5DA4.2010707@gmx.net>
Date: Sat, 09 Nov 2002 01:58:12 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2002-Q4@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: de, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] restore framebuffer console after suspend
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------030808070400050804000805"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030808070400050804000805
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes the problem where the current framebuffer console is not 
restored after a system suspend and subsequent resume.

Benjamin Herrenschmidt approved this patch in thread "Re: Linux 2.4.20-rc1"

Please apply for 2.4.20-rc2.

Thanks
Carl-Daniel

--------------030808070400050804000805
Content-Type: text/plain;
 name="patch-fbdev.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-fbdev.txt"

diff -Naur linux.orig/drivers/video/fbcon.c linux/drivers/video/fbcon.c
--- linux.orig/drivers/video/fbcon.c	Thu Sep 12 17:22:35 2002
+++ linux/drivers/video/fbcon.c	Fri Nov  8 13:09:41 2002
@@ -1571,10 +1571,6 @@ static int fbcon_blank(struct vc_data *c
 
     if (blank < 0)	/* Entering graphics mode */
 	return 0;
-#ifdef CONFIG_PM
-    if (fbcon_sleeping)
-    	return 0;
-#endif /* CONFIG_PM */
 
     fbcon_cursor(p->conp, blank ? CM_ERASE : CM_DRAW);
 

--------------030808070400050804000805--

