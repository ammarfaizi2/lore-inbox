Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267622AbSLNOzH>; Sat, 14 Dec 2002 09:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267623AbSLNOzG>; Sat, 14 Dec 2002 09:55:06 -0500
Received: from itg-gw.cr008.cwt.esat.net ([193.120.242.226]:21252 "EHLO
	dunlop.admin.ie.alphyra.com") by vger.kernel.org with ESMTP
	id <S267622AbSLNOzG>; Sat, 14 Dec 2002 09:55:06 -0500
Date: Sat, 14 Dec 2002 15:02:53 +0000 (GMT)
From: Paul Jakma <paulj@alphyra.ie>
X-X-Sender: paulj@dunlop.admin.ie.alphyra.com
To: linux-kernel@vger.kernel.org
Subject: [patch] Docs: fix explanation of file-nr
Message-ID: <Pine.LNX.4.44.0212141459120.9648-100000@dunlop.admin.ie.alphyra.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Documentation/sysctl/fs.txt is incorrect wrt to the middle number of 
/proc/sys/fs/file-nr. The current docs state it is the number of 
in-use file-handles, from observation this number is actually the 
number of /unused/ file-handles - we've observe that when it hits 0 we 
get file handle problems (rather than when it hits == file-max as docs 
imply). Patch:

--- Documentation/sysctl/fs.txt~	Sat Dec 14 14:58:03 2002
+++ Documentation/sysctl/fs.txt	Sat Dec 14 14:58:03 2002
@@ -82,11 +82,11 @@
 want to increase this limit.
 
 The three values in file-nr denote the number of allocated
-file handles, the number of used file handles and the maximum
+file handles, the number of unused file handles and the maximum
 number of file handles. When the allocated file handles come
-close to the maximum, but the number of actually used ones is
-far behind, you've encountered a peak in your usage of file
-handles and you don't need to increase the maximum.
+close to the maximum, but the number of unused file handles is
+significantly greater than 0, you've encountered a peak in your 
+usage of file handles and you don't need to increase the maximum.
 
 ==============================================================
 

regards,
-- 
Paul Jakma	Sys Admin	Alphyra
	paulj@alphyra.ie
Warning: /never/ send email to spam@dishone.st or trap@dishone.st

