Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266224AbUFUNd2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266224AbUFUNd2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 09:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266228AbUFUNd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 09:33:28 -0400
Received: from cantor.suse.de ([195.135.220.2]:51910 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266224AbUFUNd0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 09:33:26 -0400
Date: Mon, 21 Jun 2004 17:31:55 +0200
From: Andi Kleen <ak@suse.de>
To: Janos Farkas <jf-ml-k1-1087813225@lk8rp.mail.xeon.eu.org>
Cc: akpm@osdl.org, manfred@colorfullife.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7 shows K7 with Pentium Pro erratum [Re: New version of
 early CPU detect] II
Message-Id: <20040621173155.74982100.ak@suse.de>
In-Reply-To: <20040621120416.GA2722@noc.xeon.eu.org>
References: <20040423043001.4bb05d5f.ak@suse.de>
	<20040621120416.GA2722@noc.xeon.eu.org>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jun 2004 14:04:16 +0200
Janos Farkas <jf-ml-k1-1087813225@lk8rp.mail.xeon.eu.org> wrote:
[...]

Please ignore the previous patch I sent. This patch should actually fix it.

diff -u linux-2.6.7-work/arch/i386/kernel/cpu/common.c-o linux-2.6.7-work/arch/i386/kernel/cpu/common.c
--- linux-2.6.7-work/arch/i386/kernel/cpu/common.c-o	2004-06-16 12:22:43.000000000 +0200
+++ linux-2.6.7-work/arch/i386/kernel/cpu/common.c	2004-06-21 17:30:57.000000000 +0200
@@ -473,7 +473,6 @@
 
 void __init early_cpu_init(void)
 {
-	early_cpu_detect();
 	intel_cpu_init();
 	cyrix_init_cpu();
 	nsc_init_cpu();
@@ -483,6 +482,7 @@
 	rise_init_cpu();
 	nexgen_init_cpu();
 	umc_init_cpu();
+	early_cpu_detect();
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
 	/* pse is not compatible with on-the-fly unmapping,
