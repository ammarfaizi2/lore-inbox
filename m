Return-Path: <SRS0=KKPr=ZF=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E73C432C3
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 23:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18574206EC
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 23:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="INNTFxxQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfKMXQU (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 13 Nov 2019 18:16:20 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36561 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfKMXQU (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 13 Nov 2019 18:16:20 -0500
Received: by mail-pl1-f193.google.com with SMTP id d7so1731086pls.3
        for <io-uring@vger.kernel.org>; Wed, 13 Nov 2019 15:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=dsDN1Vvy8fxoT+L0amnUb7xtXYUjFX88Qdj+Iy0sDwE=;
        b=INNTFxxQ86e3CQcfRpGQALiFp/925J8QOYzXnLNsiBKGBIj+foB2LkzsxchYUL2U00
         48AcNEX25bSuSpn2odFhcTUK/WTZ7FVX68sRnntXCP9EbihLsEJB4XkppE2N98cy1v9R
         fl89HzQrjx+ktRF+2dezUZbrvxlOipUHlPkKXT1DqjMZfv2TqNqP+Zhj04QNsDoLXo+T
         d7+8VKu+2iq+ctP5egvUhUMWicVfFnScgmiriOgZAajui3SgaO0J3nD03SakA+KDO4h4
         1L4s2FQlkUc16iV5ot+zQWNKwN7eGFOEsKWrFwhRuxc6swsilorwSNjyN8KWCngmYDQw
         94OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=dsDN1Vvy8fxoT+L0amnUb7xtXYUjFX88Qdj+Iy0sDwE=;
        b=JTlPHoHFSP0Vv20pG4SmCCXg8tuKw2grMaMA1HM1kypSEdakWrh4/9KC1gI/ZCfI7r
         szcI6gFZdiKm8lfSb+Zp3aif2rWGB/a91Tqv0/19QSqzUdR8t2W4xYvCRpql/9K/0Ksv
         9p/GHBMj+F6V6NAsF3OeXwI6XXuvEY8+JIDZeHdfdBbZ4shSf47Xa3ecHxiFuSEMKp7Z
         aWmZ2M6wo32jGfpcZhaEaXZveJyEC0z5YJK5PiyZRo77+ZiuoH1zfmtROy00itezhs4z
         3tGZfM75NkHPI7pi56QWrjBv3QhZjume83VJIxo3JuZ8P44JG/HimOVrF996XQyMFEs4
         6IBA==
X-Gm-Message-State: APjAAAVgAP3ThFrQKKLi3MK4O+ouwMzI0VTg/CFAjaz7zC+gsKDc4uje
        JeCyxwt6B5kn1LxX+YgjrpSQ6XcYyDY=
X-Google-Smtp-Source: APXvYqw8UwnzBr4hzSPxA/pkfyYolutjD5Z5wfvB+MxJXMyKiKE+xF/GONLY3qWwpPgZHWmhuPA63A==
X-Received: by 2002:a17:902:6a82:: with SMTP id n2mr6557051plk.5.1573686979858;
        Wed, 13 Nov 2019 15:16:19 -0800 (PST)
Received: from [192.168.1.182] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id c9sm3695033pfn.65.2019.11.13.15.16.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 15:16:18 -0800 (PST)
To:     io-uring@vger.kernel.org
Cc:     carter.li@eoitek.com
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: ensure registered buffer import returns the IO
 length
Message-ID: <388e5f83-2abb-32df-446d-0e1e26bfaef7@kernel.dk>
Date:   Wed, 13 Nov 2019 16:16:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

A test case was reported where two linked reads with registered buffers
failed the second link always. This is because we set the expected value
of a request in req->result, and if we don't get this result, then we
fail the dependent links. For some reason the registered buffer import
returned -ERROR/0, while the normal import returns -ERROR/length. This
broke linked commands with registered buffers.

Fix this by making io_import_fixed() correctly return the mapped length.

Cc: stable@vger.kernel.org # v5.3
Reported-by: 李通洲 <carter.li@eoitek.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 57ea54d5b0fb..2c819c3c855d 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1230,7 +1230,7 @@ static int io_import_fixed(struct io_ring_ctx *ctx, int rw,
 		}
 	}
 
-	return 0;
+	return len;
 }
 
 static ssize_t io_import_iovec(struct io_ring_ctx *ctx, int rw,

-- 
Jens Axboe

