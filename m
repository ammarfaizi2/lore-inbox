Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262496AbTENPQw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 11:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262493AbTENPQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 11:16:52 -0400
Received: from port-212-202-185-200.reverse.qdsl-home.de ([212.202.185.200]:62596
	"EHLO gw.localnet") by vger.kernel.org with ESMTP id S262437AbTENPQr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 11:16:47 -0400
Message-ID: <3EC260D9.9050401@trash.net>
Date: Wed, 14 May 2003 17:29:29 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030430 Debian/1.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix two bogus kfree(skb)
Content-Type: multipart/mixed;
 boundary="------------060106000503080804030606"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060106000503080804030606
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes two occurences of kfree(skb) in net/bridge/br_input.c and
net/decnet/netfilter/dn_rtmsg.c.

Best regards,
Patrick


--------------060106000503080804030606
Content-Type: text/plain;
 name="net-bogus-kfree.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="net-bogus-kfree.diff"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1114  -> 1.1115 
#	net/bridge/br_input.c	1.11    -> 1.12   
#	net/decnet/netfilter/dn_rtmsg.c	1.1     -> 1.2    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/14	kaber@trash.net	1.1115
# Fix bogus kfree in br_input.c and dn_rtmsg.c
# --------------------------------------------
#
diff -Nru a/net/bridge/br_input.c b/net/bridge/br_input.c
--- a/net/bridge/br_input.c	Wed May 14 17:26:31 2003
+++ b/net/bridge/br_input.c	Wed May 14 17:26:31 2003
@@ -64,7 +64,7 @@
 	smp_read_barrier_depends();
 
 	if (p == NULL || p->state == BR_STATE_DISABLED) {
-		kfree(skb);
+		kfree_skb(skb);
 		goto out;
 	}
 
diff -Nru a/net/decnet/netfilter/dn_rtmsg.c b/net/decnet/netfilter/dn_rtmsg.c
--- a/net/decnet/netfilter/dn_rtmsg.c	Wed May 14 17:26:31 2003
+++ b/net/decnet/netfilter/dn_rtmsg.c	Wed May 14 17:26:31 2003
@@ -55,7 +55,7 @@
 
 nlmsg_failure:
 	if (skb)
-		kfree(skb);
+		kfree_skb(skb);
 	*errp = -ENOMEM;
 	if (net_ratelimit())
 		printk(KERN_ERR "dn_rtmsg: error creating netlink message\n");

--------------060106000503080804030606--

