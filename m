Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261727AbVCXDSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbVCXDSp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 22:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262996AbVCXDRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 22:17:44 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:60433 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261602AbVCXDOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 22:14:50 -0500
Date: Thu, 24 Mar 2005 04:14:47 +0100
From: Adrian Bunk <bunk@stusta.de>
To: vojtech@suse.cz
Cc: linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
Subject: [2.6 patch] drivers/input/serio/libps2.c: ps2_command: add a missing check
Message-ID: <20050324031447.GY1948@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker noted that while all other uses of param in 
ps2_command() were guarded by a NULL check, this one wasn't.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc1-mm1-full/drivers/input/serio/libps2.c.old	2005-03-24 02:37:08.000000000 +0100
+++ linux-2.6.12-rc1-mm1-full/drivers/input/serio/libps2.c	2005-03-24 02:38:28.000000000 +0100
@@ -106,9 +106,10 @@ int ps2_command(struct ps2dev *ps2dev, u
 			command == PS2_CMD_RESET_BAT ? 1000 : 200))
 			goto out;
 
-	for (i = 0; i < send; i++)
-		if (ps2_sendbyte(ps2dev, param[i], 200))
-			goto out;
+	if (param)
+		for (i = 0; i < send; i++)
+			if (ps2_sendbyte(ps2dev, param[i], 200))
+				goto out;
 
 	/*
 	 * The reset command takes a long time to execute.

