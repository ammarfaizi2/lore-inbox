Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B07EC07E99
	for <io-uring@archiver.kernel.org>; Mon, 12 Jul 2021 18:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5513E6120A
	for <io-uring@archiver.kernel.org>; Mon, 12 Jul 2021 18:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhGLTAy (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 12 Jul 2021 15:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235328AbhGLTAy (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 12 Jul 2021 15:00:54 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9C7C0613E5
        for <io-uring@vger.kernel.org>; Mon, 12 Jul 2021 11:58:05 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id i5so15474300lfe.2
        for <io-uring@vger.kernel.org>; Mon, 12 Jul 2021 11:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6GsSMYaQI588Ffnw4CVBQ3sZ6gvGzoY3yVC41+xYYto=;
        b=WaihP7jKxzYCMxQCcBtDaK9LmZeQKKvPkG1ySyIo4LNPgwjRqAFy7a5dztQR5tpjJW
         YkETbz91Hcae6AiCzUcs4RkrgDln8zvMEF3keoZqq8wekngRzxIpRwji7vR9b7EZtHpU
         ttvfKt8Tq2Mkm5tGIfvw2FFs73bO9TNxQBXaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6GsSMYaQI588Ffnw4CVBQ3sZ6gvGzoY3yVC41+xYYto=;
        b=LtnsHsSNNvjroOClire71bMXagN9vwcDXH4anKsGMZY2zvN+DuQ65oKhSHt1IB+yPT
         bWZSHfCSKo/x+5H72y+SDAoKP6VeJcwxmaDH2S2Q/ayzpSCHZpAUMpQsGXSvIqpH/anZ
         AC5+VkAD4NQlWqzyp5yoPvnRizullGY8QvDNfsXA6VODTp92o8xbhFYYRaQGCDnqUri3
         MyTVTQYXYujYuWz76k6zEkjHSQPsnF+crkKjzk49z2b4MSuKICciGPulO5A6bh0Lhs/B
         FUGjcED5KwBXGM1dNBjrq4sHnoWLw1SAnxi9a6hmn7DNW2k0n/7uxEVV1a+c9D9+aDmT
         nUbQ==
X-Gm-Message-State: AOAM533Y32AI7Jp3JyB7w+DRMRQSbRiUblcjGGALD1PMH8854bn5st1D
        KwthoYp7LS1EWIifLB/Z0meDH4OjpjTBp5NU
X-Google-Smtp-Source: ABdhPJx8OCccqpyz/9/xati7u0RCLZ+Jwm+pgtFywdw7FPkA1dLcrTMT7YRGBA+8VfxoaKcaeEnvGg==
X-Received: by 2002:a19:c46:: with SMTP id 67mr171437lfm.482.1626116283727;
        Mon, 12 Jul 2021 11:58:03 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id c5sm1675430ljj.17.2021.07.12.11.58.02
        for <io-uring@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 11:58:03 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id x25so32529996lfu.13
        for <io-uring@vger.kernel.org>; Mon, 12 Jul 2021 11:58:02 -0700 (PDT)
X-Received: by 2002:ac2:42d6:: with SMTP id n22mr163067lfl.41.1626116282616;
 Mon, 12 Jul 2021 11:58:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210712123649.1102392-1-dkadashev@gmail.com> <20210712123649.1102392-7-dkadashev@gmail.com>
In-Reply-To: <20210712123649.1102392-7-dkadashev@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Jul 2021 11:57:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiE_JVny73KRZ6wuhL_5U0RRSmAw678_Cnkh3OHM8C7Jg@mail.gmail.com>
Message-ID: <CAHk-=wiE_JVny73KRZ6wuhL_5U0RRSmAw678_Cnkh3OHM8C7Jg@mail.gmail.com>
Subject: Re: [PATCH 6/7] namei: clean up do_linkat retry logic
To:     Dmitry Kadashev <dkadashev@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On Mon, Jul 12, 2021 at 5:37 AM Dmitry Kadashev <dkadashev@gmail.com> wrote:
>
> Moving the main logic to a helper function makes the whole thing much
> easier to follow.

Ok, this has the same thing as the previous patches had.

I see why the old code tried to avoid the repeat of some tests, but
honestly, that "retry_estale()" might as well be marked "unlikely()",
and we might as well do the test again if it triggers.

That said, in this case we actually end up doing other things too in
"do_linkat()", so I guess it could go either way.

              Linus
