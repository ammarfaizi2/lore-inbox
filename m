Return-Path: <SRS0=KKPr=ZF=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14882C432C3
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 16:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D609E238E2
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 16:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1TUcSiFx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfKMQOC (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 13 Nov 2019 11:14:02 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:34494 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfKMQOC (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 13 Nov 2019 11:14:02 -0500
Received: by mail-io1-f66.google.com with SMTP id q83so3195368iod.1
        for <io-uring@vger.kernel.org>; Wed, 13 Nov 2019 08:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=n/GeYaAff8fIcJQTyhb9Gs+P5B7TtOYc+CO6pw4R5Tk=;
        b=1TUcSiFx11kZmSiMPMCQUjexQ+qIK9XvvnN0MXqlU8/4AXe6LS5GdRMkf/MYbMV6W1
         bwJdWDaTzBmIWANhB/S0bzIAj84bru8G9Z3tO9MipHqkhkCVXqjKEh2X7kMxur/s7VQi
         /j/JuhIhViJBjHpwX2k3u7m6SQWd3vf/cfXPIis00vAGzDKbF235ZmLVlDmJAKonGcKm
         RsPd1RueuwHxaI0jltErw/pu7XIuqZEINDAql5vWadSmMf0BYBCaYCiWcevqYKScAIK3
         h4YUSTdJqnsdOhpkSZwj5Wi2TaCVS2/PVtENnue+NKcPZlk0YP0bUcoQWghII0H0Swfc
         ZLGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=n/GeYaAff8fIcJQTyhb9Gs+P5B7TtOYc+CO6pw4R5Tk=;
        b=eatjiPOVbvPYWM3Q3vOSVU2Gwx8lwMYAskApkHyzBavMcLgRnV3RFzsXwiIYnyMHPX
         17+QnJ7uBLtCMWfu3yFLpI4NVIjwG1yAhCtppAbZD8o0o2LOfy3GAN888OApSkfv5v7B
         CKBEea2FzDwV7CMRt7UvflRnEquXLX08RQ+ZiHonI/q+bGiPOUiU8re9r3TWZB/Eg20H
         7Pfpr6ayEUVAaMS/3ITQsyM9KcCRJi04+MtTpXiw/e6B4aJOVLuVSbko3XR4GxrbM4Zu
         fJhJ8HqoMKH/m+X1svZH5TgggE3zbP4CR3HZaekPTI9W+dDsyyFxlVT0G6GbBWW2FRWz
         J7Cw==
X-Gm-Message-State: APjAAAXGeOPRXRhwIWzihExIJXthG7dujIlaP6gBCvWamJqYZk7Uq3sm
        qI0zx4bVgxEjh+2B+TfsmjjyiKw9k4Y=
X-Google-Smtp-Source: APXvYqwgcGIUPoXV3TE1kZB0ZF51tNAZhOR8uAg5RXm1YzR1NyOiD9l2fnLkuxsjNTU3aQYuPoB1rQ==
X-Received: by 2002:a5e:aa06:: with SMTP id s6mr4061619ioe.30.1573661640853;
        Wed, 13 Nov 2019 08:14:00 -0800 (PST)
Received: from [192.168.1.163] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o184sm336690ila.45.2019.11.13.08.13.59
        for <io-uring@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 08:14:00 -0800 (PST)
To:     io-uring@vger.kernel.org
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: check for validity of ->rings in teardown
Message-ID: <d0061a1b-9aa1-ff29-8f20-38256ea3f811@kernel.dk>
Date:   Wed, 13 Nov 2019 09:13:59 -0700
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

Normally the rings are always valid, the exception is if we failed to
allocate the rings at setup time. syzbot reports this:

RSP: 002b:00007ffd6e8aa078 EFLAGS: 00000246 ORIG_RAX: 00000000000001a9
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441229
RDX: 0000000000000002 RSI: 0000000020000140 RDI: 0000000000000d0d
RBP: 00007ffd6e8aa090 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000000000
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 8903 Comm: syz-executor410 Not tainted 5.4.0-rc7-next-20191113
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
Google 01/01/2011
RIP: 0010:__read_once_size include/linux/compiler.h:199 [inline]
RIP: 0010:__io_commit_cqring fs/io_uring.c:496 [inline]
RIP: 0010:io_commit_cqring+0x1e1/0xdb0 fs/io_uring.c:592
Code: 03 0f 8e df 09 00 00 48 8b 45 d0 4c 8d a3 c0 00 00 00 4c 89 e2 48 c1
ea 03 44 8b b8 c0 01 00 00 48 b8 00 00 00 00 00 fc ff df <0f> b6 14 02 4c
89 e0 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 61
RSP: 0018:ffff88808f51fc08 EFLAGS: 00010006
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff815abe4a
RDX: 0000000000000018 RSI: ffffffff81d168d5 RDI: ffff8880a9166100
RBP: ffff88808f51fc70 R08: 0000000000000004 R09: ffffed1011ea3f7d
R10: ffffed1011ea3f7c R11: 0000000000000003 R12: 00000000000000c0
R13: ffff8880a91661c0 R14: 1ffff1101522cc10 R15: 0000000000000000
FS:  0000000001e7a880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000140 CR3: 000000009a74c000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  io_cqring_overflow_flush+0x6b9/0xa90 fs/io_uring.c:673
  io_ring_ctx_wait_and_kill+0x24f/0x7c0 fs/io_uring.c:4260
  io_uring_create fs/io_uring.c:4600 [inline]
  io_uring_setup+0x1256/0x1cc0 fs/io_uring.c:4626
  __do_sys_io_uring_setup fs/io_uring.c:4639 [inline]
  __se_sys_io_uring_setup fs/io_uring.c:4636 [inline]
  __x64_sys_io_uring_setup+0x54/0x80 fs/io_uring.c:4636
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x441229
Code: e8 5c ae 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
ff 0f 83 bb 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffd6e8aa078 EFLAGS: 00000246 ORIG_RAX: 00000000000001a9
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441229
RDX: 0000000000000002 RSI: 0000000020000140 RDI: 0000000000000d0d
RBP: 00007ffd6e8aa090 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace b0f5b127a57f623f ]---
RIP: 0010:__read_once_size include/linux/compiler.h:199 [inline]
RIP: 0010:__io_commit_cqring fs/io_uring.c:496 [inline]
RIP: 0010:io_commit_cqring+0x1e1/0xdb0 fs/io_uring.c:592
Code: 03 0f 8e df 09 00 00 48 8b 45 d0 4c 8d a3 c0 00 00 00 4c 89 e2 48 c1
ea 03 44 8b b8 c0 01 00 00 48 b8 00 00 00 00 00 fc ff df <0f> b6 14 02 4c
89 e0 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 61
RSP: 0018:ffff88808f51fc08 EFLAGS: 00010006
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff815abe4a
RDX: 0000000000000018 RSI: ffffffff81d168d5 RDI: ffff8880a9166100
RBP: ffff88808f51fc70 R08: 0000000000000004 R09: ffffed1011ea3f7d
R10: ffffed1011ea3f7c R11: 0000000000000003 R12: 00000000000000c0
R13: ffff8880a91661c0 R14: 1ffff1101522cc10 R15: 0000000000000000
FS:  0000000001e7a880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000140 CR3: 000000009a74c000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

which is exactly the case of failing to allocate the SQ/CQ rings, and
then entering shutdown. Check if the rings are valid before trying to
access them at shutdown time.

Reported-by: syzbot+21147d79607d724bd6f3@syzkaller.appspotmail.com
Fixes: 1d7bb1d50fb4 ("io_uring: add support for backlogged CQ ring")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 11b3e1e23720..e1a3b8b667e0 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -4280,7 +4280,9 @@ static void io_ring_ctx_wait_and_kill(struct io_ring_ctx *ctx)
 		io_wq_cancel_all(ctx->io_wq);
 
 	io_iopoll_reap_events(ctx);
-	io_cqring_overflow_flush(ctx, true);
+	/* if we failed setting up the ctx, we might not have any rings */
+	if (ctx->rings)
+		io_cqring_overflow_flush(ctx, true);
 	wait_for_completion(&ctx->completions[0]);
 	io_ring_ctx_free(ctx);
 }
-- 
2.24.0

-- 
Jens Axboe

