Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267614AbUHEJ7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267614AbUHEJ7b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 05:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267615AbUHEJ7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 05:59:31 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:7590 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S267614AbUHEJ72 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 05:59:28 -0400
Date: Thu, 5 Aug 2004 15:32:27 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org, ak@muc.de, akpm@osdl.org,
       suparna@in.ibm.com
Subject: [2/3] kprobes-netfilter-268-rc3.patch
Message-ID: <20040805100227.GB2303@in.ibm.com>
Reply-To: prasanna@in.ibm.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jq0ap7NbKX2Kqbes"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Below  is the [2/3] kprobes-netfilter-268-rc3.patch.
This patche includes changes to export the dump_packet routine.

Please see the description of individual patches for more details.

Thanks
Prasanna
-- 

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>

--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kprobes-netfilter-268-rc3.patch"


This patch exports the dump_packet kernel routine, useful for dumping
network packets.
---



---


diff -puN include/linux/netfilter_ipv4/ipt_LOG.h~kprobes-netfilter-268-rc3 include/linux/netfilter_ipv4/ipt_LOG.h
--- linux-2.6.8-rc3/include/linux/netfilter_ipv4/ipt_LOG.h~kprobes-netfilter-268-rc3	2004-08-06 04:39:40.815978448 -0700
+++ linux-2.6.8-rc3-root/include/linux/netfilter_ipv4/ipt_LOG.h	2004-08-06 04:39:40.826976776 -0700
@@ -11,5 +11,7 @@ struct ipt_log_info {
 	unsigned char logflags;
 	char prefix[30];
 };
+void dump_packet(const struct ipt_log_info *info, const struct sk_buff *skb,
+			unsigned int iphoff);
 
 #endif /*_IPT_LOG_H*/
diff -puN net/ipv4/netfilter/ipt_LOG.c~kprobes-netfilter-268-rc3 net/ipv4/netfilter/ipt_LOG.c
--- linux-2.6.8-rc3/net/ipv4/netfilter/ipt_LOG.c~kprobes-netfilter-268-rc3	2004-08-06 04:39:40.819977840 -0700
+++ linux-2.6.8-rc3-root/net/ipv4/netfilter/ipt_LOG.c	2004-08-06 04:39:40.827976624 -0700
@@ -41,7 +41,7 @@ MODULE_PARM_DESC(nflog, "register as int
 static spinlock_t log_lock = SPIN_LOCK_UNLOCKED;
 
 /* One level of recursion won't kill us */
-static void dump_packet(const struct ipt_log_info *info,
+void dump_packet(const struct ipt_log_info *info,
 			const struct sk_buff *skb,
 			unsigned int iphoff)
 {
@@ -461,5 +461,6 @@ static void __exit fini(void)
 	ipt_unregister_target(&ipt_log_reg);
 }
 
+EXPORT_SYMBOL_GPL(dump_packet);
 module_init(init);
 module_exit(fini);

_

--jq0ap7NbKX2Kqbes--
