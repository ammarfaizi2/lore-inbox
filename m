Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270002AbUJHOwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270002AbUJHOwy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 10:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270005AbUJHOwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 10:52:54 -0400
Received: from lehre.fh-hagenberg.at ([193.170.124.119]:44940 "EHLO
	postfix.fhs-hagenberg.ac.at") by vger.kernel.org with ESMTP
	id S270002AbUJHOwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 10:52:50 -0400
Date: Fri, 8 Oct 2004 16:55:56 +0200
From: Clemens Buchacher <drizzd@aon.at>
To: "David S. Miller" <davem@davemloft.net>
Cc: "Keith M. Wesolowsi" <wesolows@foobazco.org>, linux-kernel@vger.kernel.org,
       sparclinux@vger.kernel.org
Subject: [patch] [SPARC]: Fix warning for changed section attributes
Message-ID: <20041008145556.GA11450@kzelldran.lan>
Mail-Followup-To: "David S. Miller" <davem@davemloft.net>,
	"Keith M. Wesolowsi" <wesolows@foobazco.org>,
	linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
X-OriginalArrivalTime: 08 Oct 2004 14:52:49.0052 (UTC) FILETIME=[7AAA65C0:01C4AD46]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the "Ignoring changed section attributes" warning by commenting out
the attributes appended by gcc.

The previous 'fix' created a section '.text,#alloc' (literally), which I guess
was not intended.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

Runtime tested (Leon2 TSIM SPARC simulation)

 arch/sparc/kernel/init_task.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- a/arch/sparc/kernel/init_task.c	2004-10-06 20:19:25 +02:00
+++ b/arch/sparc/kernel/init_task.c	2004-10-06 20:19:25 +02:00
@@ -23,6 +23,6 @@
  * in etrap.S which assumes it.
  */
 union thread_union init_thread_union
-	__attribute__((section (".text,#alloc")))
+	__attribute__((section (".text\"\n\t#")))
 	__attribute__((aligned (THREAD_SIZE)))
 	= { INIT_THREAD_INFO(init_task) };
