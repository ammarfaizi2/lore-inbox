Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261540AbVDWLLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbVDWLLp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 07:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbVDWLLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 07:11:45 -0400
Received: from mail.dif.dk ([193.138.115.101]:61924 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261540AbVDWLLn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 07:11:43 -0400
Date: Sat, 23 Apr 2005 13:14:54 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] keyboard: checking the same thing twice is pretty pointless
Message-ID: <Pine.LNX.4.62.0504231244150.2474@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

in drivers/char/keyboard.c::setkeycode two 'if' statements test exately 
the same thing - one of them should go away, I removed the second one. 
Since 'keycode' is an unsigned int it can never be <0 and the >KEY_MAX 
check has just been performed by the 'if' above.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 drivers/char/keyboard.c |    2 --
 1 files changed, 2 deletions(-)

--- linux-2.6.12-rc2-mm3-orig/drivers/char/keyboard.c	2005-04-11 21:20:40.000000000 +0200
+++ linux-2.6.12-rc2-mm3/drivers/char/keyboard.c	2005-04-23 12:43:28.000000000 +0200
@@ -200,8 +200,6 @@ int setkeycode(unsigned int scancode, un
 		return -EINVAL;
 	if (keycode > KEY_MAX)
 		return -EINVAL;
-	if (keycode < 0 || keycode > KEY_MAX)
-		return -EINVAL;
 
 	oldkey = SET_INPUT_KEYCODE(dev, scancode, keycode);
 


