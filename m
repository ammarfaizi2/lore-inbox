Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317397AbSGIUTK>; Tue, 9 Jul 2002 16:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317398AbSGIUTJ>; Tue, 9 Jul 2002 16:19:09 -0400
Received: from [213.187.195.158] ([213.187.195.158]:48368 "EHLO
	kokeicha.ingate.se") by vger.kernel.org with ESMTP
	id <S317397AbSGIUTI>; Tue, 9 Jul 2002 16:19:08 -0400
To: netfilter-devel@lists.samba.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Iptables multiport match fix
From: Marcus Sundberg <marcus@ingate.com>
Date: 09 Jul 2002 22:21:36 +0200
Message-ID: <veznx0ejov.fsf@inigo.ingate.se>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The multiport match checks for the IPT_INV_PROTO flag in the 'flags'
member of struct ipt_ip instead of in the 'invflags' member.

diff -ur linux.current/net/ipv4/netfilter/ipt_multiport.c linux-mine/net/ipv4/netfilter/ipt_multiport.c
--- linux-2.4.19-rc1/net/ipv4/netfilter/ipt_multiport.c	Tue Jun 20 23:32:27 2000
+++ linux/net/ipv4/netfilter/ipt_multiport.c	Tue Jul  9 10:43:23 2002
@@ -78,7 +78,7 @@
 
 	/* Must specify proto == TCP/UDP, no unknown flags or bad count */
 	return (ip->proto == IPPROTO_TCP || ip->proto == IPPROTO_UDP)
-		&& !(ip->flags & IPT_INV_PROTO)
+		&& !(ip->invflags & IPT_INV_PROTO)
 		&& matchsize == IPT_ALIGN(sizeof(struct ipt_multiport))
 		&& (multiinfo->flags == IPT_MULTIPORT_SOURCE
 		    || multiinfo->flags == IPT_MULTIPORT_DESTINATION

(Where should I send this btw? The kernel part of iptables doesn't
seem to be in the netfilter CVS. Was I supposed to create a p-o-m
patch? Or send it directly to Marcelo?)

//Marcus
-- 
---------------------------------------+--------------------------
  Marcus Sundberg <marcus@ingate.com>  | Firewalls with SIP & NAT
 Firewall Developer, Ingate Systems AB |  http://www.ingate.com/
