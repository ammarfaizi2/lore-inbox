Return-Path: <SRS0=ex/T=ZC=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24195C43331
	for <io-uring@archiver.kernel.org>; Sun, 10 Nov 2019 15:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E84352077C
	for <io-uring@archiver.kernel.org>; Sun, 10 Nov 2019 15:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="VNuB9TIT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfKJPrB (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sun, 10 Nov 2019 10:47:01 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41555 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbfKJPrB (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sun, 10 Nov 2019 10:47:01 -0500
Received: by mail-pg1-f196.google.com with SMTP id h4so7552000pgv.8
        for <io-uring@vger.kernel.org>; Sun, 10 Nov 2019 07:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=atBGv2oufa7QSuqs3SYcvpX3GEpx/raytY0koDU2GMc=;
        b=VNuB9TITgwhu7Nix2gusg18hld8WwT3Ft5nfF+3rYDrNM6ur9XZWGv77kkxKpQkC1y
         fCCu1kcRIGQASAbWyk0VGdDAReDdEIuWKpLgqLrKJTHb5Y6H+WsWkJeq113hUEXId5d6
         qAkHlnObLNpWj03iXlcc/bNehPBsT82p/D9qb+rMxiAJQKUlQ96+5vEDs8Ly9BZsoBdW
         GrwwHWOLBN+kqx8Adu5jK51HPT+ab+1qXYdaT3WVpl9wLXzOYhzJzycULQatdKWB6zQY
         XOsD2ODnxYOf4YBuPow9Iy6d9wjuNa5CYXmqQ3mBgCeuK/lfidTt23N9EgcLmNntMgNl
         kKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=atBGv2oufa7QSuqs3SYcvpX3GEpx/raytY0koDU2GMc=;
        b=e7CMEejvkFM0sn4yeURZWRgjJ/pTd7rbv/VN7ymo4nz94wMG8YfZ5NxeYk2Xj1M8bA
         MQC62undMU+Eys9RBtTy3TL8fmaM8hFmMfMDOC3pdzGa7ONiDfSnjgVuyspSI5IIWXZo
         MJZumtvP0Vz4kOSMsinRp6TJvlc0gTNM8B2zfSgnjzWnN9Ec0smYeMsELt1/+i36L11e
         MYJYxYvMEA+XJ3IPWPJ8MDBXi0dpsxa2sTsIf6uSh7s8Cdrj0vq2vsZ3ZmwG3NWdv77Z
         i8EIQFRVwgBHPC3VfdAYwdYYEqAeYlBZu6ZIebZxAHTTPQkW67O2WNrA8bncATnUFxIj
         Wl2w==
X-Gm-Message-State: APjAAAW7UNUZGR3nILKouR2MjqtxNH3+LiwspzapgWQvEsbwFqgiJBmu
        THErbZ3xEPUxxPfww98yFOs2wxCNdW0=
X-Google-Smtp-Source: APXvYqzqZc9HX3X5cW/IdDDcYmTPXkjkDolkZyGxERMMNkVLpx3HlvYEKF28gH2W4v+36L4dQMHdXg==
X-Received: by 2002:a63:6483:: with SMTP id y125mr23980290pgb.444.1573400818844;
        Sun, 10 Nov 2019 07:46:58 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id h5sm15172612pjc.9.2019.11.10.07.46.57
        for <io-uring@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Nov 2019 07:46:58 -0800 (PST)
To:     io-uring@vger.kernel.org
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: fix error clear of ->file_table in
 io_sqe_files_register()
Message-ID: <9851837d-47f3-abfe-8c19-f518e0935b22@kernel.dk>
Date:   Sun, 10 Nov 2019 08:46:56 -0700
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

syzbot reports that when using failslab and friends, we can get a double
free in io_sqe_files_unregister():

BUG: KASAN: double-free or invalid-free in
io_sqe_files_unregister+0x20b/0x300 fs/io_uring.c:3185

CPU: 1 PID: 8819 Comm: syz-executor452 Not tainted 5.4.0-rc6-next-20191108
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
  kasan_report_invalid_free+0x65/0xa0 mm/kasan/report.c:468
  __kasan_slab_free+0x13a/0x150 mm/kasan/common.c:450
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:480
  __cache_free mm/slab.c:3426 [inline]
  kfree+0x10a/0x2c0 mm/slab.c:3757
  io_sqe_files_unregister+0x20b/0x300 fs/io_uring.c:3185
  io_ring_ctx_free fs/io_uring.c:3998 [inline]
  io_ring_ctx_wait_and_kill+0x348/0x700 fs/io_uring.c:4060
  io_uring_release+0x42/0x50 fs/io_uring.c:4068
  __fput+0x2ff/0x890 fs/file_table.c:280
  ____fput+0x16/0x20 fs/file_table.c:313
  task_work_run+0x145/0x1c0 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x904/0x2e60 kernel/exit.c:817
  do_group_exit+0x135/0x360 kernel/exit.c:921
  __do_sys_exit_group kernel/exit.c:932 [inline]
  __se_sys_exit_group kernel/exit.c:930 [inline]
  __x64_sys_exit_group+0x44/0x50 kernel/exit.c:930
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x43f2c8
Code: 31 b8 c5 f7 ff ff 48 8b 5c 24 28 48 8b 6c 24 30 4c 8b 64 24 38 4c 8b
6c 24 40 4c 8b 74 24 48 4c 8b 7c 24 50 48 83 c4 58 c3 66 <0f> 1f 84 00 00
00 00 00 48 8d 35 59 ca 00 00 0f b6 d2 48 89 fb 48
RSP: 002b:00007ffd5b976008 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000043f2c8
RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
RBP: 00000000004bf0a8 R08: 00000000000000e7 R09: ffffffffffffffd0
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000001
R13: 00000000006d1180 R14: 0000000000000000 R15: 0000000000000000

This happens if we fail allocating the file tables. For that case we do
free the file table correctly, but we forget to set it to NULL. This
means that ring teardown will see it as being non-NULL, and attempt to
free it again.

Fix this by clearing the file_table pointer if we free the table.

Reported-by: syzbot+3254bc44113ae1e331ee@syzkaller.appspotmail.com
Fixes: 65e19f54d29c ("io_uring: support for larger fixed file sets")
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 7fc3a72e1e1e..5c10b34ceb24 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -3488,6 +3488,7 @@ static int io_sqe_files_register(struct io_ring_ctx *ctx, void __user *arg,
 
 	if (io_sqe_alloc_file_tables(ctx, nr_tables, nr_args)) {
 		kfree(ctx->file_table);
+		ctx->file_table = NULL;
 		return -ENOMEM;
 	}
 
-- 
Jens Axboe

