Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbWDXOIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbWDXOIR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 10:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWDXOIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 10:08:17 -0400
Received: from moci.net4u.de ([217.7.64.195]:24249 "EHLO moci.net4u.de")
	by vger.kernel.org with ESMTP id S1750834AbWDXOIQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 10:08:16 -0400
From: Ernst Herzberg <list-lkml@net4u.de>
Reply-To: earny@net4u.de
Organization: Net4U
To: linux-kernel@vger.kernel.org
Subject: 2.6.16.9 alpha compile error
Date: Mon, 24 Apr 2006 16:08:13 +0200
User-Agent: KMail/1.8.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604241608.13153.list-lkml@net4u.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


arch/alpha/kernel/setup.c: In function `register_cpus':
arch/alpha/kernel/setup.c:486: warning: implicit declaration of function `for_each_possible_cpu'
arch/alpha/kernel/setup.c:486: error: syntax error before '{' token
arch/alpha/kernel/setup.c:488: error: `p' undeclared (first use in this function)
arch/alpha/kernel/setup.c:488: error: (Each undeclared identifier is reported only once
arch/alpha/kernel/setup.c:488: error: for each function it appears in.)
arch/alpha/kernel/setup.c: At top level:
arch/alpha/kernel/setup.c:492: error: syntax error before "return"

This q&d patch fixes it for me:

--

--- lx-2.6.16.9.vanilla/arch/alpha/kernel/setup.c	2006-04-24 15:56:23.000000000 +0200
+++ lx-2.6.16.9/arch/alpha/kernel/setup.c	2006-04-24 15:36:50.000000000 +0200
@@ -483,7 +483,8 @@ register_cpus(void)
 {
 	int i;
 
-	for_each_possible_cpu(i) {
+	for (i = 0; i < NR_CPUS; i++) 
+		if (cpu_possible(i)) {
 		struct cpu *p = kzalloc(sizeof(*p), GFP_KERNEL);
 		if (!p)
 			return -ENOMEM;


--
