Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965087AbVHJMrl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965087AbVHJMrl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 08:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965089AbVHJMrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 08:47:41 -0400
Received: from kenga.kmv.ru ([217.13.212.5]:64421 "EHLO kenga.kmv.ru")
	by vger.kernel.org with ESMTP id S965087AbVHJMrk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 08:47:40 -0400
Date: Wed, 10 Aug 2005 16:46:54 +0400
From: "Andrey J. Melnikoff (TEMHOTA)" <temnota@kmv.ru>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Cc: Olya Briginets <bolya@ukrpost.net>
Subject: [PATCH] 2.4.31: fix isofs mount options parser
Message-ID: <20050810124654.GV9857@kmv.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="o0ZfoUVt4BxPQnbU"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
X-Data-Status: msg.XXucjWvk:30345@kenga.kmv.ru
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--o0ZfoUVt4BxPQnbU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hello Marcelo, LKML.

Attached patch fix this whatings from gcc-3.4 and allow user mount
isofs with "session" and "sbsector" options. Without this patch, gcc-3.4
optimizer always return zero.

--- cut ---
inode.c: In function `parse_options':
inode.c:341: warning: comparison of unsigned expression < 0 is always false
inode.c:347: warning: comparison of unsigned expression < 0 is always false
--- cut ---

Signed-of-by: Andrey Melnikoff <temnota@kmv.ru>

--- linux-2.4.31/fs/isofs/inode.c~old	2005-08-10 16:18:48.000000000 +0400
+++ linux-2.4.31/fs/isofs/inode.c	2005-08-10 16:19:11.000000000 +0400
@@ -337,13 +337,13 @@
 		}
 		if (!strcmp(this_char,"session") && value) {
 			char * vpnt = value;
-			unsigned int ivalue = simple_strtoul(vpnt, &vpnt, 0);
+			int ivalue = simple_strtoul(vpnt, &vpnt, 0);
 			if(ivalue < 0 || ivalue >99) return 0;
 			popt->session=ivalue+1;
 		}
 		if (!strcmp(this_char,"sbsector") && value) {
 			char * vpnt = value;
-			unsigned int ivalue = simple_strtoul(vpnt, &vpnt, 0);
+			int ivalue = simple_strtoul(vpnt, &vpnt, 0);
 			if(ivalue < 0 || ivalue >660*512) return 0;
 			popt->sbsector=ivalue;
 		}

-- 
 Best regards, TEMHOTA-RIPN aka MJA13-RIPE
 System Administrator. mailto:temnota@kmv.ru


--o0ZfoUVt4BxPQnbU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="isofs-fix.diff"

--- linux-2.4.31/fs/isofs/inode.c~old	2005-08-10 16:18:48.000000000 +0400
+++ linux-2.4.31/fs/isofs/inode.c	2005-08-10 16:19:11.000000000 +0400
@@ -337,13 +337,13 @@
 		}
 		if (!strcmp(this_char,"session") && value) {
 			char * vpnt = value;
-			unsigned int ivalue = simple_strtoul(vpnt, &vpnt, 0);
+			int ivalue = simple_strtoul(vpnt, &vpnt, 0);
 			if(ivalue < 0 || ivalue >99) return 0;
 			popt->session=ivalue+1;
 		}
 		if (!strcmp(this_char,"sbsector") && value) {
 			char * vpnt = value;
-			unsigned int ivalue = simple_strtoul(vpnt, &vpnt, 0);
+			int ivalue = simple_strtoul(vpnt, &vpnt, 0);
 			if(ivalue < 0 || ivalue >660*512) return 0;
 			popt->sbsector=ivalue;
 		}

--o0ZfoUVt4BxPQnbU--
