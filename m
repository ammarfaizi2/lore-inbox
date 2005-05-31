Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261964AbVEaQqW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261964AbVEaQqW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 12:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbVEaQdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 12:33:39 -0400
Received: from 81-223-63-139.dynamic.adsl-line.inode.at ([81.223.63.139]:22002
	"EHLO mercury.foo") by vger.kernel.org with ESMTP id S261988AbVEaQbf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 12:31:35 -0400
Date: Tue, 31 May 2005 18:31:51 +0200 (CEST)
From: Dominik Hackl <dominik@hackl.dhs.org>
X-X-Sender: dominik@mercury.foo
To: bfennema@falcon.csc.calpoly.edu
cc: linux_udf@hpesjro.fc.hp.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 2.6.12-rc5] UML + UDF duplicated symbol
Message-ID: <Pine.LNX.4.61.0505311804570.10685@mercury.foo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Linux with UDF compiled in, can't be linked against the libc (needed for 
UML).

This patch makes the variable __mon_yday static and avoids a namespace 
conflict with the libc.


	Signed-off-by: Dominik Hackl <dominik@hackl.dhs.org>



--- linux-2.6.12-rc5.orig/fs/udf/udftime.c	2005-05-25 20:37:16.000000000 +0200
+++ linux-2.6.12-rc5/fs/udf/udftime.c	2005-05-31 16:51:11.000000000 +0200
@@ -46,7 +46,7 @@
 #endif
 
 /* How many days come before each month (0-12).  */
-const unsigned short int __mon_yday[2][13] =
+const static unsigned short int __mon_yday[2][13] =
 {
 	/* Normal years.  */
 	{ 0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, 365 },
