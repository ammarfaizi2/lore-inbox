Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268420AbUHTRi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268420AbUHTRi7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 13:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268429AbUHTRi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 13:38:59 -0400
Received: from yacht.ocn.ne.jp ([222.146.40.168]:25547 "EHLO
	smtp.yacht.ocn.ne.jp") by vger.kernel.org with ESMTP
	id S268420AbUHTRiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 13:38:24 -0400
From: mita akinobu <amgta@yacht.ocn.ne.jp>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm3 (build failture w/ CONFIG_NUMA)
Date: Sat, 21 Aug 2004 02:38:32 +0900
User-Agent: KMail/1.5.4
References: <20040820031919.413d0a95.akpm@osdl.org>
In-Reply-To: <20040820031919.413d0a95.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408210238.32922.amgta@yacht.ocn.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had tried to compile with CONFIG_NUMA and got this error:

  CC      kernel/sched.o
kernel/sched.c: In function `sched_domain_node_span':
kernel/sched.c:4001: error: invalid lvalue in unary `&'
make[1]: *** [kernel/sched.o] Error 1
make: *** [kernel] Error 2

Below patch fixes this.


--- linux-2.6.8.1-mm3/kernel/sched.c.orig	2004-08-21 00:32:26.000000000 +0900
+++ linux-2.6.8.1-mm3/kernel/sched.c	2004-08-21 00:36:41.000000000 +0900
@@ -3998,7 +3998,10 @@ cpumask_t __init sched_domain_node_span(
 
 	for (i = 0; i < size; i++) {
 		int next_node = find_next_best_node(node, used_nodes);
-		cpus_or(span, span, node_to_cpumask(next_node));
+		cpumask_t  nodemask;
+
+		nodemask = node_to_cpumask(next_node);
+		cpus_or(span, span, nodemask);
 	}
 
 	return span;

