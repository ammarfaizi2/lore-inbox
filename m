Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272308AbTHDWam (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 18:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272309AbTHDWam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 18:30:42 -0400
Received: from rj.sgi.com ([192.82.208.96]:34528 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S272308AbTHDWak (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 18:30:40 -0400
Date: Mon, 4 Aug 2003 15:30:38 -0700
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make lookup_create non-static
Message-ID: <20030804223037.GA2214@sgi.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20030804213543.GA1697@sgi.com> <20030804144129.3dfe4aac.akpm@osdl.org> <20030804214412.GA1788@sgi.com> <20030804145723.533e77f7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030804145723.533e77f7.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 04, 2003 at 02:57:23PM -0700, Andrew Morton wrote:
> jbarnes@sgi.com (Jesse Barnes) wrote:
> >
> > You mean copy lookup_create into hwgfs (which is already in the tree,
> >  btw)?  Yeah, I guess I could do that if you don't want to take this.
> 
> ah, I thought you were referring to an out-of-tree filesystem.
> 
> It would appear that intermezzo has already created a private copy of
> lookup_create().  Sigh.
> 
> If we're going to export this thing to filesystems then it really should be
> documented a bit.  You could bribe me with a patch which does that ;)

Ok, how does this look?

Jesse


===== fs/namei.c 1.81 vs edited =====
--- 1.81/fs/namei.c	Thu Jul 10 22:23:45 2003
+++ edited/fs/namei.c	Mon Aug  4 15:28:38 2003
@@ -1375,8 +1375,15 @@
 	goto do_last;
 }
 
-/* SMP-safe */
-static struct dentry *lookup_create(struct nameidata *nd, int is_dir)
+/**
+ * lookup_create - lookup a dentry, creating it if it doesn't exist
+ * @nd: nameidata info
+ * @is_dir: directory flag
+ *
+ * Simple function to lookup and return a dentry and create it
+ * if it doesn't exist.  Is SMP-safe.
+ */
+struct dentry *lookup_create(struct nameidata *nd, int is_dir)
 {
 	struct dentry *dentry;
 
