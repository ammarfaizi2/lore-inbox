Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbULACUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbULACUg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 21:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbULACUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 21:20:35 -0500
Received: from ozlabs.org ([203.10.76.45]:32161 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261169AbULACTE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 21:19:04 -0500
Date: Wed, 1 Dec 2004 13:14:07 +1100
From: Anton Blanchard <anton@samba.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH] Allow multiple cpus in irq affinity call
Message-ID: <20041201021407.GE17540@krispykreme.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

The generic irq affinity code limits us to a single cpu target regardless
of what the architecture supports. If required this should be done in
the architecture specific ->set_affinity call.

With this patch ppc64 is able to select all cpus affinity again.

Anton

Signed-off-by: Anton Blanchard <anton@samba.org>

diff -puN kernel/irq/proc.c~debug_gqirm kernel/irq/proc.c
--- gr_work/kernel/irq/proc.c~debug_gqirm	2004-11-30 19:57:04.584233473 -0600
+++ gr_work-anton/kernel/irq/proc.c	2004-11-30 19:57:13.149208938 -0600
@@ -56,8 +56,7 @@ static int irq_affinity_write_proc(struc
 		return -EINVAL;
 
 	irq_affinity[irq] = new_value;
-	irq_desc[irq].handler->set_affinity(irq,
-					cpumask_of_cpu(first_cpu(new_value)));
+	irq_desc[irq].handler->set_affinity(irq, new_value);
 
 	return full_count;
 }
_
