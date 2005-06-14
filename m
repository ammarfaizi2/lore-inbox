Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261301AbVFNTPh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbVFNTPh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 15:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbVFNTPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 15:15:37 -0400
Received: from cms101.neoplus.adsl.tpnet.pl ([83.31.146.101]:64522 "EHLO
	cne142.neoplus.adsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S261301AbVFNTPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 15:15:25 -0400
Date: Tue, 14 Jun 2005 21:23:06 +0200
From: Jakub Bogusz <qboosh@pld-linux.org>
To: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH 2.4][SPARC64] fix sys32_utimes(somefile, NULL)
Message-ID: <20050614192306.GC13702@fngna.oyu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Black Hosts
X-Disclaimer: speaking only for myself
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes utimes(somefile, NULL) syscalls on sparc64 kernel with
32-bit userland - use of uninitialized value resulted in making random
timestamps, which confused e.g. sudo.
It has been already fixed (by davem) in linux-2.6 tree 30 months ago.

Signed-off-by: Jakub Bogusz <qboosh@pld-linux.org>

--- linux-2.4.31/arch/sparc64/kernel/sys_sparc32.c.orig	2005-06-06 14:55:31.000000000 +0200
+++ linux-2.4.31/arch/sparc64/kernel/sys_sparc32.c	2005-06-14 12:00:15.000000000 +0200
@@ -4267,7 +4267,7 @@
 
 		old_fs = get_fs();
 		set_fs(KERNEL_DS);
-		ret = sys_utimes(kfilename, &ktvs[0]);
+		ret = sys_utimes(kfilename, (tvs ? &ktvs[0] : NULL));
 		set_fs(old_fs);
 
 		putname(kfilename);


-- 
Jakub Bogusz    http://qboosh.cs.net.pl/
