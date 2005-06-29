Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262285AbVF2JvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbVF2JvK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 05:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbVF2JvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 05:51:10 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:22240 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S262285AbVF2JvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 05:51:07 -0400
Date: Wed, 29 Jun 2005 11:50:51 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: [RFC] menu -> menuconfig changes
Message-ID: <Pine.LNX.4.58.0506291131320.3554@be1.lrz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are many submenus in the config system where the fist option 
controls the availability of the remaining options. This is very 
inconvenient in menuconfig, since you'll have to enter each menu
to see whether or not the corresponding subsystem is enabled.

I suggest moving the first option out of the subsystem by changing
'menu' to 'menuconfig', as demonstrated by the patch below.

--- ../linux-2.6.12/drivers/cdrom/Kconfig	2005-06-19 14:16:31.000000000 +0200
+++ ./drivers/cdrom/Kconfig	2005-06-29 11:27:02.000000000 +0200
@@ -2,11 +2,9 @@
 # CDROM driver configuration
 #
 
-menu "Old CD-ROM drivers (not SCSI, not IDE)"
+menuconfig CD_NO_IDESCSI
+	bool "Old CD-ROM drivers (not SCSI, IDE or ATAPI)"
 	depends on ISA
-
-config CD_NO_IDESCSI
-	bool "Support non-SCSI/IDE/ATAPI CDROM drives"
 	---help---
 	  If you have a CD-ROM drive that is neither SCSI nor IDE/ATAPI, say Y
 	  here, otherwise N. Read the CD-ROM-HOWTO, available from
@@ -209,5 +207,3 @@ config CDU535
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called sonycd535.
-
-endmenu
-- 
Top 100 things you don't want the sysadmin to say:
83. Damn, and I just bought that pop...
