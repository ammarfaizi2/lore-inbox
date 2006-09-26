Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbWIZMft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbWIZMft (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 08:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbWIZMft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 08:35:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:2741 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751305AbWIZMfs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 08:35:48 -0400
X-Authenticated: #704063
Subject: [Patch] Off-by-one in drivers/char/mwave/mwavedd.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 26 Sep 2006 14:35:46 +0200
Message-Id: <1159274146.7062.1.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

this fixes two off by ones in the mwave driver, found
via find -iname \*.[ch] | xargs grep "> ARRAY_SIZE("

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.18-git5/drivers/char/mwave/mwavedd.c.orig	2006-09-26 14:32:54.000000000 +0200
+++ linux-2.6.18-git5/drivers/char/mwave/mwavedd.c	2006-09-26 14:34:20.000000000 +0200
@@ -297,7 +297,7 @@ static int mwave_ioctl(struct inode *ino
 				" ipcnum %x, usIntCount %x\n",
 				ipcnum,
 				pDrvData->IPCs[ipcnum].usIntCount);
-			if (ipcnum > ARRAY_SIZE(pDrvData->IPCs)) {
+			if (ipcnum >= ARRAY_SIZE(pDrvData->IPCs)) {
 				PRINTK_ERROR(KERN_ERR_MWAVE
 						"mwavedd::mwave_ioctl:"
 						" IOCTL_MW_GET_IPC: Error:"
@@ -355,7 +355,7 @@ static int mwave_ioctl(struct inode *ino
 				"mwavedd::mwave_ioctl IOCTL_MW_UNREGISTER_IPC"
 				" ipcnum %x\n",
 				ipcnum);
-			if (ipcnum > ARRAY_SIZE(pDrvData->IPCs)) {
+			if (ipcnum >= ARRAY_SIZE(pDrvData->IPCs)) {
 				PRINTK_ERROR(KERN_ERR_MWAVE
 						"mwavedd::mwave_ioctl:"
 						" IOCTL_MW_UNREGISTER_IPC:"


