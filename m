Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261637AbUKSXbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbUKSXbc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 18:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbUKSXa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 18:30:28 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:16071 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S261652AbUKSX2T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 18:28:19 -0500
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
cc: linux-kernel@vger.kernel.org, Steven.Hand@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk, Keir.Fraser@cl.cam.ac.uk,
       Ian.Pratt@cl.cam.ac.uk
Subject: [7/7] Xen VMM patch set : handle fragemented skbs correctly in icmp_filter
In-reply-to: Your message of "Fri, 19 Nov 2004 23:16:33 GMT."
             <E1CVHzW-0004XC-00@mta1.cl.cam.ac.uk> 
Date: Fri, 19 Nov 2004 23:28:17 +0000
From: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Message-Id: <E1CVIAs-0004dp-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Simple bug fix to icmp_filter -- handle fragemented skbs correctly.

Signed-off-by: ian.pratt@cl.cam.ac.uk

---
diff -Nurp pristine-linux-2.6.10-rc2/net/ipv4/raw.c tmp-linux-2.6.10-rc2-xen.patch/net/ipv4/raw.c
--- pristine-linux-2.6.10-rc2/net/ipv4/raw.c	2004-11-15 01:27:42.000000000 +0000
+++ tmp-linux-2.6.10-rc2-xen.patch/net/ipv4/raw.c	2004-11-18 20:08:06.000000000 +0000
@@ -130,6 +130,9 @@ static __inline__ int icmp_filter(struct
 {
 	int type;
 
+	if (!pskb_may_pull(skb, sizeof(struct icmphdr)))
+		return 1;
+
 	type = skb->h.icmph->type;
 	if (type < 32) {
 		__u32 data = raw4_sk(sk)->filter.data;

