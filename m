Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264566AbUBDXoE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 18:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264971AbUBDXlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 18:41:16 -0500
Received: from dsl081-085-091.lax1.dsl.speakeasy.net ([64.81.85.91]:43659 "EHLO
	mrhankey.megahappy.net") by vger.kernel.org with ESMTP
	id S264566AbUBDXez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 18:34:55 -0500
To: ctindel@users.sourceforge.net
Subject: [PATCH 2.6.2] drivers/net/bonding/bond_alb.c
Cc: bonding-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Message-Id: <20040204233356.485BBFA5F1@mrhankey.megahappy.net>
Date: Wed,  4 Feb 2004 15:33:56 -0800 (PST)
From: driver@megahappy.net (Bryan Whitehead)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Building with gcc 3.3.2 on gentoo linux on Athlon x86 system I get
a warning:
  CC [M]  drivers/net/bonding/bond_alb.o
drivers/net/bonding/bond_alb.c: In function `bond_alb_xmit':
drivers/net/bonding/bond_alb.c:1340: warning: comparison is always true due to limited range of data type                                                                                                         
This is due to using __constant_htons for endian issues. This is a byte so there
is no point in using __constant_htons in the first place. Unless I'm mistaken using
__constant_htons makes this statment always true as the compiler states.
 
if ipx_type = IPX_TYPE_NCP then the intended logic will not happen?

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
Email:driver@megahappy.net
WorkE:driver@jpl.nasa.gov
