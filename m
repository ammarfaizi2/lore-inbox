Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267396AbTA1PoC>; Tue, 28 Jan 2003 10:44:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267389AbTA1PoB>; Tue, 28 Jan 2003 10:44:01 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:3250 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S267396AbTA1Pn7>; Tue, 28 Jan 2003 10:43:59 -0500
Date: Tue, 28 Jan 2003 16:53:12 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Vojtech Pavlik <vojtech@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: [BUG] in drivers/char/joystick/magellan.c
Message-ID: <20030128155312.GD10685@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Without the patch below, the \0 terminating the string is written
anywhere. nibbles[] would be even better, I guess.
Can you check for stupidity on my side?

Jörn

-- 
But this is not to say that the main benefit of Linux and other GPL
software is lower-cost. Control is the main benefit--cost is secondary.
-- Bruce Perens

diff -Naur linux-2.4.21-pre3-ac4/drivers/char/joystick/magellan.c scratch/drivers/char/joystick/magellan.c
--- linux-2.4.21-pre3-ac4/drivers/char/joystick/magellan.c	Thu Sep 13 00:34:06 2001
+++ scratch/drivers/char/joystick/magellan.c	Mon Jan 27 13:49:54 2003
@@ -66,7 +66,7 @@
 
 static int magellan_crunch_nibbles(unsigned char *data, int count)
 {
-	static unsigned char nibbles[16] = "0AB3D56GH9:K<MN?";
+	static unsigned char nibbles[17] = "0AB3D56GH9:K<MN?";
 
 	do {
 		if (data[count] == nibbles[data[count] & 0xf])
