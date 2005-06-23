Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262598AbVFWQQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbVFWQQR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 12:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbVFWQQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 12:16:17 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:6619 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S262598AbVFWQPW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 12:15:22 -0400
Subject: Re: -mm -> 2.6.13 merge status
From: Vladimir Saveliev <vs@namesys.com>
To: Pekka Enberg <penberg@gmail.com>
Cc: Alexander Zarochentcev <zam@namesys.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <42BA67C9.7060604@namesys.com>
References: <20050620235458.5b437274.akpm@osdl.org.suse.lists.linux.kernel>
	 <p73d5qgc67h.fsf@verdi.suse.de> <42B86027.3090001@namesys.com>
	 <20050621195642.GD14251@wotan.suse.de> <42B8C0FF.2010800@namesys.com>
	 <84144f0205062223226d560e41@mail.gmail.com>  <42BA67C9.7060604@namesys.com>
Content-Type: text/plain
Message-Id: <1119543302.4115.141.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 23 Jun 2005 20:15:03 +0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Thu, 2005-06-23 at 11:42, Hans Reiser wrote:
> Pekka Enberg wrote:
> 
> >
> >>--- /dev/null	2003-09-23 21:59:22.000000000 +0400
> >>+++ linux-2.6.11-vs/fs/reiser4/pool.c	2005-06-03 17:49:38.668204642 +0400
> >>+/* initialise new pool */
> >>+reiser4_internal void
> >>+reiser4_init_pool(reiser4_pool * pool /* pool to initialise */ ,
> >>+		  size_t obj_size /* size of objects in @pool */ ,
> >>+		  int num_of_objs /* number of preallocated objects */ ,
> >>+		  char *data /* area for preallocated objects */ )
> >>+{
> >>+	reiser4_pool_header *h;
> >>+	int i;
> >>+
> >>+	assert("nikita-955", pool != NULL);
> >>    
> >>
> >
> >These assertion codes are meaningless to the rest of us so please drop
> >them.
> > 

Pekka, am I correct that you object aginst assertion ids like "joe-700"?

> >>--- /dev/null	2003-09-23 21:59:22.000000000 +0400
> >>+++ linux-2.6.11-vs/fs/reiser4/type_safe_hash.h	2005-06-03 17:49:38.751209197 +0400
> >>@@ -0,0 +1,320 @@
> >>+/* Copyright 2001, 2002, 2003 by Hans Reiser, licensing governed by
> >>+ * reiser4/README */
> >>+
> >>+/* A hash table class that uses hash chains (singly-linked) and is
> >>+   parametrized to provide type safety.  */
> >
> >This belongs to include/linux, not reiser4.

ok.

> >>--- /dev/null	2003-09-23 21:59:22.000000000 +0400
> >>+++ linux-2.6.11-vs/fs/reiser4/type_safe_list.h	2005-06-03 17:49:38.755209417 +0400
> >>@@ -0,0 +1,436 @@
> >>+/* Copyright 2001, 2002, 2003 by Hans Reiser, licensing governed by reiser4/README */
> >>+
> >>+#ifndef __REISER4_TYPE_SAFE_LIST_H__
> >>+#define __REISER4_TYPE_SAFE_LIST_H__
> >>+
> >>+#include "debug.h"
> >>+/* A circular doubly linked list that differs from the previous
> >>+   <linux/list.h> implementation because it is parametrized to provide
> >>+   type safety.  This data structure is also useful as a queue or stack.
> >
> >This belongs to include/linux, not reiser4.
> >

ok

> >>+/*
> >>+ * Initialization stages for reiser4.
> >>+ *
> >>+ * These enumerate various things that have to be done during reiser4
> >>+ * startup. Initialization code (init_reiser4()) keeps track of what stage was
> >>+ * reached, so that proper undo can be done if error occurs during
> >>+ * initialization.
> >>+ */
> >>+typedef enum {
> >>+	INIT_NONE,               /* nothing is initialized yet */
> >>+	INIT_INODECACHE,         /* inode cache created */
> >>+	INIT_CONTEXT_MGR,        /* list of active contexts created */
> >>+	INIT_ZNODES,             /* znode slab created */
> >>+	INIT_PLUGINS,            /* plugins initialized */
> >>+	INIT_PLUGIN_SET,         /* psets initialized */
> >>+	INIT_TXN,                /* transaction manager initialized */
> >>+	INIT_FAKES,              /* fake inode initialized */
> >>+	INIT_JNODES,             /* jnode slab initialized */
> >>+	INIT_EFLUSH,             /* emergency flush initialized */
> >>+	INIT_FQS,                /* flush queues initialized */
> >>+	INIT_DENTRY_FSDATA,      /* dentry_fsdata slab initialized */
> >>+	INIT_FILE_FSDATA,        /* file_fsdata slab initialized */
> >>+	INIT_D_CURSOR,           /* d_cursor suport initialized */
> >>+	INIT_FS_REGISTERED,      /* reiser4 file system type registered */
> >>+} reiser4_init_stage;
> >>    
> >>
> >
> >Please use regular gotos instead. This is a silly hack especially since you
> >don't have release function for all of the stages.
> >  
> >
> I'll let vs comment.
> 

IMHO, it is convinient. But lets change it as requested.

> >  
> >
> >>+reiser4_internal void reiser4_handle_error(void)
> >>+{
> >>+	struct super_block *sb = reiser4_get_current_sb();
> >>+
> >>+	if ( !sb )
> >>+		return;
> >>+	reiser4_status_write(REISER4_STATUS_DAMAGED, 0, "Filesystem error occured");
> >>+	switch ( get_super_private(sb)->onerror ) {
> >>+	case 0:
> >>+		reiser4_panic("foobar-42", "Filesystem error occured\n");
> >>+	case 1:
> >>+		if ( sb->s_flags & MS_RDONLY )
> >>+			return;
> >>+		sb->s_flags |= MS_RDONLY;
> >>+		break;
> >>+	case 2:
> >>+		machine_restart(NULL);
> >>    
> >>
> >
> >Probably not something you should do at fs level.
> >  
ok

> >>+
> >>+	/* not yet phash_jnode_destroy(ZJNODE(node)); */
> >>+
> >>+	/* poison memory. */
> >>+	ON_DEBUG(memset(node, 0xde, sizeof *node));
> >>    
> >>
> >
> >Poisoning belongs to slab, not fs.
> >  

ok

> >  
> >
> >>+/* allocate fresh znode */
> >>+reiser4_internal znode *
> >>+zalloc(int gfp_flag /* allocation flag */ )
> >>+{
> >>+	znode *node;
> >>+
> >>+	node = kmem_cache_alloc(znode_slab, gfp_flag);
> >>+	return node;
> >>+}
> >>    
> >>
> >
> >Please drop this useless wrapper.
> >  

ok

> >  
> >
> >>+reiser4_internal void
> >>+znode_remove(znode * node /* znode to remove */ , reiser4_tree * tree)
> >>+{
> >>+	assert("nikita-2108", node != NULL);
> >>+	assert("nikita-470", node->c_count == 0);
> >>+	assert("zam-879", rw_tree_is_write_locked(tree));
> >>+
> >>+	/* remove reference to this znode from cbk cache */
> >>+	cbk_cache_invalidate(node, tree);
> >>+
> >>+	/* update c_count of parent */
> >>+	if (znode_parent(node) != NULL) {
> >>+		assert("nikita-472", znode_parent(node)->c_count > 0);
> >>+		/* father, onto your hands I forward my spirit... */
> >>+		znode_parent(node)->c_count --;
> >>+		node->in_parent.node = NULL;
> >>+	} else {
> >>+		/* orphaned znode?! Root? */
> >>    
> >>
> >
> >Drop the useless else branch.
> >  
> >
> >>--- /dev/null	2003-09-23 21:59:22.000000000 +0400
> >>+++ linux-2.6.11-vs/fs/reiser4/debug.c	2005-06-03 17:49:38.293184063 +0400
> >>@@ -0,0 +1,447 @@
> >>+/* Copyright 2001, 2002, 2003 by Hans Reiser, licensing governed by
> >>+ * reiser4/README */
> >>+
> >>+/* Debugging facilities. */
> >>+
> >>+/*
> >>+ * This file contains generic debugging functions used by reiser4. Roughly
> >>+ * following:
> >>+ *
> >>+ *     panicking: reiser4_do_panic(), reiser4_print_prefix().
> >>+ *
> >>+ *     locking: schedulable(), lock_counters(), print_lock_counters(),
> >>+ *     no_counters_are_held(), commit_check_locks()
> >>+ *
> >>+ *     {debug,trace,log}_flags: reiser4_are_all_debugged(),
> >>+ *     reiser4_is_debugged(), get_current_trace_flags(),
> >>+ *     get_current_log_flags().
> >>+ *
> >>+ *     kmalloc/kfree leak detection: reiser4_kmalloc(), reiser4_kfree(),
> >>+ *     reiser4_kfree_in_sb().
> >>    
> >>
> >
> >Please don't do this! We've had enough trouble trying to get the
> >current subsystem specific allocators out, so do not introduce a new one. If
> >you need memory leak detection, make it generic and submit that. Reiser4, like
> >all other subsystems, should use kmalloc() and friends directly.
> >  
> >
> I will let vs comment.
> 
I agree with Pekka.

> >  
> >
> >>--- /dev/null	2003-09-23 21:59:22.000000000 +0400
> >>+++ linux-2.6.11-vs/fs/reiser4/debug.h	2005-06-03 17:49:38.297184283 +0400
> >>+
> >>+/*
> >>+ * Error code tracing facility. (Idea is borrowed from XFS code.)
> >>    
> >>
> >
> >Could this be turned into a generic facility?
> >  

I do not think that it will ever become accepted.
To get use of that task_t would have to be extended with fields to store
error code, file name and line in it, and several return addresses.
Moreover lines like 
return -ENOENT;
would have to be replaced with:
return RETERR(-ENOENT);

This is debugging feature, we should probably move it to our internal
debugging patch.

> >
> >  
> >
> >>+#define reiser4_internal
> >>    
> >>
> >
> >Please drop the above useless #define.
> >

ok

> >
> >>--- /dev/null	2003-09-23 21:59:22.000000000 +0400
> >>+++ linux-2.6.11-vs/fs/reiser4/init_super.c	2005-06-03 17:51:27.959201950 +0400
> >>+
> >>+#define _INIT_PARAM_LIST (struct super_block * s, reiser4_context * ctx, void * data, int silent)
> >>+#define _DONE_PARAM_LIST (struct super_block * s)
> >>+
> >>+#define _INIT_(subsys) static int _init_##subsys _INIT_PARAM_LIST
> >>+#define _DONE_(subsys) static void _done_##subsys _DONE_PARAM_LIST
> >>    
> >>
> >
> >Please remove this macro obfuscation.
> >  
> >
> vs, I think he is right, do you?
> 
> >  
> >
> >>+
> >>+_DONE_EMPTY(exit_context)
> >>+
> >>+struct reiser4_subsys {
> >>+	int  (*init) _INIT_PARAM_LIST;
> >>+	void (*done) _DONE_PARAM_LIST;
> >>+};
> >>+
> >>+#define _SUBSYS(subsys) {.init = &_init_##subsys, .done = &_done_##subsys}
> >>+static struct reiser4_subsys subsys_array[] = {
> >>+	_SUBSYS(mount_flags_check),
> >>+	_SUBSYS(sinfo),
> >>+	_SUBSYS(context),
> >>+	_SUBSYS(parse_options),
> >>+	_SUBSYS(object_ops),
> >>+	_SUBSYS(read_super),
> >>+	_SUBSYS(tree0),
> >>+	_SUBSYS(txnmgr),
> >>+	_SUBSYS(ktxnmgrd_context),
> >>+	_SUBSYS(ktxnmgrd),
> >>+	_SUBSYS(entd),
> >>+	_SUBSYS(formatted_fake),
> >>+	_SUBSYS(disk_format),
> >>+	_SUBSYS(sb_counters),
> >>+	_SUBSYS(d_cursor),
> >>+	_SUBSYS(fs_root),
> >>+	_SUBSYS(safelink),
> >>+	_SUBSYS(exit_context)
> >>+};
> >>    
> >>
> >
> >The above is overkill and silly. parse_options and read_super, for
> >example, are _not_ a subsystem inits but regular fs ops. Please consider
> >dropping this altogether but at least trim it down to something sane.
> > 

Pekka, would you prefer something like:

reiser4_fill_super()
{
    if (init_a() == 0) {
	if (init_b() == 0) {
	    if (init_c() == 0) {
		if (init_last() == 0)
		    return 0;
		else {
		    done_c();
		    done_b();
		    done_a();
		}
	    } else {
		done_b();
		done_a();
	    }
	} else {
	    done_a();
	}
    }
}

With these macros we have reiser4_fill_super to look like the below, and
it remains unchanged when something new is added for initilizing on
filesystem mounting.

reiser4_fill_super()
{
	for (i = 0; i < REISER4_NR_SUBSYS; i++) {
		ret = subsys_array[i].init(s, &ctx, data, silent);
		if (ret) {
			done_super(s, i - 1);
			return ret;
		}
	}
}


