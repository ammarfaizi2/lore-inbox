Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262875AbVDAUSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262875AbVDAUSQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 15:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbVDAUSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 15:18:03 -0500
Received: from waste.org ([216.27.176.166]:16786 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262878AbVDAULQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 15:11:16 -0500
Date: Fri, 1 Apr 2005 12:11:11 -0800
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] quiet ide-cd warning
Message-ID: <20050401201111.GH15453@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This shuts up a potential uninitialized variable warning.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: af/drivers/ide/ide-cd.c
===================================================================
--- af.orig/drivers/ide/ide-cd.c	2005-04-01 11:17:37.000000000 -0800
+++ af/drivers/ide/ide-cd.c	2005-04-01 11:55:09.000000000 -0800
@@ -430,7 +430,7 @@ void cdrom_analyze_sense_data(ide_drive_
 #if VERBOSE_IDE_CD_ERRORS
 	{
 		int i;
-		const char *s;
+		const char *s = "bad sense key!";
 		char buf[80];
 
 		printk ("ATAPI device %s:\n", drive->name);
@@ -445,8 +445,6 @@ void cdrom_analyze_sense_data(ide_drive_
 
 		if (sense->sense_key < ARY_LEN(sense_key_texts))
 			s = sense_key_texts[sense->sense_key];
-		else
-			s = "bad sense key!";
 
 		printk("%s -- (Sense key=0x%02x)\n", s, sense->sense_key);
 

-- 
Mathematics is the supreme nostalgia of our time.
