Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262780AbSLEIVG>; Thu, 5 Dec 2002 03:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262789AbSLEIVG>; Thu, 5 Dec 2002 03:21:06 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:27529 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S262780AbSLEIVG>; Thu, 5 Dec 2002 03:21:06 -0500
From: SL Baur <steve@kbuxd.necst.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15855.3826.974944.748428@sofia.bsd2.kbnes.nec.co.jp>
Date: Thu, 5 Dec 2002 17:31:46 +0900
To: linux-kernel@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] Re: [PATCH] fix netlink compile breakage
X-Mailer: VM 7.03 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On lkml you write:

> More viro breakage. I wonder if 'int i' is missing from several other 
> files I did not compile... 

The other driver patches appear O.K.

> ===== net/netlink/netlink_dev.c 1.10 vs edited ===== 
> --- 1.10/net/netlink/netlink_dev.c Mon Dec 2 18:45:41 2002 
> +++ edited/net/netlink/netlink_dev.c Wed Dec 4 19:58:43 2002 

You missed one.  This patch is against bk-latest (which has your
netlink_dev patch applied).

--- linus-2.5/net/netlink/netlink_dev.c.orig	Thu Dec  5 15:38:42 2002
+++ linus-2.5/net/netlink/netlink_dev.c	Thu Dec  5 17:16:56 2002
@@ -225,6 +225,8 @@
 
 void cleanup_module(void)
 {
+	int i;
+
 	for (i = 0; i < sizeof(entries)/sizeof(entries[0]); i++)
 		devfs_remove("netlink/%s", entries[i].name);
 	for (i = 0; i < 16; i++)

