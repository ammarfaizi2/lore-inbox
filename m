Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261844AbTCaUzI>; Mon, 31 Mar 2003 15:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261845AbTCaUzI>; Mon, 31 Mar 2003 15:55:08 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:39135 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261844AbTCaUzG>; Mon, 31 Mar 2003 15:55:06 -0500
Date: Mon, 31 Mar 2003 23:06:21 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, Muli Ben-Yehuda <mulix@mulix.org>,
       John Levon <levon@movementarian.org>, trivial@rustcorp.com.au
Subject: [2.4 patch] trident 1/1 fix operator precedence bug
Message-ID: <20030331210620.GA864@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below by John Levon is already in 2.5. Muli Ben-Yehuda wrote:

<--  snip  -->

Fix an operator precedence bug that caused a comparison to always
return false. Patch from John Levon <levon@movementarian.org>. Tested,
works fine. 

<--  snip  -->

Please apply
Adrian

--- linux-2.4.21-pre6-full/drivers/sound/trident.c.old	2003-03-31 22:57:08.000000000 +0200
+++ linux-2.4.21-pre6-full/drivers/sound/trident.c	2003-03-31 22:57:29.000000000 +0200
@@ -3060,7 +3060,7 @@
         ncount = 10;
 	while(1) {
 		wcontrol = inw(TRID_REG(card, ALI_AC97_WRITE));
-		if(!wcontrol & 0x8000)
+		if(!(wcontrol & 0x8000))
 			break;
 		if(ncount <= 0)
 			break;
