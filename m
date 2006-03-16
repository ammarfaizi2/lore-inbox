Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbWCPDyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbWCPDyf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 22:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932615AbWCPDyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 22:54:35 -0500
Received: from fmr19.intel.com ([134.134.136.18]:47043 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S932352AbWCPDyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 22:54:35 -0500
Subject: [PATCH]swsusp: drain high mem pages
From: Shaohua Li <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 16 Mar 2006 11:53:22 +0800
Message-Id: <1142481202.26706.15.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Highmem could be in pcp list as well.

Signed-off-by: Shaohua Li<shaohua.li@intel.com>
---

 linux-2.6.15-root/kernel/power/snapshot.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN kernel/power/snapshot.c~drain_highmem kernel/power/snapshot.c
--- linux-2.6.15/kernel/power/snapshot.c~drain_highmem	2006-03-14 13:38:16.000000000 +0800
+++ linux-2.6.15-root/kernel/power/snapshot.c	2006-03-14 14:13:30.000000000 +0800
@@ -120,6 +120,7 @@ int save_highmem(void)
 	int res = 0;
 
 	pr_debug("swsusp: Saving Highmem\n");
+	drain_local_pages();
 	for_each_zone (zone) {
 		if (is_highmem(zone))
 			res = save_highmem_zone(zone);
_


