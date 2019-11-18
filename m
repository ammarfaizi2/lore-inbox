Return-Path: <SRS0=qbCF=ZK=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936EEC432C0
	for <io-uring@archiver.kernel.org>; Mon, 18 Nov 2019 19:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 660C522304
	for <io-uring@archiver.kernel.org>; Mon, 18 Nov 2019 19:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="F0ZiBNdk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfKRTZx (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 18 Nov 2019 14:25:53 -0500
Received: from mail-il1-f170.google.com ([209.85.166.170]:38954 "EHLO
        mail-il1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfKRTZx (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 18 Nov 2019 14:25:53 -0500
Received: by mail-il1-f170.google.com with SMTP id a7so17091835ild.6
        for <io-uring@vger.kernel.org>; Mon, 18 Nov 2019 11:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=lj4X6tMV0lVYUzuEqZtweMBrD+Aq3LwiDPXSWpptqKg=;
        b=F0ZiBNdk1pRv5ixMqyWZWUVPLhX+ffHK7WNvdK/eVdhMIdeaZU+E3PCEJCnDGN3Ygn
         /8OJvP7/hnEK3NaZ62Cz/e7qUeBkdzUdx3OkFbbEOZSm0piWdN9LXHq3jkRNB5wjKg3L
         h7p43X04zaBqxPMrURFuPNP+nehjHlV0BXhGCKUEPhYCLi+kDZgIG7Z9BjJudPJ0mJ2V
         hMOX2TlMlMLpEfGtWcTUeQWk8XPNEdks/8uXbnSCgWQC40PwRhdLqLBsuDj3BvtT7IFp
         ge0PtkJ7qKxGPqpWe5G1kiHKSGzi/jOOz59W/ccMCC1wqfuGTZ+lXqIDTlDHs3Zfd0bH
         RSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=lj4X6tMV0lVYUzuEqZtweMBrD+Aq3LwiDPXSWpptqKg=;
        b=FzO8ILAeiMDTVqgR9HamKpqRIYMECyUOeuOAy2mNeG+ZvJGDOQ81tzdvMMiJnaw2lT
         GKorlm4MjAdTIwmHzpJdX4cNIHlJ0HcLDNp9Dt/2AN4XWd3vDzNWKIntoWqTrmDJc+vu
         oik0DxsjuUeaVINhuai1DVz+CGbp97001Q+Fv/Lmzakfb6vUc91PZTIUgYeo56UiX1q1
         /S5/N/ONtM19lI3enjYYW8193ondlAUeeFkyZHxkR+X0GuTVLkK2D2MgtbHxwoDud+m7
         jFB/texda5Cgz+ceVKCV5iFjG/WqZ3TD8NKAP74+xf+dYZWvS9ToVcJkHlKOGj0yumA5
         v1FQ==
X-Gm-Message-State: APjAAAWAdtKTWI8NTIjhe0Us/Xs8GjYWCkIfYHFwyvj5PGVYGTAyzaM1
        RWArvmHuiPOJWwOE7SnMg6eCrXyanEg=
X-Google-Smtp-Source: APXvYqzYL8L0e7fFnnmScOurWB/HMp/qMO73cmb+DNmwHYmDfYn9R6s5XhNP8YQiM6Np4ZeufJy+XQ==
X-Received: by 2002:a92:868f:: with SMTP id l15mr17970393ilh.199.1574105150027;
        Mon, 18 Nov 2019 11:25:50 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k4sm3598397iof.61.2019.11.18.11.25.48
        for <io-uring@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 11:25:48 -0800 (PST)
To:     io-uring@vger.kernel.org
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: request cancellations should break links
Message-ID: <78cb69d4-81e1-5cda-7b43-bba5d4ce76ef@kernel.dk>
Date:   Mon, 18 Nov 2019 12:25:47 -0700
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

We currently don't explicitly break links if a request is cancelled, but
we should. Add explicitly link breakage for all types of request
cancellations that we support.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/fs/io_uring.c b/fs/io_uring.c
index c9f810a75ef6..ebc58f896088 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2112,6 +2112,8 @@ static void io_poll_complete_work(struct io_wq_work **workptr)
 
 	io_cqring_ev_posted(ctx);
 
+	if (ret < 0 && req->flags & REQ_F_LINK)
+		req->flags |= REQ_F_FAIL_LINK;
 	io_put_req_find_next(req, &nxt);
 	if (nxt)
 		*workptr = &nxt->work;
@@ -2325,6 +2327,8 @@ static int io_timeout_cancel(struct io_ring_ctx *ctx, __u64 user_data)
 	if (ret == -1)
 		return -EALREADY;
 
+	if (req->flags & REQ_F_LINK)
+		req->flags |= REQ_F_FAIL_LINK;
 	io_cqring_fill_event(req, -ECANCELED);
 	io_put_req(req);
 	return 0;
@@ -2826,6 +2830,8 @@ static enum hrtimer_restart io_link_timeout_fn(struct hrtimer *timer)
 	spin_unlock_irqrestore(&ctx->completion_lock, flags);
 
 	if (prev) {
+		if (prev->flags & REQ_F_LINK)
+			prev->flags |= REQ_F_FAIL_LINK;
 		io_async_find_and_cancel(ctx, req, prev->user_data, NULL,
 						-ETIME);
 		io_put_req(prev);

-- 
Jens Axboe

