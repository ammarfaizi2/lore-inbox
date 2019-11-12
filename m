Return-Path: <SRS0=vuSH=ZE=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF66C17440
	for <io-uring@archiver.kernel.org>; Tue, 12 Nov 2019 11:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBFED214E0
	for <io-uring@archiver.kernel.org>; Tue, 12 Nov 2019 11:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t5KeaaNk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbfKLLO0 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:14:26 -0500
Received: from mail-lj1-f170.google.com ([209.85.208.170]:34591 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbfKLLO0 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 12 Nov 2019 06:14:26 -0500
Received: by mail-lj1-f170.google.com with SMTP id 139so17340469ljf.1
        for <io-uring@vger.kernel.org>; Tue, 12 Nov 2019 03:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=AyYIW0hxpbNiqVGDfzYgYxaWltITVvvW3WzKdIOILGM=;
        b=t5KeaaNkIWTW3Dbef5vPyqhlUxo56kHDi0QpdVWX4fN7yAV4hG2GH1DpnTtKwXulQS
         fUzqKtfiRadeBX9qbkwdioKcxu6suY+VM9OKo9dd24iU7tLK5Psl7wzAw6QnVcYWynHz
         KoXAHVWUV7W9hOUwSXB92JhgxJCdnv0u4q0XfNzXkaF0ah92joUMcL5ABXRIEo3xRBap
         7hzRTNnVa0QPpUqctiFJzCFtHK/xkH8boVEKyQaRls5P12yhP40oihVqBGtZmsNuk61t
         wk7kEmt9+TqlyyHitrVE+an0Zz4Js0Bthc/aOUxLD29G0g6PQaFSR7ZB3IUfGKaVe3tJ
         DRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=AyYIW0hxpbNiqVGDfzYgYxaWltITVvvW3WzKdIOILGM=;
        b=Tazr1M4qTKKyxVFA7OQ3hC7WEv1JUnnIp/nAFtIxQiaWr4dy55EzLjHRRNaMp+RsoN
         XcPE2TRs+WZGoTBtuSCilLsGd1hLP1sqvfVu0Ig5s9C/Bmk3iUupSc84dO424h90iF3J
         azV6TCVzVTaVXGlU6TWCZLKZL78QSG1FrpByOyaVKbGc69qXmltxjexPN4GT5Ttt3NWN
         j9PRyKxQXAy/7u/5aMV8pPMH/0cfD0ep0EsjPwT5EZq/guoeGCYY6093/5n32gZQ57q4
         vwVLKEJuwrSZ4z7GotKINod2smNTRkJn1qAsGsOiNA9OU3u6Ms9CV0PdajGGWfxBrzha
         nvAQ==
X-Gm-Message-State: APjAAAV7Pi9TKJjeGpr9PhZ+6glk37XIzDthgTmLwd0+mzQT02xWhXmK
        TcJ9tjg7CEYh6gOUQ083J9RcRdCn
X-Google-Smtp-Source: APXvYqxAa4Kz/2yj/yxFrcPP/hArZYq3dWWiXSFN+BfDGIauueej8GYnxMKFkO6cHcqNcBnE8nHmow==
X-Received: by 2002:a2e:9216:: with SMTP id k22mr20192678ljg.157.1573557264211;
        Tue, 12 Nov 2019 03:14:24 -0800 (PST)
Received: from [172.31.190.83] ([86.57.146.226])
        by smtp.gmail.com with ESMTPSA id a144sm8028260lfd.27.2019.11.12.03.14.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 03:14:23 -0800 (PST)
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
From:   Pavel Begunkov <asml.silence@gmail.com>
Subject: [RFC] migrating mm
Message-ID: <6e4c0f3f-745e-c8ed-3dca-2a763e5841ee@gmail.com>
Date:   Tue, 12 Nov 2019 14:14:22 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

There is a case I'm not sure about, but which bothers me.
What would happen, if we try to use io_uring with offloading (i.e.
IORING_SETUP_SQPOLL), after its creator is gone? The thing is that
io_sq_thread() is getting mm by using ctx->sqo_mm, which is current->mm
of the creator process, which potentially may be released.


The case in mind:
let: @parent has a @child process

@child:
    uring_fd = io_uring_create(IORING_SETUP_SQPOLL)
    pass_fd_via_pipe(uring_fd, to=@parent);
    exit()

@parent:
    uring_fd = get_fd_from_pipe()
    wait(@child)

    sqe = create_sqe_which_needs_mm();
    io_submit_sqe(uring_fd, sqe)
    // io_uring tries to grab mm of @child, which is gone.



What do you think?

-- 
Pavel Begunkov
