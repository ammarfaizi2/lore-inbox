Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263039AbVFWI3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263039AbVFWI3H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 04:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbVFWI15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 04:27:57 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:49824 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262583AbVFWHl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 03:41:59 -0400
Message-ID: <42BA67C9.7060604@namesys.com>
Date: Thu, 23 Jun 2005 00:42:01 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pekka Enberg <penberg@gmail.com>, vs <vs@thebsh.namesys.com>
CC: Andi Kleen <ak@suse.de>, Alexander Lyamin aka FLX <flx@namesys.com>,
       Alexander Zarochentcev <zam@namesys.com>, vs <vs@thebsh.namesys.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>,
       Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: -mm -> 2.6.13 merge status
References: <20050620235458.5b437274.akpm@osdl.org.suse.lists.linux.kernel>	 <p73d5qgc67h.fsf@verdi.suse.de> <42B86027.3090001@namesys.com>	 <20050621195642.GD14251@wotan.suse.de> <42B8C0FF.2010800@namesys.com> <84144f0205062223226d560e41@mail.gmail.com>
In-Reply-To: <84144f0205062223226d560e41@mail.gmail.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:

>Hi Hans,
>
>On 6/22/05, Hans Reiser <reiser@namesys.com> wrote:
>  
>
>>I would in particular love to have you Andi Kleen do a full review of V4
>>if you could be that generous with your time, as I liked much of the
>>advice you gave us on V3.
>>    
>>
>
>Well, I am not Andi Kleen and this is not even in the ballpark of a full
>review but here goes...
>  
>
thanks kindly for your time, your comments were appreciated

>P.S. Would it be possible to have a version without the plugin stuff
>submitted (and perhaps file as directory)?
>
No, I am sorry.  It is like asking for ext2 without directories.

> It would make much more
>sense for the rest of us to review reiser4 without the most controversial
>bits and get the bits that people agree on merged.
>
>                                     Pekka
>
>  
>
>>--- /dev/null	2003-09-23 21:59:22.000000000 +0400
>>+++ linux-2.6.11-vs/fs/reiser4/pool.c	2005-06-03 17:49:38.668204642 +0400
>>+/* initialise new pool */
>>+reiser4_internal void
>>+reiser4_init_pool(reiser4_pool * pool /* pool to initialise */ ,
>>+		  size_t obj_size /* size of objects in @pool */ ,
>>+		  int num_of_objs /* number of preallocated objects */ ,
>>+		  char *data /* area for preallocated objects */ )
>>+{
>>+	reiser4_pool_header *h;
>>+	int i;
>>+
>>+	assert("nikita-955", pool != NULL);
>>    
>>
>
>These assertion codes are meaningless to the rest of us so please drop
>them.
>  
>
I think you don't appreciate the role of assertions in making code
easier to audit and debug.

>  
>
>>--- /dev/null	2003-09-23 21:59:22.000000000 +0400
>>+++ linux-2.6.11-vs/fs/reiser4/type_safe_hash.h	2005-06-03 17:49:38.751209197 +0400
>>@@ -0,0 +1,320 @@
>>+/* Copyright 2001, 2002, 2003 by Hans Reiser, licensing governed by
>>+ * reiser4/README */
>>+
>>+/* A hash table class that uses hash chains (singly-linked) and is
>>+   parametrized to provide type safety.  */
>>    
>>
>
>This belongs to include/linux, not reiser4.
>  
>
Too much politics are involved in modifying other peoples directories,
or I'd agree with you.  The first person outside the reiser4 project to
use it should move it into a different place.

>  
>
>>--- /dev/null	2003-09-23 21:59:22.000000000 +0400
>>+++ linux-2.6.11-vs/fs/reiser4/type_safe_list.h	2005-06-03 17:49:38.755209417 +0400
>>@@ -0,0 +1,436 @@
>>+/* Copyright 2001, 2002, 2003 by Hans Reiser, licensing governed by reiser4/README */
>>+
>>+#ifndef __REISER4_TYPE_SAFE_LIST_H__
>>+#define __REISER4_TYPE_SAFE_LIST_H__
>>+
>>+#include "debug.h"
>>+/* A circular doubly linked list that differs from the previous
>>+   <linux/list.h> implementation because it is parametrized to provide
>>+   type safety.  This data structure is also useful as a queue or stack.
>>    
>>
>
>This belongs to include/linux, not reiser4.
>  
>
Yes, but see above about first person outside reiser4 project should.....

>  
>
>>--- /dev/null	2003-09-23 21:59:22.000000000 +0400
>>+++ linux-2.6.11-vs/fs/reiser4/vfs_ops.c	2005-06-03 17:51:28.110210237 +0400
>>+/* ->get_sb() method of file_system operations. */
>>+static struct super_block *
>>+reiser4_get_sb(struct file_system_type *fs_type	/* file
>>+						 * system
>>+						 * type */ ,
>>+	       int flags /* flags */ ,
>>+	       const char *dev_name /* device name */ ,
>>+	       void *data /* mount options */ )
>>    
>>
>
>Please drop the useless parameter comments.
>  
>
vs, figure out who added the flags and device name comments and ask them
to prepare a patch.  If nobody admits to the shameful act,;-) have
Edward fix it.

>  
>
>>+/*
>>+ * Initialization stages for reiser4.
>>+ *
>>+ * These enumerate various things that have to be done during reiser4
>>+ * startup. Initialization code (init_reiser4()) keeps track of what stage was
>>+ * reached, so that proper undo can be done if error occurs during
>>+ * initialization.
>>+ */
>>+typedef enum {
>>+	INIT_NONE,               /* nothing is initialized yet */
>>+	INIT_INODECACHE,         /* inode cache created */
>>+	INIT_CONTEXT_MGR,        /* list of active contexts created */
>>+	INIT_ZNODES,             /* znode slab created */
>>+	INIT_PLUGINS,            /* plugins initialized */
>>+	INIT_PLUGIN_SET,         /* psets initialized */
>>+	INIT_TXN,                /* transaction manager initialized */
>>+	INIT_FAKES,              /* fake inode initialized */
>>+	INIT_JNODES,             /* jnode slab initialized */
>>+	INIT_EFLUSH,             /* emergency flush initialized */
>>+	INIT_FQS,                /* flush queues initialized */
>>+	INIT_DENTRY_FSDATA,      /* dentry_fsdata slab initialized */
>>+	INIT_FILE_FSDATA,        /* file_fsdata slab initialized */
>>+	INIT_D_CURSOR,           /* d_cursor suport initialized */
>>+	INIT_FS_REGISTERED,      /* reiser4 file system type registered */
>>+} reiser4_init_stage;
>>    
>>
>
>Please use regular gotos instead. This is a silly hack especially since you
>don't have release function for all of the stages.
>  
>
I'll let vs comment.

>  
>
>>+reiser4_internal void reiser4_handle_error(void)
>>+{
>>+	struct super_block *sb = reiser4_get_current_sb();
>>+
>>+	if ( !sb )
>>+		return;
>>+	reiser4_status_write(REISER4_STATUS_DAMAGED, 0, "Filesystem error occured");
>>+	switch ( get_super_private(sb)->onerror ) {
>>+	case 0:
>>+		reiser4_panic("foobar-42", "Filesystem error occured\n");
>>+	case 1:
>>+		if ( sb->s_flags & MS_RDONLY )
>>+			return;
>>+		sb->s_flags |= MS_RDONLY;
>>+		break;
>>+	case 2:
>>+		machine_restart(NULL);
>>    
>>
>
>Probably not something you should do at fs level.
>  
>
Not sure why you say that.

vs, given the existence of case 0, why do we need to have case 2?

>  
>
>>+/* free this znode */
>>+reiser4_internal void
>>+zfree(znode * node /* znode to free */ )
>>+{
>>+	assert("nikita-465", node != NULL);
>>+	assert("nikita-2120", znode_page(node) == NULL);
>>+	assert("nikita-2301", owners_list_empty(&node->lock.owners));
>>+	assert("nikita-2302", requestors_list_empty(&node->lock.requestors));
>>+	assert("nikita-2663", capture_list_is_clean(ZJNODE(node)) && NODE_LIST(ZJNODE(node)) == NOT_CAPTURED);
>>+	assert("nikita-2773", !JF_ISSET(ZJNODE(node), JNODE_EFLUSH));
>>+	assert("nikita-3220", list_empty(&ZJNODE(node)->jnodes));
>>+	assert("nikita-3293", !znode_is_right_connected(node));
>>+	assert("nikita-3294", !znode_is_left_connected(node));
>>+	assert("nikita-3295", node->left == NULL);
>>+	assert("nikita-3296", node->right == NULL);
>>    
>>
>
>Are all these still required? Seems bit too defensive for the kernel.
>  
>
Hmm, someday must put you in a room with DARPA guys, and let you get us
another round of funding by trying to convince them that our code is too
defensive.;-)

This is not too defensive.  Nikita did well here.  The culture of code
auditors is very different from most programmers.  Like most
specialists, they have wisdom to offer those who listen to them.  In
essence, they teach that every function should have a specification of
every possible restriction on allowed input that can be imagined and is
correct as a restriction.  Code auditors love assertions like this.  I
look at my understanding of this before DARPA, and I wince.  DARPA
patiently taught me much in this area as I listened to security talks at
our meetings, and I thank them for it. 

Large scale projects like reiser4 are crippled by debugging costs. 
Anything that reduces debugging time is worth so much.....

>  
>
>>+
>>+
>>+	/* not yet phash_jnode_destroy(ZJNODE(node)); */
>>+
>>+	/* poison memory. */
>>+	ON_DEBUG(memset(node, 0xde, sizeof *node));
>>    
>>
>
>Poisoning belongs to slab, not fs.
>  
>
vs, please comment.

>  
>
>>+/* allocate fresh znode */
>>+reiser4_internal znode *
>>+zalloc(int gfp_flag /* allocation flag */ )
>>+{
>>+	znode *node;
>>+
>>+	node = kmem_cache_alloc(znode_slab, gfp_flag);
>>+	return node;
>>+}
>>    
>>
>
>Please drop this useless wrapper.
>  
>
Thanks.  vs, I think he is right here.... I see zalloc used in only two
places.....  Or is the desire to ease future porting work?

>  
>
>>+reiser4_internal void
>>+znode_remove(znode * node /* znode to remove */ , reiser4_tree * tree)
>>+{
>>+	assert("nikita-2108", node != NULL);
>>+	assert("nikita-470", node->c_count == 0);
>>+	assert("zam-879", rw_tree_is_write_locked(tree));
>>+
>>+	/* remove reference to this znode from cbk cache */
>>+	cbk_cache_invalidate(node, tree);
>>+
>>+	/* update c_count of parent */
>>+	if (znode_parent(node) != NULL) {
>>+		assert("nikita-472", znode_parent(node)->c_count > 0);
>>+		/* father, onto your hands I forward my spirit... */
>>+		znode_parent(node)->c_count --;
>>+		node->in_parent.node = NULL;
>>+	} else {
>>+		/* orphaned znode?! Root? */
>>    
>>
>
>Drop the useless else branch.
>  
>
>>--- /dev/null	2003-09-23 21:59:22.000000000 +0400
>>+++ linux-2.6.11-vs/fs/reiser4/debug.c	2005-06-03 17:49:38.293184063 +0400
>>@@ -0,0 +1,447 @@
>>+/* Copyright 2001, 2002, 2003 by Hans Reiser, licensing governed by
>>+ * reiser4/README */
>>+
>>+/* Debugging facilities. */
>>+
>>+/*
>>+ * This file contains generic debugging functions used by reiser4. Roughly
>>+ * following:
>>+ *
>>+ *     panicking: reiser4_do_panic(), reiser4_print_prefix().
>>+ *
>>+ *     locking: schedulable(), lock_counters(), print_lock_counters(),
>>+ *     no_counters_are_held(), commit_check_locks()
>>+ *
>>+ *     {debug,trace,log}_flags: reiser4_are_all_debugged(),
>>+ *     reiser4_is_debugged(), get_current_trace_flags(),
>>+ *     get_current_log_flags().
>>+ *
>>+ *     kmalloc/kfree leak detection: reiser4_kmalloc(), reiser4_kfree(),
>>+ *     reiser4_kfree_in_sb().
>>    
>>
>
>Please don't do this! We've had enough trouble trying to get the
>current subsystem specific allocators out, so do not introduce a new one. If
>you need memory leak detection, make it generic and submit that. Reiser4, like
>all other subsystems, should use kmalloc() and friends directly.
>  
>
I will let vs comment.

>  
>
>>--- /dev/null	2003-09-23 21:59:22.000000000 +0400
>>+++ linux-2.6.11-vs/fs/reiser4/debug.h	2005-06-03 17:49:38.297184283 +0400
>>+
>>+/*
>>+ * Error code tracing facility. (Idea is borrowed from XFS code.)
>>    
>>
>
>Could this be turned into a generic facility?
>  
>
Probably it already is one.  Getting it used as such sounds like a lot
of political work though.  Maybe the first person outside the reiser4
project to want to use it should move the code into a different location.

>  
>
>>+ *
>>+ * Suppose some strange and/or unexpected code is returned from some function
>>+ * (for example, write(2) returns -EEXIST). It is possible to place a
>>+ * breakpoint in the reiser4_write(), but it is too late here. How to find out
>>    
>>
>--
>  
>
>>+#define RETERR(code) 				\
>>+({						\
>>+	typeof(code) __code;			\
>>+						\
>>+	__code = (code);			\
>>+	return_err(__code, __FILE__, __LINE__);	\
>>+	__code;					\
>>+})
>>    
>>
>
>  
>
>>+#define reiser4_internal
>>    
>>
>
>Please drop the above useless #define.
>
>  
>
>>--- /dev/null	2003-09-23 21:59:22.000000000 +0400
>>+++ linux-2.6.11-vs/fs/reiser4/emergency_flush.c	2005-06-03 17:51:59.000905353 +0400
>>@@ -0,0 +1,913 @@
>>+/* Copyright 2002, 2003 by Hans Reiser, licensing governed by reiser4/README */
>>+
>>+/* This file exists only until VM gets fixed to reserve pages properly, which
>>+ * might or might not be very political. */
>>    
>>
>
>Please fix vm instead of working around it in fs.
>  
>
actually I want to see emergency flush die very very much.   As for
fixing vm, easier said than done, politically.

>  
>
>>--- /dev/null	2003-09-23 21:59:22.000000000 +0400
>>+++ linux-2.6.11-vs/fs/reiser4/init_super.c	2005-06-03 17:51:27.959201950 +0400
>>+
>>+#define _INIT_PARAM_LIST (struct super_block * s, reiser4_context * ctx, void * data, int silent)
>>+#define _DONE_PARAM_LIST (struct super_block * s)
>>+
>>+#define _INIT_(subsys) static int _init_##subsys _INIT_PARAM_LIST
>>+#define _DONE_(subsys) static void _done_##subsys _DONE_PARAM_LIST
>>    
>>
>
>Please remove this macro obfuscation.
>  
>
vs, I think he is right, do you?

>  
>
>>+
>>+_DONE_EMPTY(exit_context)
>>+
>>+struct reiser4_subsys {
>>+	int  (*init) _INIT_PARAM_LIST;
>>+	void (*done) _DONE_PARAM_LIST;
>>+};
>>+
>>+#define _SUBSYS(subsys) {.init = &_init_##subsys, .done = &_done_##subsys}
>>+static struct reiser4_subsys subsys_array[] = {
>>+	_SUBSYS(mount_flags_check),
>>+	_SUBSYS(sinfo),
>>+	_SUBSYS(context),
>>+	_SUBSYS(parse_options),
>>+	_SUBSYS(object_ops),
>>+	_SUBSYS(read_super),
>>+	_SUBSYS(tree0),
>>+	_SUBSYS(txnmgr),
>>+	_SUBSYS(ktxnmgrd_context),
>>+	_SUBSYS(ktxnmgrd),
>>+	_SUBSYS(entd),
>>+	_SUBSYS(formatted_fake),
>>+	_SUBSYS(disk_format),
>>+	_SUBSYS(sb_counters),
>>+	_SUBSYS(d_cursor),
>>+	_SUBSYS(fs_root),
>>+	_SUBSYS(safelink),
>>+	_SUBSYS(exit_context)
>>+};
>>    
>>
>
>The above is overkill and silly. parse_options and read_super, for
>example, are _not_ a subsystem inits but regular fs ops. Please consider
>dropping this altogether but at least trim it down to something sane.
>  
>
vs please comment.

>  
>
>>--- /dev/null	2003-09-23 21:59:22.000000000 +0400
>>+++ linux-2.6.11-vs/fs/reiser4/page_cache.c	2005-06-03 17:51:59.003905518 +0400
>>+/* one-time initialization of fake inodes handling functions. */
>>+reiser4_internal int
>>+init_fakes()
>>+{
>>+	return 0;
>>+}
>>    
>>
>
>Please drop this empty function.
>
>
>  
>
sure.
