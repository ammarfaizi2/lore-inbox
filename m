Return-Path: <SRS0=jdTg=ZM=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A49BC432C0
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 03:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38B5C22419
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 03:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="pI49T4iA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfKTDdo (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 19 Nov 2019 22:33:44 -0500
Received: from mail-pl1-f177.google.com ([209.85.214.177]:43646 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfKTDdn (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 19 Nov 2019 22:33:43 -0500
Received: by mail-pl1-f177.google.com with SMTP id a18so13122286plm.10
        for <io-uring@vger.kernel.org>; Tue, 19 Nov 2019 19:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=tJP5Iys4LS4d+wXfmY2doaWWdmN3OYttiAEiXY7X9Eg=;
        b=pI49T4iAw4/4wKx+nY4JxM3vyeLd2XRMahONDf5DvaCLaDs1XVFxvA/ivM/+GGso+c
         dQvTMsQW7qizPUShzsFBSHJe0pZp29JJvR5vMPr1B87zD7N4PEq5dOo3b3dXJOoB/n2s
         zk0vmwoqJ6Af7yfqLtIbXvmg7GYp/Js830K42aKaPPkX53GB8e9dAwIw4zl/FzPffElb
         BXBLViEcgSLwUCddUQ4WrqGPDwFgbHDI+BepylD6lAvXjUy06QuZMWLPVlsIly1Isj6n
         yu/9tQfL9HJvuC2Maj1jeJcEY/CxDsyU45QWMRkPfQb1B256VGIHWgFYfat7AMx02xB9
         /x/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=tJP5Iys4LS4d+wXfmY2doaWWdmN3OYttiAEiXY7X9Eg=;
        b=KOcbz4okhYk+txlzwEB1yG9dyRJFovIG8YBZWAGRAxWwM5O8ZU+4w82psV4qKgnXtV
         vnF5H0HuY90gyduiV6xQoR2978KGZVeAo8ldYgLX4Xg6Hm15Dv1pzNz/dSkcx0kzPPhh
         caWm3XxFzk29NmF+bV6UClkAztGJEuzb9/FVQ6dWUoW6qkYESlQf0ypPycZehJ4IfVJc
         SzsQ+FJWEYwekQdaoUA6nZggvIqy6d5WMZKg4epRvbJZZMXWlsKfcaHepFBLK4sPfRxF
         lDIfEQA9I+LN/bwjdJL5UGI75c3CSSfqL29wVGZBEJuPIY25SUUBCgtXYZaGohZIf5Q4
         OXyA==
X-Gm-Message-State: APjAAAVeOZTqKcElYyrRUTGz3fpAp1D3VfnoVwetivXrTz785CC3ZoI5
        WFX7TTlSh8WHlKGcsbtw837PlcGUPEaTrg==
X-Google-Smtp-Source: APXvYqx68MhTNBd0D8JV0L8l6A8iyQTamXQWmXove/iuyPQKrEdoz4x3zGKOnwsq+0OzpEdw3ZmzWA==
X-Received: by 2002:a17:902:d717:: with SMTP id w23mr654428ply.142.1574220820734;
        Tue, 19 Nov 2019 19:33:40 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id x190sm28786615pfc.89.2019.11.19.19.33.39
        for <io-uring@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Nov 2019 19:33:39 -0800 (PST)
To:     io-uring@vger.kernel.org
From:   Jens Axboe <axboe@kernel.dk>
Subject: io_uring: io_fail_links() should only consider first linked timeout
Message-ID: <efca87b0-3b8a-9614-c4c7-a341a2882b58@kernel.dk>
Date:   Tue, 19 Nov 2019 15:33:20 -0700
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

We currently clear the linked timeout field if we cancel such a timeout,
but we should only attempt to cancel if it's the first one we see.
Others should simply be freed like other requests, as they haven't
been started yet.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/fs/io_uring.c b/fs/io_uring.c
index a79ef43367b1..d1085e4e8ae9 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -937,12 +937,12 @@ static void io_fail_links(struct io_kiocb *req)
 		if ((req->flags & REQ_F_LINK_TIMEOUT) &&
 		    link->submit.sqe->opcode == IORING_OP_LINK_TIMEOUT) {
 			io_link_cancel_timeout(link);
-			req->flags &= ~REQ_F_LINK_TIMEOUT;
 		} else {
 			io_cqring_fill_event(link, -ECANCELED);
 			__io_double_put_req(link);
 		}
 		kfree(sqe_to_free);
+		req->flags &= ~REQ_F_LINK_TIMEOUT;
 	}
 
 	io_commit_cqring(ctx);

-- 
Jens Axboe

