Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266038AbUAQNX7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 08:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266050AbUAQNX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 08:23:59 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:34700 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S266038AbUAQNXv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 08:23:51 -0500
Date: Sat, 17 Jan 2004 14:23:07 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Mathias.Beilstein@t-online.de
Cc: linux-kernel@vger.kernel.org, realtek@scyld.com, netdev@oss.sgi.com
Subject: Re: Bug? 2.4.24 module/networking Kernel driver/net/r8169.c freeze
Message-ID: <20040117142307.A14176@electric-eye.fr.zoreil.com>
References: <1074217033.400740491d6ff@webmail.t-online.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1074217033.400740491d6ff@webmail.t-online.de>; from Mathias.Beilstein@t-online.de on Fri, Jan 16, 2004 at 03:13:29AM +0100
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Mathias.Beilstein@t-online.de <Mathias.Beilstein@t-online.de> :
[...]
> 1. short: smb over tcp delays > 5 sec; flood ping to machine --> machine 
> freeze

Please apply attached patch and see 1) if Tx traffic stops 2) if something
appears in dmesg.

netdev@oss.sgi.com added to Cc:.

--
Ueimor

--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="r8169-debug.patch"

--- r8169.c-realtek	2004-01-17 14:14:50.000000000 +0100
+++ r8169.c-debug	2004-01-17 14:17:25.000000000 +0100
@@ -1290,6 +1290,11 @@ static void rtl8169_tx_interrupt (struct
 	dirty_tx = priv->dirty_tx;
 	tx_left = priv->cur_tx - dirty_tx;
 
+	if (entry + tx_left > NUM_TX_DESC) {
+		printk(KERN_ERR, "r8169 bug. Please mail netdev@oss.sgi.com\n");
+		return;
+	}
+
 	while (tx_left > 0) {
 		if( (priv->TxDescArray[entry].status & OWNbit) == 0 ){
 			dev_kfree_skb_irq( priv->Tx_skbuff[dirty_tx % NUM_TX_DESC] );

--NzB8fVQJ5HfG6fxh--
