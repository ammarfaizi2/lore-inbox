Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317557AbSFIFhF>; Sun, 9 Jun 2002 01:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317559AbSFIFhE>; Sun, 9 Jun 2002 01:37:04 -0400
Received: from newman.edw2.uc.edu ([129.137.2.198]:45330 "EHLO smtp.uc.edu")
	by vger.kernel.org with ESMTP id <S317557AbSFIFhD>;
	Sun, 9 Jun 2002 01:37:03 -0400
From: kuebelr@email.uc.edu
Date: Sun, 9 Jun 2002 01:36:57 -0400
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [TRIVIAL] ip_nat_core.c - fix compiler warning
Message-Id: <20020609053657.GA552@cartman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If netfilter is build w/o CONFIG_IP_NF_NAT_LOCAL, gcc will complain that
do_extra_mangle() is not used.  So only compile the function when
IP_NF_NAT_LOCAL is defined.  Patch is against 2.4.19-pre10.

Rob.

--- linux-clean/net/ipv4/netfilter/ip_nat_core.c	Fri Jun  7 23:42:15 2002
+++ linux-dirty/net/ipv4/netfilter/ip_nat_core.c	Sat Jun  8 12:12:46 2002
@@ -198,6 +198,7 @@
 		return NULL;
 }
 
+#ifdef CONFIG_IP_NF_NAT_LOCAL
 /* If it's really a local destination manip, it may need to do a
    source manip too. */
 static int
@@ -216,6 +217,7 @@
 	ip_rt_put(rt);
 	return 1;
 }
+#endif
 
 /* Simple way to iterate through all. */
 static inline int fake_cmp(const struct ip_nat_hash *i,
