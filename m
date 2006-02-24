Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbWBXBmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbWBXBmh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 20:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWBXBmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 20:42:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:3544 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932377AbWBXBmg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 20:42:36 -0500
Date: Thu, 23 Feb 2006 20:42:28 -0500
From: Dave Jones <davej@redhat.com>
To: ak@suse.de
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Suppress APIC errors on UP x86-64.
Message-ID: <20060224014228.GB16089@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, ak@suse.de,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quite a few UP x86-64 laptops print APIC error 40's repeatedly
when they run an SMP kernel (And Fedora doesn't ship a UP x86-64 kernel
any more).  We can suppress this as there's not really anything we
can do about them.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.14/arch/x86_64/kernel/apic.c~	2005-12-07 15:17:33.000000000 -0500
+++ linux-2.6.14/arch/x86_64/kernel/apic.c	2005-12-07 15:18:16.000000000 -0500
@@ -1032,7 +1032,8 @@ asmlinkage void smp_error_interrupt(void
 	   6: Received illegal vector
 	   7: Illegal register address
 	*/
-	printk (KERN_DEBUG "APIC error on CPU%d: %02x(%02x)\n",
+	if (num_online_cpus() > 1)
+		printk (KERN_DEBUG "APIC error on CPU%d: %02x(%02x)\n",
 	        smp_processor_id(), v , v1);
 	irq_exit();
 }
