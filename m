Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261558AbVCORWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbVCORWx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 12:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261547AbVCORVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 12:21:22 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:13018 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261604AbVCORUL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 12:20:11 -0500
Message-ID: <42371945.1030606@austin.ibm.com>
Date: Tue, 15 Mar 2005 11:20:05 -0600
From: Joel Schopp <jschopp@austin.ibm.com>
Reply-To: jschopp@austin.ibm.com
User-Agent: Mozilla/5.0 (X11; U; Linux ppc64; en-US; rv:1.4) Gecko/20030922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] matroxfb compile error
Content-Type: multipart/mixed;
 boundary="------------070003070401000100050605"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070003070401000100050605
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

When compiling 2.6.11-bk10 I get a compile error.  The attached patch 
fixes it for me.  Please apply if you haven't gotten another patch for 
this already.

--------------070003070401000100050605
Content-Type: text/plain;
 name="matrox.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="matrox.patch"


This patch fixes this compile error by causing the object that
contains the referenced function to be built:

drivers/built-in.o(.text+0x26db8): In function `.initMatrox2':
: undefined reference to `.mac_vmode_to_var' 

Signed-off-by: Joel Schopp <jschopp@austin.ibm.com>
---


diff -puN drivers/video/Makefile~matrox drivers/video/Makefile
--- 2.6.11-bk10/drivers/video/Makefile~matrox	2005-03-15 11:08:44.000000000 -0600
+++ 2.6.11-bk10-jschopp/drivers/video/Makefile	2005-03-15 11:12:08.000000000 -0600
@@ -26,7 +26,7 @@ obj-$(CONFIG_FB_CYBER2000)        += cyb
 obj-$(CONFIG_FB_PM2)              += pm2fb.o
 obj-$(CONFIG_FB_PM3)		  += pm3fb.o
 
-obj-$(CONFIG_FB_MATROX)		  += matrox/
+obj-$(CONFIG_FB_MATROX)		  += matrox/ macmodes.o
 obj-$(CONFIG_FB_RIVA)		  += riva/ vgastate.o
 obj-$(CONFIG_FB_NVIDIA)		  += nvidia/
 obj-$(CONFIG_FB_ATY)		  += aty/
_

--------------070003070401000100050605--

