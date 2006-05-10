Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932438AbWEJC5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbWEJC5z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 22:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbWEJC5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 22:57:32 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:5182 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP id S932438AbWEJC4t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 22:56:49 -0400
Date: Tue, 9 May 2006 19:55:58 -0700
Message-Id: <200605100255.k4A2twsu031694@dwalker1.mvista.com>
From: Daniel Walker <dwalker@mvista.com>
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH -mm] ip_conntrack_ftp gcc 4.1 warning fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following warning,

net/ipv4/netfilter/ip_conntrack_ftp.c: In function 'help':
net/ipv4/netfilter/ip_conntrack_ftp.c:298: warning: 'matchoff' may be used uninitialized in this function
net/ipv4/netfilter/ip_conntrack_ftp.c:298: warning: 'matchlen' may be used uninitialized in this function

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.16/net/ipv4/netfilter/ip_conntrack_ftp.c
===================================================================
--- linux-2.6.16.orig/net/ipv4/netfilter/ip_conntrack_ftp.c
+++ linux-2.6.16/net/ipv4/netfilter/ip_conntrack_ftp.c
@@ -295,7 +295,8 @@ static int help(struct sk_buff **pskb,
 	int ret;
 	u32 seq, array[6] = { 0 };
 	int dir = CTINFO2DIR(ctinfo);
-	unsigned int matchlen, matchoff;
+	unsigned int matchlen = 0;
+	unsigned int matchoff = 0;
 	struct ip_ct_ftp_master *ct_ftp_info = &ct->help.ct_ftp_info;
 	struct ip_conntrack_expect *exp;
 	unsigned int i;
