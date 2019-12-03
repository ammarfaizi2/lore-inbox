Return-Path: <SRS0=jlnN=ZZ=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394D3C432C0
	for <io-uring@archiver.kernel.org>; Tue,  3 Dec 2019 18:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1D4C206EC
	for <io-uring@archiver.kernel.org>; Tue,  3 Dec 2019 18:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Rqv0eWEa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfLCSZ1 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 3 Dec 2019 13:25:27 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:39620 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbfLCSZ1 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 3 Dec 2019 13:25:27 -0500
Received: by mail-io1-f67.google.com with SMTP id c16so4862895ioh.6
        for <io-uring@vger.kernel.org>; Tue, 03 Dec 2019 10:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=k6xfgtCw/fIdsIS/ehnwa3Dsj2lshSTkDVD6UMZv0RE=;
        b=Rqv0eWEabFM5022OGAgduVcMOsCm3l63NQMpm9huSQYeeYRZjCc2Hdllw4phoSGIXM
         8n9F9ikcP/5TC5IOOQzDEftEXWrdlhv3fW58IrAWy6eqiRRoupiq67dJ90u0vExWPLTe
         1DfInF9HRIL4lEIIJaklF78gTgqoJQ99eIs32E0NtteX4zYkKCBko/LM08uOtHhhhSUV
         cymjfk3FtpIej/QzhS48SKHF2tL+F2wQN4DPxLsJmEEqsL+4Y1/3pEJnLqVbKP3oH0oB
         7jZ9tSnaGCvjUaQwDJEpITgCkp96A/ponjGn8sWaYAQFSN7I/b6cnJgbg/+GqcqOUE5K
         5x0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=k6xfgtCw/fIdsIS/ehnwa3Dsj2lshSTkDVD6UMZv0RE=;
        b=Tq/UQDIvpu5R1dsF53xyZ8rziqGHOA/5SDstzLsNnKoGQK5LkOazVhXfsxl7m7rymn
         l1rhmB1w/u3hokiKRA9So31sYqYn1odu6ynMgpRNZTwe13fV8+HNiUJxZuNc9ZxGF8UC
         eT8tHueevmiLa78tx3RHJ+Mss1wYarK0qkvX7NfmoobqIL752m0V/4E4wvIlkjrxfZYY
         uXdLIIZAxZHNpIFAT+SkFS3o3nnjK9HYPhDj9YSvm1EF6K+9KN05ZJ/23we1SPuSgsaG
         70pRRykltu6LFW6ZL48C2bJGkDJaYrybI8vzdSQVu7nhfUkrQQ0flW5yDyHURZZftxjN
         YRZQ==
X-Gm-Message-State: APjAAAWgtXLf6t0Q7GpmgacYW9m4ycjT9+UPNIOtP0f05sFON/cDD+/G
        1ieAFTf/B/zjVQE3txGEgitS1O/ffLbNjw==
X-Google-Smtp-Source: APXvYqymuiVT9h3E6mAlVrcflAyJoKt98OoZXPpWZ9vcBll9NegehiP7aZBxxBrtpJSDpXFX1WkisA==
X-Received: by 2002:a02:8525:: with SMTP id g34mr6619814jai.72.1575397525833;
        Tue, 03 Dec 2019 10:25:25 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f13sm856674iob.56.2019.12.03.10.25.23
        for <io-uring@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2019 10:25:24 -0800 (PST)
To:     io-uring <io-uring@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: handle connect -EINPROGRESS like -EAGAIN
Message-ID: <36e61a79-8e7c-e869-99d3-eaafdd6ad63d@kernel.dk>
Date:   Tue, 3 Dec 2019 11:25:23 -0700
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

Right now we return it to userspace, which means the application has
to poll for the socket to be writeable. Let's just treat it like
-EAGAIN and have io_uring handle it internally, this makes it much
easier to use.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/fs/io_uring.c b/fs/io_uring.c
index f7985f270d4a..6c22a277904e 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2242,7 +2242,7 @@ static int io_connect(struct io_kiocb *req, const struct io_uring_sqe *sqe,
  
  	ret = __sys_connect_file(req->file, &io->connect.address, addr_len,
  					file_flags);
-	if (ret == -EAGAIN && force_nonblock) {
+	if ((ret == -EAGAIN || ret == -EINPROGRESS) && force_nonblock) {
  		io = kmalloc(sizeof(*io), GFP_KERNEL);
  		if (!io) {
  			ret = -ENOMEM;
-- 
Jens Axboe

