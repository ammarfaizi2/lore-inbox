Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264680AbSJ3OI5>; Wed, 30 Oct 2002 09:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264684AbSJ3OI5>; Wed, 30 Oct 2002 09:08:57 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:2531 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S264680AbSJ3OIy>; Wed, 30 Oct 2002 09:08:54 -0500
Date: Wed, 30 Oct 2002 15:15:16 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: netfilter-devel@lists.netfilter.org
Subject: [PATCH 2.5.bk] make netfilter's ipt_TCPMSS compile again
Message-ID: <20021030141516.GG17103@tahoe.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	netfilter-devel@lists.netfilter.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The attached patch is required to make ipt_TCPMSS.c compile again,
due to the pmtu changes.

Stelian.

===== net/ipv4/netfilter/ipt_TCPMSS.c 1.5 vs edited =====
--- 1.5/net/ipv4/netfilter/ipt_TCPMSS.c	Tue Feb  5 16:23:43 2002
+++ edited/net/ipv4/netfilter/ipt_TCPMSS.c	Wed Oct 30 13:01:44 2002
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
 
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
