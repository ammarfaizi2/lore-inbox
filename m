Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262375AbVEMOCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262375AbVEMOCt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 10:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbVEMOBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 10:01:41 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:8453 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262375AbVEMOAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 10:00:46 -0400
Date: Fri, 13 May 2005 16:00:43 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: vojtech@suse.cz, linux-input@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/input/keyboard/atkbd.c: fix off by one errors
Message-ID: <20050513140043.GC16549@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes two possible off by one errors found by the Coverity 
checker (look at the period[i] and delay[j] in the two first unchanged 
lines).

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 24 Mar 2005

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

