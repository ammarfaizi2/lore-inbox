Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932478AbWGYFxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbWGYFxZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 01:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbWGYFxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 01:53:25 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:1984 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932478AbWGYFxY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 01:53:24 -0400
Subject: Re: [NFS] [PATCH 002 of 9] knfsd: knfsd: Remove an unused
	variable	from e_show().
From: Greg Banks <gnb@melbourne.sgi.com>
To: Neil Brown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux NFS Mailing List <nfs@lists.sourceforge.net>,
       Josef Sipek <jsipek@fsl.cs.sunysb.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1153801950.1547.657.camel@hole.melbourne.sgi.com>
References: <20060725114207.21779.patches@notabene>
	 <1060725015432.21921@suse.de>
	 <20060725041059.GA13294@filer.fsl.cs.sunysb.edu>
	 <17605.39934.963857.665398@cse.unsw.edu.au>
	 <1153801950.1547.657.camel@hole.melbourne.sgi.com>
Content-Type: text/plain
Organization: Silicon Graphics Inc, Australian Software Group.
Message-Id: <1153806790.21040.45.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 25 Jul 2006 15:53:11 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-25 at 14:32, Greg Banks wrote:
> On Tue, 2006-07-25 at 14:20, Neil Brown wrote:
> > On Tuesday July 25, jsipek@fsl.cs.sunysb.edu wrote:
> > > On Tue, Jul 25, 2006 at 11:54:32AM +1000, NeilBrown wrote:
> > > ...
> > 
> > Probably.  We just need a pointer value that is definitely not a
> > pointer to a valid cache_head object, and is not NULL.
> > (void*)1 seems a reasonable choice, but maybe #defineing something
> > would help.
> > 
> > Patches welcome.
> 
> This trivial patch compiles.

But only applies to sles10 <sigh>.  Here's the version
which applies to today's GIT.
--

knfsd: Use SEQ_START_TOKEN instead of hardcoded magic (void*)1.

Signed-off-by: Greg Banks <gnb@melbourne.sgi.com>
---

 fs/nfsd/export.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

Index: linus-git/fs/nfsd/export.c
===================================================================
--- linus-git.orig/fs/nfsd/export.c	2006-07-25 14:55:28.000000000 +1000
+++ linus-git/fs/nfsd/export.c	2006-07-25 15:40:03.987257265 +1000
@@ -1086,7 +1086,7 @@ static void *e_start(struct seq_file *m,
 	exp_readlock();
 	read_lock(&svc_export_cache.hash_lock);
 	if (!n--)
-		return (void *)1;
+		return SEQ_START_TOKEN;
 	hash = n >> 32;
 	export = n & ((1LL<<32) - 1);
 
@@ -1110,7 +1110,7 @@ static void *e_next(struct seq_file *m, 
 	struct cache_head *ch = p;
 	int hash = (*pos >> 32);
 
-	if (p == (void *)1)
+	if (p == SEQ_START_TOKEN)
 		hash = 0;
 	else if (ch->next == NULL) {
 		hash++;
@@ -1179,7 +1179,7 @@ static int e_show(struct seq_file *m, vo
 	struct cache_head *cp = p;
 	struct svc_export *exp = container_of(cp, struct svc_export, h);
 
-	if (p == (void *)1) {
+	if (p == SEQ_START_TOKEN) {
 		seq_puts(m, "# Version 1.1\n");
 		seq_puts(m, "# Path Client(Flags) # IPs\n");
 		return 0;


Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.


