Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312973AbSFTJ21>; Thu, 20 Jun 2002 05:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313060AbSFTJ20>; Thu, 20 Jun 2002 05:28:26 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:5873 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S312973AbSFTJ2Z>; Thu, 20 Jun 2002 05:28:25 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15633.40926.324833.121952@wombat.chubb.wattle.id.au>
Date: Thu, 20 Jun 2002 19:26:54 +1000
To: paulus@samba.org
CC: linux-kernel@vger.kernel.org, trivial@rustcorp.com
Subject: ppp_generic.c doesn't compile on IA64
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
X-Face: .slVUC18R`%{j(W3ztQe~*ATzet;h`*Wv33MZ]*M,}9AP<`+C=U)c#NzI5vK!0^d#6:<_`a
 {#.<}~(T^aJ~]-.C'p~saJ7qZXP-$AY==]7,9?WVSH5sQ}g3,8j>u%@f$/Z6,WR7*E~BFY.Yjw,H6<
 F.cEDj2$S:kO2+-5<]afj@kC!:uw\(<>lVpk)lPZs+2(=?=D/TZPG+P9LDN#1RRUPxdX
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Paul,
   ppp_generic.c needs the attached patch (or something like it) to
compile on IA64, because outl() is a macro that expands to something
that doesn't look like a label.

--- /tmp/geta7153	Thu Jun 20 19:23:26 2002
+++ linux-2.5.23/drivers/net/ppp_generic.c	Thu Jun 20 19:23:24 2002
@@ -2437,7 +2437,7 @@
 	write_lock_bh(&pch->upl);
 	ret = -EINVAL;
 	if (pch->ppp != 0)
-		goto outl;
+		goto out_unlock;
 
 	ppp_lock(ppp);
 	if (pch->file.hdrlen > ppp->file.hdrlen)
@@ -2452,7 +2452,7 @@
 	ppp_unlock(ppp);
 	ret = 0;
 
- outl:
+ out_unlock:
 	write_unlock_bh(&pch->upl);
  out:
 	up(&all_ppp_sem);
