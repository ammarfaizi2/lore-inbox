Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261307AbVD0J3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbVD0J3E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 05:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbVD0J3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 05:29:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1702 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261307AbVD0J25 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 05:28:57 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0504260737040.18901@ppc970.osdl.org> 
References: <Pine.LNX.4.58.0504260737040.18901@ppc970.osdl.org>  <20050417033806.65a5786a.sfr@canb.auug.org.au> <26687.1113576302@redhat.com> <4872.1114506372@redhat.com> 
To: Linus Torvalds <torvalds@osdl.org>
Cc: akpm@osdl.org, Stephen Rothwell <sfr@canb.auug.org.au>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] NFS4: Don't use __user with compat_uptr_t 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Wed, 27 Apr 2005 10:28:32 +0100
Message-ID: <27018.1114594112@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch removes __user from compat_uptr_t types in the NFS4 mount
32-bit->64-bit compatibility structures.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 nfs4-compat-2612rc3.diff 
 fs/compat.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -uNrp linux-2.6.12-rc3/fs/compat.c linux-2.6.12-rc3-nfs4compat/fs/compat.c
--- linux-2.6.12-rc3/fs/compat.c	2005-04-27 10:21:13.660310933 +0100
+++ linux-2.6.12-rc3-nfs4compat/fs/compat.c	2005-04-27 10:24:09.176911721 +0100
@@ -809,7 +809,7 @@ static void *do_smb_super_data_conv(void
 
 struct compat_nfs_string {
 	compat_uint_t len;
-	compat_uptr_t __user data;
+	compat_uptr_t data;
 };
 
 static inline void compat_nfs_string(struct nfs_string *dst,
@@ -834,10 +834,10 @@ struct compat_nfs4_mount_data_v1 {
 	struct compat_nfs_string mnt_path;
 	struct compat_nfs_string hostname;
 	compat_uint_t host_addrlen;
-	compat_uptr_t __user host_addr;
+	compat_uptr_t host_addr;
 	compat_int_t proto;
 	compat_int_t auth_flavourlen;
-	compat_uptr_t __user auth_flavours;
+	compat_uptr_t auth_flavours;
 };
 
 static int do_nfs4_super_data_conv(void *raw_data)
