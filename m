Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264713AbRFZMdz>; Tue, 26 Jun 2001 08:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264714AbRFZMdp>; Tue, 26 Jun 2001 08:33:45 -0400
Received: from wildsau.idv-edu.uni-linz.ac.at ([140.78.40.25]:39180 "EHLO
	wildsau.idv-edu.uni-linz.ac.at") by vger.kernel.org with ESMTP
	id <S264713AbRFZMdc>; Tue, 26 Jun 2001 08:33:32 -0400
From: Herbert Rosmanith <herp@wildsau.idv-edu.uni-linz.ac.at>
Message-Id: <200106261232.f5QCWJ022221@wildsau.idv-edu.uni-linz.ac.at>
Subject: patch: af_netlink rmmod problem
To: alan@redhat.com, kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Date: Tue, 26 Jun 2001 14:32:19 +0200 (MET DST)
Cc: herp@wildsau.idv-edu.uni-linz.ac.at (Herbert Rosmanith),
        kernel@wildsau.idv-edu.uni-linz.ac.at (Kernel Mailing List)
X-Mailer: ELM [version 2.4ME+ PL37 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hello,

when doing a series of insmod/rmmod of af_netlink, I noticed
/proc/net/netlink entries being added each time.

this small patch addresses the problem:

--- snip ---
bash-2.03# diff -u linux-2.4.5.orig/net/netlink/af_netlink.c linux-2.4.5.new/net/netlink/af_netlink.c
--- linux-2.4.5.orig/net/netlink/af_netlink.c   Thu Apr 12 21:11:39 2001
+++ linux-2.4.5.new/net/netlink/af_netlink.c    Tue Jun 26 14:41:25 2001
@@ -9,6 +9,9 @@
  *             as published by the Free Software Foundation; either version
  *             2 of the License, or (at your option) any later version.
  * 
+ * Tue Jun 26 14:36:48 MEST 2001 Herbert "herp" Rosmanith
+ *                               added netlink_proto_exit
+ *
  */
 
 #include <linux/config.h>
@@ -985,4 +988,11 @@
        return 0;
 }
 
+static void __exit netlink_proto_exit(void)
+{
+       sock_unregister(PF_NETLINK);
+       remove_proc_entry("net/netlink", NULL);
+}
+
 module_init(netlink_proto_init);
+module_exit(netlink_proto_exit);
--- snip ---

thanks,
h.rosmanith
herp@wildsau.idv.uni-linz.ac.at

