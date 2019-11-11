Return-Path: <SRS0=oqI+=ZD=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7503CC43331
	for <io-uring@archiver.kernel.org>; Mon, 11 Nov 2019 03:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45924206DF
	for <io-uring@archiver.kernel.org>; Mon, 11 Nov 2019 03:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="sI97/wyy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfKKDhP (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sun, 10 Nov 2019 22:37:15 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35288 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbfKKDhO (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sun, 10 Nov 2019 22:37:14 -0500
Received: by mail-pg1-f195.google.com with SMTP id q22so8570710pgk.2
        for <io-uring@vger.kernel.org>; Sun, 10 Nov 2019 19:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=9RlASWKZkhBGbxmFJFL84CR6ipr/xz+ZObDMa6Tvuyc=;
        b=sI97/wyyKT5tq316umYTZ2Pn212gTlVp7Ab0Z1dh6mE1jIPE5bMuY3w7zpXh0oxCrf
         GKerFmfQCDGvNJ9QCT9vRVMh+V6qKwwBcX6QawFl7ByBDI3NJHzku64X/nvRj+dwQoxp
         4aHK3aQqFKJHBCo8/VKZIh5XwB0r/lhrmWVgItJ13uEyu5//+8/eYu7e3FU2cQx2iRSk
         0AWMy08T331o1vegbQWv/ZUrld+JEuZ71gJd63vNwwZNlKyq1oc890Gr4QvqHWFiuG+X
         Yt+N//K2mCnLoPGLsFRuNEGh4DiIzoisAakR++8sLdwmP1ohcG4RQTFoUy8/iT5cXZ7y
         SvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=9RlASWKZkhBGbxmFJFL84CR6ipr/xz+ZObDMa6Tvuyc=;
        b=ZY6z5KLCtM7zYIEka/xUxsf+k/g+2lNYidIEcpgAxHtgT+RBVjnGFs8dQEuArtBc7b
         B1Smkk7aG1s/db1L6jfmkSEpLtziTLqyzKMMYml6BF7nNDHXGeHxHaaNSNvnkpfcXxxb
         pQ8VA/GisqPNHHLXdGn+jIIhO3eCZoljYkpvt6RIOqhHhg88iHXwSZf2RXQRLaxZuSjE
         Ut23JObix7a3xV9DECxCpZ961w+H4jtj6nK72TRRsXSifOzeyN3C3UgSBntyGFWwNdEq
         CXONaDnNLPzLYMYNLzYQvRBZONsfgnfjYd5s3C7yNF+myhrTxPxh4JUBG7sRapKY7WDi
         sUPQ==
X-Gm-Message-State: APjAAAULB9UZFfyj123D4G1phPvZYOMovF8COlQPbZ1KiAZp0V3Nlvgg
        IYtzJdwyiMgV3meitez+NrrES8mLL8w=
X-Google-Smtp-Source: APXvYqyxN6Yk5N/iH5cBMqknvWYBuvRuHea7ViQGfXM0MHU1qzwlrKori1jWnnt/ix3yQLtjuDXhJA==
X-Received: by 2002:a62:ae09:: with SMTP id q9mr27144486pff.157.1573443432080;
        Sun, 10 Nov 2019 19:37:12 -0800 (PST)
Received: from [192.168.201.136] ([50.234.116.4])
        by smtp.gmail.com with ESMTPSA id d25sm15110724pfq.70.2019.11.10.19.37.10
        for <io-uring@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Nov 2019 19:37:11 -0800 (PST)
To:     io-uring@vger.kernel.org
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: flag SQPOLL busy condition to userspace
Message-ID: <71565a00-f153-d8e2-6fbf-6fb2ed2ae6c5@kernel.dk>
Date:   Sun, 10 Nov 2019 19:37:10 -0800
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

Now that we have backpressure, for SQPOLL, we have one more condition
that warrants flagging that the application needs to enter the kernel:
we failed to submit IO due to backpressure. Make sure we catch that
and flag it appropriately.

If we run into backpressure issues with the SQPOLL thread, flag it
as such to the application by setting IORING_SQ_NEED_WAKEUP. This will
cause the application to enter the kernel, and that will flush the
backlog and clear the condition.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/fs/io_uring.c b/fs/io_uring.c
index baee60ce6473..cc38f872dbf0 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -3142,16 +3142,16 @@ static int io_sq_thread(void *data)
 	DEFINE_WAIT(wait);
 	unsigned inflight;
 	unsigned long timeout;
+	int ret;
 
 	complete(&ctx->completions[1]);
 
 	old_fs = get_fs();
 	set_fs(USER_DS);
 
-	timeout = inflight = 0;
+	ret = timeout = inflight = 0;
 	while (!kthread_should_park()) {
 		unsigned int to_submit;
-		int ret;
 
 		if (inflight) {
 			unsigned nr_events = 0;
@@ -3185,13 +3185,21 @@ static int io_sq_thread(void *data)
 		}
 
 		to_submit = io_sqring_entries(ctx);
-		if (!to_submit) {
+
+		/*
+		 * If submit got -EBUSY, flag us as needing the application
+		 * to enter the kernel to reap and flush events.
+		 */
+		if (!to_submit || ret == -EBUSY) {
 			/*
 			 * We're polling. If we're within the defined idle
 			 * period, then let us spin without work before going
-			 * to sleep.
+			 * to sleep. The exception is if we got EBUSY doing
+			 * more IO, we should wait for the application to
+			 * reap events and wake us up.
 			 */
-			if (inflight || !time_after(jiffies, timeout)) {
+			if (inflight ||
+			    (!time_after(jiffies, timeout) && ret != -EBUSY)) {
 				cond_resched();
 				continue;
 			}
@@ -3217,7 +3225,7 @@ static int io_sq_thread(void *data)
 			smp_mb();
 
 			to_submit = io_sqring_entries(ctx);
-			if (!to_submit) {
+			if (!to_submit || ret == -EBUSY) {
 				if (kthread_should_park()) {
 					finish_wait(&ctx->sqo_wait, &wait);
 					break;
@@ -4375,6 +4383,8 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
 	 */
 	ret = 0;
 	if (ctx->flags & IORING_SETUP_SQPOLL) {
+		if (!list_empty_careful(&ctx->cq_overflow_list))
+			io_cqring_overflow_flush(ctx, false);
 		if (flags & IORING_ENTER_SQ_WAKEUP)
 			wake_up(&ctx->sqo_wait);
 		submitted = to_submit;

-- 
Jens Axboe

