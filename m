Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262134AbVFWGrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbVFWGrg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 02:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262559AbVFWGqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 02:46:42 -0400
Received: from [24.22.56.4] ([24.22.56.4]:30950 "EHLO
	w-gerrit.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id S262346AbVFWGTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:19:08 -0400
Message-Id: <20050623061756.318352000@w-gerrit.beaverton.ibm.com>
References: <20050623061552.833852000@w-gerrit.beaverton.ibm.com>
Date: Wed, 22 Jun 2005 23:16:03 -0700
From: Gerrit Huizenga <gh@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: ckrm-tech@lists.sourceforge.net, Chandra Seetharaman <sekharan@us.ibm.com>,
       Vivek Kashyap <kashyapv@us.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>
Subject: [patch 11/38] CKRM e18: Change ipaddr_port syntax
Content-Disposition: inline; filename=06b-ckrm_sockc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-Off-By: Vivek Kashyap <kashyapv@us.ibm.com>
Signed-Off-By: Gerrit Huizenga <gh@us.ibm.com>

Change the ipaddr_port syntax from "xxx.xxx.xxx.xxx\\YY" to
"xxx.xxx.xxx.xxx:YY" to make it easy for cut-n-paste.


 ckrm_sockc.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

Index: linux-2.6.12-ckrm1/kernel/ckrm/ckrm_sockc.c
===================================================================
--- linux-2.6.12-ckrm1.orig/kernel/ckrm/ckrm_sockc.c	2005-06-20 13:08:32.000000000 -0700
+++ linux-2.6.12-ckrm1/kernel/ckrm/ckrm_sockc.c	2005-06-20 13:08:38.000000000 -0700
@@ -343,7 +343,7 @@ static int ckrm_sock_show_members(struct
 	class_lock(core);
 	list_for_each(lh, &core->objlist) {
 		ns = container_of(lh, struct ckrm_net_struct, ckrm_link);
-		seq_printf(seq, "%d.%d.%d.%d\\%d\n",
+		seq_printf(seq, "%d.%d.%d.%d:%d\n",
 			   NIPQUAD(ns->ns_daddrv4), ns->ns_dport);
 	}
 	class_unlock(core);
@@ -459,7 +459,7 @@ ckrm_sock_forced_reclassify(struct ckrm_
 			return -EPERM;
 		if (id != 0)
 			return -EINVAL;
-		printk("ckrm_sock_class: reclassify all not net implemented\n");
+		printk("socketclass: reclassify all not implemented yet\n");
 		return 0;
 	}
 
@@ -478,15 +478,15 @@ ckrm_sock_forced_reclassify(struct ckrm_
 			while (*p2 && (*p2 != '='))
 				++p2;
 			p2++;
-			p2 = v4toi(p2, '\\', &(v4addr));
+			p2 = v4toi(p2, ':', &(v4addr));
 			ns.ns_daddrv4 = htonl(v4addr);
 			ns.ns_family = AF_INET;
-			p2 = v4toi(++p2, ':', &tmp);
+			p2 = v4toi(++p2, '/', &tmp);
 			ns.ns_dport = (__u16) tmp;
 			if (*p2)
 				p2 = v4toi(++p2, '\0', &ns.ns_pid);
 			ckrm_sock_forced_reclassify_ns(&ns, target);
-			break;
+			return 0;
 
 		case IPV6:
 			printk(KERN_INFO "rcfs: IPV6 not supported yet\n");

--
