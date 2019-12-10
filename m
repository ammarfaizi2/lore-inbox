Return-Path: <SRS0=l6sb=2A=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98090C43603
	for <io-uring@archiver.kernel.org>; Tue, 10 Dec 2019 16:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B992077B
	for <io-uring@archiver.kernel.org>; Tue, 10 Dec 2019 16:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="WImoAqb8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfLJQGx (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 10 Dec 2019 11:06:53 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:44675 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbfLJQGw (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 10 Dec 2019 11:06:52 -0500
Received: by mail-il1-f196.google.com with SMTP id z12so16564808iln.11
        for <io-uring@vger.kernel.org>; Tue, 10 Dec 2019 08:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=GGZebgukB5evpi4qZyfjrRtVwT20XOhKRYI+hSA9M5M=;
        b=WImoAqb8gk7A4WIliTimfcbLOkGXhLoWi6DRQcvM51qKwzuaqDyUI5Dyw0BZ9LRBkl
         MCDE9XeyDa4oH1hybijXraLTMU26Xtm9Vx3qngdAJd6E4lqp8x4lj6BubdUcC2qcYKwR
         WbSMpxM1/tpGKtlDhT+zvuhhb+xCZDdSc3cdvsHhUjb5WYcqb/hra4h8IcADDeF/7+Il
         qcgn7Sx9pGzPOtCSUIYs6QthB6ehpkDLZKxAI9kAUXqRWGoaf7EZvtB3PuIjGfOdliO2
         Arf0pSMfScN+YgkMq+OotwjyLcjSEwoEJDBDPT5r2HoD1g98AjIP/gUsAz41W7cDpl1k
         lPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=GGZebgukB5evpi4qZyfjrRtVwT20XOhKRYI+hSA9M5M=;
        b=cdF0pqgP1+N+J8yRzqaw1Ql+hAii62BiWXQhcyYuevfqVLAsl8KQBEmraMoNYYdOp7
         8J9b0GIFYkth4x90P+hBUowRdW3aArZr95/LTs1WB462Ow2h+fy0oKEZ/2DJLxXVIDRz
         4WHLDGZsXmeJpAuFUnFvzm3a3ghBshCaWtcSn5fHGBaghC1VthW1/DYBQqJXV/qjNyAr
         osS6sONwJn9RNEUfHgGKhwty2RhbBqZOkIDPTT+G6PEaRQMFM7c7i696P9hjSC6i+Z9y
         EnKyxCiL9ItFPaPjSE4EMZ6eUZfbesUoGS38fCe4I2Z8b4XE92Q6ZnNYELSIA1SJB89T
         rfxw==
X-Gm-Message-State: APjAAAVnEJJbV4vfpNnIaQdkH1/FaJv5t6JtoG6rCsRaOgLPO+27vo9y
        Fe0/CGjYQDBanZexUrBVJ/ikZNeNCCc/gw==
X-Google-Smtp-Source: APXvYqyHxnEUP3vvg8/+cgULUN43QQsDBHS39uHDEiejMcHl3FZS0o5ZOMCzvM1/je6Kaq5VMf6R+Q==
X-Received: by 2002:a05:6e02:80c:: with SMTP id u12mr34319626ilm.273.1575994011080;
        Tue, 10 Dec 2019 08:06:51 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 18sm984425ilx.68.2019.12.10.08.06.49
        for <io-uring@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 08:06:50 -0800 (PST)
To:     io-uring <io-uring@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: avoid ring quiesce for fixed file set unregister
 and update
Message-ID: <0e64d3be-c6b0-dc0d-57f7-da3312bfa743@kernel.dk>
Date:   Tue, 10 Dec 2019 09:06:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

We currently fully quiesce the ring before an unregister or update of
the fixed fileset. This is very expensive, and we can be a bit smarter
about this.

Add a percpu refcount for the file tables as a whole. Grab a percpu ref
when we use a registered file, and put it on completion. This is cheap
to do. Upon removal of a file from a set, switch the ref count to atomic
mode. When we hit zero ref on the completion side, then we know we can
drop the previously registered files. When the old files have been
dropped, switch the ref back to percpu mode for normal operation.

Since there's a period between doing the update and the kernel being
done with it, add a IORING_OP_FILES_UPDATE opcode that can perform the
same action. The application knows the update has completed when it gets
the CQE for it. Between doing the update and receiving this completion,
the application must continue to use the unregistered fd if submitting
IO on this particular file.

This takes the runtime of test/file-register from liburing from 14s to
about 0.7s.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

Patch is against the series posted for 5.5, I don't intend to queue this
one up for 5.5 at this point, it's a 5.6 thing.

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 80e02957ae9e..d129cb467ca6 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -177,6 +177,15 @@ struct fixed_file_table {
 	struct file		**files;
 };
 
+struct fixed_file_data {
+	struct fixed_file_table		*table;
+	struct io_ring_ctx		*ctx;
+
+	struct percpu_ref		refs;
+	struct llist_head		put_llist;
+	struct io_wq_work		ref_work;
+};
+
 struct io_ring_ctx {
 	struct {
 		struct percpu_ref	refs;
@@ -229,7 +238,7 @@ struct io_ring_ctx {
 	 * readers must ensure that ->refs is alive as long as the file* is
 	 * used. Only updated through io_uring_register(2).
 	 */
-	struct fixed_file_table	*file_table;
+	struct fixed_file_data	*file_data;
 	unsigned		nr_user_files;
 
 	/* if used, fixed mapped user buffers */
@@ -418,6 +427,8 @@ static void io_double_put_req(struct io_kiocb *req);
 static void __io_double_put_req(struct io_kiocb *req);
 static struct io_kiocb *io_prep_linked_timeout(struct io_kiocb *req);
 static void io_queue_linked_timeout(struct io_kiocb *req);
+static int io_sqe_files_update(struct io_ring_ctx *ctx, void __user *arg,
+			       unsigned nr_args);
 
 static struct kmem_cache *req_cachep;
 
@@ -456,7 +467,7 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 	if (!ctx->fallback_req)
 		goto err;
 
-	ctx->completions = kmalloc(2 * sizeof(struct completion), GFP_KERNEL);
+	ctx->completions = kmalloc(3 * sizeof(struct completion), GFP_KERNEL);
 	if (!ctx->completions)
 		goto err;
 
@@ -484,6 +495,7 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 	INIT_LIST_HEAD(&ctx->cq_overflow_list);
 	init_completion(&ctx->completions[0]);
 	init_completion(&ctx->completions[1]);
+	init_completion(&ctx->completions[2]);
 	mutex_init(&ctx->uring_lock);
 	init_waitqueue_head(&ctx->wait);
 	spin_lock_init(&ctx->completion_lock);
@@ -881,8 +893,12 @@ static void __io_free_req(struct io_kiocb *req)
 
 	if (req->io)
 		kfree(req->io);
-	if (req->file && !(req->flags & REQ_F_FIXED_FILE))
-		fput(req->file);
+	if (req->file) {
+		if (req->flags & REQ_F_FIXED_FILE)
+			percpu_ref_put(&ctx->file_data->refs);
+		else
+			fput(req->file);
+	}
 	if (req->flags & REQ_F_INFLIGHT) {
 		unsigned long flags;
 
@@ -2852,6 +2868,35 @@ static int io_async_cancel(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	return 0;
 }
 
+static int io_files_update(struct io_kiocb *req, bool force_nonblock)
+{
+	const struct io_uring_sqe *sqe = req->sqe;
+	struct io_ring_ctx *ctx = req->ctx;
+	void __user *arg;
+	unsigned nr_args;
+	int ret;
+
+	if (sqe->flags || sqe->ioprio || sqe->fd || sqe->off || sqe->rw_flags)
+		return -EINVAL;
+	if (force_nonblock) {
+		req->work.flags |= IO_WQ_WORK_NEEDS_FILES;
+		return -EAGAIN;
+	}
+
+	nr_args = READ_ONCE(sqe->len);
+	arg = (void __user *) (unsigned long) READ_ONCE(sqe->addr);
+
+	mutex_lock(&ctx->uring_lock);
+	ret = io_sqe_files_update(ctx, arg, nr_args);
+	mutex_unlock(&ctx->uring_lock);
+
+	if (ret < 0)
+		req_set_fail_links(req);
+	io_cqring_add_event(req, ret);
+	io_put_req(req);
+	return 0;
+}
+
 static int io_req_defer_prep(struct io_kiocb *req, struct io_async_ctx *io)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
@@ -2883,6 +2928,8 @@ static int io_req_defer_prep(struct io_kiocb *req, struct io_async_ctx *io)
 		return io_timeout_prep(req, io, false);
 	case IORING_OP_LINK_TIMEOUT:
 		return io_timeout_prep(req, io, true);
+	case IORING_OP_FILES_UPDATE:
+		return -EINVAL;
 	default:
 		req->io = io;
 		return 0;
@@ -2989,6 +3036,9 @@ static int io_issue_sqe(struct io_kiocb *req, struct io_kiocb **nxt,
 	case IORING_OP_ASYNC_CANCEL:
 		ret = io_async_cancel(req, req->sqe, nxt);
 		break;
+	case IORING_OP_FILES_UPDATE:
+		ret = io_files_update(req, force_nonblock);
+		break;
 	default:
 		ret = -EINVAL;
 		break;
@@ -3090,8 +3140,8 @@ static inline struct file *io_file_from_index(struct io_ring_ctx *ctx,
 {
 	struct fixed_file_table *table;
 
-	table = &ctx->file_table[index >> IORING_FILE_TABLE_SHIFT];
-	return table->files[index & IORING_FILE_TABLE_MASK];
+	table = &ctx->file_data->table[index >> IORING_FILE_TABLE_SHIFT];
+	return READ_ONCE(table->files[index & IORING_FILE_TABLE_MASK]);
 }
 
 static int io_req_set_file(struct io_submit_state *state, struct io_kiocb *req)
@@ -3110,7 +3160,7 @@ static int io_req_set_file(struct io_submit_state *state, struct io_kiocb *req)
 		return 0;
 
 	if (flags & IOSQE_FIXED_FILE) {
-		if (unlikely(!ctx->file_table ||
+		if (unlikely(!ctx->file_data ||
 		    (unsigned) fd >= ctx->nr_user_files))
 			return -EBADF;
 		fd = array_index_nospec(fd, ctx->nr_user_files);
@@ -3118,6 +3168,7 @@ static int io_req_set_file(struct io_submit_state *state, struct io_kiocb *req)
 		if (!req->file)
 			return -EBADF;
 		req->flags |= REQ_F_FIXED_FILE;
+		percpu_ref_get(&ctx->file_data->refs);
 	} else {
 		if (req->needs_fixed_file)
 			return -EBADF;
@@ -3796,15 +3847,18 @@ static int io_sqe_files_unregister(struct io_ring_ctx *ctx)
 {
 	unsigned nr_tables, i;
 
-	if (!ctx->file_table)
+	if (!ctx->file_data)
 		return -ENXIO;
 
+	percpu_ref_kill(&ctx->file_data->refs);
+	wait_for_completion(&ctx->completions[2]);
 	__io_sqe_files_unregister(ctx);
 	nr_tables = DIV_ROUND_UP(ctx->nr_user_files, IORING_MAX_FILES_TABLE);
 	for (i = 0; i < nr_tables; i++)
-		kfree(ctx->file_table[i].files);
-	kfree(ctx->file_table);
-	ctx->file_table = NULL;
+		kfree(ctx->file_data->table[i].files);
+	kfree(ctx->file_data->table);
+	kfree(ctx->file_data);
+	ctx->file_data = NULL;
 	ctx->nr_user_files = 0;
 	return 0;
 }
@@ -3954,7 +4008,7 @@ static int io_sqe_alloc_file_tables(struct io_ring_ctx *ctx, unsigned nr_tables,
 	int i;
 
 	for (i = 0; i < nr_tables; i++) {
-		struct fixed_file_table *table = &ctx->file_table[i];
+		struct fixed_file_table *table = &ctx->file_data->table[i];
 		unsigned this_files;
 
 		this_files = min(nr_files, IORING_MAX_FILES_TABLE);
@@ -3969,36 +4023,158 @@ static int io_sqe_alloc_file_tables(struct io_ring_ctx *ctx, unsigned nr_tables,
 		return 0;
 
 	for (i = 0; i < nr_tables; i++) {
-		struct fixed_file_table *table = &ctx->file_table[i];
+		struct fixed_file_table *table = &ctx->file_data->table[i];
 		kfree(table->files);
 	}
 	return 1;
 }
 
+static void io_ring_file_put(struct io_ring_ctx *ctx, struct file *file)
+{
+#if defined(CONFIG_UNIX)
+	struct sock *sock = ctx->ring_sock->sk;
+	struct sk_buff_head list, *head = &sock->sk_receive_queue;
+	struct sk_buff *skb;
+	int i;
+
+	__skb_queue_head_init(&list);
+
+	/*
+	 * Find the skb that holds this file in its SCM_RIGHTS. When found,
+	 * remove this entry and rearrange the file array.
+	 */
+	skb = skb_dequeue(head);
+	while (skb) {
+		struct scm_fp_list *fp;
+
+		fp = UNIXCB(skb).fp;
+		for (i = 0; i < fp->count; i++) {
+			int left;
+
+			if (fp->fp[i] != file)
+				continue;
+
+			unix_notinflight(fp->user, fp->fp[i]);
+			left = fp->count - 1 - i;
+			if (left) {
+				memmove(&fp->fp[i], &fp->fp[i + 1],
+						left * sizeof(struct file *));
+			}
+			fp->count--;
+			if (!fp->count) {
+				kfree_skb(skb);
+				skb = NULL;
+			} else {
+				__skb_queue_tail(&list, skb);
+			}
+			fput(file);
+			file = NULL;
+			break;
+		}
+
+		if (!file)
+			break;
+
+		__skb_queue_tail(&list, skb);
+
+		skb = skb_dequeue(head);
+	}
+
+	if (skb_peek(&list)) {
+		spin_lock_irq(&head->lock);
+		while ((skb = __skb_dequeue(&list)) != NULL)
+			__skb_queue_tail(head, skb);
+		spin_unlock_irq(&head->lock);
+	}
+#else
+	fput(file);
+#endif
+}
+
+static void io_ring_file_ref_switch(struct io_wq_work **workptr)
+{
+	struct fixed_file_data *data;
+	struct llist_node *node;
+	struct file *file, *tmp;
+
+	data = container_of(*workptr, struct fixed_file_data, ref_work);
+
+	clear_bit_unlock(0, (unsigned long *) &data->ref_work.files);
+	smp_mb__after_atomic();
+
+	while ((node = llist_del_all(&data->put_llist)) != NULL) {
+		llist_for_each_entry_safe(file, tmp, node, f_u.fu_llist)
+			io_ring_file_put(data->ctx, file);
+	}
+
+	percpu_ref_switch_to_percpu(&data->refs);
+	if (percpu_ref_is_dying(&data->refs))
+		complete(&data->ctx->completions[2]);
+}
+
+static void io_file_data_ref_zero(struct percpu_ref *ref)
+{
+	struct fixed_file_data *data;
+
+	data = container_of(ref, struct fixed_file_data, refs);
+	if (test_and_set_bit_lock(0, (unsigned long *) &data->ref_work.files))
+		return;
+	if (!llist_empty(&data->put_llist)) {
+		percpu_ref_get(&data->refs);
+		io_wq_enqueue(data->ctx->io_wq, &data->ref_work);
+	} else {
+		clear_bit_unlock(0, (unsigned long *) &data->ref_work.files);
+		if (percpu_ref_is_dying(&data->refs))
+			complete(&data->ctx->completions[2]);
+	}
+}
+
 static int io_sqe_files_register(struct io_ring_ctx *ctx, void __user *arg,
 				 unsigned nr_args)
 {
 	__s32 __user *fds = (__s32 __user *) arg;
 	unsigned nr_tables;
+	struct file *file;
 	int fd, ret = 0;
 	unsigned i;
 
-	if (ctx->file_table)
+	if (ctx->file_data)
 		return -EBUSY;
 	if (!nr_args)
 		return -EINVAL;
 	if (nr_args > IORING_MAX_FIXED_FILES)
 		return -EMFILE;
 
+	ctx->file_data = kzalloc(sizeof(*ctx->file_data), GFP_KERNEL);
+	if (!ctx->file_data)
+		return -ENOMEM;
+	ctx->file_data->ctx = ctx;
+
 	nr_tables = DIV_ROUND_UP(nr_args, IORING_MAX_FILES_TABLE);
-	ctx->file_table = kcalloc(nr_tables, sizeof(struct fixed_file_table),
+	ctx->file_data->table = kcalloc(nr_tables,
+					sizeof(struct fixed_file_table),
 					GFP_KERNEL);
-	if (!ctx->file_table)
+	if (!ctx->file_data->table) {
+		kfree(ctx->file_data);
+		ctx->file_data = NULL;
 		return -ENOMEM;
+	}
+
+	if (percpu_ref_init(&ctx->file_data->refs, io_file_data_ref_zero,
+				PERCPU_REF_ALLOW_REINIT, GFP_KERNEL)) {
+		kfree(ctx->file_data->table);
+		kfree(ctx->file_data);
+		ctx->file_data = NULL;
+	}
+	ctx->file_data->put_llist.first = NULL;
+	INIT_IO_WORK(&ctx->file_data->ref_work, io_ring_file_ref_switch);
+	ctx->file_data->ref_work.flags = IO_WQ_WORK_INTERNAL;
 
 	if (io_sqe_alloc_file_tables(ctx, nr_tables, nr_args)) {
-		kfree(ctx->file_table);
-		ctx->file_table = NULL;
+		percpu_ref_exit(&ctx->file_data->refs);
+		kfree(ctx->file_data->table);
+		kfree(ctx->file_data);
+		ctx->file_data = NULL;
 		return -ENOMEM;
 	}
 
@@ -4015,13 +4191,14 @@ static int io_sqe_files_register(struct io_ring_ctx *ctx, void __user *arg,
 			continue;
 		}
 
-		table = &ctx->file_table[i >> IORING_FILE_TABLE_SHIFT];
+		table = &ctx->file_data->table[i >> IORING_FILE_TABLE_SHIFT];
 		index = i & IORING_FILE_TABLE_MASK;
-		table->files[index] = fget(fd);
+		file = fget(fd);
 
 		ret = -EBADF;
-		if (!table->files[index])
+		if (!file)
 			break;
+
 		/*
 		 * Don't allow io_uring instances to be registered. If UNIX
 		 * isn't enabled, then this causes a reference cycle and this
@@ -4029,26 +4206,26 @@ static int io_sqe_files_register(struct io_ring_ctx *ctx, void __user *arg,
 		 * handle it just fine, but there's still no point in allowing
 		 * a ring fd as it doesn't support regular read/write anyway.
 		 */
-		if (table->files[index]->f_op == &io_uring_fops) {
-			fput(table->files[index]);
+		if (file->f_op == &io_uring_fops) {
+			fput(file);
 			break;
 		}
 		ret = 0;
+		WRITE_ONCE(table->files[index], file);
 	}
 
 	if (ret) {
 		for (i = 0; i < ctx->nr_user_files; i++) {
-			struct file *file;
-
 			file = io_file_from_index(ctx, i);
 			if (file)
 				fput(file);
 		}
 		for (i = 0; i < nr_tables; i++)
-			kfree(ctx->file_table[i].files);
+			kfree(ctx->file_data->table[i].files);
 
-		kfree(ctx->file_table);
-		ctx->file_table = NULL;
+		kfree(ctx->file_data->table);
+		kfree(ctx->file_data);
+		ctx->file_data = NULL;
 		ctx->nr_user_files = 0;
 		return ret;
 	}
@@ -4060,69 +4237,6 @@ static int io_sqe_files_register(struct io_ring_ctx *ctx, void __user *arg,
 	return ret;
 }
 
-static void io_sqe_file_unregister(struct io_ring_ctx *ctx, int index)
-{
-#if defined(CONFIG_UNIX)
-	struct file *file = io_file_from_index(ctx, index);
-	struct sock *sock = ctx->ring_sock->sk;
-	struct sk_buff_head list, *head = &sock->sk_receive_queue;
-	struct sk_buff *skb;
-	int i;
-
-	__skb_queue_head_init(&list);
-
-	/*
-	 * Find the skb that holds this file in its SCM_RIGHTS. When found,
-	 * remove this entry and rearrange the file array.
-	 */
-	skb = skb_dequeue(head);
-	while (skb) {
-		struct scm_fp_list *fp;
-
-		fp = UNIXCB(skb).fp;
-		for (i = 0; i < fp->count; i++) {
-			int left;
-
-			if (fp->fp[i] != file)
-				continue;
-
-			unix_notinflight(fp->user, fp->fp[i]);
-			left = fp->count - 1 - i;
-			if (left) {
-				memmove(&fp->fp[i], &fp->fp[i + 1],
-						left * sizeof(struct file *));
-			}
-			fp->count--;
-			if (!fp->count) {
-				kfree_skb(skb);
-				skb = NULL;
-			} else {
-				__skb_queue_tail(&list, skb);
-			}
-			fput(file);
-			file = NULL;
-			break;
-		}
-
-		if (!file)
-			break;
-
-		__skb_queue_tail(&list, skb);
-
-		skb = skb_dequeue(head);
-	}
-
-	if (skb_peek(&list)) {
-		spin_lock_irq(&head->lock);
-		while ((skb = __skb_dequeue(&list)) != NULL)
-			__skb_queue_tail(head, skb);
-		spin_unlock_irq(&head->lock);
-	}
-#else
-	fput(io_file_from_index(ctx, index));
-#endif
-}
-
 static int io_sqe_file_register(struct io_ring_ctx *ctx, struct file *file,
 				int index)
 {
@@ -4169,12 +4283,16 @@ static int io_sqe_file_register(struct io_ring_ctx *ctx, struct file *file,
 static int io_sqe_files_update(struct io_ring_ctx *ctx, void __user *arg,
 			       unsigned nr_args)
 {
+	struct fixed_file_data *data = ctx->file_data;
+	unsigned long __percpu *percpu_count;
 	struct io_uring_files_update up;
+	bool did_unregister = false;
+	struct file *file;
 	__s32 __user *fds;
 	int fd, i, err;
 	__u32 done;
 
-	if (!ctx->file_table)
+	if (!data)
 		return -ENXIO;
 	if (!nr_args)
 		return -EINVAL;
@@ -4197,15 +4315,15 @@ static int io_sqe_files_update(struct io_ring_ctx *ctx, void __user *arg,
 			break;
 		}
 		i = array_index_nospec(up.offset, ctx->nr_user_files);
-		table = &ctx->file_table[i >> IORING_FILE_TABLE_SHIFT];
+		table = &ctx->file_data->table[i >> IORING_FILE_TABLE_SHIFT];
 		index = i & IORING_FILE_TABLE_MASK;
 		if (table->files[index]) {
-			io_sqe_file_unregister(ctx, i);
-			table->files[index] = NULL;
+			file = io_file_from_index(ctx, index);
+			llist_add(&file->f_u.fu_llist, &data->put_llist);
+			WRITE_ONCE(table->files[index], NULL);
+			did_unregister = true;
 		}
 		if (fd != -1) {
-			struct file *file;
-
 			file = fget(fd);
 			if (!file) {
 				err = -EBADF;
@@ -4224,7 +4342,7 @@ static int io_sqe_files_update(struct io_ring_ctx *ctx, void __user *arg,
 				err = -EBADF;
 				break;
 			}
-			table->files[index] = file;
+			WRITE_ONCE(table->files[index], file);
 			err = io_sqe_file_register(ctx, file, i);
 			if (err)
 				break;
@@ -4234,6 +4352,11 @@ static int io_sqe_files_update(struct io_ring_ctx *ctx, void __user *arg,
 		up.offset++;
 	}
 
+	if (did_unregister && __ref_is_percpu(&data->refs, &percpu_count)) {
+		percpu_ref_put(&data->refs);
+		percpu_ref_switch_to_atomic(&data->refs, NULL);
+	}
+
 	return done ? done : err;
 }
 
@@ -5152,18 +5275,22 @@ static int __io_uring_register(struct io_ring_ctx *ctx, unsigned opcode,
 	if (percpu_ref_is_dying(&ctx->refs))
 		return -ENXIO;
 
-	percpu_ref_kill(&ctx->refs);
+	if (opcode != IORING_UNREGISTER_FILES &&
+	    opcode != IORING_REGISTER_FILES_UPDATE) {
+		percpu_ref_kill(&ctx->refs);
 
-	/*
-	 * Drop uring mutex before waiting for references to exit. If another
-	 * thread is currently inside io_uring_enter() it might need to grab
-	 * the uring_lock to make progress. If we hold it here across the drain
-	 * wait, then we can deadlock. It's safe to drop the mutex here, since
-	 * no new references will come in after we've killed the percpu ref.
-	 */
-	mutex_unlock(&ctx->uring_lock);
-	wait_for_completion(&ctx->completions[0]);
-	mutex_lock(&ctx->uring_lock);
+		/*
+		 * Drop uring mutex before waiting for references to exit. If
+		 * another thread is currently inside io_uring_enter() it might
+		 * need to grab the uring_lock to make progress. If we hold it
+		 * here across the drain wait, then we can deadlock. It's safe
+		 * to drop the mutex here, since no new references will come in
+		 * after we've killed the percpu ref.
+		 */
+		mutex_unlock(&ctx->uring_lock);
+		wait_for_completion(&ctx->completions[0]);
+		mutex_lock(&ctx->uring_lock);
+	}
 
 	switch (opcode) {
 	case IORING_REGISTER_BUFFERS:
@@ -5204,9 +5331,13 @@ static int __io_uring_register(struct io_ring_ctx *ctx, unsigned opcode,
 		break;
 	}
 
-	/* bring the ctx back to life */
-	reinit_completion(&ctx->completions[0]);
-	percpu_ref_reinit(&ctx->refs);
+
+	if (opcode != IORING_UNREGISTER_FILES &&
+	    opcode != IORING_REGISTER_FILES_UPDATE) {
+		/* bring the ctx back to life */
+		reinit_completion(&ctx->completions[0]);
+		percpu_ref_reinit(&ctx->refs);
+	}
 	return ret;
 }
 
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index ea231366f5fd..24df84e2194f 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -75,6 +75,7 @@ struct io_uring_sqe {
 #define IORING_OP_ASYNC_CANCEL	14
 #define IORING_OP_LINK_TIMEOUT	15
 #define IORING_OP_CONNECT	16
+#define IORING_OP_FILES_UPDATE	17
 
 /*
  * sqe->fsync_flags

-- 
Jens Axboe

