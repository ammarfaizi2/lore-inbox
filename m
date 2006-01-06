Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbWAFKpp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbWAFKpp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 05:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbWAFKpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 05:45:44 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:13715 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932392AbWAFKpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 05:45:33 -0500
Subject: [patch 4/7] Mark some key VFS functions as __always_inline
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu
In-Reply-To: <1136543825.2940.8.camel@laptopd505.fenrus.org>
References: <1136543825.2940.8.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Fri, 06 Jan 2006 11:41:12 +0100
Message-Id: <1136544072.2940.17.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arjan van de Ven <arjan@infradead.org>

Mark a few VFS functions as mandatory inline (based on Al Viro's
request); these must be inline due to stack usage issues during a recursive loop
that happens during the recursive symlink resolution (symlink to a symlink to 
a symlink ..)
This patch at this point does not change behavior and is for documentation purposes
only (but this changes later in the series)


Signed-off-by: Arjan van de Ven <arjan@infradead.org>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 fs/namei.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

Index: linux-gcc.q/fs/namei.c
===================================================================
--- linux-gcc.q.orig/fs/namei.c
+++ linux-gcc.q/fs/namei.c
@@ -485,7 +485,7 @@ static struct dentry * real_lookup(struc
 static int __emul_lookup_dentry(const char *, struct nameidata *);
 
 /* SMP-safe */
-static inline int
+static __always_inline int
 walk_init_root(const char *name, struct nameidata *nd)
 {
 	read_lock(&current->fs->lock);
@@ -503,7 +503,7 @@ walk_init_root(const char *name, struct 
 	return 1;
 }
 
-static inline int __vfs_follow_link(struct nameidata *nd, const char *link)
+static __always_inline int __vfs_follow_link(struct nameidata *nd, const char *link)
 {
 	int res = 0;
 	char *name;
@@ -543,7 +543,7 @@ struct path {
 	struct dentry *dentry;
 };
 
-static inline int __do_follow_link(struct path *path, struct nameidata *nd)
+static __always_inline int __do_follow_link(struct path *path, struct nameidata *nd)
 {
 	int error;
 	void *cookie;
@@ -689,7 +689,7 @@ int follow_down(struct vfsmount **mnt, s
 	return 0;
 }
 
-static inline void follow_dotdot(struct nameidata *nd)
+static __always_inline void follow_dotdot(struct nameidata *nd)
 {
 	while(1) {
 		struct vfsmount *parent;


