Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265331AbUAZLbK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 06:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265335AbUAZLbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 06:31:10 -0500
Received: from spc1-leed3-6-0-cust58.leed.broadband.ntl.com ([80.7.68.58]:5103
	"EHLO arthur.pjc.net") by vger.kernel.org with ESMTP
	id S265331AbUAZLbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 06:31:08 -0500
Date: Mon, 26 Jan 2004 11:31:06 +0000
From: Patrick Caulfield <patrick@tykepenguin.com>
To: davem@redhat.com, linux-kernel@vger.kernel.org
Cc: Steve Whitehouse <Steve@ChyGwyn.com>
Subject: [PATCH] 1/2 DECnet fix SDF_WILD
Message-ID: <20040126113106.GB21366@tykepenguin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the operation of SDF_WILD sockets on Linux 2.6.0/1
(they don't currently work at all).

--- net/decnet/af_decnet.c.orig 2003-12-08 11:27:59.000000000 +0000
+++ net/decnet/af_decnet.c      2003-12-08 11:28:34.000000000 +0000
@@ -163,7 +163,7 @@
        struct dn_scp *scp = DN_SK(sk);

        if (scp->addr.sdn_flags & SDF_WILD)
-               return hlist_empty(&dn_wild_sk) ? NULL : &dn_wild_sk;
+               return hlist_empty(&dn_wild_sk) ? &dn_wild_sk : NULL;

        return &dn_sk_hash[scp->addrloc & DN_SK_HASH_MASK];
 }


patrick

