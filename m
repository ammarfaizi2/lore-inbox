Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319315AbSHNWWb>; Wed, 14 Aug 2002 18:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319329AbSHNWWb>; Wed, 14 Aug 2002 18:22:31 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:12194 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id <S319315AbSHNWVs>; Wed, 14 Aug 2002 18:21:48 -0400
Date: Wed, 14 Aug 2002 23:25:32 +0100
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Re: Some JBD documenation
Message-ID: <20020814232529.A3190@computer-surgery.co.uk>
References: <20020322143444.A671@zuse.computer-surgery.co.uk> <3C9B8B36.1AFFDFA6@zip.com.au> <20020325091041.A514@zuse.computer-surgery.co.uk> <3C9EE97E.2F494AF9@zip.com.au> <20020805144845.A18390@computer-surgery.co.uk> <3D4EC3CC.A4827C50@zip.com.au> <20020814232310.B704@computer-surgery.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020814232310.B704@computer-surgery.co.uk>; from roger on Wed, Aug 14, 2002 at 11:23:10PM +0100
From: Roger Gammans <roger@computer-surgery.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--b5gNqxB1S1yM7hjW
Content-Type: multipart/mixed; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2002 at 11:23:10PM +0100, roger wrote:
> Hi
>=20
> This patch is the JBD DocBook documentation patch which I

Of course it helps if I don't leave the patch in the
paperbag.


--=20
Roger.
Master of Peng Shui.  (Ancient oriental art of Penguin Arranging)
GPG Key FPR: CFF1 F383 F854 4E6A 918D  5CFF A90D E73B 88DE 0B3E

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="jbd.patch"
Content-Transfer-Encoding: quoted-printable

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.744   -> 1.745 =20
#	    fs/jbd/journal.c	1.5     -> 1.6   =20
#	   fs/jbd/recovery.c	1.3     -> 1.4   =20
#	fs/jbd/transaction.c	1.4     -> 1.5   =20
#	Documentation/DocBook/Makefile	1.13    -> 1.14  =20
#	 include/linux/jbd.h	1.5     -> 1.6   =20
#	               (new)	        -> 1.1     Documentation/DocBook/journal-api=
.tmpl
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/14	roger@zuse.computer-surgery.co.uk	1.745
# Add DocBook style documentation for the jbd
# layers client api.
# --------------------------------------------
#
diff -Nru a/Documentation/DocBook/Makefile b/Documentation/DocBook/Makefile
--- a/Documentation/DocBook/Makefile	Wed Aug 14 22:13:58 2002
+++ b/Documentation/DocBook/Makefile	Wed Aug 14 22:13:58 2002
@@ -1,7 +1,8 @@
 BOOKS	:=3D wanbook.sgml z8530book.sgml mcabook.sgml videobook.sgml \
 	   kernel-api.sgml parportbook.sgml kernel-hacking.sgml \
 	   kernel-locking.sgml via-audio.sgml mousedrivers.sgml sis900.sgml \
-	   deviceiobook.sgml procfs-guide.sgml tulip-user.sgml
+	   deviceiobook.sgml procfs-guide.sgml tulip-user.sgml \
+	   journal-api.sgml
=20
 PS	:=3D	$(patsubst %.sgml, %.ps, $(BOOKS))
 PDF	:=3D	$(patsubst %.sgml, %.pdf, $(BOOKS))
@@ -137,6 +138,17 @@
 parportbook.ps: $(EPS-parportbook)
 parportbook.sgml: parportbook.tmpl $(TOPDIR)/drivers/parport/init.c
 	$(TOPDIR)/scripts/docgen $(TOPDIR)/drivers/parport/init.c <$< >$@
+
+
+JBDSOURCES :=3D  $(TOPDIR)/include/linux/jbd.h \
+	       $(TOPDIR)/fs/jbd/journal.c \
+	       $(TOPDIR)/fs/jbd/recovery.c \
+	       $(TOPDIR)/fs/jbd/transaction.c
+
+journal-api.sgml: journal-api.tmpl $(JBDSOURCES)
+	$(TOPDIR)/scripts/docgen   $(JBDSOURCES) \
+		<journal-api.tmpl >journal-api.sgml
+
=20
 DVI	:=3D	$(patsubst %.sgml, %.dvi, $(BOOKS))
 AUX	:=3D	$(patsubst %.sgml, %.aux, $(BOOKS))
diff -Nru a/Documentation/DocBook/journal-api.tmpl b/Documentation/DocBook/=
journal-api.tmpl
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/Documentation/DocBook/journal-api.tmpl	Wed Aug 14 22:13:58 2002
@@ -0,0 +1,297 @@
+<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook V3.1//EN"[]>
+<book id=3D"LinuxJBDAPI">
+ <bookinfo>
+  <title>The Linux Journalling API</title>
+  <authorgroup>
+  <author>
+     <firstname>Roger</firstname>
+     <surname>Gammans</surname>
+     <affiliation>
+     <address>
+      <email>rgammans@computer-surgery.co.uk</email>
+     </address>
+    </affiliation>
+     </author>=20
+  </authorgroup>
+ =20
+  <authorgroup>
+   <author>
+    <firstname>Stephen</firstname>
+    <surname>Tweedie</surname>
+    <affiliation>
+     <address>
+      <email>sct@redhat.com</email>
+     </address>
+    </affiliation>
+   </author>
+  </authorgroup>
+
+  <copyright>
+   <year>2002</year>
+   <holder>Roger Gammans</holder>
+  </copyright>
+
+<legalnotice>
+   <para>
+     This documentation is free software; you can redistribute
+     it and/or modify it under the terms of the GNU General Public
+     License as published by the Free Software Foundation; either
+     version 2 of the License, or (at your option) any later
+     version.
+   </para>
+     =20
+   <para>
+     This program is distributed in the hope that it will be
+     useful, but WITHOUT ANY WARRANTY; without even the implied
+     warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+     See the GNU General Public License for more details.
+   </para>
+     =20
+   <para>
+     You should have received a copy of the GNU General Public
+     License along with this program; if not, write to the Free
+     Software Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+     MA 02111-1307 USA
+   </para>
+     =20
+   <para>
+     For more details see the file COPYING in the source
+     distribution of Linux.
+   </para>
+  </legalnotice>
+ </bookinfo>
+
+<toc></toc>
+
+  <chapter id=3D"Overview">
+     <title>Overview</title>
+  <sect1>
+     <title>Details</title>
+<para>
+The journalling layer is  easy to use. You need to=20
+first of all create a journal_t data structure. There are
+two calls to do this dependent on how you decide to allocate the physical
+media on which the journal resides. The journal_init_inode() call=20
+is for journals stored in filesystem inodes, or the journal_init_dev()
+call can be use for journal stored on a raw device (in a continuous range=
=20
+of blocks). A journal_t is a typedef for a struct pointer, so when
+you are finally finished make sure you call journal_destroy() on it
+to free up any used kernel memory.
+</para>
+
+<para>
+Once you have got your journal_t object you need to 'mount' or load the jo=
urnal
+file, unless of course you haven't initialised it yet - in which case you
+need to call journal_create().
+</para>
+
+<para>
+Most of the time however your journal file will already have been created,=
 but
+before you load it you must call journal_wipe() to empty the journal file.
+Hang on, you say , what if the filesystem wasn't cleanly umount()'d . Well=
, it is the=20
+job of the client file system to detect this and skip the call to journal_=
wipe().
+</para>
+
+<para>
+In either case the next call should be to journal_load() which prepares the
+journal file for use. Note that journal_wipe(..,0) calls journal_skip_reco=
very()=20
+for you if it detects any outstanding transactions in the journal and simi=
larly
+journal_load() will call journal_recover() if necessary.
+I would advise reading fs/ext3/super.c for examples on this stage.
+[RGG: Why is the journal_wipe() call necessary - doesn't this needlessly=
=20
+complicate the API. Or isn't a good idea for the journal layer to hide=20
+dirty mounts from the client fs]
+</para>
+
+<para>
+Now you can go ahead and start modifying the underlying=20
+filesystem. Almost.
+</para>
+
+
+<para>
+
+You still need to actually journal your filesystem changes, this
+is done by wrapping them into transactions. Additionally you
+also need to wrap the modification of each of the the buffers
+with calls to the journal layer, so it knows what the modifications
+you are actually making are. To do this use  journal_start() which
+returns a transaction handle.
+</para>
+
+<para>
+journal_start()
+and its counterpart journal_stop(), which indicates the end of a transacti=
on
+are nestable calls, so you can reenter a transaction if necessary,
+but remember you must call journal_stop() the same number of times as
+journal_start() before the transaction is completed (or more accurately
+leaves the the update phase). Ext3/VFS makes use of this feature to simpli=
fy=20
+quota support.
+</para>
+
+<para>
+Inside each transaction you need to wrap the modifications to the
+individual buffers (blocks). Before you start to modify a buffer you
+need to call journal_get_{create,write,undo}_access() as appropriate,
+this allows the journalling layer to copy the unmodified data if it
+needs to. After all the buffer may be part of a previously uncommitted
+transaction.=20
+At this point you are at last ready to modify a buffer, and once
+you are have done so you need to call journal_dirty_{meta,}data().
+Or if you've asked for access to a buffer you now know is now longer=20
+required to be pushed back on the device you can call journal_forget()
+in much the same way as you might have used bforget() in the past.
+
+</para>
+
+
+
+<para>
+A journal_flush() may be called at any time to commit and checkpoint
+all your transactions.
+</para>
+<para>
+
+Then at umount time , in your put_super() (2.4) or write_super() (2.5)
+you can then call journal_destroy() to clean up your in-core journal objec=
t.
+</para>
+
+
+<para>
+Unfortunately there a couple of ways the journal layer can cause a deadloc=
k.
+The first thing to note is that each task can only have
+a single outstanding transaction at any one time, remember nothing
+commits until the outermost journal_stop(). This means
+you must complete the transaction at the end of each file/inode/address
+etc. operation you perform, so that the journalling system isn't re-entered
+on another journal. Since transactions can't be nested/batched=20
+across differing journals, and another filesystem other than
+yours (say ext3) may be modified in a later syscall.
+</para>
+<para>
+
+The second case to bear in mind is that journal_start() can=20
+block if there isn't enough space in the journal for your transaction=20
+(based on the passed nblocks param) - when it blocks it merely(!) needs to
+wait for transactions to complete and be committed from other tasks,=20
+so essentially we are waiting for journal_stop(). So to avoid=20
+deadlocks you must treat journal_start/stop() as if they
+were semaphores and include them in your semaphore ordering rules to preve=
nt=20
+deadlocks. Note that journal_extend() has similar blocking behaviour to
+journal_start() so you can deadlock here just as easily as on journal_star=
t().
+</para>
+<para>
+
+Try to reserve the right number of blocks the first time. ;-).
+</para>
+<para>
+Another wriggle to watch out for is your on-disk block allocation strategy.
+why? Because, if you undo a delete, you need to ensure you haven't reused =
any
+of the freed blocks in a later transaction. One simple way of doing this
+is make sure any blocks you allocate only have checkpointed transactions
+listed against them. Ext3 does this in ext3_test_allocatable().=20
+</para>
+
+<para>
+Lock is also providing through journal_{un,}lock_updates(),
+ext3 uses this when it wants a window with a clean and stable fs for a mom=
ent.
+eg.=20
+<programlisting>
+
+	journal_lock_updates() //stop new stuff happening..
+	journal_flush()        // checkpoint everything.
+	..do stuff on stable fs
+	journal_unlock_updates() // carry on with filesystem use.
+</programlisting>
+
+The opportunities for abuse and DOS attacks with this should be obvious,
+if you allow unprivileged userspace to trigger codepaths containing these
+calls.
+
+<para>
+</sect1>
+<sect1>
+<title>Summary</title>
+<para>
+Using the journal is a matter of wrapping the different context changes,
+being each mount, each modification (transaction) and each changed buffer
+to tell the journalling layer about them.
+
+Here is a some pseudo code to give you an idea of how it works, as
+an example.
+<programlisting>
+  journal_t* my_jnrl =3D journal_create();
+  journal_init_{dev,inode}(jnrl,...)
+  if (clean) journal_wipe();
+  journal_load();
+
+   foreach(transaction) { /*transactions must be=20
+                            completed before
+                            a syscall returns to=20
+                            userspace*/
+
+          handle_t * xct=3Djournal_start(my_jnrl);
+          foreach(bh) {
+                journal_get_{create,write,undo}_access(xact,bh);
+                if ( myfs_modify(bh) ) { /* returns true=20
+                                        if makes changes */
+                           journal_dirty_{meta,}data(xact,bh);
+                } else {
+                           journal_forget(bh);
+                }
+          }
+          journal_stop(xct);
+   }
+   journal_destroy(my_jrnl);
+</programlisting>
+
+</chapter>
+
+  <chapter id=3D"adt">
+     <title>Data Types</title>
+     <para>=09
+	The journalling layer uses typedefs to 'hide' the concrete definitions
+	of the structures used. As a client of the JBD layer you can
+	just rely on the using the pointer as a magic cookie  of some sort.
+=09
+	Obviously the hiding is not enforced as this is 'C'.
+	</para>
+	<sect1><title>Structures</title>
+!Iinclude/linux/jbd.h
+	</sect1>
+</chapter>
+
+  <chapter id=3D"calls">
+     <title>Functions</title>
+     <para>=09
+	The functions here are split into two groups those that
+	affect a journal as a whole, and those which are used to
+	manage transactions
+</para>
+	<sect1><title>Journal Level</title>
+!Efs/jbd/journal.c
+!Efs/jbd/recovery.c
+	</sect1>
+	<sect1><title>Transasction Level</title>
+!Efs/jbd/transaction.c=09
+	</sect1>
+</chapter>
+<chapter>
+     <title>See also</title>
+	<para>
+	<citation>
+	   <ulink url=3D"ftp://ftp.uk.linux.org/pub/linux/sct/fs/jfs/journal-desi=
gn.ps.gz">
+	   	Journaling the Linux ext2fs Filesystem,LinuxExpo 98, Stephen Tweedie
+	   </ulink>
+	   </citation>
+	   </para>
+	   <para>
+	   <citation>
+	   <ulink url=3D"http://olstrans.sourceforge.net/release/OLS2000-ext3/OLS=
2000-ext3.html">
+	   	Ext3 Journalling FileSystem , OLS 2000, Dr. Stephen Tweedie
+	   </ulink>
+	   </citation>
+	   </para>
+</chapter>
+
+</book>
diff -Nru a/fs/jbd/journal.c b/fs/jbd/journal.c
--- a/fs/jbd/journal.c	Wed Aug 14 22:13:58 2002
+++ b/fs/jbd/journal.c	Wed Aug 14 22:13:58 2002
@@ -730,14 +730,21 @@
  * need to set up all of the mapping information to tell the journaling
  * system where the journal blocks are.
  *
- * journal_init_dev creates a journal which maps a fixed contiguous
- * range of blocks on an arbitrary block device.
- *
- * journal_init_inode creates a journal which maps an on-disk inode as
- * the journal.  The inode must exist already, must support bmap() and
- * must have all data blocks preallocated.
  */
=20
+ /**
+  *  journal_t * journal_init_dev() - creates an initialises a journal str=
ucture
+  *  @kdev: Block device on which to create the journal
+  *  @fs_dev: Device which hold journalled filesystem for this journal.
+  *  @start: Block nr Start of journal.
+  *  @len:  Lenght of the journal in blocks.
+  *  @blocksize: blocksize of journalling device
+  *  @returns: a newly created journal_t *
+  * =20
+  *  journal_init_dev creates a journal which maps a fixed contiguous
+  *  range of blocks on an arbitrary block device.
+  *=20
+  */
 journal_t * journal_init_dev(kdev_t dev, kdev_t fs_dev,
 			int start, int len, int blocksize)
 {
@@ -760,7 +767,15 @@
=20
 	return journal;
 }
-
+=20
+/**=20
+ *  journal_t * journal_init_inode () - creates a journal which maps to a =
inode.
+ *  @inode: An inode to create the journal in
+ * =20
+ * journal_init_inode creates a journal which maps an on-disk inode as
+ * the journal.  The inode must exist already, must support bmap() and
+ * must have all data blocks preallocated.
+ */
 journal_t * journal_init_inode (struct inode *inode)
 {
 	struct buffer_head *bh;
@@ -850,12 +865,15 @@
 	return 0;
 }
=20
-/*
+/**=20
+ * int journal_create() - Initialise the new journal file
+ * @journal: Journal to create. This structure must have been initialised
+ *=20
  * Given a journal_t structure which tells us which disk blocks we can
  * use, create a new journal superblock and initialise all of the
- * journal fields from scratch.  */
-
-int journal_create (journal_t *journal)
+ * journal fields from scratch. =20
+ **/
+int journal_create(journal_t *journal)
 {
 	unsigned long blocknr;
 	struct buffer_head *bh;
@@ -916,11 +934,14 @@
 	return journal_reset(journal);
 }
=20
-/*
+/**=20
+ * void journal_update_superblock() - Update journal sb on disk.
+ * @journal: The journal to update.
+ * @wait: Set to '0' if you don't want to wait for IO completion.
+ *
  * Update a journal's dynamic superblock fields and write it to disk,
  * optionally waiting for the IO to complete.
-*/
-
+ */
 void journal_update_superblock(journal_t *journal, int wait)
 {
 	journal_superblock_t *sb =3D journal->j_superblock;
@@ -1036,12 +1057,14 @@
 }
=20
=20
-/*
+/**
+ * int journal_load() - Read journal from disk.
+ * @journal: Journal to act on.
+ *=20
  * Given a journal_t structure which tells us which disk blocks contain
  * a journal, read the journal from disk to initialise the in-memory
  * structures.
  */
-
 int journal_load(journal_t *journal)
 {
 	int err;
@@ -1086,11 +1109,13 @@
 	return -EIO;
 }
=20
-/*
+/**
+ * void journal_destroy() - Release a journal_t structure.
+ * @journal: Journal to act on.
+*=20
  * Release a journal_t structure once it is no longer in use by the
  * journaled object.
  */
-
 void journal_destroy (journal_t *journal)
 {
 	/* Wait for the commit thread to wake up and die. */
@@ -1128,8 +1153,12 @@
 }
=20
=20
-/* Published API: Check whether the journal uses all of a given set of
- * features.  Return true (non-zero) if it does. */
+/**
+ *int journal_check_used_features () - Check if features specified are use=
d.
+ *=20
+ * Check whether the journal uses all of a given set of
+ * features.  Return true (non-zero) if it does.=20
+ **/
=20
 int journal_check_used_features (journal_t *journal, unsigned long compat,
 				 unsigned long ro, unsigned long incompat)
@@ -1151,7 +1180,10 @@
 	return 0;
 }
=20
-/* Published API: Check whether the journaling code supports the use of
+/**
+ * int journal_check_available_features() - Check feature set in journalli=
ng layer
+ *=20
+ * Check whether the journaling code supports the use of
  * all of a given set of features on this journal.  Return true
  * (non-zero) if it can. */
=20
@@ -1180,8 +1212,13 @@
 	return 0;
 }
=20
-/* Published API: Mark a given journal feature as present on the
- * superblock.  Returns true if the requested features could be set. */
+/**
+ * int journal_set_features () - Mark a given journal feature in the super=
block
+ *
+ * Mark a given journal feature as present on the
+ * superblock.  Returns true if the requested features could be set.=20
+ *
+ */
=20
 int journal_set_features (journal_t *journal, unsigned long compat,
 			  unsigned long ro, unsigned long incompat)
@@ -1207,12 +1244,12 @@
 }
=20
=20
-/*
- * Published API:
+/**
+ * int journal_update_format () - Update on-disk journal structure.
+ *
  * Given an initialised but unloaded journal struct, poke about in the
  * on-disk structure to update it to the most recent supported version.
  */
-
 int journal_update_format (journal_t *journal)
 {
 	journal_superblock_t *sb;
@@ -1262,7 +1299,10 @@
 }
=20
=20
-/*
+/**
+ * int journal_flush () - Flush journal
+ * @journal: Journal to act on.
+ *=20
  * Flush all data for a given journal to disk and empty the journal.
  * Filesystems can use this when remounting readonly to ensure that
  * recovery does not need to happen on remount.
@@ -1316,12 +1356,16 @@
 	return err;
 }
=20
-/*
+/**
+ * int journal_wipe() - Wipe journal contents
+ * @journal: Journal to act on.
+ * @write: flag (see below)
+ *=20
  * Wipe out all of the contents of a journal, safely.  This will produce
  * a warning if the journal contains any valid recovery information.
  * Must be called between journal_init_*() and journal_load().
  *
- * If (write) is non-zero, then we wipe out the journal on disk; otherwise
+ * If 'write' is non-zero, then we wipe out the journal on disk; otherwise
  * we merely suppress recovery.
  */
=20
@@ -1370,43 +1414,11 @@
 }
=20
 /*
- * journal_abort: perform a complete, immediate shutdown of the ENTIRE
- * journal (not of a single transaction).  This operation cannot be
- * undone without closing and reopening the journal.
- *
- * The journal_abort function is intended to support higher level error
- * recovery mechanisms such as the ext2/ext3 remount-readonly error
- * mode.
- *
- * Journal abort has very specific semantics.  Any existing dirty,
- * unjournaled buffers in the main filesystem will still be written to
- * disk by bdflush, but the journaling mechanism will be suspended
- * immediately and no further transaction commits will be honoured.
- *
- * Any dirty, journaled buffers will be written back to disk without
- * hitting the journal.  Atomicity cannot be guaranteed on an aborted
- * filesystem, but we _do_ attempt to leave as much data as possible
- * behind for fsck to use for cleanup.
- *
- * Any attempt to get a new transaction handle on a journal which is in
- * ABORT state will just result in an -EROFS error return.  A
- * journal_stop on an existing handle will return -EIO if we have
- * entered abort state during the update.
- *
- * Recursive transactions are not disturbed by journal abort until the
- * final journal_stop, which will receive the -EIO error.
- *
- * Finally, the journal_abort call allows the caller to supply an errno
- * which will be recored (if possible) in the journal superblock.  This
- * allows a client to record failure conditions in the middle of a
- * transaction without having to complete the transaction to record the
- * failure to disk.  ext3_error, for example, now uses this
- * functionality.
+ * Journal abort has very specific semantics, which we describe
+ * for journal abort.=20
  *
- * Errors which originate from within the journaling layer will NOT
- * supply an errno; a null errno implies that absolutely no further
- * writes are done to the journal (unless there are any already in
- * progress).
+ * Two internal function, which provide abort to te jbd layer
+ * itself are here.
  */
=20
 /* Quick version for internal journal use (doesn't lock the journal).
@@ -1444,7 +1456,52 @@
 		journal_update_superblock(journal, 1);
 }
=20
-/* Full version for external use */
+/**
+ * void journal_abort () - Shutdown the journal immediately.
+ * @journal: the journal to shutdown.
+ * @errno:   an error number to record in the journal indicating
+ *           the reason for the shutdown.
+ *
+ * Perform a complete, immediate shutdown of the ENTIRE
+ * journal (not of a single transaction).  This operation cannot be
+ * undone without closing and reopening the journal.
+ *          =20
+ * The journal_abort function is intended to support higher level error
+ * recovery mechanisms such as the ext2/ext3 remount-readonly error
+ * mode.
+ *
+ * Journal abort has very specific semantics.  Any existing dirty,
+ * unjournaled buffers in the main filesystem will still be written to
+ * disk by bdflush, but the journaling mechanism will be suspended
+ * immediately and no further transaction commits will be honoured.
+ *
+ * Any dirty, journaled buffers will be written back to disk without
+ * hitting the journal.  Atomicity cannot be guaranteed on an aborted
+ * filesystem, but we _do_ attempt to leave as much data as possible
+ * behind for fsck to use for cleanup.
+ *
+ * Any attempt to get a new transaction handle on a journal which is in
+ * ABORT state will just result in an -EROFS error return.  A
+ * journal_stop on an existing handle will return -EIO if we have
+ * entered abort state during the update.
+ *
+ * Recursive transactions are not disturbed by journal abort until the
+ * final journal_stop, which will receive the -EIO error.
+ *
+ * Finally, the journal_abort call allows the caller to supply an errno
+ * which will be recorded (if possible) in the journal superblock.  This
+ * allows a client to record failure conditions in the middle of a
+ * transaction without having to complete the transaction to record the
+ * failure to disk.  ext3_error, for example, now uses this
+ * functionality.
+ *
+ * Errors which originate from within the journaling layer will NOT
+ * supply an errno; a null errno implies that absolutely no further
+ * writes are done to the journal (unless there are any already in
+ * progress).
+ *=20
+ */
+
 void journal_abort (journal_t *journal, int errno)
 {
 	lock_journal(journal);
@@ -1452,6 +1509,17 @@
 	unlock_journal(journal);
 }
=20
+/**=20
+ * int journal_errno () - returns the journal's error state.
+ * @journal: journal to examine.
+ *
+ * This is the errno numbet set with journal_abort(), the last
+ * time the journal was mounted - if the journal was stopped
+ * without calling abort this will be 0.
+ *
+ * If the journal has been aborted on this mount time -EROFS will
+ * be returned.
+ */
 int journal_errno (journal_t *journal)
 {
 	int err;
@@ -1465,6 +1533,14 @@
 	return err;
 }
=20
+
+
+/**=20
+ * int journal_clear_err () - clears the journal's error state
+ *
+ * An error must be cleared or Acked to take a FS out of readonly
+ * mode.
+ */
 int journal_clear_err (journal_t *journal)
 {
 	int err =3D 0;
@@ -1478,6 +1554,13 @@
 	return err;
 }
=20
+
+/**=20
+ * void journal_ack_err() - Ack journal err.
+ *
+ * An error must be cleared or Acked to take a FS out of readonly
+ * mode.
+ */
 void journal_ack_err (journal_t *journal)
 {
 	lock_journal(journal);
diff -Nru a/fs/jbd/recovery.c b/fs/jbd/recovery.c
--- a/fs/jbd/recovery.c	Wed Aug 14 22:13:58 2002
+++ b/fs/jbd/recovery.c	Wed Aug 14 22:13:58 2002
@@ -207,20 +207,22 @@
 		var -=3D ((journal)->j_last - (journal)->j_first);	\
 } while (0)
=20
-/*
- * journal_recover
- *
+/**
+ * int journal_recover(journal_t *journal) - recovers a on-disk journal
+ * @journal: the journal to recover
+ *=20
  * The primary function for recovering the log contents when mounting a
  * journaled device. =20
- *=20
+ */
+int journal_recover(journal_t *journal)
+{
+/*
  * Recovery is done in three passes.  In the first pass, we look for the
  * end of the log.  In the second, we assemble the list of revoke
  * blocks.  In the third and final pass, we replay any un-revoked blocks
  * in the log. =20
  */
=20
-int journal_recover(journal_t *journal)
-{
 	int			err;
 	journal_superblock_t *	sb;
=20
@@ -264,20 +266,23 @@
 	return err;
 }
=20
-/*
- * journal_skip_recovery
- *
+/**
+ * int journal_skip_recovery() - Start journal and wipe exiting records=20
+ * @journal: journal to startup
+ *=20
  * Locate any valid recovery information from the journal and set up the
  * journal structures in memory to ignore it (presumably because the
  * caller has evidence that it is out of date). =20
- *
+ * This function does'nt appear to be exorted..
+ */
+int journal_skip_recovery(journal_t *journal)
+{
+/*
  * We perform one pass over the journal to allow us to tell the user how
  * much recovery information is being erased, and to let us initialise
  * the journal transaction sequence numbers to the next unused ID.=20
  */
=20
-int journal_skip_recovery(journal_t *journal)
-{
 	int			err;
 	journal_superblock_t *	sb;
=20
diff -Nru a/fs/jbd/transaction.c b/fs/jbd/transaction.c
--- a/fs/jbd/transaction.c	Wed Aug 14 22:13:58 2002
+++ b/fs/jbd/transaction.c	Wed Aug 14 22:13:58 2002
@@ -201,19 +201,20 @@
 	return 0;
 }
=20
-/*
- * Obtain a new handle. =20
+/**
+ * handle_t *journal_start() - Obtain a new handle. =20
+ * @journal: Journal to start transaction on.
+ * @nblocks: number of block buffer we might modify
  *
  * We make sure that the transaction can guarantee at least nblocks of
  * modified buffers in the log.  We block until the log can guarantee
  * that much space. =20
  *
- * This function is visible to journal users (like ext2fs), so is not
+ * This function is visible to journal users (like ext3fs), so is not
  * called with the journal already locked.
  *
  * Return a pointer to a newly allocated handle, or NULL on failure
  */
-
 handle_t *journal_start(journal_t *journal, int nblocks)
 {
 	handle_t *handle =3D journal_current_handle();
@@ -306,7 +307,11 @@
 	return ret;
 }
=20
-/*
+/**
+ * handle_t *journal_try_start() - Don't block, but try and get a handle
+ * @journal: Journal to start transaction on.
+ * @nblocks: number of block buffer we might modify
+ *=20
  * Try to start a handle, but non-blockingly.  If we weren't able
  * to, return an ERR_PTR value.
  */
@@ -353,16 +358,18 @@
 	return handle;
 }
=20
-/*
- * journal_extend: extend buffer credits.
- *
+/**
+ * int journal_extend() - extend buffer credits.
+ * @handle:  handle to 'extend'
+ * @nblocks: nr blocks to try to extend by.
+ *=20
  * Some transactions, such as large extends and truncates, can be done
  * atomically all at once or in several stages.  The operation requests
  * a credit for a number of buffer modications in advance, but can
  * extend its credit if it needs more. =20
  *
  * journal_extend tries to give the running handle more buffer credits.
- * It does not guarantee that allocation: this is a best-effort only.
+ * It does not guarantee that allocation - this is a best-effort only.
  * The calling process MUST be able to deal cleanly with a failure to
  * extend here.
  *
@@ -371,7 +378,6 @@
  * return code < 0 implies an error
  * return code > 0 implies normal transaction-full status.
  */
-
 int journal_extend (handle_t *handle, int nblocks)
 {
 	transaction_t *transaction =3D handle->h_transaction;
@@ -420,8 +426,12 @@
 }
=20
=20
-/*
- * journal_restart: restart a handle for a multi-transaction filesystem
+/**
+ * int journal_restart() - restart a handle .
+ * @handle:  handle to restart
+ * @nblocks: nr credits requested
+ *=20
+ * Restart a handle for a multi-transaction filesystem
  * operation.
  *
  * If the journal_extend() call above fails to grant new buffer credits
@@ -463,8 +473,9 @@
 }
=20
=20
-/*=20
- * Barrier operation: establish a transaction barrier.=20
+/**
+ * void journal_lock_updates () - establish a transaction barrier.
+ * @journal:  Journal to establish a barrier on.
  *
  * This locks out any further updates from being started, and blocks
  * until all existing updates have completed, returning only once the
@@ -472,7 +483,6 @@
  *
  * The journal lock should not be held on entry.
  */
-
 void journal_lock_updates (journal_t *journal)
 {
 	lock_journal(journal);
@@ -500,12 +510,14 @@
 	down(&journal->j_barrier);
 }
=20
-/*
+/**
+ * void journal_unlock_updates (journal_t* journal) - release barrier
+ * @journal:  Journal to release the barrier on.
+ *=20
  * Release a transaction barrier obtained with journal_lock_updates().
  *
  * Should be called without the journal lock held.
  */
-
 void journal_unlock_updates (journal_t *journal)
 {
 	lock_journal(journal);
@@ -519,23 +531,14 @@
 }
=20
 /*
- * journal_get_write_access: notify intent to modify a buffer for metadata
- * (not data) update.
- *
- * If the buffer is already part of the current transaction, then there
- * is nothing we need to do.  If it is already part of a prior
+ * if the buffer is already part of the current transaction, then there
+ * is nothing we need to do.  if it is already part of a prior
  * transaction which we are still committing to disk, then we need to
  * make sure that we do not overwrite the old copy: we do copy-out to
- * preserve the copy going to disk.  We also account the buffer against
+ * preserve the copy going to disk.  we also account the buffer against
  * the handle's metadata buffer credits (unless the buffer is already
  * part of the transaction, that is).
- *
- * Returns an error code or 0 on success.
- *
- * In full data journalling mode the buffer may be of type BJ_AsyncData,
- * because we're write()ing a buffer which is also part of a shared mappin=
g.
  */
-
 static int
 do_get_write_access(handle_t *handle, struct journal_head *jh, int force_c=
opy)=20
 {
@@ -749,6 +752,17 @@
 	return error;
 }
=20
+/**
+ * int journal_get_write_access() - notify intent to modify a buffer for m=
etadata (not data) update.
+ * @handle: transaction to add buffer modifications to
+ * @bh:     bh to be used for metadata writes
+ *
+ * Returns an error code or 0 on success.
+ *
+ * In full data journalling mode the buffer may be of type BJ_AsyncData,
+ * because we're write()ing a buffer which is also part of a shared mappin=
g.
+ */
+
 int journal_get_write_access (handle_t *handle, struct buffer_head *bh)=20
 {
 	transaction_t *transaction =3D handle->h_transaction;
@@ -779,6 +793,13 @@
  * There is no lock ranking violation: it was a newly created,
  * unlocked buffer beforehand. */
=20
+/**
+ * int journal_get_create_access () - notify intent to use newly created bh
+ * @handle: ransaction to new buffer to
+ * @bh: new buffer.
+ *
+ * Call this if you create a new bh.
+ */
 int journal_get_create_access (handle_t *handle, struct buffer_head *bh)=
=20
 {
 	transaction_t *transaction =3D handle->h_transaction;
@@ -840,13 +861,14 @@
=20
=20
=20
-/*
- * journal_get_undo_access: Notify intent to modify metadata with non-
- * rewindable consequences
- *
+/**
+ * int journal_get_undo_access() -  Notify intent to modify metadata with =
non-rewindable consequences
+ * @handle: transaction
+ * @bh: buffer to undo
+ *=20
  * Sometimes there is a need to distinguish between metadata which has
  * been committed to disk and that which has not.  The ext3fs code uses
- * this for freeing and allocating space: we have to make sure that we
+ * this for freeing and allocating space, we have to make sure that we
  * do not reuse freed space until the deallocation has been committed,
  * since if we overwrote that space we would make the delete
  * un-rewindable in case of a crash.
@@ -858,13 +880,12 @@
  * as we know that the buffer has definitely been committed to disk.
  *=20
  * We never need to know which transaction the committed data is part
- * of: buffers touched here are guaranteed to be dirtied later and so
+ * of, buffers touched here are guaranteed to be dirtied later and so
  * will be committed to a new transaction in due course, at which point
  * we can discard the old committed data pointer.
  *
  * Returns error number or 0 on success. =20
  */
-
 int journal_get_undo_access (handle_t *handle, struct buffer_head *bh)
 {
 	journal_t *journal =3D handle->h_transaction->t_journal;
@@ -906,10 +927,12 @@
 	return err;
 }
=20
-/*=20
- * journal_dirty_data: mark a buffer as containing dirty data which
- * needs to be flushed before we can commit the current transaction. =20
- *
+/**=20
+ * int journal_dirty_data() -  mark a buffer as containing dirty data whic=
h needs to be flushed before we can commit the current transaction. =20
+ * @handle: transaction
+ * @bh: bufferhead to mark
+ * @async: flag
+ *=20
  * The buffer is placed on the transaction's data list and is marked as
  * belonging to the transaction.
  *
@@ -918,7 +941,10 @@
  * t_async_datalist.
  *=20
  * Returns error number or 0 on success. =20
- *
+ */
+int journal_dirty_data (handle_t *handle, struct buffer_head *bh, int asyn=
c)
+{
+/*
  * journal_dirty_data() can be called via page_launder->ext3_writepage
  * by kswapd.  So it cannot block.  Happily, there's nothing here
  * which needs lock_journal if `async' is set.
@@ -927,9 +953,6 @@
  * between BJ_AsyncData and BJ_SyncData according to who tried to
  * change its state last.
  */
-
-int journal_dirty_data (handle_t *handle, struct buffer_head *bh, int asyn=
c)
-{
 	journal_t *journal =3D handle->h_transaction->t_journal;
 	int need_brelse =3D 0;
 	int wanted_jlist =3D async ? BJ_AsyncData : BJ_SyncData;
@@ -1072,24 +1095,28 @@
 	return 0;
 }
=20
-/*=20
- * journal_dirty_metadata: mark a buffer as containing dirty metadata
- * which needs to be journaled as part of the current transaction.
+/**=20
+ * int journal_dirty_metadata() -  mark a buffer as containing dirty metad=
ata
+ * @handle: transaction to add buffer to.
+ * @bh: buffer to mark=20
+ *=20
+ * mark dirty metadata which needs to be journaled as part of the current =
transaction.
  *
  * The buffer is placed on the transaction's metadata list and is marked
  * as belonging to the transaction. =20
  *
+ * Returns error number or 0 on success. =20
+ */
+int journal_dirty_metadata (handle_t *handle, struct buffer_head *bh)
+{
+/*
  * Special care needs to be taken if the buffer already belongs to the
  * current committing transaction (in which case we should have frozen
  * data present for that commit).  In that case, we don't relink the
  * buffer: that only gets done when the old transaction finally
  * completes its commit.
  *=20
- * Returns error number or 0 on success. =20
  */
-
-int journal_dirty_metadata (handle_t *handle, struct buffer_head *bh)
-{
 	transaction_t *transaction =3D handle->h_transaction;
 	journal_t *journal =3D transaction->t_journal;
 	struct journal_head *jh =3D bh2jh(bh);
@@ -1175,9 +1202,12 @@
 }
 #endif
=20
-/*=20
- * journal_forget: bforget() for potentially-journaled buffers.  We can
- * only do the bforget if there are no commits pending against the
+/**=20
+ * void journal_forget() - bforget() for potentially-journaled buffers.
+ * @handle: transaction handle
+ * @bh:     bh to 'forget'
+ *
+ * We can only do the bforget if there are no commits pending against the
  * buffer.  If the buffer is dirty in the current running transaction we
  * can safely unlink it.=20
  *
@@ -1189,7 +1219,6 @@
  * Allow this call even if the handle has aborted --- it may be part of
  * the caller's cleanup after an abort.
  */
-
 void journal_forget (handle_t *handle, struct buffer_head *bh)
 {
 	transaction_t *transaction =3D handle->h_transaction;
@@ -1328,7 +1357,10 @@
 }
 #endif
=20
-/*
+/**
+ * int journal_stop() - complete a transaction
+ * @handle: tranaction to complete.
+ *=20
  * All done for a particular handle.
  *
  * There is not much action needed here.  We just return any remaining
@@ -1341,7 +1373,6 @@
  * return -EIO if a journal_abort has been executed since the
  * transaction began.
  */
-
 int journal_stop(handle_t *handle)
 {
 	transaction_t *transaction =3D handle->h_transaction;
@@ -1425,8 +1456,10 @@
 	return err;
 }
=20
-/*
- * For synchronous operations: force any uncommitted trasnactions
+/**int journal_force_commit() - force any uncommitted transactions
+ * @journal: journal to force
+ *
+ * For synchronous operations: force any uncommitted transactions
  * to disk.  May seem kludgy, but it reuses all the handle batching
  * code in a very simple manner.
  */
@@ -1630,6 +1663,26 @@
 	return 0;
 }
=20
+
+/**=20
+ * int journal_try_to_free_buffers() - try to free page buffers.
+ * @journal: journal for operation
+ * @page: to try and free
+ * @gfp_mask: 'IO' mode for try_to_free_buffers()
+ *
+ *=20
+ * For all the buffers on this page,
+ * if they are fully written out ordered data, move them onto BUF_CLEAN
+ * so try_to_free_buffers() can reap them.
+ *=20
+ * This function returns non-zero if we wish try_to_free_buffers()
+ * to be called. We do this if the page is releasable by try_to_free_buffe=
rs().
+ * We also do it if the page has locked or dirty buffers and the caller wa=
nts
+ * us to perform sync or async writeout.
+ */
+int journal_try_to_free_buffers(journal_t *journal,=20
+				struct page *page, int gfp_mask)
+{
 /*
  * journal_try_to_free_buffers().  For all the buffers on this page,
  * if they are fully written out ordered data, move them onto BUF_CLEAN
@@ -1654,14 +1707,7 @@
  * cannot happen because we never reallocate freed data as metadata
  * while the data is part of a transaction.  Yes?
  *
- * This function returns non-zero if we wish try_to_free_buffers()
- * to be called. We do this is the page is releasable by try_to_free_buffe=
rs().
- * We also do it if the page has locked or dirty buffers and the caller wa=
nts
- * us to perform sync or async writeout.
  */
-int journal_try_to_free_buffers(journal_t *journal,=20
-				struct page *page, int gfp_mask)
-{
 	struct buffer_head *bh;
 	struct buffer_head *tmp;
 	int locked_or_dirty =3D 0;
@@ -1872,8 +1918,15 @@
 	return may_free;
 }
=20
-/*
- * Return non-zero if the page's buffers were successfully reaped
+/**=20
+ * int journal_flushpage()=20
+ * @journal: journal to use for flush...=20
+ * @page:    page to flush
+ * @offset:  length of page to flush.
+ *
+ * Reap page buffers containing data after offset in page.
+ *
+ * Return non-zero if the page's buffers were successfully reaped.
  */
 int journal_flushpage(journal_t *journal,=20
 		      struct page *page,=20
diff -Nru a/include/linux/jbd.h b/include/linux/jbd.h
--- a/include/linux/jbd.h	Wed Aug 14 22:13:58 2002
+++ b/include/linux/jbd.h	Wed Aug 14 22:13:58 2002
@@ -62,7 +62,38 @@
 #define JFS_MIN_JOURNAL_BLOCKS 1024
=20
 #ifdef __KERNEL__
+
+/**
+ * typedef handle_t - The handle_t type represents a single atomic update =
being performed by some process.
+ *
+ * All filesystem modifications made by the process go
+ * through this handle.  Recursive operations (such as quota operations)
+ * are gathered into a single update.
+ *
+ * The buffer credits field is used to account for journaled buffers
+ * being modified by the running process.  To ensure that there is
+ * enough log space for all outstanding operations, we need to limit the
+ * number of outstanding buffers possible at any time.  When the
+ * operation completes, any buffer credits not used are credited back to
+ * the transaction, so that at all times we know how many buffers the
+ * outstanding updates on a transaction might possibly touch.=20
+ *=20
+ * This is an opaque datatype.
+ **/
 typedef struct handle_s		handle_t;	/* Atomic operation type */
+
+
+/**
+ * typedef journal_t - The journal_t maintains all of the journaling state=
 information for a single filesystem.
+ *
+ * journal_t is linked to from the fs superblock structure.
+ *=20
+ * We use the journal_t to keep track of all outstanding transaction
+ * activity on the filesystem, and to manage the state of the log
+ * writing process.
+ *
+ * This is an opaque datatype.
+ **/
 typedef struct journal_s	journal_t;	/* Journal control structure */
 #endif
=20
@@ -251,18 +282,20 @@
=20
 struct jbd_revoke_table_s;
=20
-/* The handle_t type represents a single atomic update being performed
- * by some process.  All filesystem modifications made by the process go
- * through this handle.  Recursive operations (such as quota operations)
- * are gathered into a single update.
- *
- * The buffer credits field is used to account for journaled buffers
- * being modified by the running process.  To ensure that there is
- * enough log space for all outstanding operations, we need to limit the
- * number of outstanding buffers possible at any time.  When the
- * operation completes, any buffer credits not used are credited back to
- * the transaction, so that at all times we know how many buffers the
- * outstanding updates on a transaction might possibly touch. */
+/**
+ * struct handle_s - The handle_s type is the concrete type associated wit=
h handle_t.
+ * @h_transaction: Which compound transaction is this update a part of?
+ * @h_buffer_credits: Number of remaining buffers we are allowed to dirty.
+ * @h_ref: Reference count on this handle
+ * @h_err: Field for caller's use to track errors through large fs operati=
ons
+ * @h_sync: flag for sync-on-close
+ * @h_jdata: flag to force data journaling
+ * @h_aborted: flag indicating fatal error on handle
+ **/
+
+/* Docbook can't yet cope with the bit fields, but will leave the document=
ation
+ * in so it can be fixed later.=20
+ */
=20
 struct handle_s=20
 {
@@ -275,8 +308,8 @@
 	/* Reference count on this handle */
 	int			h_ref;
=20
-	/* Field for caller's use to track errors through large fs
-	   operations */
+	/* Field for caller's use to track errors through large fs */
+	/* operations */
 	int			h_err;
=20
 	/* Flags */
@@ -400,21 +433,58 @@
 	int t_handle_count;
 };
=20
-
-/* The journal_t maintains all of the journaling state information for a
- * single filesystem.  It is linked to from the fs superblock structure.
- *=20
- * We use the journal_t to keep track of all outstanding transaction
- * activity on the filesystem, and to manage the state of the log
- * writing process. */
+/**
+ * struct journal_s - The journal_s type is the concrete type associated w=
ith journal_t.
+ * @j_flags:  General journaling state flags
+ * @j_errno:  Is there an outstanding uncleared error on the journal (from=
 a prior abort)?=20
+ * @j_sb_buffer: First part of superblock buffer
+ * @j_superblock: Second part of superblock buffer
+ * @j_format_version: Version of the superblock format
+ * @j_barrier_count:  Number of processes waiting to create a barrier lock
+ * @j_barrier: The barrier lock itself
+ * @j_running_transaction: The current running transaction..
+ * @j_committing_transaction: the transaction we are pushing to disk
+ * @j_checkpoint_transactions: a linked circular list of all transactions =
waiting for checkpointing
+ * @j_wait_transaction_locked: Wait queue for waiting for a locked transac=
tion to start committing, or for a barrier lock to be released
+ * @j_wait_logspace: Wait queue for waiting for checkpointing to complete
+ * @j_wait_done_commit: Wait queue for waiting for commit to complete=20
+ * @j_wait_checkpoint:  Wait queue to trigger checkpointing
+ * @j_wait_commit: Wait queue to trigger commit
+ * @j_wait_updates: Wait queue to wait for updates to complete
+ * @j_checkpoint_sem: Semaphore for locking against concurrent checkpoints
+ * @j_sem: The main journal lock, used by lock_journal()=20
+ * @j_head: Journal head - identifies the first unused block in the journal
+ * @j_tail: Journal tail - identifies the oldest still-used block in the j=
ournal.
+ * @j_free: Journal free - how many free blocks are there in the journal?
+ * @j_first: The block number of the first usable block=20
+ * @j_last: The block number one beyond the last usable block
+ * @j_dev: Device where we store the journal
+ * @j_blocksize: blocksize for the location where we store the journal.
+ * @j_blk_offset: starting block offset for into the device where we store=
 the journal
+ * @j_fs_dev: Device which holds the client fs.  For internal journal this=
 will be equal to j_dev
+ * @j_maxlen: Total maximum capacity of the journal region on disk.
+ * @j_inode: Optional inode where we store the journal.  If present, all  =
journal block numbers are mapped into this inode via bmap().
+ * @j_tail_sequence:  Sequence number of the oldest transaction in the log=
=20
+ * @j_transaction_sequence: Sequence number of the next transaction to gra=
nt
+ * @j_commit_sequence: Sequence number of the most recently committed tran=
saction
+ * @j_commit_request: Sequence number of the most recent transaction wanti=
ng commit=20
+ * @j_uuid: Uuid of client object.
+ * @j_task: Pointer to the current commit thread for this journal
+ * @j_max_transaction_buffers:  Maximum number of metadata buffers to allo=
w in a single compound commit transaction
+ * @j_commit_interval: What is the maximum transaction lifetime before we =
begin a commit?
+ * @j_commit_timer:  The timer used to wakeup the commit thread
+ * @j_commit_timer_active: Timer flag
+ * @j_all_journals:  Link all journals together - system-wide=20
+ * @j_revoke: The revoke table - maintains the list of revoked blocks in t=
he current transaction.
+ **/
=20
 struct journal_s
 {
 	/* General journaling state flags */
 	unsigned long		j_flags;
=20
-	/* Is there an outstanding uncleared error on the journal (from
-	 * a prior abort)? */
+	/* Is there an outstanding uncleared error on the journal (from */
+	/* a prior abort)? */
 	int			j_errno;
 =09
 	/* The superblock buffer */
@@ -436,13 +506,13 @@
 	/* ... the transaction we are pushing to disk ... */
 	transaction_t *		j_committing_transaction;
 =09
-	/* ... and a linked circular list of all transactions waiting
-	 * for checkpointing. */
+	/* ... and a linked circular list of all transactions waiting */
+	/* for checkpointing. */
 	/* Protected by journal_datalist_lock */
 	transaction_t *		j_checkpoint_transactions;
=20
-	/* Wait queue for waiting for a locked transaction to start
-           committing, or for a barrier lock to be released */
+	/* Wait queue for waiting for a locked transaction to start */
+        /*  committing, or for a barrier lock to be released */
 	wait_queue_head_t	j_wait_transaction_locked;
 =09
 	/* Wait queue for waiting for checkpointing to complete */
@@ -469,33 +539,33 @@
 	/* Journal head: identifies the first unused block in the journal. */
 	unsigned long		j_head;
 =09
-	/* Journal tail: identifies the oldest still-used block in the
-	 * journal. */
+	/* Journal tail: identifies the oldest still-used block in the */
+	/* journal. */
 	unsigned long		j_tail;
=20
 	/* Journal free: how many free blocks are there in the journal? */
 	unsigned long		j_free;
=20
-	/* Journal start and end: the block numbers of the first usable
-	 * block and one beyond the last usable block in the journal. */
+	/* Journal start and end: the block numbers of the first usable */
+	/* block and one beyond the last usable block in the journal. */
 	unsigned long		j_first, j_last;
=20
-	/* Device, blocksize and starting block offset for the location
-	 * where we store the journal. */
+	/* Device, blocksize and starting block offset for the location */
+	/* where we store the journal. */
 	kdev_t			j_dev;
 	int			j_blocksize;
 	unsigned int		j_blk_offset;
=20
-	/* Device which holds the client fs.  For internal journal this
-	 * will be equal to j_dev. */
+	/* Device which holds the client fs.  For internal journal this */
+	/* will be equal to j_dev. */
 	kdev_t			j_fs_dev;
=20
 	/* Total maximum capacity of the journal region on disk. */
 	unsigned int		j_maxlen;
=20
-	/* Optional inode where we store the journal.  If present, all
-	 * journal block numbers are mapped into this inode via
-	 * bmap(). */
+	/* Optional inode where we store the journal.  If present, all */
+	/* journal block numbers are mapped into this inode via */
+	/* bmap(). */
 	struct inode *		j_inode;
=20
 	/* Sequence number of the oldest transaction in the log */
@@ -507,23 +577,23 @@
 	/* Sequence number of the most recent transaction wanting commit */
 	tid_t			j_commit_request;
=20
-	/* Journal uuid: identifies the object (filesystem, LVM volume
-	 * etc) backed by this journal.  This will eventually be
-	 * replaced by an array of uuids, allowing us to index multiple
-	 * devices within a single journal and to perform atomic updates
-	 * across them.  */
+	/* Journal uuid: identifies the object (filesystem, LVM volume   */
+	/* etc) backed by this journal.  This will eventually be         */
+	/* replaced by an array of uuids, allowing us to index multiple  */
+	/* devices within a single journal and to perform atomic updates */
+	/* across them.  */
=20
 	__u8			j_uuid[16];
=20
 	/* Pointer to the current commit thread for this journal */
 	struct task_struct *	j_task;
=20
-	/* Maximum number of metadata buffers to allow in a single
-	 * compound commit transaction */
+	/* Maximum number of metadata buffers to allow in a single */
+	/* compound commit transaction */
 	int			j_max_transaction_buffers;
=20
-	/* What is the maximum transaction lifetime before we begin a
-	 * commit? */
+	/* What is the maximum transaction lifetime before we begin a */
+	/* commit? */
 	unsigned long		j_commit_interval;
=20
 	/* The timer used to wakeup the commit thread: */
@@ -533,8 +603,8 @@
 	/* Link all journals together - system-wide */
 	struct list_head	j_all_journals;
=20
-	/* The revoke table: maintains the list of revoked blocks in the
-           current transaction. */
+	/* The revoke table: maintains the list of revoked blocks in the */
+        /*  current transaction. */
 	struct jbd_revoke_table_s *j_revoke;
 };
=20

--G4iJoqBmSsgzjUCe--

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9WtjYqQ3nO4jeCz4RAnlBAJ9Qb/0mS+coNbAKEDyysGakd/TO1ACgrPGF
P3xMbGTQ40Jatygi3LjHGtY=
=ngQH
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--
