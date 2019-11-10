Return-Path: <SRS0=ex/T=ZC=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8E8C43331
	for <io-uring@archiver.kernel.org>; Sun, 10 Nov 2019 02:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70DF721019
	for <io-uring@archiver.kernel.org>; Sun, 10 Nov 2019 02:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="mTYiF8I7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfKJCfu (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 9 Nov 2019 21:35:50 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41903 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfKJCfu (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 9 Nov 2019 21:35:50 -0500
Received: by mail-pg1-f195.google.com with SMTP id h4so6698477pgv.8
        for <io-uring@vger.kernel.org>; Sat, 09 Nov 2019 18:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=WPNA83C9daNcId0GSooIDPnKsXvfBs7McDm8u3ikek8=;
        b=mTYiF8I7Sbacsp050jH3xAuo1OOgTf5ZS9t0nsSkEmYxFhGDSYwvJ4i8rl1OmnpEWQ
         LdOULS5oAclyTYDkE2X05dqSS+6vxNFr2EzOdKh/PXTSHW1WM7j2I52D5j5Q2bA73DnB
         XryNVbHvMh4Z4EGX3C4pyx1tGPppi3pBx6rIvXOdsgSBHRD7ir30+sBnTxpwxG3wLY1b
         VYXVib/CgPX17dJ90bOS88SSwixmG6q85ScuvmlSfN3Ryq975MBk1se7MwLEUJjpuI03
         qZCGGTliZ+Fa69phTBd2aGh1d71f60aEd22WWDtr9bGnDu91IVOomFpEJNxwVK6KIAHp
         rxLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=WPNA83C9daNcId0GSooIDPnKsXvfBs7McDm8u3ikek8=;
        b=YyWDiujV+I4c+AkUVHWU9hn38bzLoVHvfeLp8BFT2BAYxvZjiOzfxuWLs0DLV3o+Gx
         zv/29AyqR3NJGcyLMP+uC1OP9SijF4KBMyNwpqJwT+HaS6zy0IIT4AYcMJ1Ocm3VUmYn
         njJv9rJ5VRaDTo3GMNf4y+lEP7LgPXtQ4k3NKqlQhpt9o0Sfmmp6VDNjt8Ggicdd8AWs
         us/Fs9KkMbsjWEt3cjIi9BnXmTgucr+l0Zzuf/4l33fGR5aA97jEnW3uh8eIhqatWFG8
         qqJvyAMy/QEu6yQpgNheXdrajPBKcFoYscDSkd1L48whMblYp8GeOULGK8RUy6Iy7oeO
         sBaw==
X-Gm-Message-State: APjAAAWvAYCDBTdCbdfscB/EsH+Sl1xFJHSPWauSr927v36ANF75IveJ
        XdKvxBL99j4LZAf2CRofNlz6zA==
X-Google-Smtp-Source: APXvYqzdK4sp+kE7yOJ9a0NVeNFr/h0LZAxPXAiXFDlHOgGvnmu9QUYrc5MWn2vQWgnrOH7zzSFBkQ==
X-Received: by 2002:a63:1f08:: with SMTP id f8mr21454097pgf.145.1573353349453;
        Sat, 09 Nov 2019 18:35:49 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id z62sm13856119pfz.135.2019.11.09.18.35.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Nov 2019 18:35:48 -0800 (PST)
To:     io-uring@vger.kernel.org
Cc:     Hrvoje Zeba <zeba.hrvoje@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: convert accept4() -ERESTARTSYS into -EINTR
Message-ID: <e12108cb-1194-e7b8-1aec-812d2a6ac799@kernel.dk>
Date:   Sat, 9 Nov 2019 19:35:46 -0700
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

If we cancel a pending accept operating with a signal, we get
-ERESTARTSYS returned. Turn that into -EINTR for userspace, we should
not be return -ERESTARTSYS.

Reported-by: Hrvoje Zeba <zeba.hrvoje@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 6db27bc9b2e3..059773c5d2ce 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1920,6 +1920,8 @@ static int io_accept(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 		req->work.flags |= IO_WQ_WORK_NEEDS_FILES;
 		return -EAGAIN;
 	}
+	if (ret == -ERESTARTSYS)
+		ret = -EINTR;
 	if (ret < 0 && (req->flags & REQ_F_LINK))
 		req->flags |= REQ_F_FAIL_LINK;
 	io_cqring_add_event(req, ret);

-- 
Jens Axboe

