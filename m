Return-Path: <SRS0=BBHt=ZN=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18672C432C0
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 17:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A1B206CC
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 17:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="yReXUuVo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfKURKv (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 21 Nov 2019 12:10:51 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:42795 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfKURKv (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 21 Nov 2019 12:10:51 -0500
Received: by mail-il1-f195.google.com with SMTP id f6so12497ilh.9
        for <io-uring@vger.kernel.org>; Thu, 21 Nov 2019 09:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=QPu1PuREFUOXufmAU7KkOYywh7wmcD1DRaJTU6PTzRc=;
        b=yReXUuVoPkpuClQa5V2JiXU2X9RricBQCTxz5YJrxxfTnoyCA3I99wJVROgINjcatU
         gqKK6gyEhEb9q1hpyxBdEuwrAw0/V4V/TRTSEcD46tDKd+JJSS83mzUsa3HVnIECt8Bh
         R1AZwC5ARROhIzGMj7h7Wg2rIBs4fZ5YkKA51v/4DqOfGabgHgKMKNQzAniI4843RVwh
         mK12JbwHxZDlG+XLub1UoHQU8iwveeZ+znhwLReKpH7G3w9kpjWHWlD4GbkFNwJyt+w9
         /9n8+Q+FHyGKumLKHEJs2mWWtUqPkT1FiPGy2mwkHOBr3h4PsaXA/EoQSS2GdJHYvAxV
         SDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=QPu1PuREFUOXufmAU7KkOYywh7wmcD1DRaJTU6PTzRc=;
        b=OFq3BLYe4e0D7R2XjaARx3s/ad4LydEiyermyK8GdWkNA4OL5d1lL4MHUKNT1LgEMr
         2+x7bnppMP1okl/DFPQbqG5FUBlcrTA4nClq9wz2LDbptFIPVwFD7tID2cdjNZDow/DL
         Qet/tCl1OZIb5HmwCeIyctVVw8jTdZU+/M6n7tkt3z7oONziCrRZ/oAkKzFQAdMaGxVV
         atCZmf4t18uFvUyJcxkkcCiLlwMSkDmRW8GqZW0v3dx17yG+GtGIX/sOrfhrPfgU7T6I
         NCv2qH0dKilohqG/bp6lzunPpqYFFtzcPyFjNPT703RGqsqyrK7efABHJ3Ptb30IS+tz
         TyiQ==
X-Gm-Message-State: APjAAAW50uGlSahMvohnW+uHbOrYGaKGKaZC9YE7revHqYecU/B5g1Nx
        lOo4QRq0YKJKlXf0sJknkMWP+fl1GmS02w==
X-Google-Smtp-Source: APXvYqyRqbpaWfT6cZJb90JsaePRWxL6xFFVajr6foV0oG6AZXAJBQod3J2QYCPkZsp5aUPoydWw1g==
X-Received: by 2002:a92:6611:: with SMTP id a17mr11630049ilc.208.1574356248538;
        Thu, 21 Nov 2019 09:10:48 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id q7sm1383035ild.81.2019.11.21.09.10.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 09:10:47 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] io_uring changes for 5.5-rc
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     io-uring@vger.kernel.org
Message-ID: <e7bce6a8-c15b-58e4-e1ff-2068e4b83f84@kernel.dk>
Date:   Thu, 21 Nov 2019 10:10:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Hi Linus,

Here are the changes for io_uring for 5.5. A lot of stuff has been going
on this cycle, with improving the support for networked IO (and hence
unbounded request completion times) being one of the major themes.
There's been a set of fixes done this week, I'll send those out as well
once we're certain we're fully happy with them. This pull request
contains:

- Unification of the "normal" submit path and the SQPOLL path (Pavel)

- Support for sparse (and bigger) file sets, and updating of those file
  sets without needing to unregister/register again.

- Independently sized CQ ring, instead of just making it always 2x the
  SQ ring size. This makes it more flexible for networked applications.

- Support for overflowed CQ ring, never dropping events but providing
  backpressure on submits.

- Add support for absolute timeouts, not just relative ones.

- Support for generic cancellations. This divorces io_uring from
  workqueues as well, which additionally gets us one step closer to
  generic async system call support.

- With cancellations, we can support grabbing the process file table as
  well, just like we do mm context. This allows support for system calls
  that create file descriptors, like accept4() support that's built on
  top of that.

- Support for io_uring tracing (Dmitrii)

- Support for linked timeouts. These abort an operation if it isn't
  completed by the time noted in the linke timeout.

- Speedup tracking of poll requests

- Various cleanups making the coder easier to follow (Jackie, Pavel,
  Bob, YueHaibing, me)

- Update MAINTAINERS with new io_uring list

This will cause a merge conflict with some of the late fixes that
went into mainline. I'm attaching my merge commit of pulling master
into for-next the other day to resolve it. There are three main
conflicts, two first are trivial, the last one not that bad. But figured
I'd attach it for reference.

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-5.5/io_uring-20191121


----------------------------------------------------------------
Bob Liu (2):
      io_uring: clean up io_uring_cancel_files()
      io_uring: introduce req_need_defer()

Dmitrii Dolgov (1):
      io_uring: add set of tracing events

Jackie Liu (5):
      io_uring: replace s->needs_lock with s->in_async
      io_uring: set -EINTR directly when a signal wakes up in io_cqring_wait
      io_uring: remove passed in 'ctx' function parameter ctx if possible
      io_uring: keep io_put_req only responsible for release and put req
      io_uring: separate the io_free_req and io_free_req_find_next interface

Jens Axboe (47):
      io_uring: run dependent links inline if possible
      io_uring: allow sparse fixed file sets
      io_uring: add support for IORING_REGISTER_FILES_UPDATE
      io_uring: allow application controlled CQ ring size
      io_uring: add support for absolute timeouts
      io_uring: add support for canceling timeout requests
      io-wq: small threadpool implementation for io_uring
      io_uring: replace workqueue usage with io-wq
      io_uring: io_uring: add support for async work inheriting files
      net: add __sys_accept4_file() helper
      io_uring: add support for IORING_OP_ACCEPT
      io_uring: protect fixed file indexing with array_index_nospec()
      io_uring: support for larger fixed file sets
      io_uring: fix race with canceling timeouts
      io_uring: io_wq_create() returns an error pointer, not NULL
      io_uring: support for generic async request cancel
      io_uring: remove io_uring_add_to_prev() trace event
      io_uring: add completion trace event
      MAINTAINERS: update io_uring entry
      io-wq: use proper nesting IRQ disabling spinlocks for cancel
      io_uring: enable optimized link handling for IORING_OP_POLL_ADD
      io_uring: fixup a few spots where link failure isn't flagged
      io_uring: kill dead REQ_F_LINK_DONE flag
      io_uring: abstract out io_async_cancel_one() helper
      io_uring: add support for linked SQE timeouts
      io_uring: make io_cqring_events() take 'ctx' as argument
      io_uring: pass in io_kiocb to fill/add CQ handlers
      io_uring: add support for backlogged CQ ring
      io-wq: io_wqe_run_queue() doesn't need to use list_empty_careful()
      io-wq: add support for bounded vs unbunded work
      io_uring: properly mark async work as bounded vs unbounded
      io_uring: reduce/pack size of io_ring_ctx
      io_uring: fix error clear of ->file_table in io_sqe_files_register()
      io_uring: convert accept4() -ERESTARTSYS into -EINTR
      io_uring: provide fallback request for OOM situations
      io_uring: make ASYNC_CANCEL work with poll and timeout
      io_uring: flag SQPOLL busy condition to userspace
      io_uring: don't do flush cancel under inflight_lock
      io_uring: fix -ENOENT issue with linked timer with short timeout
      io_uring: use correct "is IO worker" helper
      io_uring: fix potential deadlock in io_poll_wake()
      io_uring: check for validity of ->rings in teardown
      io_wq: add get/put_work handlers to io_wq_create()
      io-wq: ensure we have a stable view of ->cur_work for cancellations
      io-wq: ensure free/busy list browsing see all items
      io-wq: remove now redundant struct io_wq_nulls_list
      io_uring: make POLL_ADD/POLL_REMOVE scale better

Pavel Begunkov (8):
      io_uring: remove index from sqe_submit
      io_uring: Fix mm_fault with READ/WRITE_FIXED
      io_uring: Merge io_submit_sqes and io_ring_submit
      io_uring: io_queue_link*() right after submit
      io_uring: allocate io_kiocb upfront
      io_uring: Use submit info inlined into req
      io_uring: use inlined struct sqe_submit
      io_uring: Fix getting file for non-fd opcodes

YueHaibing (1):
      io-wq: use kfree_rcu() to simplify the code

 MAINTAINERS                     |    5 +-
 fs/Kconfig                      |    3 +
 fs/Makefile                     |    1 +
 fs/io-wq.c                      | 1065 +++++++++++++++++++
 fs/io-wq.h                      |   74 ++
 fs/io_uring.c                   | 2213 ++++++++++++++++++++++++++-------------
 include/Kbuild                  |    1 +
 include/linux/sched.h           |    1 +
 include/linux/socket.h          |    3 +
 include/trace/events/io_uring.h |  358 +++++++
 include/uapi/linux/io_uring.h   |   24 +-
 init/Kconfig                    |    1 +
 kernel/sched/core.c             |   16 +-
 net/socket.c                    |   65 +-
 14 files changed, 3098 insertions(+), 732 deletions(-)
 create mode 100644 fs/io-wq.c
 create mode 100644 fs/io-wq.h
 create mode 100644 include/trace/events/io_uring.h

commit 22ffc78881bce32ae83dbd315fb15cd7ef8a6e4a
Merge: a3085d8079be b226c9e1f4cb
Author: Jens Axboe <axboe@kernel.dk>
Date:   Fri Nov 15 18:03:21 2019 -0700

    Merge branch 'master' into for-next
    
    * master: (98 commits)
      afs: Fix race in commit bulk status fetch
      KVM: Add a comment describing the /dev/kvm no_compat handling
      drm/amdgpu: fix null pointer deref in firmware header printing
      rsxx: add missed destroy_workqueue calls in remove
      iocost: check active_list of all the ancestors in iocg_activate()
      rbd: silence bogus uninitialized warning in rbd_object_map_update_finish()
      ceph: increment/decrement dio counter on async requests
      ceph: take the inode lock before acquiring cap refs
      ALSA: usb-audio: Fix incorrect size check for processing/extension units
      KVM: x86/mmu: Take slots_lock when using kvm_mmu_zap_all_fast()
      kbuild: tell sparse about the $ARCH
      sparc: vdso: fix build error of vdso32
      block, bfq: deschedule empty bfq_queues not referred by any process
      mmc: sdhci-of-at91: fix quirk2 overwrite
      ALSA: usb-audio: Fix incorrect NULL check in create_yamaha_midi_quirk()
      io_uring: ensure registered buffer import returns the IO length
      io_uring: Fix getting file for timeout
      drm/i915/tgl: MOCS table update
      Revert "drm/i915/ehl: Update MOCS table for EHL"
      KVM: Forbid /dev/kvm being opened by a compat task when CONFIG_KVM_COMPAT=n
      ...
    
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --cc fs/io_uring.c
index 25f0e8fd935b,2c819c3c855d..187e1c5021ac
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@@ -340,8 -326,7 +340,9 @@@ struct io_kiocb 
  #define REQ_F_TIMEOUT		1024	/* timeout request */
  #define REQ_F_ISREG		2048	/* regular file */
  #define REQ_F_MUST_PUNT		4096	/* must be punted even for NONBLOCK */
- #define REQ_F_INFLIGHT		8192	/* on inflight list */
- #define REQ_F_COMP_LOCKED	16384	/* completion under lock */
+ #define REQ_F_TIMEOUT_NOSEQ	8192	/* no timeout sequence */
++#define REQ_F_INFLIGHT		16384	/* on inflight list */
++#define REQ_F_COMP_LOCKED	32768	/* completion under lock */
  	u64			user_data;
  	u32			result;
  	u32			sequence;
@@@ -482,9 -454,13 +483,13 @@@ static struct io_kiocb *io_get_timeout_
  	struct io_kiocb *req;
  
  	req = list_first_entry_or_null(&ctx->timeout_list, struct io_kiocb, list);
- 	if (req && !__req_need_defer(req)) {
- 		list_del_init(&req->list);
- 		return req;
+ 	if (req) {
+ 		if (req->flags & REQ_F_TIMEOUT_NOSEQ)
+ 			return NULL;
 -		if (!__io_sequence_defer(ctx, req)) {
++		if (!__req_need_defer(req)) {
+ 			list_del_init(&req->list);
+ 			return req;
+ 		}
  	}
  
  	return NULL;
@@@ -2296,12 -1946,7 +2301,13 @@@ static int io_timeout(struct io_kiocb *
  	if (get_timespec64(&ts, u64_to_user_ptr(sqe->addr)))
  		return -EFAULT;
  
 +	if (flags & IORING_TIMEOUT_ABS)
 +		mode = HRTIMER_MODE_ABS;
 +	else
 +		mode = HRTIMER_MODE_REL;
 +
 +	hrtimer_init(&req->timeout.timer, CLOCK_MONOTONIC, mode);
+ 	req->flags |= REQ_F_TIMEOUT;
  
  	/*
  	 * sqe->off holds how many events that need to occur for this
@@@ -2352,82 -2004,14 +2365,83 @@@
  		nxt->sequence++;
  	}
  	req->sequence -= span;
+ add:
  	list_add(&req->list, entry);
 +	req->timeout.timer.function = io_timeout_fn;
 +	hrtimer_start(&req->timeout.timer, timespec64_to_ktime(ts), mode);
  	spin_unlock_irq(&ctx->completion_lock);
 +	return 0;
 +}
  
 -	hrtimer_init(&req->timeout.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 -	req->timeout.timer.function = io_timeout_fn;
 -	hrtimer_start(&req->timeout.timer, timespec64_to_ktime(ts),
 -			HRTIMER_MODE_REL);
 +static bool io_cancel_cb(struct io_wq_work *work, void *data)
 +{
 +	struct io_kiocb *req = container_of(work, struct io_kiocb, work);
 +
 +	return req->user_data == (unsigned long) data;
 +}
 +
 +static int io_async_cancel_one(struct io_ring_ctx *ctx, void *sqe_addr)
 +{
 +	enum io_wq_cancel cancel_ret;
 +	int ret = 0;
 +
 +	cancel_ret = io_wq_cancel_cb(ctx->io_wq, io_cancel_cb, sqe_addr);
 +	switch (cancel_ret) {
 +	case IO_WQ_CANCEL_OK:
 +		ret = 0;
 +		break;
 +	case IO_WQ_CANCEL_RUNNING:
 +		ret = -EALREADY;
 +		break;
 +	case IO_WQ_CANCEL_NOTFOUND:
 +		ret = -ENOENT;
 +		break;
 +	}
 +
 +	return ret;
 +}
 +
 +static void io_async_find_and_cancel(struct io_ring_ctx *ctx,
 +				     struct io_kiocb *req, __u64 sqe_addr,
 +				     struct io_kiocb **nxt)
 +{
 +	unsigned long flags;
 +	int ret;
 +
 +	ret = io_async_cancel_one(ctx, (void *) (unsigned long) sqe_addr);
 +	if (ret != -ENOENT) {
 +		spin_lock_irqsave(&ctx->completion_lock, flags);
 +		goto done;
 +	}
 +
 +	spin_lock_irqsave(&ctx->completion_lock, flags);
 +	ret = io_timeout_cancel(ctx, sqe_addr);
 +	if (ret != -ENOENT)
 +		goto done;
 +	ret = io_poll_cancel(ctx, sqe_addr);
 +done:
 +	io_cqring_fill_event(req, ret);
 +	io_commit_cqring(ctx);
 +	spin_unlock_irqrestore(&ctx->completion_lock, flags);
 +	io_cqring_ev_posted(ctx);
 +
 +	if (ret < 0 && (req->flags & REQ_F_LINK))
 +		req->flags |= REQ_F_FAIL_LINK;
 +	io_put_req_find_next(req, nxt);
 +}
 +
 +static int io_async_cancel(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 +			   struct io_kiocb **nxt)
 +{
 +	struct io_ring_ctx *ctx = req->ctx;
 +
 +	if (unlikely(ctx->flags & IORING_SETUP_IOPOLL))
 +		return -EINVAL;
 +	if (sqe->flags || sqe->ioprio || sqe->off || sqe->len ||
 +	    sqe->cancel_flags)
 +		return -EINVAL;
 +
 +	io_async_find_and_cancel(ctx, req, READ_ONCE(sqe->addr), NULL);
  	return 0;
  }
  

-- 
Jens Axboe

