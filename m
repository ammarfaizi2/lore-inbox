Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932520AbVHKW5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520AbVHKW5A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 18:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbVHKW5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 18:57:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16515 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932459AbVHKW47 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 18:56:59 -0400
Message-Id: <20050811225556.869832000@localhost.localdomain>
References: <20050811225445.404816000@localhost.localdomain>
Date: Thu, 11 Aug 2005 15:54:47 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, discuss@x86-64.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Andi Kleen <ak@suse.de>,
       Chris Wright <chrisw@osdl.org>
Subject: [patch 2/8] [PATCH] Fix SRAT for non dual core AMD systems
Content-Disposition: inline; filename=x86_64-srat-dual-core-amd.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any  objections, please let us know.
------------------


This fixes a bug in SRAT handling on AMD systems that was introduced
with the dual core support. It would be disabled on CPUs without dual core.
Just drop the bogus check.

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Chris Wright <chrisw@osdl.org>

Index: linux-2.6.12/arch/x86_64/kernel/setup.c
===================================================================
--- linux-2.6.12.orig/arch/x86_64/kernel/setup.c
+++ linux-2.6.12/arch/x86_64/kernel/setup.c
@@ -729,8 +729,6 @@ static void __init amd_detect_cmp(struct
 	int cpu = smp_processor_id();
 	int node = 0;
 	unsigned bits;
-	if (c->x86_num_cores == 1)
-		return;
 
 	bits = 0;
 	while ((1 << bits) < c->x86_num_cores)

--
