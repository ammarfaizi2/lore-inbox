Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbWDWVWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWDWVWv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 17:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbWDWVWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 17:22:51 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3089 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751459AbWDWVWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 17:22:50 -0400
Date: Sun, 23 Apr 2006 23:22:48 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Eric Sesterhenn <snakebyte@gmx.de>, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fix array overrun in drivers/char/mwave/mwavedd.c
Message-ID: <20060423212248.GF13666@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Sesterhenn <snakebyte@gmx.de>

this fixes coverity id #489.
Since the last element in the array is always ARRAY_SIZE-1
we have to check for ipcnum >= ARRAY_SIZE()

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was sent by Eric Sesterhenn on:
- 9 Apr 2006

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


