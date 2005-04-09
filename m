Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261376AbVDISOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbVDISOa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 14:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbVDISGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 14:06:42 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:12036 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261366AbVDISEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 14:04:04 -0400
Date: Sat, 9 Apr 2005 20:04:03 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: vojtech@suse.cz, linux-joystick@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/input/joystick/spaceorb.c: fix an array overflow
Message-ID: <20050409180403.GG3632@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes an array overflow found by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 27 Mar 2005

--- linux-2.6.12-rc1-mm1-full/drivers/input/joystick/spaceorb.c.old	2005-03-23 02:12:33.000000000 +0100
+++ linux-2.6.12-rc1-mm1-full/drivers/input/joystick/spaceorb.c	2005-03-23 02:16:18.000000000 +0100
@@ -116,7 +116,7 @@ static void spaceorb_process_packet(stru
 
 		case 'K':				/* Button data */
 			if (spaceorb->idx != 5) return;
-			for (i = 0; i < 7; i++)
+			for (i = 0; i < 6; i++)
 				input_report_key(dev, spaceorb_buttons[i], (data[2] >> i) & 1);
 
 			break;

