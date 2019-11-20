Return-Path: <SRS0=jdTg=ZM=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA6BC432C0
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 09:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D8552243F
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 09:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QViYxQsC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbfKTJDe (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 20 Nov 2019 04:03:34 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34882 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbfKTJDe (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 20 Nov 2019 04:03:34 -0500
Received: by mail-lf1-f65.google.com with SMTP id q28so5585406lfp.2
        for <io-uring@vger.kernel.org>; Wed, 20 Nov 2019 01:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=PBOccnL9bkQM2dZLi8sQ0EtGmtYFuPNbB54cvycZySM=;
        b=QViYxQsCZO5NUWGF3eJIiN6V5RLbMsJYq6IO8G3ygRPab0qgE7MbyC0AtBgdLOXNh8
         s4ba2Ks6lT0a4gT6t7FfjzGm8QLQKhQpqOd88ykUwDKi885QMIuG60b+FTdwgUi0IFwB
         3DxtrNH7cLLLZ8xmVbK/lTBm1dYAEObxKGcldD+qsdApVbGeuP1Z/nhRrr2nufhCZfSh
         XUzEK3clDtLZszCgRvhlN1BdwRIBz/sH/Dg4JQXXCDWQMkqdhgrwzUeEKHM+Iwd4F8v4
         /o4jng7/Ktxmi6E+OvRvcTzBcmytpYQnrdCuAboyBFeFWXWOoLxa6jROeB1mZVXz50VC
         6OPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PBOccnL9bkQM2dZLi8sQ0EtGmtYFuPNbB54cvycZySM=;
        b=BDbHmLeFx5e/dDfAdru0xaAMEHz/uQ5sQnjEsJ/CvmWBNjqg8NKfiN8JV3unyckpIu
         GQKJsJ9gLjHYiSiiTKH2vY5vSNYukmgfT0HhquC1qJouMzk7JnrCsRCl1AqZNh2DMfY5
         QCzC+cUzJcAXjDNFr7NGD5Ty02XgyZBg3i6kf+OolDQc//4k0vl67KQw3jdWAms4WUJf
         /Ey+Gd6JBF3sovNvT0J8tMifqH4MdwrMWbU2iwL62YMXbXraKgfXh1Vq2PQjpsGbMyIt
         0zneSD5+z2fnJYSaFqd+D2LZskgI1wQLZXbBJ8nuaAnp9nEKlJ0WMFEY4RaQAMmEGdU/
         W7eA==
X-Gm-Message-State: APjAAAW+rNPiqz5q90YTEvvjRFBzMvfbKEdb4sJj7vWMgAoQ66wHE3Wf
        7rWecQ8AgaOVQjNypxCUddk9HVzA
X-Google-Smtp-Source: APXvYqzatTIuSoS/cI1wu71TVqEn9k4naQYGDbSDEE+rt8odL4evuTx4xAP4ysQcGCgCpVb1endNfw==
X-Received: by 2002:a19:c514:: with SMTP id w20mr1855441lfe.143.1574240612500;
        Wed, 20 Nov 2019 01:03:32 -0800 (PST)
Received: from [172.31.190.83] ([86.57.146.226])
        by smtp.gmail.com with ESMTPSA id 80sm5365295lfh.86.2019.11.20.01.03.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 01:03:31 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [PATCH 1/4] io_uring: Always REQ_F_FREE_SQE for allocated sqe
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
References: <cover.1574195129.git.asml.silence@gmail.com>
 <d879b9ce9ea9d47129d8f0a093bc96ce5dc3f54d.1574195129.git.asml.silence@gmail.com>
 <0655d5c5-e241-034c-6ec2-ad97012fd2f1@kernel.dk>
Message-ID: <4eea8a32-68dc-4d34-f69d-5a2281594844@gmail.com>
Date:   Wed, 20 Nov 2019 12:03:30 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <0655d5c5-e241-034c-6ec2-ad97012fd2f1@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/20/2019 1:10 AM, Jens Axboe wrote:
> and it is tempting as a cleanup, but it
> also moves it into the fastpath instead of keeping it in the slow
> link fail path. Any allocated sqe is normally freed when the work
> is processed, which is generally also a better path to do it in as
> we know we're not under locks/irq disabled.

Good point with locks/irq, but io_put_req() is usually called out of
locking. Isn't it? E.g. @completion_lock is taken mainly by *add_cq_event().

SQE needs to be freed in any case, and there is only one extra "if",
what we really should not worry about. There are much heavier parts.
e.g. excessive atomics/locking, I'll send an RFC for that, if needed.

I find the complexity of much more concern here.

-- 
Pavel Begunkov
