Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261636AbVDZQXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261636AbVDZQXu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 12:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbVDZQVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 12:21:12 -0400
Received: from mailfe10.tele2.se ([212.247.155.33]:61423 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261677AbVDZQTU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 12:19:20 -0400
X-T2-Posting-ID: k1c2aGMK8Lj9Cnpb+Eju4eOhqUzXuhsckJNC9B9P7R8=
Date: Tue, 26 Apr 2005 18:22:03 +0200
From: Frederik Deweerdt <frederik.deweerdt@laposte.net>
To: prasanna@in.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Don't oops when unregistering unknown kprobes
Message-ID: <20050426162203.GE27406@gilgamesh.home.res>
Mail-Followup-To: prasanna@in.ibm.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Prasanna,

Here's a patch that handles gracefully attempts to unregister
unregistered kprobes (ie. a warning message instead of an oops).
Patch is against 2.6.12-rc3

Signed-off-by: Frederik Deweerdt <frederik.deweerdt@laposte.net>

Regards,
Frederik

-- 
o----------------------------------------------o
| http://open-news.net : l'info alternative    |
| Tech - Sciences - Politique - International  |
o----------------------------------------------o

--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dont.oops.on.unregister.unknown.kprobe.patch"

--- linux-2.6.12-rc3/kernel/kprobes.c	2005-04-26 16:35:22.000000000 +0200
+++ linux-2.6.12-rc3-devel/kernel/kprobes.c	2005-04-26 16:44:57.000000000 +0200
@@ -107,6 +107,13 @@ rm_kprobe:
 void unregister_kprobe(struct kprobe *p)
 {
 	unsigned long flags;
+
+	if (!get_kprobe(p)) {
+		printk(KERN_WARNING "Warning: Attempt to unregister "
+					"unknown kprobe (addr:0x%lx)\n",
+					(unsigned long) p);
+		return;
+	}
 	arch_remove_kprobe(p);
 	spin_lock_irqsave(&kprobe_lock, flags);
 	*p->addr = p->opcode;

--ZPt4rx8FFjLCG7dd--
