Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264513AbTK0Mvf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 07:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264515AbTK0Mvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 07:51:35 -0500
Received: from smithers.nildram.co.uk ([195.112.4.54]:51721 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S264513AbTK0Mvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 07:51:33 -0500
Date: Thu, 27 Nov 2003 12:49:12 +0000
From: Joe Thornber <thornber@sistina.com>
To: Joe Thornber <thornber@sistina.com>
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: [Patch 1/2] dm: disable v1 interface
Message-ID: <20031127124912.GB470@reti>
References: <20031127124626.GA470@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031127124626.GA470@reti>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Disable v1 of the ioctl interface.
--- diff/drivers/md/Kconfig	2003-11-25 15:47:48.000000000 +0000
+++ source/drivers/md/Kconfig	2003-11-27 12:18:40.000000000 +0000
@@ -135,13 +135,5 @@
 
 	  If unsure, say N.
 
-config DM_IOCTL_V4
-	bool "ioctl interface version 4"
-	depends on BLK_DEV_DM
-	default y
-	---help---
-	  Recent tools use a new version of the ioctl interface, only
-          select this option if you intend using such tools.
-
 endmenu
 
--- diff/drivers/md/dm-ioctl.c	2003-08-20 14:16:09.000000000 +0100
+++ source/drivers/md/dm-ioctl.c	2003-11-27 12:24:10.000000000 +0000
@@ -6,8 +6,4 @@
 
 #include <linux/dm-ioctl.h>
 
-#ifdef CONFIG_DM_IOCTL_V4
 #include "dm-ioctl-v4.c"
-#else
-#include "dm-ioctl-v1.c"
-#endif
--- diff/include/linux/dm-ioctl.h	2003-08-20 14:16:14.000000000 +0100
+++ source/include/linux/dm-ioctl.h	2003-11-27 12:19:20.000000000 +0000
@@ -7,12 +7,6 @@
 #ifndef _LINUX_DM_IOCTL_H
 #define _LINUX_DM_IOCTL_H
 
-#include <linux/config.h>
-
-#ifdef CONFIG_DM_IOCTL_V4
 #include "dm-ioctl-v4.h"
-#else
-#include "dm-ioctl-v1.h"
-#endif
 
 #endif
