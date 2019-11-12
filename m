Return-Path: <SRS0=vuSH=ZE=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E024C43331
	for <io-uring@archiver.kernel.org>; Tue, 12 Nov 2019 16:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1072E2196E
	for <io-uring@archiver.kernel.org>; Tue, 12 Nov 2019 16:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="y91iFLhM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfKLQsD (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 12 Nov 2019 11:48:03 -0500
Received: from mail-pg1-f170.google.com ([209.85.215.170]:36812 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfKLQsD (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 12 Nov 2019 11:48:03 -0500
Received: by mail-pg1-f170.google.com with SMTP id k13so12240620pgh.3
        for <io-uring@vger.kernel.org>; Tue, 12 Nov 2019 08:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=GY/3VRPjXoczoujjypW/bjexDwN/oQKcoHLKXV+FTj8=;
        b=y91iFLhME5FEnocbcvN4LNJBA14VenbRntP+2Bw8U3ksSe6B5XdSEqPWuNqwqwsXg7
         g8KjuPEDgnOP+ApVRRCv4JDldj3N8blQIxlJZvOyEeeWlkIqt3yZ1LUKphXePj03muGY
         LXYBOhqr0aPeoH65FXkZApnAA1jVI6dXM/WaR4zgyjT6WkHoW0uwkzMPpm9TEUs75vG3
         BaImKCYRAt25HMDm9LnRcY4tWdb48TTNVmU0fS7KpO7T0FTfBFt8oie1Tg18i29HWlsu
         z/gP5dDJvHnqVJcKZ4oqUiwTrA49P6UQ0t2tDs43sG8xb1jlen67CdDobfL8NKhPKLoB
         QnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=GY/3VRPjXoczoujjypW/bjexDwN/oQKcoHLKXV+FTj8=;
        b=JX2rf4Qm1kaWihu16jBYfGVKFnNisFNcmHyyWQBIcaL+t+uzqBbjeLrQ4HvFB4YfbX
         vGuUBYSFhtFKFEOqggAdVCraFULmg3eTq4NPdiEBZmA96asxlvIzjUVmClQgEHCuls2x
         Vf780RLLQjWOATH5L3Jr8hrMWuri8b31ewnqCUDi7FxwtcLH3thWXmu/9zd3OMt4TZjr
         v8AI5FOUzosaAeDDHlZAxmAWrU0QGOnn/mhJSnGi8ys2oEHBk03MmRXuDrweiu+9F4oZ
         B1S3rRHWq4yA4uZw4D26bz/a8bDYTTNwFajpcs/0H6KbWsTm8/xClgPG+CVzxBNdMDj5
         iMOg==
X-Gm-Message-State: APjAAAUvyoilu/2DbeY+gtQUEeBX1mC1RM6FDLbn2o0peaNHUED5Bt9n
        pFFMmd1vRQeo95szyDb/nx2Nhf/jrkg=
X-Google-Smtp-Source: APXvYqyT6GKdLaJpP1I5sjZMVJya7FWaC0Bl5vpDdw+67AJzO6haliIveBY3SCwTq1v/quDbq01ptg==
X-Received: by 2002:a62:1841:: with SMTP id 62mr36709098pfy.108.1573577280995;
        Tue, 12 Nov 2019 08:48:00 -0800 (PST)
Received: from [10.47.172.222] ([156.39.10.47])
        by smtp.gmail.com with ESMTPSA id d139sm27415908pfd.162.2019.11.12.08.47.59
        for <io-uring@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 08:48:00 -0800 (PST)
To:     io-uring@vger.kernel.org
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: fix potential deadlock in io_poll_wake()
Message-ID: <e3c30838-6823-a4d8-48f7-47171cd94524@kernel.dk>
Date:   Tue, 12 Nov 2019 08:47:58 -0800
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

We attempt to run the poll completion inline, but we're using trylock to
do so. This avoids a deadlock since we're grabbing the locks in reverse
order at this point, we already hold the poll wq lock and we're trying
to grab the completion lock, while the normal rules are the reverse of
that order.

IO completion for a timeout link will need to grab the completion lock,
but that's not safe from this context. Put the completion under the
completion_lock om io_poll_wake(), and mark the request as entering
the completion with completion_lock already held.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

Changes since v1:

- Retain the inline running, use REQ_F_COMP_LOCKED instead to tell
  io_free_req_find_next() that we are already holding the completion
  lock when entered.
- Correct protection -> protect in comment

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 3c573f0578a8..247e5e1137a3 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -341,6 +341,7 @@ struct io_kiocb {
 #define REQ_F_ISREG		2048	/* regular file */
 #define REQ_F_MUST_PUNT		4096	/* must be punted even for NONBLOCK */
 #define REQ_F_INFLIGHT		8192	/* on inflight list */
+#define REQ_F_COMP_LOCKED	16384	/* completion under lock */
 	u64			user_data;
 	u32			result;
 	u32			sequence;
@@ -931,14 +932,15 @@ static void io_free_req_find_next(struct io_kiocb *req, struct io_kiocb **nxt)
 	 */
 	if (req->flags & REQ_F_FAIL_LINK) {
 		io_fail_links(req);
-	} else if (req->flags & REQ_F_LINK_TIMEOUT) {
+	} else if ((req->flags & (REQ_F_LINK_TIMEOUT | REQ_F_COMP_LOCKED)) ==
+			REQ_F_LINK_TIMEOUT) {
 		struct io_ring_ctx *ctx = req->ctx;
 		unsigned long flags;
 
 		/*
 		 * If this is a timeout link, we could be racing with the
 		 * timeout timer. Grab the completion lock for this case to
-		 * protection against that.
+		 * protect against that.
 		 */
 		spin_lock_irqsave(&ctx->completion_lock, flags);
 		io_req_link_next(req, nxt);
@@ -2064,13 +2066,20 @@ static int io_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 
 	list_del_init(&poll->wait.entry);
 
+	/*
+	 * Run completion inline if we can. We're using trylock here because
+	 * we are violating the completion_lock -> poll wq lock ordering.
+	 * If we have a link timeout we're going to need the completion_lock
+	 * for finalizing the request, mark us as having grabbed that already.
+	 */
 	if (mask && spin_trylock_irqsave(&ctx->completion_lock, flags)) {
 		list_del(&req->list);
 		io_poll_complete(req, mask);
+		req->flags |= REQ_F_COMP_LOCKED;
+		io_put_req(req);
 		spin_unlock_irqrestore(&ctx->completion_lock, flags);
 
 		io_cqring_ev_posted(ctx);
-		io_put_req(req);
 	} else {
 		io_queue_async_work(req);
 	}
-- 
Jens Axboe

