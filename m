Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263103AbTC1TGk>; Fri, 28 Mar 2003 14:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263104AbTC1TGk>; Fri, 28 Mar 2003 14:06:40 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:48542 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S263103AbTC1TGj>; Fri, 28 Mar 2003 14:06:39 -0500
Date: Fri, 28 Mar 2003 20:02:58 +0100
From: Dominik Brodowski <linux@brodo.de>
To: rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5] pcmcia: don't inform "driver services" of cardbus-related events
Message-ID: <20030328190258.GA14674@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Untested due to lack of CardBus card...

diff -ruN linux-original/drivers/pcmcia/cs.c linux/drivers/pcmcia/cs.c
--- linux-original/drivers/pcmcia/cs.c	2003-03-28 19:59:53.000000000 +0100
+++ linux/drivers/pcmcia/cs.c	2003-03-28 19:59:17.000000000 +0100
@@ -647,6 +647,8 @@
     DEBUG(1, "cs: send_event(sock %d, event %d, pri %d)\n",
 	  s->sock, event, priority);
     ret = 0;
+    if (s->state & SOCKET_CARDBUS)
+	    return 0;
     for (; client; client = client->next) { 
 	if (client->state & (CLIENT_UNBOUND|CLIENT_STALE))
 	    continue;
