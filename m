Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266507AbRG1IIo>; Sat, 28 Jul 2001 04:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266490AbRG1IIZ>; Sat, 28 Jul 2001 04:08:25 -0400
Received: from eriador.apana.org.au ([203.14.152.116]:14344 "EHLO
	eriador.apana.org.au") by vger.kernel.org with ESMTP
	id <S266448AbRG1IIM>; Sat, 28 Jul 2001 04:08:12 -0400
Date: Sat, 28 Jul 2001 18:08:01 +1000
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Patch in 2.2.18pre21 breaks fbcon logo
Message-ID: <20010728180801.A671@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following patch that appeared in 2.2.18pre21 breaks the fbcon logo.
Anyone knows what it was for?

Thanks.
-- 
Debian GNU/Linux 2.2 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: console.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source/drivers/char/console.c,v
retrieving revision 1.1.1.6
retrieving revision 1.1.1.7
diff -u -r1.1.1.6 -r1.1.1.7
--- console.c	4 Sep 2000 17:39:17 -0000	1.1.1.6
+++ console.c	18 Nov 2000 00:21:46 -0000	1.1.1.7
@@ -575,10 +575,12 @@
 	}
 
 	if (redraw) {
+		int update;
+		
 		set_origin(currcons);
+		update = sw->con_switch(vc_cons[currcons].d);
 		set_palette(currcons);
-		if (sw->con_switch(vc_cons[currcons].d) && vcmode != KD_GRAPHICS)
-			/* Update the screen contents */
+		if (update && vcmode != KD_GRAPHICS)
 			do_update_region(currcons, origin, screenbuf_size/2);
 	}
 	set_cursor(currcons);

--M9NhX3UHpAaciwkO--
