Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262864AbUDTPgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262864AbUDTPgc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 11:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263141AbUDTPgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 11:36:32 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:63396 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S262864AbUDTPg3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 11:36:29 -0400
Subject: [PATCH][SELINUX] Remove hardcoded policy assumption from
	get_user_sids logic
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>, selinux@tycho.nsa.gov
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1082475370.7481.63.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 20 Apr 2004 11:36:10 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.6.6-rc1-mm1 removes a hardcoded policy assumption
from the get_user_sids logic in the SELinux module that was preventing
it from returning contexts that had the same type as the caller even if
the policy allowed such a transition.  The assumption is not valid for
all policies, and can be handled via policy configuration and userspace
rather than hardcoding it in the module logic.

 security/selinux/ss/services.c |    2 --
 1 files changed, 2 deletions(-)

diff -X /home/sds/dontdiff -ru linux-2.6.old/security/selinux/ss/services.c linux-2.6/security/selinux/ss/services.c
--- linux-2.6.old/security/selinux/ss/services.c	2004-04-20 10:11:03.000000000 -0400
+++ linux-2.6/security/selinux/ss/services.c	2004-04-20 10:48:30.772189123 -0400
@@ -1341,8 +1341,6 @@
 			if (!ebitmap_get_bit(&role->types, j))
 				continue;
 			usercon.type = j+1;
-			if (usercon.type == fromcon->type)
-				continue;
 			mls_for_user_ranges(user,usercon) {
 				rc = context_struct_compute_av(fromcon, &usercon,
 							       SECCLASS_PROCESS,


-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

