Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264289AbTCXRPQ>; Mon, 24 Mar 2003 12:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264291AbTCXQta>; Mon, 24 Mar 2003 11:49:30 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:53226 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S264290AbTCXQbB>; Mon, 24 Mar 2003 11:31:01 -0500
Message-Id: <200303241642.h2OGgC35008344@deviant.impure.org.uk>
Date: Mon, 24 Mar 2003 16:42:00 +0000
To: linux-kernel@vger.kernel.org
From: davej@codemonkey.org.uk
Subject: stray 2.4 tcp fix.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sent to davem and netdev already, and was met with silence..

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/net/ipv4/tcp.c linux-2.5/net/ipv4/tcp.c
--- bk-linus/net/ipv4/tcp.c	2003-03-21 12:53:31.000000000 +0000
+++ linux-2.5/net/ipv4/tcp.c	2003-03-21 13:45:21.000000000 +0000
@@ -1189,7 +1189,8 @@ new_segment:
 
 			from += copy;
 			copied += copy;
-			seglen -= copy;
+			if ((seglen -= copy) == 0 && iovlen == 0)
+				goto out;
 
 			if (skb->len != mss_now || (flags & MSG_OOB))
 				continue;
