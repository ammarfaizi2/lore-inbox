Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261465AbVCWWSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbVCWWSf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 17:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbVCWWSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 17:18:35 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:52694 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261465AbVCWWSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 17:18:04 -0500
From: Darren Williams <dsw@gelato.unsw.edu.au>
To: Mark Wong <markw@osdl.org>
Date: Thu, 24 Mar 2005 09:17:53 +1100
Cc: linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: ext3 journalling BUG on full filesystem
Message-ID: <20050323221753.GA6334@cse.unsw.EDU.AU>
Mail-Followup-To: Mark Wong <markw@osdl.org>, linux-kernel@vger.kernel.org,
	sct@redhat.com
References: <20050323202130.GA30844@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="JP+T4n/bALQSJXh8"
Content-Disposition: inline
In-Reply-To: <20050323202130.GA30844@osdl.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Mark

Looks like you need to apply the attached patch (for the current
bk kernel or see the link below for an earlier version (which
will require some modification to remove implicit warnings, see
to extern and prototype declarations for __journal_temp_unlink_buffer
in attached patch). 

Looking at Anton reply this may not be true but worth a try.

Darren

--

Stephen
 I am still seeing this Oops on ext3 journal with current bk tree, this
patch: 

http://lkml.org/lkml/2005/3/8/147

fixes the problem though required changes to remove implicit declaration
warnings updated patch attached.

Unable to handle kernel NULL pointer dereference (address 0000000000000018)
kjournald[16894]: Oops 8821862825984 [1]

Pid: 16894, CPU 0, comm:            kjournald
psr : 0000101008026018 ifs : 8000000000000e21 ip  : [<a0000001001ce1e0>]    Not tainted
ip is at journal_commit_transaction+0x840/0x2700
unat: 0000000000000000 pfs : 0000000000000e21 rsc : 0000000000000003
rnat: 0000000000000000 bsps: 0000000000000000 pr  : 0000000000001641
ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c8a70433f
csd : 0000000000000000 ssd : 0000000000000000
b0  : a0000001001ce300 b6  : a000000100633000 b7  : a00000010000a9d0
f6  : 0fffbccccccccc8c00000 f7  : 0ffea9877e00000000000
f8  : 1000ff0f0000000000000 f9  : 10002a000000000000000
f10 : 1000cc0bffffffc303400 f11 : 1003e0000000000003030
r1  : a000000100a8c830 r2  : 0000000000000286 r3  : 0000000000000000
r8  : 0000000000000001 r9  : e000070062f40d50 r10 : e000070062f40d60
r11 : 0000000000000000 r12 : e000070062f47d10 r13 : e000070062f40000
r14 : e000070062f47cb0 r15 : e00007005c2632f8 r16 : 0000000040000000
r17 : e00007005c263338 r18 : 0000000000000000 r19 : 0009804c8a70433f
r20 : 0000070062f40000 r21 : a00000010062f9d0 r22 : 0000000000000000
r23 : 0000000000000000 r24 : 0000000000000000 r25 : 0000000000000000
r26 : 0000000000000000 r27 : 0000000000000000 r28 : 0000000000005a41
r29 : 0000000000000000 r30 : 0000000000000000 r31 : e000070079ab18dc

Call Trace:
 [<a00000010000fd80>] show_stack+0x80/0xa0
                                sp=e000070062f478d0 bsp=e000070062f41060
 [<a0000001000105e0>] show_regs+0x7e0/0x800
                                sp=e000070062f47aa0 bsp=e000070062f41000
 [<a000000100033f90>] die+0x150/0x1c0
                                sp=e000070062f47ab0 bsp=e000070062f40fb8
 [<a000000100052d50>] ia64_do_page_fault+0x370/0x980
                                sp=e000070062f47ab0 bsp=e000070062f40f50
 [<a00000010000b160>] ia64_leave_kernel+0x0/0x260
                                sp=e000070062f47b40 bsp=e000070062f40f50
 [<a0000001001ce1e0>] journal_commit_transaction+0x840/0x2700
                                sp=e000070062f47d10 bsp=e000070062f40e48
 [<a0000001001d5260>] kjournald+0x180/0x4e0
                                sp=e000070062f47d80 bsp=e000070062f40dd8
 [<a000000100011df0>] kernel_thread_helper+0xd0/0x100
                                sp=e000070062f47e30 bsp=e000070062f40db0
 [<a0000001000090e0>] start_kernel_thread+0x20/0x40
                                sp=e000070062f47e30 bsp=e000070062f40db0



> On Wed, 23 Mar 2005, Mark Wong wrote:

> I originally reported this to the linuxppc64-dev list, since I made it
> happen on a POWER system.  I'm told this might be more generic...
> 
> Anyone run into something like this?
> 
> Mark
> 
> ----- Forwarded message from Mark Wong <markw@osdl.org> -----
> 
> Date: Wed, 23 Mar 2005 08:05:30 -0800
> To: linuxppc64-dev@ozlabs.org
> From: Mark Wong <markw@osdl.org>
> Subject: ext3 journalling BUG on full filesystem
> 
> Hi,
> 
> I'm running 2.6.11 and I'm suspecting that a full ext3 filesystem is
> causing the following problem when performing some journaling
> operation.  Let me know if I can provide more details:
> 
> cpu 0x6: Vector: 700 (Program Check) at [c0000002e4f3f6d0]
>     pc: c0000000000a5fbc: .submit_bh+0x64/0x1fc
>     lr: c0000000000a62b4: .ll_rw_block+0x160/0x164
>     sp: c0000002e4f3f950
>    msr: 8000000000029032
>   current = 0xc00000038ff5c7c0
>   paca    = 0xc000000000612000
>     pid   = 1376, comm = kjournald
> kernel BUG in submit_bh at fs/buffer.c:2706!
> enter ? for help
> 6:mon> t
> [c0000002e4f3f9f0] c0000000000a62b4 .ll_rw_block+0x160/0x164
> [c0000002e4f3fab0] c000000000151ac4 .journal_commit_transaction+0xd88/0x16d4
> [c0000002e4f3fe30] c000000000155590 .kjournald+0x114/0x308
> [c0000002e4f3ff90] c000000000013ec0 .kernel_thread+0x4c/0x6c
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--------------------------------------------------
Darren Williams <dsw AT gelato.unsw.edu.au>
Gelato@UNSW <www.gelato.unsw.edu.au>
--------------------------------------------------

--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="jbd-temp-unlink.patch"

Fix destruction of in-use journal_head

journal_put_journal_head() can destroy a journal_head at any time as
long as the jh's b_jcount is zero and b_transaction is NULL.  It has no
locking protection against the rest of the journaling code, as the lock
it uses to protect b_jcount and bh->b_private is not used elsewhere in
jbd.

However, there are small windows where b_transaction is getting set
temporarily to NULL during normal operations; typically this is
happening in 

			__journal_unfile_buffer(jh);
 			__journal_file_buffer(jh, ...);

call pairs, as __journal_unfile_buffer() will set b_transaction to NULL
and __journal_file_buffer() re-sets it afterwards.  A truncate running
in parallel can lead to journal_unmap_buffer() destroying the jh if it
occurs between these two calls.

Fix this by adding a variant of __journal_unfile_buffer() which is only
used for these temporary jh unlinks, and which leaves the b_transaction
field intact so that we never leave a window open where b_transaction is
NULL.

Additionally, trap this error if it does occur, by checking against
jh->b_jlist being non-null when we destroy a jh.

Signed-off-by: Stephen Tweedie <sct@redhat.com>
Signed-off-by: Darren Williams <dsw@gelato.unsw.edu.au>

Index: linux-2.5-import/fs/jbd/commit.c
===================================================================
--- linux-2.5-import.orig/fs/jbd/commit.c	2005-03-24 08:47:00.000000000 +1100
+++ linux-2.5-import/fs/jbd/commit.c	2005-03-24 09:07:34.000000000 +1100
@@ -166,6 +166,7 @@
  * The primary function for committing a transaction to the log.  This
  * function is called by the journal thread to begin a complete commit.
  */
+extern  void __journal_temp_unlink_buffer(struct journal_head *jh);
 void journal_commit_transaction(journal_t *journal)
 {
 	transaction_t *commit_transaction;
@@ -341,7 +342,7 @@
 			BUFFER_TRACE(bh, "locked");
 			if (!inverted_lock(journal, bh))
 				goto write_out_data;
-			__journal_unfile_buffer(jh);
+			__journal_temp_unlink_buffer(jh);
 			__journal_file_buffer(jh, commit_transaction,
 						BJ_Locked);
 			jbd_unlock_bh_state(bh);
Index: linux-2.5-import/fs/jbd/journal.c
===================================================================
--- linux-2.5-import.orig/fs/jbd/journal.c	2005-03-24 08:47:00.000000000 +1100
+++ linux-2.5-import/fs/jbd/journal.c	2005-03-24 08:47:00.000000000 +1100
@@ -1803,6 +1803,7 @@
 		if (jh->b_transaction == NULL &&
 				jh->b_next_transaction == NULL &&
 				jh->b_cp_transaction == NULL) {
+			J_ASSERT_JH(jh, jh->b_jlist == BJ_None);
 			J_ASSERT_BH(bh, buffer_jbd(bh));
 			J_ASSERT_BH(bh, jh2bh(jh) == bh);
 			BUFFER_TRACE(bh, "remove journal_head");
Index: linux-2.5-import/fs/jbd/transaction.c
===================================================================
--- linux-2.5-import.orig/fs/jbd/transaction.c	2005-03-24 08:47:00.000000000 +1100
+++ linux-2.5-import/fs/jbd/transaction.c	2005-03-24 09:07:38.000000000 +1100
@@ -922,6 +922,8 @@
  * journal_dirty_data() can be called via page_launder->ext3_writepage
  * by kswapd.
  */
+void __journal_temp_unlink_buffer(struct journal_head *jh);
+
 int journal_dirty_data(handle_t *handle, struct buffer_head *bh)
 {
 	journal_t *journal = handle->h_transaction->t_journal;
@@ -1031,7 +1033,12 @@
 			/* journal_clean_data_list() may have got there first */
 			if (jh->b_transaction != NULL) {
 				JBUFFER_TRACE(jh, "unfile from commit");
-				__journal_unfile_buffer(jh);
+				__journal_temp_unlink_buffer(jh);
+				/* It still points to the committing
+				 * transaction; move it to this one so
+				 * that the refile assert checks are
+				 * happy. */
+				jh->b_transaction = handle->h_transaction;
 			}
 			/* The buffer will be refiled below */
 
@@ -1045,7 +1052,8 @@
 		if (jh->b_jlist != BJ_SyncData && jh->b_jlist != BJ_Locked) {
 			JBUFFER_TRACE(jh, "not on correct data list: unfile");
 			J_ASSERT_JH(jh, jh->b_jlist != BJ_Shadow);
-			__journal_unfile_buffer(jh);
+			__journal_temp_unlink_buffer(jh);
+			jh->b_transaction = handle->h_transaction;
 			JBUFFER_TRACE(jh, "file as data");
 			__journal_file_buffer(jh, handle->h_transaction,
 						BJ_SyncData);
@@ -1225,7 +1233,6 @@
 
 		JBUFFER_TRACE(jh, "belongs to current transaction: unfile");
 
-		__journal_unfile_buffer(jh);
 		drop_reserve = 1;
 
 		/* 
@@ -1241,8 +1248,10 @@
 		 */
 
 		if (jh->b_cp_transaction) {
+			__journal_temp_unlink_buffer(jh);
 			__journal_file_buffer(jh, transaction, BJ_Forget);
 		} else {
+			__journal_unfile_buffer(jh);
 			journal_remove_journal_head(bh);
 			__brelse(bh);
 			if (!buffer_jbd(bh)) {
@@ -1468,7 +1477,7 @@
  *
  * Called under j_list_lock.  The journal may not be locked.
  */
-void __journal_unfile_buffer(struct journal_head *jh)
+void __journal_temp_unlink_buffer(struct journal_head *jh)
 {
 	struct journal_head **list = NULL;
 	transaction_t *transaction;
@@ -1485,7 +1494,7 @@
 
 	switch (jh->b_jlist) {
 	case BJ_None:
-		goto out;
+		return;
 	case BJ_SyncData:
 		list = &transaction->t_sync_datalist;
 		break;
@@ -1518,7 +1527,11 @@
 	jh->b_jlist = BJ_None;
 	if (test_clear_buffer_jbddirty(bh))
 		mark_buffer_dirty(bh);	/* Expose it to the VM */
-out:
+}
+
+void __journal_unfile_buffer(struct journal_head *jh)
+{
+	__journal_temp_unlink_buffer(jh);
 	jh->b_transaction = NULL;
 }
 
@@ -1928,7 +1941,7 @@
 	}
 
 	if (jh->b_transaction)
-		__journal_unfile_buffer(jh);
+		__journal_temp_unlink_buffer(jh);
 	jh->b_transaction = transaction;
 
 	switch (jlist) {
@@ -2011,7 +2024,7 @@
 	 */
 
 	was_dirty = test_clear_buffer_jbddirty(bh);
-	__journal_unfile_buffer(jh);
+	__journal_temp_unlink_buffer(jh);
 	jh->b_transaction = jh->b_next_transaction;
 	jh->b_next_transaction = NULL;
 	__journal_file_buffer(jh, jh->b_transaction, BJ_Metadata);

--JP+T4n/bALQSJXh8--
