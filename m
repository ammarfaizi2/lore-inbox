Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262682AbTDARFy>; Tue, 1 Apr 2003 12:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262683AbTDARFy>; Tue, 1 Apr 2003 12:05:54 -0500
Received: from dclient217-162-108-200.hispeed.ch ([217.162.108.200]:3082 "HELO
	ritz.dnsalias.org") by vger.kernel.org with SMTP id <S262682AbTDARFv> convert rfc822-to-8bit;
	Tue, 1 Apr 2003 12:05:51 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: "David S. Miller" <davem@redhat.com>
Subject: [PATCH 2.5] fix /proc/net/route missing the default route
Date: Tue, 1 Apr 2003 19:17:07 +0200
User-Agent: KMail/1.4.3
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>, szazol@e98.hu
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200304011917.07544.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

this one fixes /proc/net/route missing the default route for me.
[see http://bugme.osdl.org/show_bug.cgi?id=528 ]
against 2.5.66-bk. please apply if it's correct.

rgds
-daniel



===== net/ipv4/fib_hash.c 1.10 vs edited =====
--- 1.10/net/ipv4/fib_hash.c	Sat Feb  1 02:04:16 2003
+++ edited/net/ipv4/fib_hash.c	Tue Apr  1 19:03:45 2003
@@ -936,14 +936,10 @@
 				goto out;
 		}
 
-		for (;;) {
-			iter->zone = iter->zone->fz_next;
+		iter->zone = iter->zone->fz_next;
 
-			if (!iter->zone)
-				goto out;
-			if (iter->zone->fz_next)
-				break;
-		}
+		if (!iter->zone)
+			goto out;
 		
 		iter->hash = iter->zone->fz_hash;
 		iter->bucket = 0;

