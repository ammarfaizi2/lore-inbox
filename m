Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261541AbVC0Uiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261541AbVC0Uiz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 15:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbVC0Uiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 15:38:54 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:21776 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261539AbVC0Uih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 15:38:37 -0500
Date: Sun, 27 Mar 2005 22:38:32 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] sound/oss/sonicvibes.c: fix an array overflow
Message-ID: <20050327203832.GW4285@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes an array overflow found by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc1-mm1-full/sound/oss/sonicvibes.c.old	2005-03-23 01:53:13.000000000 +0100
+++ linux-2.6.12-rc1-mm1-full/sound/oss/sonicvibes.c	2005-03-23 01:55:11.000000000 +0100
@@ -1146,13 +1146,13 @@ static int mixer_ioctl(struct sv_state *
 		for (i = 0; i < SOUND_MIXER_NRDEVICES; i++) {
 			if (!(val & (1 << i)))
 				continue;
 			if (mixtable[i].rec)
 				break;
 		}
-		if (!mixtable[i].rec)
+		if (i == SOUND_MIXER_NRDEVICES)
 			return 0;
 		spin_lock_irqsave(&s->lock, flags);
 		frobindir(s, SV_CIMIX_ADCINL, 0x1f, mixtable[i].rec << 5);
 		frobindir(s, SV_CIMIX_ADCINR, 0x1f, mixtable[i].rec << 5);
 		spin_unlock_irqrestore(&s->lock, flags);
 		return 0;

