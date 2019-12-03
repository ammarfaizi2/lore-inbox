Return-Path: <SRS0=jlnN=ZZ=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C5AC432C0
	for <io-uring@archiver.kernel.org>; Tue,  3 Dec 2019 02:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9437D20684
	for <io-uring@archiver.kernel.org>; Tue,  3 Dec 2019 02:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nQhHHiYv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfLCCuY (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 2 Dec 2019 21:50:24 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39123 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfLCCuX (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 2 Dec 2019 21:50:23 -0500
Received: by mail-pj1-f66.google.com with SMTP id v93so850156pjb.6
        for <io-uring@vger.kernel.org>; Mon, 02 Dec 2019 18:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=V7mw1PZacwUsAaB1VU83lkGXXWmGIKU6D8r7r10MjMA=;
        b=nQhHHiYv6B8jvNmywl1t78XU0S97l9JpajuU5UFSSF7Aa+fEuc/KMFIG4W5mYnCa6c
         LSRiqg52QTIzxegeXRoro2NfBMNdAo/Q6tuFhoUqU4yY5KU0BW4356qBqoxE9XLTh91c
         mBHQ7GFk+hztkfKEbcz55qHv5VaRTbCKAnJshHYQwh8mAtQzyf/NlSeOJC7CkV56hu07
         Mc9Arv7sAOfukknuEVD1mDLcOtkpDEU8imLo1tqKssioCUoyarl+iFuUHHxRLnloJRXB
         4eQ2Y6pQqkVxLouyQnGkWwECyXnH/h04/RMvgo99WK/iTyJkZac/RmitWkqf1r51RF75
         yodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=V7mw1PZacwUsAaB1VU83lkGXXWmGIKU6D8r7r10MjMA=;
        b=Zr59COMqU5LCAQ5SgoMbcUg4xFHsRMhu2Bzx6/3JM15RA9F8ioo/kpfiNteyndmu8+
         jE6nfbPVkAKxVTguncm6kl3wF+Iyk5ARql/i2SJccF6twKEs2G78v0QLTveokkRpiVcC
         3Q6yRbEQaWybEFIt+9ZMp8NBiJi7K8ca6iRoKRnDwCDYzsYT8PPC25hw0i9UKbOJ5HCA
         tCSoVgYidA3K458bMy2BTIz1TAgrHWsTbhiF8kzZxsCdqMvXRQHzwly5+NXF+3EZZl2m
         6ntnR1PUA33t8+g0q45SB0fVnwKaNnGYiavBhMADyAvqfrnKZ8+tIgOHfMXdKM1t6bQa
         VqNg==
X-Gm-Message-State: APjAAAXU0102a68MuZAy87fSpQ3uMSCScfs/cXvIhT4eIbIhNr+Xs43Y
        tnmpc7e4bbi+4szTTfqzmItLmsV5f1+IVQ==
X-Google-Smtp-Source: APXvYqyJAbxtAxTqryn536f2bv3QAeRIjNffviEM8Yz2cBePFOE8+fBnj+DlPngBWf6v4TUa2gAaLA==
X-Received: by 2002:a17:902:6acb:: with SMTP id i11mr2799627plt.214.1575341422197;
        Mon, 02 Dec 2019 18:50:22 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id i11sm917619pfo.80.2019.12.02.18.50.20
        for <io-uring@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2019 18:50:21 -0800 (PST)
To:     io-uring <io-uring@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: use current task creds instead of allocating a new
 one
Message-ID: <abc36b36-4285-b0d9-02de-e2e0b740835d@kernel.dk>
Date:   Mon, 2 Dec 2019 19:50:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

syzbot reports:

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 9217 Comm: io_uring-sq Not tainted 5.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
Google 01/01/2011
RIP: 0010:creds_are_invalid kernel/cred.c:792 [inline]
RIP: 0010:__validate_creds include/linux/cred.h:187 [inline]
RIP: 0010:override_creds+0x9f/0x170 kernel/cred.c:550
Code: ac 25 00 81 fb 64 65 73 43 0f 85 a3 37 00 00 e8 17 ab 25 00 49 8d 7c
24 10 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84
c0 74 08 3c 03 0f 8e 96 00 00 00 41 8b 5c 24 10 bf
RSP: 0018:ffff88809c45fda0 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000043736564 RCX: ffffffff814f3318
RDX: 0000000000000002 RSI: ffffffff814f3329 RDI: 0000000000000010
RBP: ffff88809c45fdb8 R08: ffff8880a3aac240 R09: ffffed1014755849
R10: ffffed1014755848 R11: ffff8880a3aac247 R12: 0000000000000000
R13: ffff888098ab1600 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd51c40664 CR3: 0000000092641000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
   io_sq_thread+0x1c7/0xa20 fs/io_uring.c:3274
   kthread+0x361/0x430 kernel/kthread.c:255
   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Modules linked in:
---[ end trace f2e1a4307fbe2245 ]---
RIP: 0010:creds_are_invalid kernel/cred.c:792 [inline]
RIP: 0010:__validate_creds include/linux/cred.h:187 [inline]
RIP: 0010:override_creds+0x9f/0x170 kernel/cred.c:550
Code: ac 25 00 81 fb 64 65 73 43 0f 85 a3 37 00 00 e8 17 ab 25 00 49 8d 7c
24 10 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84
c0 74 08 3c 03 0f 8e 96 00 00 00 41 8b 5c 24 10 bf
RSP: 0018:ffff88809c45fda0 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000043736564 RCX: ffffffff814f3318
RDX: 0000000000000002 RSI: ffffffff814f3329 RDI: 0000000000000010
RBP: ffff88809c45fdb8 R08: ffff8880a3aac240 R09: ffffed1014755849
R10: ffffed1014755848 R11: ffff8880a3aac247 R12: 0000000000000000
R13: ffff888098ab1600 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd51c40664 CR3: 0000000092641000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

which is caused by slab fault injection triggering a failure in
prepare_creds(). We don't actually need to create a copy of the creds
as we're not modifying it, we just need a reference on the current task
creds. This avoids the failure case as well, and propagates the const
throughout the stack.

Fixes: 181e448d8709 ("io_uring: async workers should inherit the user creds")
Reported-by: syzbot+5320383e16029ba057ff@syzkaller.appspotmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/fs/io-wq.c b/fs/io-wq.c
index 91b85df0861e..74b40506c5d9 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -111,7 +111,7 @@ struct io_wq {
  
  	struct task_struct *manager;
  	struct user_struct *user;
-	struct cred *creds;
+	const struct cred *creds;
  	struct mm_struct *mm;
  	refcount_t refs;
  	struct completion done;
diff --git a/fs/io-wq.h b/fs/io-wq.h
index 600e0158cba7..dd0af0d7376c 100644
--- a/fs/io-wq.h
+++ b/fs/io-wq.h
@@ -87,7 +87,7 @@ typedef void (put_work_fn)(struct io_wq_work *);
  struct io_wq_data {
  	struct mm_struct *mm;
  	struct user_struct *user;
-	struct cred *creds;
+	const struct cred *creds;
  
  	get_work_fn *get_work;
  	put_work_fn *put_work;
diff --git a/fs/io_uring.c b/fs/io_uring.c
index ec53aa7cdc94..5cab7a047317 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -238,7 +238,7 @@ struct io_ring_ctx {
  
  	struct user_struct	*user;
  
-	struct cred		*creds;
+	const struct cred	*creds;
  
  	/* 0 is for ctx quiesce/reinit/free, 1 is for sqo_thread started */
  	struct completion	*completions;
@@ -4759,7 +4759,7 @@ static int io_uring_create(unsigned entries, struct io_uring_params *p)
  	ctx->compat = in_compat_syscall();
  	ctx->account_mem = account_mem;
  	ctx->user = user;
-	ctx->creds = prepare_creds();
+	ctx->creds = get_current_cred();
  
  	ret = io_allocate_scq_urings(ctx, p);
  	if (ret)

-- 
Jens Axboe

