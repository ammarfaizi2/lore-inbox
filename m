Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbWBARzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbWBARzy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 12:55:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbWBARzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 12:55:54 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45972 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932398AbWBARzy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 12:55:54 -0500
Date: Wed, 1 Feb 2006 09:55:49 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] sysctl initialization of zone_reclaim_mode
Message-ID: <20060201095549.6fca4944@dxpl.pdx.osdl.net>
X-Mailer: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix warning about initialization of sysctl table in current 2.6.16-rc1
git tree. It could cause a nasty if anyone wrote to it.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

--- linux-2.6.orig/kernel/sysctl.c
+++ linux-2.6/kernel/sysctl.c
@@ -878,7 +878,8 @@ static ctl_table vm_table[] = {
 		.maxlen		= sizeof(zone_reclaim_mode),
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
-		.strategy	= &zero,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &zero,
 	},
 #endif
 	{ .ctl_name = 0 }
