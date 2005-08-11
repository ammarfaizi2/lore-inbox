Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030252AbVHKLFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030252AbVHKLFH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 07:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030272AbVHKLFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 07:05:06 -0400
Received: from kenga.kmv.ru ([217.13.212.5]:42424 "EHLO kenga.kmv.ru")
	by vger.kernel.org with ESMTP id S1030271AbVHKLFB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 07:05:01 -0400
Date: Thu, 11 Aug 2005 15:01:22 +0400
From: "Andrey J. Melnikoff (TEMHOTA)" <temnota@kmv.ru>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Cc: Olya Briginets <bolya@ukrpost.net>
Subject: [PATCH] 2.4.31: fix isofs mount options parser
Message-ID: <20050811110122.GX9857@kmv.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="rMWmSaSbD7nr+du9"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
X-Data-Status: msg.XX4OQGep:32049@kenga.kmv.ru
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rMWmSaSbD7nr+du9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Marcelo, LKML.

Previos patch incomplete and fix only gcc warnings. New patch attached.

Description:
This patch pix gcc-3.4 warnings, andfix broken logic in mount options
parser.

--- cut ---
inode.c: In function `parse_options':
inode.c:341: warning: comparison of unsigned expression < 0 is always false
inode.c:347: warning: comparison of unsigned expression < 0 is always false
--- cut ---

Signed-of-by: Andrey Melnikoff <temnota@kmv.ru>

--- linux-2.4.31/fs/isofs/inode.c~old	2005-08-10 16:18:48.000000000 +0400
+++ linux-2.4.31/fs/isofs/inode.c	2005-08-11 13:55:25.000000000 +0400
@@ -335,15 +335,15 @@
 			else if (!strcmp(value,"acorn")) popt->map = 'a';
 			else return 0;
 		}
-		if (!strcmp(this_char,"session") && value) {
+		else if (!strcmp(this_char,"session") && value) {
 			char * vpnt = value;
-			unsigned int ivalue = simple_strtoul(vpnt, &vpnt, 0);
+			int ivalue = simple_strtoul(vpnt, &vpnt, 0);
 			if(ivalue < 0 || ivalue >99) return 0;
 			popt->session=ivalue+1;
 		}
-		if (!strcmp(this_char,"sbsector") && value) {
+		else if (!strcmp(this_char,"sbsector") && value) {
 			char * vpnt = value;
-			unsigned int ivalue = simple_strtoul(vpnt, &vpnt, 0);
+			int ivalue = simple_strtoul(vpnt, &vpnt, 0);
 			if(ivalue < 0 || ivalue >660*512) return 0;
 			popt->sbsector=ivalue;
 		}

-- 
 Best regards, TEMHOTA-RIPN aka MJA13-RIPE
 System Administrator. mailto:temnota@kmv.ru


--rMWmSaSbD7nr+du9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="isofs-fix.diff"

--- linux-2.4.31/fs/isofs/inode.c~old	2005-08-10 16:18:48.000000000 +0400
+++ linux-2.4.31/fs/isofs/inode.c	2005-08-11 13:55:25.000000000 +0400
@@ -335,15 +335,15 @@
 			else if (!strcmp(value,"acorn")) popt->map = 'a';
 			else return 0;
 		}
-		if (!strcmp(this_char,"session") && value) {
+		else if (!strcmp(this_char,"session") && value) {
 			char * vpnt = value;
-			unsigned int ivalue = simple_strtoul(vpnt, &vpnt, 0);
+			int ivalue = simple_strtoul(vpnt, &vpnt, 0);
 			if(ivalue < 0 || ivalue >99) return 0;
 			popt->session=ivalue+1;
 		}
-		if (!strcmp(this_char,"sbsector") && value) {
+		else if (!strcmp(this_char,"sbsector") && value) {
 			char * vpnt = value;
-			unsigned int ivalue = simple_strtoul(vpnt, &vpnt, 0);
+			int ivalue = simple_strtoul(vpnt, &vpnt, 0);
 			if(ivalue < 0 || ivalue >660*512) return 0;
 			popt->sbsector=ivalue;
 		}

--rMWmSaSbD7nr+du9--
