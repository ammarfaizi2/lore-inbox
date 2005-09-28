Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbVI1XHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbVI1XHc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 19:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbVI1XHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 19:07:31 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:5030 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751189AbVI1XHb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 19:07:31 -0400
Date: Thu, 29 Sep 2005 00:07:29 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Knut Petersen <Knut_Petersen@t-online.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] cyblafb: portability fixes, sanitized work with pointers
Message-ID: <20050928230729.GD7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-rc2-git6-i810/drivers/video/cyblafb.c RC14-rc2-git6-cyblafb/drivers/video/cyblafb.c
--- RC14-rc2-git6-i810/drivers/video/cyblafb.c	2005-09-10 15:41:34.000000000 -0400
+++ RC14-rc2-git6-cyblafb/drivers/video/cyblafb.c	2005-09-28 13:02:18.000000000 -0400
@@ -410,20 +410,21 @@
 	out32(GE0C,point(image->dx+image->width-1,image->dy+image->height-1));
 
 	while(index < index_end) {
+		const char *p = image->data + index;
 		for(i=0;i<width_dds;i++) {
-			out32(GE9C,*((u32*) ((u32)image->data + index)));
+			out32(GE9C,*(u32*)p);
+			p+=4;
 			index+=4;
 		}
 		switch(width_dbs) {
 		case 0: break;
-		case 8:	out32(GE9C,*((u8*)((u32)image->data+index)));
+		case 8:	out32(GE9C,*(u8*)p);
 			index+=1;
 			break;
-		case 16: out32(GE9C,*((u16*)((u32)image->data+index)));
+		case 16: out32(GE9C,*(u16*)p);
 			index+=2;
 			break;
-		case 24: out32(GE9C,(u32)(*((u16*)((u32)image->data+index))) |
-			       (u32)(*((u8*)((u32)image->data+index+2)))<<16);
+		case 24: out32(GE9C,*(u16*)p | *(u8*)(p+2)<<16);
 			index+=3;
 			break;
 		}
