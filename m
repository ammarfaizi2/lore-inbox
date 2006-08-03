Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030180AbWHCSc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030180AbWHCSc1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 14:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030181AbWHCSc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 14:32:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11481 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030180AbWHCSc0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 14:32:26 -0400
Date: Thu, 3 Aug 2006 14:32:24 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: don't taint UP K7's running SMP kernels.
Message-ID: <20060803183224.GA10797@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have a test that looks for invalid pairings of certain athlon/durons
that weren't designed for SMP, and taint accordingly (with 'S') if we find
such a configuration.  However, this test shouldn't fire if there's only
a single CPU present. It's perfectly valid for an SMP kernel to boot on UP
hardware for example.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6/arch/i386/kernel/smpboot.c~	2006-08-03 14:29:47.000000000 -0400
+++ linux-2.6/arch/i386/kernel/smpboot.c	2006-08-03 14:30:43.000000000 -0400
@@ -177,6 +177,9 @@ static void __devinit smp_store_cpu_info
 	 */
 	if ((c->x86_vendor == X86_VENDOR_AMD) && (c->x86 == 6)) {
 
+		if (num_online_cpus() == 1)
+			goto valid_k7;
+
 		/* Athlon 660/661 is valid. */	
 		if ((c->x86_model==6) && ((c->x86_mask==0) || (c->x86_mask==1)))
 			goto valid_k7;
-- 
http://www.codemonkey.org.uk
