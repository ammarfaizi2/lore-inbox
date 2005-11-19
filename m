Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbVKSUdS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbVKSUdS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 15:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbVKSUcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 15:32:52 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:42245 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750807AbVKSUct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 15:32:49 -0500
Date: Sat, 19 Nov 2005 08:58:12 +0100
From: Adrian Bunk <bunk@stusta.de>
To: mac@melware.de
Cc: isdn4linux@listserv.isdn4linux.de, kkeil@suse.de, kai.germaschewski@gmx.de,
       stable@kernel.org
Subject: [2.6 patch] drivers/isdn/hardware/eicon/os_4bri.c: correct the xdiLoadFile() signature
Message-ID: <20051119075812.GC16060@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's not good if caller and callee disagree regarding the type of the 
arguments.

In this case, this could cause problems on 64bit architectures.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.15-rc1-mm2-full/drivers/isdn/hardware/eicon/os_4bri.c.old	2005-11-19 03:48:37.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/drivers/isdn/hardware/eicon/os_4bri.c	2005-11-19 06:18:16.000000000 +0100
@@ -16,6 +16,7 @@
 #include "diva_pci.h"
 #include "mi_pc.h"
 #include "dsrv4bri.h"
+#include "helpers.h"
 
 static void *diva_xdiLoadFileFile = NULL;
 static dword diva_xdiLoadFileLength = 0;
@@ -815,7 +816,7 @@
 	return (ret);
 }
 
-void *xdiLoadFile(char *FileName, unsigned long *FileLength,
+void *xdiLoadFile(char *FileName, dword *FileLength,
 		  unsigned long lim)
 {
 	void *ret = diva_xdiLoadFileFile;

