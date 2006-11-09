Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161787AbWKICCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161787AbWKICCK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 21:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161786AbWKICCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 21:02:10 -0500
Received: from mga09.intel.com ([134.134.136.24]:31070 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1161783AbWKICCI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 21:02:08 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,402,1157353200"; 
   d="scan'208"; a="158549831:sNHT21529501"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Andrew Morton'" <akpm@osdl.org>, "'Jeff Garzik'" <jgarzik@pobox.com>,
       <davem@davemloft.net>
Cc: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       "'NetDev'" <netdev@vger.kernel.org>
Subject: [patch] fix up generic csum_ipv6_magic function prototype
Date: Wed, 8 Nov 2006 18:02:06 -0800
Message-ID: <000301c703a3$0eedb340$ff0da8c0@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AccDow6y1r0LHc4gTi+GTodCK3/rsQ==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The generic version of csum_ipv6_magic has the len argument declared as
__u16, while most arch dependent version declare it as __u32.  After
looking at the call site of this function, I come up to a conclusion
that __u32 is a better match with the actual usage.

Hence, patch to change argument type for greater consistency.


Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>


---

asm-m32r and asm-parisc both have it declared as __u16. I think it is a
copy-n-paste error and needs to be fixed by arch maintainer, I hope.



--- ./include/net/ip6_checksum.h.orig	2006-11-08 18:49:50.000000000 -0800
+++ ./include/net/ip6_checksum.h	2006-11-08 18:50:04.000000000 -0800
@@ -36,7 +36,7 @@
 
 static __inline__ unsigned short int csum_ipv6_magic(struct in6_addr *saddr,
 						     struct in6_addr *daddr,
-						     __u16 len,
+						     __u32 len,
 						     unsigned short proto,
 						     unsigned int csum) 
 {

