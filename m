Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268838AbUIXPh6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268838AbUIXPh6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 11:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268844AbUIXPh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 11:37:58 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:56448 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268838AbUIXPhw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 11:37:52 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: torvalds@osdl.org
Subject: [PATCH] disable sched domains debug for 2.6.9
Date: Fri, 24 Sep 2004 11:37:31 -0400
User-Agent: KMail/1.7
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
References: <200409241058.41279.jbarnes@engr.sgi.com> <41543A10.504@yahoo.com.au>
In-Reply-To: <41543A10.504@yahoo.com.au>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_78DVBH2j/5xvZvQ"
Message-Id: <200409241137.31526.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_78DVBH2j/5xvZvQ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Linus, can you please apply this to the BK tree prior to 2.6.9?  Nick's 
already ok'd it.

This patch disables the sched domains debug code, which has a tendency to 
print out a *lot* of information.  It's helpful for debugging, but a bit 
overboard for general use.  Also, if you have a high NR_CPUS value, it tends 
to scare people and overflow the dmesg buffer.

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>
Signed-off-by: Jesse Barnes <jbarnes@sgi.com>

Thanks,
Jesse



--Boundary-00=_78DVBH2j/5xvZvQ
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="no-sched-domain-debug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="no-sched-domain-debug.patch"

===== kernel/sched.c 1.350 vs edited =====
--- 1.350/kernel/sched.c	2004-09-13 17:23:11 -07:00
+++ edited/kernel/sched.c	2004-09-24 07:56:00 -07:00
@@ -4577,7 +4577,7 @@
 	}
 }
 
-#define SCHED_DOMAIN_DEBUG
+#undef SCHED_DOMAIN_DEBUG
 #ifdef SCHED_DOMAIN_DEBUG
 void sched_domain_debug(void)
 {

--Boundary-00=_78DVBH2j/5xvZvQ--
