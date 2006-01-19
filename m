Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161018AbWASSwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161018AbWASSwc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 13:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161258AbWASSwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 13:52:31 -0500
Received: from mummy.ncsc.mil ([144.51.88.129]:45798 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S1161018AbWASSwa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 13:52:30 -0500
Subject: [patch 1/1] selinux: change file_alloc_security to use GFP_KERNEL
From: Stephen Smalley <sds@tycho.nsa.gov>
To: lkml <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Thu, 19 Jan 2006 13:57:55 -0500
Message-Id: <1137697075.3648.52.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the SELinux file_alloc_security function to use
GFP_KERNEL rather than GFP_ATOMIC; the use of GFP_ATOMIC appears to be a
remnant of when this function was being called with the files_lock
spinlock held, and is no longer necessary.  Please apply.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>
Acked-by:  James Morris <jmorris@namei.org>

---

 security/selinux/hooks.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/security/selinux/hooks.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/hooks.c,v
retrieving revision 1.175
diff -u -p -r1.175 hooks.c
--- linux-2.6/security/selinux/hooks.c	3 Jan 2006 16:36:59 -0000	1.175
+++ linux-2.6/security/selinux/hooks.c	18 Jan 2006 18:27:18 -0000
@@ -191,7 +191,7 @@ static int file_alloc_security(struct fi
 	struct task_security_struct *tsec = current->security;
 	struct file_security_struct *fsec;
 
-	fsec = kzalloc(sizeof(struct file_security_struct), GFP_ATOMIC);
+	fsec = kzalloc(sizeof(struct file_security_struct), GFP_KERNEL);
 	if (!fsec)
 		return -ENOMEM;
 



-- 
Stephen Smalley
National Security Agency

