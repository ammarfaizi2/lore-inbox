Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751244AbWEQWTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbWEQWTJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 18:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWEQWSC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 18:18:02 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:643 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751250AbWEQWMJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 18:12:09 -0400
Message-Id: <20060517221404.951814000@sous-sol.org>
References: <20060517221312.227391000@sous-sol.org>
Date: Wed, 17 May 2006 00:00:11 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       "Serge E. Hallyn" <serue@us.ibm.com>, James Morris <jmorris@namei.org>,
       Stephen Smalley <sds@tycho.nsa.gov>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 11/22] [PATCH] selinux: check for failed kmalloc in security_sid_to_context()
Content-Disposition: inline; filename=selinux-check-for-failed-kmalloc-in-security_sid_to_context.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Check for NULL kmalloc return value before writing to it.

Signed-off-by: "Serge E. Hallyn" <serue@us.ibm.com>
Acked-by: James Morris <jmorris@namei.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 security/selinux/ss/services.c |    4 ++++
 1 file changed, 4 insertions(+)

--- linux-2.6.16.16.orig/security/selinux/ss/services.c
+++ linux-2.6.16.16/security/selinux/ss/services.c
@@ -592,6 +592,10 @@ int security_sid_to_context(u32 sid, cha
 
 			*scontext_len = strlen(initial_sid_to_string[sid]) + 1;
 			scontextp = kmalloc(*scontext_len,GFP_ATOMIC);
+			if (!scontextp) {
+				rc = -ENOMEM;
+				goto out;
+			}
 			strcpy(scontextp, initial_sid_to_string[sid]);
 			*scontext = scontextp;
 			goto out;

--
