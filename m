Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264575AbTLWA0g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 19:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264583AbTLWA0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 19:26:36 -0500
Received: from dp.samba.org ([66.70.73.150]:27612 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264575AbTLWA0f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 19:26:35 -0500
Date: Tue, 23 Dec 2003 11:22:17 +1100
From: Anton Blanchard <anton@samba.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] seq_file version of /proc/interrupts
Message-ID: <20031223002217.GC934@krispykreme>
References: <20031113193512.GH24159@parcelfarce.linux.theplanet.co.uk> <20031113213927.27114.qmail@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031113213927.27114.qmail@lwn.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Jon,

> Here, anyway, is a better version of the patch.  It's less intrusive,
> forgoes some "cleanups" I indulged in the first time, and makes it easier
> to update other architectures.  I did x86-64, ia_64 and ppc64 just for the
> heck of it, but I can't test them.

We finally got around to testing it on ppc64. Looks good, only one problem:

diff -urN -X dontdiff test9-vanilla/arch/ppc64/kernel/irq.c test9/arch/ppc64/kernel/irq.c
--- test9-vanilla/arch/ppc64/kernel/irq.c	Tue Oct 21 04:40:13 2003
+++ test9/arch/ppc64/kernel/irq.c	Fri Nov 14 05:10:02 2003
@@ -323,18 +323,20 @@
 
 int show_interrupts(struct seq_file *p, void *v)
 {
-	int i, j;
+	int i = *(int *) v, j;
 	struct irqaction * action;
 	unsigned long flags;

That int * has to be a loff_t * or bad things will happen on a 64bit big
endian platform :)

Be nice to chuck this into -mm for some more testing.

Anton
