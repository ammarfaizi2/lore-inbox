Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262897AbUDTMkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262897AbUDTMkW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 08:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262800AbUDTMkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 08:40:22 -0400
Received: from main.gmane.org ([80.91.224.249]:8331 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262897AbUDTMkI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 08:40:08 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: [PATCH] Fix scancode->keycode->scancode conversion for 2.6.5
Date: Tue, 20 Apr 2004 14:40:02 +0200
Message-ID: <MPG.1aef388ef95f573b989696@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: oblomov.dipmat.unict.it
X-Newsreader: MicroPlanet Gravity v2.60
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a problem with the RAW mode emulation in
2.6.5 kernels for AT keyboards in Translated Set 2 mode.

It allows correct behavior for scancodes 0x81 to 0x84 which,
if mapped by e.g. setkeycodes to their correct value (129 to 132)
behave as if they were 0x85, 0x86, 0x87, 0x8c

The patch should present no problems since only 0 values get changed.

--- atkbd.c.265	Tue Apr 20 13:32:32 2004
+++ atkbd.c	Tue Apr 20 13:32:32 2004
@@ -81,13 +81,13 @@
 	 82, 83, 80, 76, 77, 72,  1, 69, 87, 78, 81, 74, 55, 73, 70, 99,
 
 	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
-	217,100,255,  0, 97,165,  0,  0,156,  0,  0,  0,  0,  0,  0,125,
-	173,114,  0,113,  0,  0,  0,126,128,  0,  0,140,  0,  0,  0,127,
+	217,100,255,  0, 97,165,172,  0,156,  0,  0,  0,  0,  0,187,125,
+	173,114,  0,113,  0,  0,189,126,128,  0,  0,140,  0,  0,  0,127,
 	159,  0,115,  0,164,  0,  0,116,158,  0,150,166,  0,  0,  0,142,
 	157,  0,  0,  0,  0,  0,  0,  0,155,  0, 98,  0,  0,163,  0,  0,
 	226,  0,  0,  0,  0,  0,  0,  0,  0,255, 96,  0,  0,  0,143,  0,
 	  0,  0,  0,  0,  0,  0,  0,  0,  0,107,  0,105,102,  0,  0,112,
-	110,111,108,112,106,103,  0,119,  0,118,109,  0, 99,104,119,  0,
+	110,111,108,112,106,103,171,119,  0,118,109,  0, 99,104,119,  0,
 
 	  0,  0,  0, 65, 99,
 };




-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

