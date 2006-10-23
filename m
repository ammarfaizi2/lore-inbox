Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965068AbWJWTFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965068AbWJWTFd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 15:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965069AbWJWTEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 15:04:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49829 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965071AbWJWTEt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 15:04:49 -0400
Date: Mon, 23 Oct 2006 12:04:37 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] netpoll: interface cleanup
Message-ID: <20061023120437.1731d817@dxpl.pdx.osdl.net>
In-Reply-To: <20061023120253.5dd146d2@dxpl.pdx.osdl.net>
References: <20061020134826.75dd1cba@freekitty>
	<20061020.140149.125893169.davem@davemloft.net>
	<20061020153027.3bed8c86@dxpl.pdx.osdl.net>
	<20061022.204220.78710782.davem@davemloft.net>
	<20061023120253.5dd146d2@dxpl.pdx.osdl.net>
X-Mailer: Sylpheed-Claws 2.5.5 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial cleanup of netpoll interface. Use constants
for size, to make usage clear.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

--- netpoll.orig/include/linux/netpoll.h
+++ netpoll/include/linux/netpoll.h
@@ -12,15 +12,14 @@
 #include <linux/rcupdate.h>
 #include <linux/list.h>
 
-struct netpoll;
-
 struct netpoll {
 	struct net_device *dev;
-	char dev_name[16], *name;
+	char dev_name[IFNAMSIZ];
+	const char *name;
 	void (*rx_hook)(struct netpoll *, int, char *, int);
 	u32 local_ip, remote_ip;
 	u16 local_port, remote_port;
-	unsigned char local_mac[6], remote_mac[6];
+	u8 local_mac[ETH_ALEN], remote_mac[ETH_ALEN];
 };
 
 struct netpoll_info {
