Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbWFLUW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbWFLUW2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 16:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbWFLUW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 16:22:28 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:16530 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932221AbWFLUW1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 16:22:27 -0400
Message-ID: <448DCA65.3030801@fr.ibm.com>
Date: Mon, 12 Jun 2006 22:11:17 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devel@openvz.org,
       xemul@openvz.org, "Eric W. Biederman" <ebiederm@xmission.com>,
       Herbert Poetzl <herbert@13thfloor.at>, saw@sw.ru,
       "Serge E. Hallyn" <serue@us.ibm.com>, sfrench@us.ibm.com,
       Sam Vilain <sam@vilain.net>, Dave Hansen <haveblue@us.ibm.com>
Subject: [PATCH 2.6.17-rc6-mm2] ipc namespace : unshare fix
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

small fix for unshare of ipc namespace

Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>

---
 kernel/fork.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: 2.6.17-rc6-mm2/kernel/fork.c
===================================================================
--- 2.6.17-rc6-mm2.orig/kernel/fork.c
+++ 2.6.17-rc6-mm2/kernel/fork.c
@@ -1599,7 +1599,8 @@ asmlinkage long sys_unshare(unsigned lon
 	/* Return -EINVAL for all unsupported flags */
 	err = -EINVAL;
 	if (unshare_flags & ~(CLONE_THREAD|CLONE_FS|CLONE_NEWNS|CLONE_SIGHAND|
-				CLONE_VM|CLONE_FILES|CLONE_SYSVSEM|CLONE_NEWUTS))
+				CLONE_VM|CLONE_FILES|CLONE_SYSVSEM|
+				CLONE_NEWUTS|CLONE_NEWIPC))
 		goto bad_unshare_out;

 	if ((err = unshare_thread(unshare_flags)))
