Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263637AbUBEGvx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 01:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263711AbUBEGvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 01:51:53 -0500
Received: from dsl081-085-091.lax1.dsl.speakeasy.net ([64.81.85.91]:23436 "EHLO
	mrhankey.megahappy.net") by vger.kernel.org with ESMTP
	id S263637AbUBEGvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 01:51:52 -0500
To: ctindel@users.sourceforge.net
Subject: [PATCH 2.6.2] drivers/net/bonding/bond_alb.c
Cc: linux-kernel@vger.kernel.org
Message-Id: <20040205065051.0EF40FA5F1@mrhankey.megahappy.net>
Date: Wed,  4 Feb 2004 22:50:51 -0800 (PST)
From: driver@megahappy.net (Bryan Whitehead)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


__constant_htons is used on a variable that is only a byte. This results
in an if statement always returning true in function bond_alb_xmit.

This is the compiler warning on gcc 3.3.2 a gentoo linux system:
  CC [M]  drivers/net/bonding/bond_alb.o
drivers/net/bonding/bond_alb.c: In function `bond_alb_xmit':
drivers/net/bonding/bond_alb.c:1340: warning: comparison is always true due to limited range of data type

Here is the patch:
--- linux-2.6.2/drivers/net/bonding/bond_alb.c.orig     2004-02-04 15:08:04.228336168 -0800
+++ linux-2.6.2/drivers/net/bonding/bond_alb.c  2004-02-04 15:26:03.769221008 -0800
@@ -1336,8 +1336,7 @@ bond_alb_xmit(struct sk_buff *skb, struc
                        break;
                }
  
-               if (ipx_hdr(skb)->ipx_type !=
-                   __constant_htons(IPX_TYPE_NCP)) {
+               if (ipx_hdr(skb)->ipx_type != IPX_TYPE_NCP) {
                        /* The only protocol worth balancing in
                         * this family since it has an "ARP" like
                         * mechanism


--
Bryan Whitehead
driver@megahappy.net
