Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263037AbUDTOXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263037AbUDTOXR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 10:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263006AbUDTOXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 10:23:17 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:29455 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S263037AbUDTOXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 10:23:13 -0400
Date: Tue, 20 Apr 2004 22:27:14 +0800 (WST)
From: raven@themaw.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc1-mm1
In-Reply-To: <20040418230131.285aa8ae.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0404202225070.18286@donald.themaw.net>
References: <20040418230131.285aa8ae.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-0.7, required 8,
	IN_REP_TO, NO_REAL_NAME, PATCH_UNIFIED_DIFF, REFERENCES,
	USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Looking at the autofs4_may_umount I think I take the vfsmount_lock to 
late.

--- linux-2.6.6-rc1-mm1.orig/fs/autofs4/expire.c	2004-04-20 22:08:39.000000000 +0800
+++ linux-2.6.6-rc1-mm1/fs/autofs4/expire.c	2004-04-20 22:20:06.000000000 +0800
@@ -53,10 +53,9 @@
 	int actual_refs;
 	int minimum_refs;
 
+	spin_lock(&vfsmount_lock);
 	actual_refs = atomic_read(&mnt->mnt_count);
 	minimum_refs = 2;
-
-	spin_lock(&vfsmount_lock);
 repeat:
 	next = this_parent->mnt_mounts.next;
 resume:

 

