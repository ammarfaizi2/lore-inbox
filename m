Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbVBZCdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbVBZCdG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 21:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVBZCdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 21:33:06 -0500
Received: from fire.osdl.org ([65.172.181.4]:25814 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261173AbVBZCdD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 21:33:03 -0500
Date: Fri, 25 Feb 2005 18:32:53 -0800
From: Chris Wright <chrisw@osdl.org>
To: akpm@osdl.org
Cc: linux-audit@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] fix audit inode filter
Message-ID: <20050226023253.GG15867@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Audit inode filter drops high bits on inode number by cut 'n paste mistake.

Signed-off-by: Chris Wright <chrisw@osdl.org>

--- linus-2.6/kernel/auditsc.c~audit-inode-filter-fix	2005-02-24 16:55:32.000000000 -0800
+++ linus-2.6/kernel/auditsc.c	2005-02-25 18:23:15.000000000 -0800
@@ -358,7 +358,7 @@ static int audit_filter_rules(struct tas
 		case AUDIT_INODE:
 			if (ctx) {
 				for (j = 0; j < ctx->name_count; j++) {
-					if (MINOR(ctx->names[j].ino)==value) {
+					if (ctx->names[j].ino == value) {
 						++result;
 						break;
 					}
