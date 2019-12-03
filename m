Return-Path: <SRS0=jlnN=ZZ=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943BDC432C0
	for <io-uring@archiver.kernel.org>; Tue,  3 Dec 2019 02:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D1B206DC
	for <io-uring@archiver.kernel.org>; Tue,  3 Dec 2019 02:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="P0k5uO0Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfLCCvW (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 2 Dec 2019 21:51:22 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:35246 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfLCCvV (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 2 Dec 2019 21:51:21 -0500
Received: by mail-pj1-f66.google.com with SMTP id s8so863006pji.2
        for <io-uring@vger.kernel.org>; Mon, 02 Dec 2019 18:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=kI3t4xQIVVkaYjDZ7W2oCNrhvD+Lab4Ibv/UMDRADLM=;
        b=P0k5uO0Zn1tA58d/dSz750iBtpXOP6+xgEcEkuqQvirMup9WPmvLmGZPnVFzRiUAnv
         sF4M2QAJk3VaJKkDqhZP+mNzG9pKxqLESEs3n7LxFB8VGR/MutvsjTMupLsky2FaKtYT
         kvFvp+JNJIAN/Fp+GW7sdoRCdeZe0DxxoMid4KqmE0bB26Ge4fNC0azEGGt2y4M+P1mQ
         obDKzLn0A0pDhlWPvX1co0MX90XlgcabUkxVGhK6qtnTTuoE/kpZ0Chp0Cz9jbxlJue6
         pE+aanNh7eZOFNxf89zQ77dFAJD8qiOgVatDPl7QWBikKb+hklG/gy9KqGNFwEf5RdAw
         Utmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=kI3t4xQIVVkaYjDZ7W2oCNrhvD+Lab4Ibv/UMDRADLM=;
        b=E2UJn6/oNlHg+Q8rCe3PNePUPsAeHZR086JuX1Hxlj73cWYsxKpYcCa8Ds2HJ/6h/X
         r9PhPefi15lvg9tdg8+hRy8h2wXpLBczLO/usxjfK/VV4Nv2mOzvtwX56zVYIIsHdMQz
         nN26kkaqwKmE43F+CENP8xjeVKZr8t1zDlIgs+HQEQ+/G/6VL8bK2ps1QFDaiZdy4Efx
         ku6GvqVJIXvThN92nO4hd4N5L8dgp9CE+D2WVN6I2GkVZulTDG0DhAaBIPtuXD43qHMZ
         sNIdWJx4SvxC8trRqfvZ0o6MRV+OSEYRluJuxsYBDeqBKice46aTiSFT7Jtl3I3FjqpR
         YleA==
X-Gm-Message-State: APjAAAX5NlFLiVshKhrBOHCd2pZwgx9JggqTCCBIaZWHFURFJOd4Z/IP
        CYLq1BwprdFOCxmXJQiiubW3CLVuk32bPQ==
X-Google-Smtp-Source: APXvYqxnHNelIZ6ublyjpTjAqehkkARx0vruza2hRYbuoBSG9vPZmtUdIeF/jBQMkatr7oKGvoranQ==
X-Received: by 2002:a17:90b:85:: with SMTP id bb5mr2939464pjb.22.1575341480453;
        Mon, 02 Dec 2019 18:51:20 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id f23sm870020pgj.76.2019.12.02.18.51.19
        for <io-uring@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2019 18:51:19 -0800 (PST)
To:     io-uring <io-uring@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: transform send/recvmsg() -ERESTARTSYS to -EINTR
Message-ID: <4cd7d532-f849-9836-0855-3845e85576ef@kernel.dk>
Date:   Mon, 2 Dec 2019 19:51:17 -0700
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

We should never return -ERESTARTSYS to userspace, transform it into
-EINTR.

Cc: stable@vger.kernel.org # v5.3+
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 5cab7a047317..a91743e1fa2c 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1917,6 +1917,8 @@ static int io_send_recvmsg(struct io_kiocb *req, const struct io_uring_sqe *sqe,
  		ret = fn(sock, msg, flags);
  		if (force_nonblock && ret == -EAGAIN)
  			return ret;
+		if (ret == -ERESTARTSYS)
+			ret = -EINTR;
  	}
  
  	io_cqring_add_event(req, ret);

-- 
Jens Axboe

