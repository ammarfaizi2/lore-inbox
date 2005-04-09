Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261367AbVDISKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbVDISKK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 14:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbVDISHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 14:07:11 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:13060 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261367AbVDISEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 14:04:06 -0400
Date: Sat, 9 Apr 2005 20:04:05 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] sound/oss/sonicvibes.c: fix an array overflow
Message-ID: <20050409180405.GH3632@stusta.de>
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

