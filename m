Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265045AbUAVVxQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 16:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266440AbUAVVxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 16:53:16 -0500
Received: from mail3.edisontel.com ([62.94.0.36]:46034 "EHLO
	mail3.edisontel.com") by vger.kernel.org with ESMTP id S265045AbUAVVxO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 16:53:14 -0500
From: Eduard Roccatello <lilo@roccatello.it>
Organization: SPINE
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] net/ipv4/tcp.c little cleanup
Date: Thu, 22 Jan 2004 22:53:37 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
X-IRC: #hardware@azzurra.org #rolug@freenode
X-Jabber: eduardroccatello@jabber.linux.it
X-GPG-Keyserver: keyserver.linux.it
X-GPG-FingerPrint: F7B3 3844 038C D582 2C04 4488 8D46 368B 474D 6DB0
X-GPG-KeyID: 474D6DB0
X-Website: http://www.pcimprover.it
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_hZEEAaGPqqFHeZc"
Message-Id: <200401222253.37426.lilo@roccatello.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_hZEEAaGPqqFHeZc
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,
i've done a little cleanup to net/ipv4/tcp.c

I hope it is ok :-)

Best regards,
Eduard Roccatello

--Boundary-00=_hZEEAaGPqqFHeZc
Content-Type: text/x-diff;
  charset="us-ascii";
  name="tcp.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="tcp.c.patch"

--- net/ipv4/tcp.c.orig	2004-01-22 22:49:38.000000000 +0100
+++ net/ipv4/tcp.c	2004-01-22 22:42:38.000000000 +0100
@@ -549,9 +549,9 @@ int tcp_listen_start(struct sock *sk)
 		return -ENOMEM;
 
 	memset(lopt, 0, sizeof(struct tcp_listen_opt));
-	for (lopt->max_qlen_log = 6; ; lopt->max_qlen_log++)
-		if ((1 << lopt->max_qlen_log) >= sysctl_max_syn_backlog)
-			break;
+	lopt->max_qlen_log = 6;
+	while (sysctl_max_syn_backlog > (1 << lopt->max_qlen_log))
+		lopt->max_qlen_log++;
 	get_random_bytes(&lopt->hash_rnd, 4);
 
 	write_lock_bh(&tp->syn_wait_lock);

--Boundary-00=_hZEEAaGPqqFHeZc--

