Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273937AbRI0V46>; Thu, 27 Sep 2001 17:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273940AbRI0V4t>; Thu, 27 Sep 2001 17:56:49 -0400
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:47368 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S273937AbRI0V4e>; Thu, 27 Sep 2001 17:56:34 -0400
Date: Thu, 27 Sep 2001 23:56:55 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Linus Torvalds <linus@transmeta.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] Fix 'get mouse type' command emulation in mousedev.c
Message-ID: <20010927235655.A18423@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

New GPM (1.19.4+) uses a more sophisticated method of detecting PS/2
mice. This uncovers a minor bug in mousedev. Mousedev reports always
mouse type 4 (ExplorerPS/2) regardless of the mode it is in due to
missing break;'s in a switch statement. This patch fixes it. Patch against
2.4.10 or similar.

--- linux-2.4.10/drivers/input/mousedev.c	Thu Sep 13 00:34:06 2001
+++ linux/drivers/input/mousedev.c	Thu Sep 27 23:47:59 2001
@@ -314,9 +314,9 @@
 
 			case 0xf2: /* Get ID */
 				switch (list->mode) {
-					case 0: list->ps2[1] = 0;
-					case 1: list->ps2[1] = 3;
-					case 2: list->ps2[1] = 4;
+					case 0: list->ps2[1] = 0; break;
+					case 1: list->ps2[1] = 3; break;
+					case 2: list->ps2[1] = 4; break;
 				}
 				list->bufsiz = 2;
 				break;

-- 
Vojtech Pavlik
SuSE Labs
