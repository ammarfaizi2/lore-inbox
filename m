Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261540AbVC0UhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbVC0UhY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 15:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbVC0UhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 15:37:24 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:19984 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261533AbVC0UhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 15:37:10 -0500
Date: Sun, 27 Mar 2005 22:37:06 +0200
From: Adrian Bunk <bunk@stusta.de>
To: vojtech@suse.cz
Cc: linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/input/joystick/spaceorb.c: fix an array overflow
Message-ID: <20050327203706.GV4285@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes an array overflow found by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc1-mm1-full/drivers/input/joystick/spaceorb.c.old	2005-03-23 02:12:33.000000000 +0100
+++ linux-2.6.12-rc1-mm1-full/drivers/input/joystick/spaceorb.c	2005-03-23 02:16:18.000000000 +0100
@@ -116,7 +116,7 @@ static void spaceorb_process_packet(stru
 
 		case 'K':				/* Button data */
 			if (spaceorb->idx != 5) return;
-			for (i = 0; i < 7; i++)
+			for (i = 0; i < 6; i++)
 				input_report_key(dev, spaceorb_buttons[i], (data[2] >> i) & 1);
 
 			break;

