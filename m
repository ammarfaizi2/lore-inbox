Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263017AbVCXDVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263017AbVCXDVd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 22:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262996AbVCXDS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 22:18:59 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:61457 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261602AbVCXDSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 22:18:01 -0500
Date: Thu, 24 Mar 2005 04:17:56 +0100
From: Adrian Bunk <bunk@stusta.de>
To: vojtech@suse.cz
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/input/keyboard/atkbd.c: fix off by one errors
Message-ID: <20050324031756.GZ1948@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes two possible off by one errors found by the Coverity 
checker (look at the period[i] and delay[j] in the two first unchanged 
lines).

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc1-mm1-full/drivers/input/keyboard/atkbd.c.old	2005-03-24 02:46:57.000000000 +0100
+++ linux-2.6.12-rc1-mm1-full/drivers/input/keyboard/atkbd.c	2005-03-24 02:47:24.000000000 +0100
@@ -468,8 +468,8 @@ static int atkbd_event(struct input_dev 
 			if (atkbd->softrepeat) return 0;
 
 			i = j = 0;
-			while (i < 32 && period[i] < dev->rep[REP_PERIOD]) i++;
-			while (j < 4 && delay[j] < dev->rep[REP_DELAY]) j++;
+			while (i < 31 && period[i] < dev->rep[REP_PERIOD]) i++;
+			while (j < 3 && delay[j] < dev->rep[REP_DELAY]) j++;
 			dev->rep[REP_PERIOD] = period[i];
 			dev->rep[REP_DELAY] = delay[j];
 			param[0] = i | (j << 5);

