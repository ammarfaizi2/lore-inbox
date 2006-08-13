Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751434AbWHMVJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbWHMVJL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 17:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbWHMVJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 17:09:11 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:32119 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751434AbWHMVJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 17:09:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=URVwNUtEgCGWKJQluysQpyvMWKVB0c4I8MGULz7ifPG8FEtTSxUcP8z+bIj62ZqzDo6N8whUhharEdc6m0whNraXlB8JfzM9rGAX516adjZDojY7ic721ICZ+xrqSK1y8aUuZd+gEYg+7tMnBgLgsigTVphXU7oi+EHiccOZCW0=
Message-ID: <44DF953B.6010707@gmail.com>
Date: Sun, 13 Aug 2006 17:10:19 -0400
From: Florin Malita <fmalita@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: dmitry.torokhov@gmail.com
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] atkbd.c: overrun in atkbd_set_repeat_rate()
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This was introduced in commit 3d0f0fa0cb554541e10cb8cb84104e4b10828468:
bounds checking is performed against period[32] while indexing delay[4].

Spotted by Coverity, CID 1376.

Signed-off-by: Florin Malita <fmalita@gmail.com>
---

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 6bfa0cf..a86afd0 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -498,7 +498,7 @@ static int atkbd_set_repeat_rate(struct 
 		i++;
 	dev->rep[REP_PERIOD] = period[i];
 
-	while (j < ARRAY_SIZE(period) - 1 && delay[j] < dev->rep[REP_DELAY])
+	while (j < ARRAY_SIZE(delay) - 1 && delay[j] < dev->rep[REP_DELAY])
 		j++;
 	dev->rep[REP_DELAY] = delay[j];
 


