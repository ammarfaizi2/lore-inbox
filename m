Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265080AbSKAQMN>; Fri, 1 Nov 2002 11:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265091AbSKAQMN>; Fri, 1 Nov 2002 11:12:13 -0500
Received: from mamona.cetuc.puc-rio.br ([139.82.74.4]:53376 "EHLO
	mamona.cetuc.puc-rio.br") by vger.kernel.org with ESMTP
	id <S265080AbSKAQMM>; Fri, 1 Nov 2002 11:12:12 -0500
Subject: [PATCH] 2.5.45 [TRIVIAL] Fixed pmtu usage in iptunnel
From: Marcelo Roberto Jimenez <mroberto@cetuc.puc-rio.br>
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 01 Nov 2002 13:18:23 -0200
Message-Id: <1036163903.18289.8.camel@genipapo>
Mime-Version: 1.0
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.858   -> 1.859  
#	net/ipv4/netfilter/ipt_TCPMSS.c	1.5     -> 1.6    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/11/01	mroberto@cetuc.puc-rio.br	1.859
# ipt_TCPMSS.c:
#   Fixed broken code to use inline shorthand dst_pmtu()
# --------------------------------------------
#
diff -Nru a/net/ipv4/netfilter/ipt_TCPMSS.c b/net/ipv4/netfilter/ipt_TCPMSS.c
--- a/net/ipv4/netfilter/ipt_TCPMSS.c	Fri Nov  1 13:13:29 2002
+++ b/net/ipv4/netfilter/ipt_TCPMSS.c	Fri Nov  1 13:13:29 2002
@@ -85,14 +85,14 @@
 			return NF_DROP; /* or IPT_CONTINUE ?? */
 		}
 
-		if((*pskb)->dst->pmtu <= (sizeof(struct iphdr) + sizeof(struct tcphdr))) {
+		if(dst_pmtu((*pskb)->dst) <= (sizeof(struct iphdr) + sizeof(struct tcphdr))) {
 			if (net_ratelimit())
 				printk(KERN_ERR
-		       			"ipt_tcpmss_target: unknown or invalid path-MTU (%d)\n", (*pskb)->dst->pmtu);
+		       			"ipt_tcpmss_target: unknown or invalid path-MTU (%d)\n", dst_pmtu((*pskb)->dst));
 			return NF_DROP; /* or IPT_CONTINUE ?? */
 		}
 
-		newmss = (*pskb)->dst->pmtu - sizeof(struct iphdr) - sizeof(struct tcphdr);
+		newmss = dst_pmtu((*pskb)->dst) - sizeof(struct iphdr) - sizeof(struct tcphdr);
 	} else
 		newmss = tcpmssinfo->mss;
 

