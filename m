Return-Path: <SRS0=5OhC=ZL=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084E3C432C3
	for <io-uring@archiver.kernel.org>; Tue, 19 Nov 2019 22:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9DC922445
	for <io-uring@archiver.kernel.org>; Tue, 19 Nov 2019 22:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Hg5foq6G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfKSWKP (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 19 Nov 2019 17:10:15 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45414 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfKSWKO (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 19 Nov 2019 17:10:14 -0500
Received: by mail-pl1-f195.google.com with SMTP id w7so12671375plz.12
        for <io-uring@vger.kernel.org>; Tue, 19 Nov 2019 14:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=seJaqBzrB46uqzDZsps0ZtRrvjay4V/1BoyGWdDoXlM=;
        b=Hg5foq6GCxfZkP13q0kVXzg6pC0vM65VpzR0j/Ot/VuN1ua3xxc2yZLLcUDOoQ3pt/
         BWhY8SlGh9ALE4Zf8z8+lDWrgvOwS4Zq55PGolPPDN0ZB51opXZZJS5uYNQ0u7+BcmHn
         LTUgng0A9ZQwLCVKD7d4Hv7dddnOp3+4ZRYPLgkKg9Zt+RcrFwBsUGZz0lNvaRiWzLK7
         B9DjZhhcm8LHnVsByqZSsdp93jnmN0wnLE0hj4qBAUvmU72cNC5BTe46e2PB7bIA2d/c
         8AwLKvt7bX83bJvmE6n1D33ZXRzaf6BlLkyDavZPg+/OmleIE80QcBkaMQZsCUF5hFR8
         JmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=seJaqBzrB46uqzDZsps0ZtRrvjay4V/1BoyGWdDoXlM=;
        b=dPTaOG0WIAF8UNjYGYudzBlRsCLNQCEuvFq95RHbjB23+wqjrW7ejfzCA1B1DsqE9+
         n24rTgE0KdwbWgy2wkRyPckMLIXGsmnsf708swrsn1dXSkn8qbhvdWlpkKUfQu9XwRQn
         kqqailBb1kcUqxiBu9Y1RiYN2fxd5RHlpDv/Q4i4+rbxf996ugIUCWMNyof7OjXAiH3T
         2FAhwj7lBixfYArUGwofCvNle7ydYReZJMQpsWMDZ21h5MI1RaKvkbUW7H4UjojnsBBM
         /cBa4y8U6vRZsIeU1EfXpt4XBSyWSNeum1V70icSdWsDvb+vbrJk2VVVROLjPhK9MXpc
         yXWQ==
X-Gm-Message-State: APjAAAV1QcJksxx77yU2A5I6gbQbOpn1J4TTj3ErHBRds/wW4Ml2/J0O
        34upS6m6UuTWtoO+ViTGl85cvA3sIBw=
X-Google-Smtp-Source: APXvYqyiNRE6yYRX9CULmIhn33Qx5glLRotmV626FhXjs+ICgI+xchpoPqDr5vyUy8fYaf6VfPuAxA==
X-Received: by 2002:a17:90a:5895:: with SMTP id j21mr9626233pji.129.1574201411569;
        Tue, 19 Nov 2019 14:10:11 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id z10sm27652832pfr.139.2019.11.19.14.10.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Nov 2019 14:10:10 -0800 (PST)
Subject: Re: [PATCH 1/4] io_uring: Always REQ_F_FREE_SQE for allocated sqe
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
References: <cover.1574195129.git.asml.silence@gmail.com>
 <d879b9ce9ea9d47129d8f0a093bc96ce5dc3f54d.1574195129.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0655d5c5-e241-034c-6ec2-ad97012fd2f1@kernel.dk>
Date:   Tue, 19 Nov 2019 15:10:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <d879b9ce9ea9d47129d8f0a093bc96ce5dc3f54d.1574195129.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/19/19 1:32 PM, Pavel Begunkov wrote:
> Always mark requests with allocated sqe and deallocate it in
> __io_free_req(). It's easier to follow and doesn't add edge cases.

I did consider doing this, and it is tempting as a cleanup, but it
also moves it into the fastpath instead of keeping it in the slow
link fail path. Any allocated sqe is normally freed when the work
is processed, which is generally also a better path to do it in as
we know we're not under locks/irq disabled.

-- 
Jens Axboe

