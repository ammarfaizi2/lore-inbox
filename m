Return-Path: <SRS0=KDoC=Y5=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D403C5DF60
	for <io-uring@archiver.kernel.org>; Tue,  5 Nov 2019 20:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3935421A49
	for <io-uring@archiver.kernel.org>; Tue,  5 Nov 2019 20:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ScuyfvPT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbfKEUxf (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 5 Nov 2019 15:53:35 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:42177 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfKEUxf (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 5 Nov 2019 15:53:35 -0500
Received: by mail-io1-f65.google.com with SMTP id g15so2833053iob.9
        for <io-uring@vger.kernel.org>; Tue, 05 Nov 2019 12:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=GX8VV76n/Cb3lM3k70PhfXKFIkmdW/TeRcKURAsaHlw=;
        b=ScuyfvPTaSN1xVRBpsrrtjrMqwYRqle2w2tYTQRMGPGX5Nxz4uF/XtSQdU8dU8joQx
         pqssF6kFb+/sEdCkNeyPyL8KGUwMsj3Av7eOEdvYLQ0SwL8S74IgX059A4PWjv1iY9FQ
         ZfPDno48w69hMIpa+tpSWhYFD2o9jxlrfjh5Ju/2uzMBvmWJNdQ/mKLMNXOxXGETsWZc
         3EDWAgVn+LQbvf1j42FFYMBtI/2tiCF315XX4hiJy2dDu9zig2p7buzDOBN8xYgrqGLG
         e1QUhzG0NxB39d8GlbWvbyMiBaGiK4rEepmbMP4VeDaSc6EWIp9hpSnTz0jx/mk2FNYF
         CNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=GX8VV76n/Cb3lM3k70PhfXKFIkmdW/TeRcKURAsaHlw=;
        b=pGysPzKGoK0i4bJeO97I74nWVPltz2qvgzsu/B6YiE7OMzqN66k8vA0uyVwroHWoY/
         DyUsOAJQYxFkEMFJT5PTX5vtluYChbgkeOwUTF0YDc1xKaWgAWCZS/gLl3Bp7DtSQFbM
         JwzFu74tAX3CoNxL0ndAwFM/rL25s+Q136nVDKWe6DJK+75itMLAe5kD+78ZwP5QGOBm
         nD5AswJT0W2Lxf1l9rnpPnF2a9vgaXiODDQz6b0uc0eSNKy6fk67YVTZ2ImCk5m1EDIq
         3pZCU+hf/g5oj5DnzS+2FoERSQl6JGdqAS1if/2rtFvG2H9duuRQx88dXqWmr4BCSsWB
         /1Ow==
X-Gm-Message-State: APjAAAVHnhZKXFBBwh9OFYaUgz/Rkpj2tpBXzeSe/8jQyPy9Jvy3I98d
        wBp5xxpmWUQfFrUpb3sIifVt7jrAugs=
X-Google-Smtp-Source: APXvYqwKFIvjRDoPT/jRFT+LFKlzBWFPrAFgVrwjTxtcAvKOBqZH+U7EeFxirk0ykFB02Fok5Tpe1g==
X-Received: by 2002:a5d:9a0c:: with SMTP id s12mr2007675iol.41.1572987213589;
        Tue, 05 Nov 2019 12:53:33 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id n16sm137928ioh.15.2019.11.05.12.53.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 12:53:32 -0800 (PST)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        io-uring@vger.kernel.org
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io-wq: use proper nesting IRQ disabling spinlocks for cancel
Message-ID: <294dec15-76ac-7475-eba5-0d06c9dc403e@kernel.dk>
Date:   Tue, 5 Nov 2019 13:53:31 -0700
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

We don't know what context we'll be called in for cancel, it could very
well be with IRQs disabled already. Use the IRQ saving variants of the
locking primitives.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/fs/io-wq.c b/fs/io-wq.c
index 3bbab2c58695..ba40a7ee31c3 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -642,19 +642,20 @@ static bool io_work_cancel(struct io_worker *worker, void *cancel_data)
 {
 	struct io_cb_cancel_data *data = cancel_data;
 	struct io_wqe *wqe = data->wqe;
+	unsigned long flags;
 	bool ret = false;
 
 	/*
 	 * Hold the lock to avoid ->cur_work going out of scope, caller
 	 * may deference the passed in work.
 	 */
-	spin_lock_irq(&wqe->lock);
+	spin_lock_irqsave(&wqe->lock, flags);
 	if (worker->cur_work &&
 	    data->cancel(worker->cur_work, data->caller_data)) {
 		send_sig(SIGINT, worker->task, 1);
 		ret = true;
 	}
-	spin_unlock_irq(&wqe->lock);
+	spin_unlock_irqrestore(&wqe->lock, flags);
 
 	return ret;
 }
@@ -669,9 +670,10 @@ static enum io_wq_cancel io_wqe_cancel_cb_work(struct io_wqe *wqe,
 		.caller_data = cancel_data,
 	};
 	struct io_wq_work *work;
+	unsigned long flags;
 	bool found = false;
 
-	spin_lock_irq(&wqe->lock);
+	spin_lock_irqsave(&wqe->lock, flags);
 	list_for_each_entry(work, &wqe->work_list, list) {
 		if (cancel(work, cancel_data)) {
 			list_del(&work->list);
@@ -679,7 +681,7 @@ static enum io_wq_cancel io_wqe_cancel_cb_work(struct io_wqe *wqe,
 			break;
 		}
 	}
-	spin_unlock_irq(&wqe->lock);
+	spin_unlock_irqrestore(&wqe->lock, flags);
 
 	if (found) {
 		work->flags |= IO_WQ_WORK_CANCEL;
@@ -733,6 +735,7 @@ static enum io_wq_cancel io_wqe_cancel_work(struct io_wqe *wqe,
 					    struct io_wq_work *cwork)
 {
 	struct io_wq_work *work;
+	unsigned long flags;
 	bool found = false;
 
 	cwork->flags |= IO_WQ_WORK_CANCEL;
@@ -742,7 +745,7 @@ static enum io_wq_cancel io_wqe_cancel_work(struct io_wqe *wqe,
 	 * from there. CANCEL_OK means that the work is returned as-new,
 	 * no completion will be posted for it.
 	 */
-	spin_lock_irq(&wqe->lock);
+	spin_lock_irqsave(&wqe->lock, flags);
 	list_for_each_entry(work, &wqe->work_list, list) {
 		if (work == cwork) {
 			list_del(&work->list);
@@ -750,7 +753,7 @@ static enum io_wq_cancel io_wqe_cancel_work(struct io_wqe *wqe,
 			break;
 		}
 	}
-	spin_unlock_irq(&wqe->lock);
+	spin_unlock_irqrestore(&wqe->lock, flags);
 
 	if (found) {
 		work->flags |= IO_WQ_WORK_CANCEL;

-- 
Jens Axboe

