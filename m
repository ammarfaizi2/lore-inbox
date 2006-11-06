Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752129AbWKFSr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129AbWKFSr0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 13:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752028AbWKFSr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 13:47:26 -0500
Received: from mx1.redhat.com ([66.187.233.31]:23954 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752026AbWKFSrY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 13:47:24 -0500
Subject: Re: [PATCH] make last_inode counter in new_inode 32-bit on kernels
	that offer x86 compatability
From: Jeff Layton <jlayton@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061106182222.GO27140@parisc-linux.org>
References: <1162836725.6952.28.camel@dantu.rdu.redhat.com>
	 <20061106182222.GO27140@parisc-linux.org>
Content-Type: text/plain
Date: Mon, 06 Nov 2006 13:47:23 -0500
Message-Id: <1162838843.12129.8.camel@dantu.rdu.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-06 at 11:22 -0700, Matthew Wilcox wrote:
> On Mon, Nov 06, 2006 at 01:12:05PM -0500, Jeff Layton wrote:
> > The attached patch remedies this by making the last_inode counter be an
> > unsigned int on kernels that have ia32 compatability mode enabled.
> 
> ... and this only happens on ia64/x86_64 kernels, not sparc64, ppc64,
> s390x, parisc64 or mips64?

Here's a new (untested) patch that replaces the ia32 specific
compatability mode defines with CONFIG_COMPAT, as suggested by Matthew.

Signed-off-by: Jeff Layton <jlayton@redhat.com>

--- linux-2.6/fs/inode.c.lastino
+++ linux-2.6/fs/inode.c
@@ -524,7 +524,11 @@ repeat:
  */
 struct inode *new_inode(struct super_block *sb)
 {
+#ifdef CONFIG_COMPAT
+	static unsigned int last_ino;
+#else
 	static unsigned long last_ino;
+#endif
 	struct inode * inode;
 
 	spin_lock_prefetch(&inode_lock);


