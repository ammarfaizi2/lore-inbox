Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750829AbWDIRtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbWDIRtQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 13:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbWDIRtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 13:49:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:36235 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750829AbWDIRtP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 13:49:15 -0400
X-Authenticated: #704063
Subject: [Patch] Overrun in drivers/char/mwave/mwavedd.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sun, 09 Apr 2006 19:49:13 +0200
Message-Id: <1144604953.22880.1.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

this fixes coverity id #489.
Since the last element in the array is always ARRAY_SIZE-1
we have to check for ipcnum >= ARRAY_SIZE()

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.17-rc1/drivers/char/mwave/mwavedd.c.orig	2006-04-09 19:45:54.000000000 +0200
+++ linux-2.6.17-rc1/drivers/char/mwave/mwavedd.c	2006-04-09 19:46:07.000000000 +0200
@@ -271,7 +271,7 @@ static int mwave_ioctl(struct inode *ino
 				ipcnum,
 				pDrvData->IPCs[ipcnum].usIntCount);
 	
-			if (ipcnum > ARRAY_SIZE(pDrvData->IPCs)) {
+			if (ipcnum >= ARRAY_SIZE(pDrvData->IPCs)) {
 				PRINTK_ERROR(KERN_ERR_MWAVE
 						"mwavedd::mwave_ioctl:"
 						" IOCTL_MW_REGISTER_IPC:"


