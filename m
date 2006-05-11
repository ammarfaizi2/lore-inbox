Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030263AbWEKPbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030263AbWEKPbY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 11:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030256AbWEKPbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 11:31:24 -0400
Received: from rusty.kulnet.kuleuven.ac.be ([134.58.240.42]:128 "EHLO
	rusty.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S1030264AbWEKPbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 11:31:23 -0400
From: Rik Bobbaers <Rik.Bobbaers@cc.kuleuven.be>
Organization: KULueven - LUDIT
To: linux-kernel@vger.kernel.org
Subject: fix compiler warning in ip_nat_standalone.c
Date: Thu, 11 May 2006 17:29:48 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605111729.48871.Rik.Bobbaers@cc.kuleuven.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hey all,

i just made small patch that fixes a compiler warning:

--- net/ipv4/netfilter/ip_nat_standalone.c~	2006-05-11 03:56:24.000000000 
+0200
+++ net/ipv4/netfilter/ip_nat_standalone.c	2006-05-11 17:17:22.000000000 +0200
@@ -219,8 +219,10 @@ ip_nat_out(unsigned int hooknum,
 	   const struct net_device *out,
 	   int (*okfn)(struct sk_buff *))
 {
+#ifdef CONFIG_XFRM
 	struct ip_conntrack *ct;
 	enum ip_conntrack_info ctinfo;
+#endif
 	unsigned int ret;
 
 	/* root is playing with raw sockets. */

or at http://harry.ulyssis.org/ip_nat.diff

-- 
harry
aka Rik Bobbaers

K.U.Leuven - LUDIT          -=- Tel: +32 485 52 71 50
Rik.Bobbaers@cc.kuleuven.be -=- http://harry.ulyssis.org

"Work hard and do your best, it'll make it easier for the rest"
-- Garfield

Disclaimer: http://www.kuleuven.be/cwis/email_disclaimer.htm

