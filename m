Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263775AbUHAA22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbUHAA22 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 20:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263818AbUHAA22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 20:28:28 -0400
Received: from mail.dif.dk ([193.138.115.101]:17316 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S263775AbUHAA2N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 20:28:13 -0400
Date: Sun, 1 Aug 2004 02:32:43 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] drivers/net/wan/cycx_x25.c:189: warning: conflicting types
 for built-in function 'log2'
Message-ID: <Pine.LNX.4.60.0408010225180.2660@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


To silence the warning in $subject, rename log2 to cycx_log2 in this file 
to remove the clash, so there's no doubt that this file uses it's own
defined log2 function.

Patch against 2.6.8-rc2-mm1

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>


diff -up linux-2.6.8-rc2-mm1-orig/drivers/net/wan/cycx_x25.c linux-2.6.8-rc2-mm1/drivers/net/wan/cycx_x25.c
--- linux-2.6.8-rc2-mm1-orig/drivers/net/wan/cycx_x25.c	2004-06-16 07:19:01.000000000 +0200
+++ linux-2.6.8-rc2-mm1/drivers/net/wan/cycx_x25.c	2004-07-31 22:10:02.000000000 +0200
@@ -186,7 +186,7 @@ static void nibble_to_byte(u8 *s, u8 *d,
  	    reset_timer(struct net_device *dev);

  static u8 bps_to_speed_code(u32 bps);
-static u8 log2(u32 n);
+static u8 cycx_log2(u32 n);

  static unsigned dec_to_uint(u8 *str, int len);

@@ -263,7 +263,7 @@ int cycx_x25_wan_init(struct cycx_device
  	else
  		card->wandev.mtu = 64;

-	cfg.pktlen = log2(card->wandev.mtu);
+	cfg.pktlen = cycx_log2(card->wandev.mtu);

  	if (conf->station == WANOPT_DTE) {
  		cfg.locaddr = 3; /* DTE */
@@ -1513,7 +1513,7 @@ static u8 bps_to_speed_code(u32 bps)
  }

  /* log base 2 */
-static u8 log2(u32 n)
+static u8 cycx_log2(u32 n)
  {
  	u8 log = 0;


