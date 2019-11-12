Return-Path: <SRS0=vuSH=ZE=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A6DC43331
	for <io-uring@archiver.kernel.org>; Tue, 12 Nov 2019 15:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A361121872
	for <io-uring@archiver.kernel.org>; Tue, 12 Nov 2019 15:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xYxFHM1L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfKLPSl (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 12 Nov 2019 10:18:41 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44955 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbfKLPSk (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 12 Nov 2019 10:18:40 -0500
Received: by mail-pl1-f196.google.com with SMTP id az9so8683048plb.11
        for <io-uring@vger.kernel.org>; Tue, 12 Nov 2019 07:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=hzlMEz9H+cNjbJz5LUkdbmiF28jbJv1n8IHUGa+7Nws=;
        b=xYxFHM1Ld7u+VPp6T0y458MSt9GPKlD79m69R1RU57YcS6+j/VmOjBYSxLuA3lw/vJ
         pSasw6RPZKRC7klvWQknSjtwEDOKMJlT32JhZAAWRpQXtJmMLyx6yrlP+dGE8ReCIgGE
         11HgIM1uYt115rOpUa8N7xVmbV8sWiM1fyWeMtMxWM1oT1S5bg7lWUrPH37PNkcO6IxZ
         oinILVGjtnd/nx9ga23KikGwKOmb2ae2PG09dtieG+W0HcUTELlmXPNnj1ie9cxrKJEU
         kPn9w89WNrY7/6/+I0uweub0/+XxZ/ebSGJiKwVlPpQwi+vpCaufNqXQd1Ib43VngGLR
         ZL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=hzlMEz9H+cNjbJz5LUkdbmiF28jbJv1n8IHUGa+7Nws=;
        b=ScXtLcARfN93UUe8K8iGkBGHuuHKRcebblkBhGPpIpoYyvwthKsTRB86Lp9MgUCiJb
         3b1CjheEV5Cm8w1j1FuCdYIG7w6DotLo1i65HdoHkrx9WFGAGkVDVDCL9rkgb2D63wxa
         3oMjh52ZRzwa3fOsrpoVuB697jevxxlwH8CwxwfnXX8k608dHHX6kIF34xytOCf62yp4
         7PZKK26mXtHcJHz3Q3TuQxp1N/WBiNz5vLekqV9xi+fdshJ1By3XUnglAuX2O7xfDVSr
         tdOrRUwTYfRr4IO+AUWPDonIyM7vzrP8LbTAGt8g2G7LruFpMHk4DcCl/929GS3Fxf3m
         FC0Q==
X-Gm-Message-State: APjAAAWsd3xfCRMpMsY5p6XuscqauJ7GDH9qkisGvoJp1+iMVgZ7TqxG
        C0XtkzH2+j3KW6CQuhMlb98csbtFmdE=
X-Google-Smtp-Source: APXvYqz2fIYXVD55TzZh4C4dE7jGnqk5e4+1gND0W1AMva4jBDFFBU3GBGiuWRJvwKAJzHGAjvyX5Q==
X-Received: by 2002:a17:902:b612:: with SMTP id b18mr24334498pls.210.1573571919115;
        Tue, 12 Nov 2019 07:18:39 -0800 (PST)
Received: from [192.168.201.136] ([50.234.116.4])
        by smtp.gmail.com with ESMTPSA id f189sm19411445pgc.94.2019.11.12.07.18.37
        for <io-uring@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 07:18:38 -0800 (PST)
To:     io-uring@vger.kernel.org
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: fix potential deadlock in io_poll_wake()
Message-ID: <4c601e0b-1ee7-d97e-54dc-2280d6643e30@kernel.dk>
Date:   Tue, 12 Nov 2019 07:18:36 -0800
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
so it's not safe to use from this particular context. If the poll
request has a timeout link, don't attempt complete inline.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 3c573f0578a8..e15c2f8e0840 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2064,7 +2064,14 @@ static int io_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 
 	list_del_init(&poll->wait.entry);
 
-	if (mask && spin_trylock_irqsave(&ctx->completion_lock, flags)) {
+	/*
+	 * Run completion inline if we can. We're using trylock here because
+	 * we are violating the completion_lock -> poll wq lock ordering.
+	 * If we have a link timeout we're going to need the completion_lock
+	 * for finalizing the request, don't allow inline completion for that.
+	 */
+	if (!(req->flags & REQ_F_LINK_TIMEOUT) &&
+	    mask && spin_trylock_irqsave(&ctx->completion_lock, flags)) {
 		list_del(&req->list);
 		io_poll_complete(req, mask);
 		spin_unlock_irqrestore(&ctx->completion_lock, flags);

-- 
Jens Axboe

