Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbUDAPDS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 10:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262453AbUDAPDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 10:03:18 -0500
Received: from [144.51.25.10] ([144.51.25.10]:20218 "EHLO epoch.ncsc.mil")
	by vger.kernel.org with ESMTP id S262427AbUDAPDR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 10:03:17 -0500
Subject: [PATCH][SELINUX] Fix struct type
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       Chad Hanson <chanson@tcs-sec.com>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1080831765.25431.59.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 01 Apr 2004 10:02:45 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.6.5-rc3 (also applies to 2.6.5-rc3-mm4) fixes the
type of the ssec pointer in the sk_free_security function.  This has no
current impact as the magic element is the top of each structure. Thanks
to Chad Hanson of TCS for discovering the bug and submitting the patch. 

Index: linux-2.6/security/selinux/hooks.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/hooks.c,v
retrieving revision 1.103
diff -u -r1.103 hooks.c
--- linux-2.6/security/selinux/hooks.c	25 Mar 2004 17:07:07 -0000	1.103
+++ linux-2.6/security/selinux/hooks.c	31 Mar 2004 19:32:05 -0000
@@ -271,7 +271,7 @@
 
 static void sk_free_security(struct sock *sk)
 {
-	struct task_security_struct *ssec = sk->sk_security;
+	struct sk_security_struct *ssec = sk->sk_security;
 
 	if (sk->sk_family != PF_UNIX || ssec->magic != SELINUX_MAGIC)
 		return;

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

