Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbWDXWYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbWDXWYM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 18:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWDXWYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 18:24:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59315 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751185AbWDXWYL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 18:24:11 -0400
Date: Mon, 24 Apr 2006 17:52:39 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Avoid printing pointless tsc skew msgs.
Message-ID: <20060424215239.GA1178@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These messages are kinda silly..

CPU#0 had 0 usecs TSC skew, fixed it up.
CPU#1 had 0 usecs TSC skew, fixed it up.

inspired from: http://bugzilla.kernel.org/attachment.cgi?id=7713&action=view

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.16.noarch/arch/i386/kernel/smpboot.c~	2006-03-29 18:49:23.000000000 -0500
+++ linux-2.6.16.noarch/arch/i386/kernel/smpboot.c	2006-03-29 18:50:35.000000000 -0500
@@ -313,7 +313,8 @@ static void __init synchronize_tsc_bp (v
 			if (tsc_values[i] < avg)
 				realdelta = -realdelta;
 
-			printk(KERN_INFO "CPU#%d had %ld usecs TSC skew, fixed it up.\n", i, realdelta);
+			if (realdelta > 0)
+				printk(KERN_INFO "CPU#%d had %ld usecs TSC skew, fixed it up.\n", i, realdelta);
 		}
 
 		sum += delta;
