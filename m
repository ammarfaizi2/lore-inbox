Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266341AbUG0IXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266341AbUG0IXT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 04:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266345AbUG0IXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 04:23:19 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:36105 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S266341AbUG0IXM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 04:23:12 -0400
Date: Tue, 27 Jul 2004 18:22:41 +1000
To: Marcelo Tosatti <marcelo@conectiva.com.br>, kkeil@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [I4L] Fix IRQ-sharing lockup in nj_s
Message-ID: <20040727082241.GA15624@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

This is a backport of a fix that's already in 2.6.  The problem is that
nj_s is enabling interrupts before the handler is even installed.  This
patch delays the call until after the handler has been registered.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

===== drivers/isdn/hisax/nj_s.c 1.7 vs edited =====
--- 1.7/drivers/isdn/hisax/nj_s.c	2002-04-01 11:02:11 +10:00
+++ edited/drivers/isdn/hisax/nj_s.c	2004-07-27 18:19:41 +10:00
@@ -130,6 +130,7 @@
 			release_io_netjet(cs);
 			return(0);
 		case CARD_INIT:
+			reset_netjet_s(cs);
 			inittiger(cs);
 			clear_pending_isac_ints(cs);
 			initisac(cs);
@@ -262,7 +263,6 @@
 	} else {
 		request_region(cs->hw.njet.base, bytecnt, "netjet-s isdn");
 	}
-	reset_netjet_s(cs);
 	cs->readisac  = &NETjet_ReadIC;
 	cs->writeisac = &NETjet_WriteIC;
 	cs->readisacfifo  = &NETjet_ReadICfifo;

--qDbXVdCdHGoSgWSk--
