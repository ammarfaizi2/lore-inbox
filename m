Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262721AbTDEXBB (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 18:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262722AbTDEXBB (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 18:01:01 -0500
Received: from jalon.able.es ([212.97.163.2]:30433 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id S262721AbTDEXA4 (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 18:00:56 -0500
Date: Sun, 6 Apr 2003 01:12:20 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] e1000 close
Message-ID: <20030405231220.GI12864@werewolf.able.es>
References: <Pine.LNX.4.53L.0304041815110.32674@freak.distro.conectiva> <20030405224233.GA12746@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030405224233.GA12746@werewolf.able.es>; from jamagallon@able.es on Sun, Apr 06, 2003 at 00:42:33 +0200
X-Mailer: Balsa 2.0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 04.06, J.A. Magallon wrote:
> 
> On 04.04, Marcelo Tosatti wrote:
> > 
> > So here goes -pre7. Hopefully the last -pre.
> > 
> 

Supposed to cure a dev_close called without dev_open.
Is this still needed ?

--- linux-2.4.20/drivers/net/e1000/e1000_main.c.orig	2003-03-11 13:45:26.000000000 -0800
+++ linux-2.4.20/drivers/net/e1000/e1000_main.c	2003-03-11 14:12:12.000000000 -0800
@@ -997,6 +997,9 @@
 	unsigned long size;
 	int i;
 
+	if(!adapter->tx_ring.buffer_info)
+		return;
+
 	/* Free all the Tx ring sk_buffs */
 
 	for(i = 0; i < adapter->tx_ring.count; i++) {
@@ -1062,6 +1065,9 @@
 	unsigned long size;
 	int i;
 
+	if(!adapter->rx_ring.buffer_info)
+		return;
+
 	/* Free all the Rx ring sk_buffs */
 
 	for(i = 0; i < adapter->rx_ring.count; i++) {

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Bamboo) for i586
Linux 2.4.21-pre7-jam1 (gcc 3.2.2 (Mandrake Linux 9.2 3.2.2-5mdk))
