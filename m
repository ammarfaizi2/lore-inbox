Return-Path: <SRS0=PUae=Y6=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA73DC5DF63
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 19:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9774E217D7
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 19:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qOFx0xEO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfKFTwR (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 6 Nov 2019 14:52:17 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43558 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfKFTwR (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 6 Nov 2019 14:52:17 -0500
Received: by mail-ot1-f66.google.com with SMTP id l14so7582840oti.10
        for <io-uring@vger.kernel.org>; Wed, 06 Nov 2019 11:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fywk/plM2dJuF2Bmhii1gb5GzxJYSB5K3wPTzmwhhxI=;
        b=qOFx0xEOpsZVDCbtwWlwrhilDwHYnSUBwi+LTF2X+8bcgpYLnD5ehgZ+3r6HyiwrdS
         LTaozXkqIzdqweUI2HKM3mYNtl5r1DceDZ3y4Bj537ejoCt+aUnxRgpIWsjEBztevPQV
         HyZtRpfqXb7nO56hyk9uGzapO4Cjh5/evdGQ4nOY5b/w6Zu9O7qClXq1v2yW0xW88J8x
         tjS2Jdh+Hh60wVdzK4ucAWOOBwLBPYcvRSgfWQoUtRDtgWuT2J9qcJcG7rWEwTFDUlZ7
         /tD+8uMO1b1a6gthBq2FlE+wPBuR5Cd4sNsq7SzPYVAAgS9CRc25bjSMHhri64rkM7IA
         k/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fywk/plM2dJuF2Bmhii1gb5GzxJYSB5K3wPTzmwhhxI=;
        b=Io3Qcs2fy6cZmCBFXi8ouf0fEJzJBWDWCyi75pDqJ8/KhSMEgQCJibLUTwF4Rl6nlJ
         Er5wfN4zCgHKoxNpmRUAHuoJ6CezbZN6C18iXF/2utNnUlvJ1k/6SjBzL7XgUa2XA3M8
         hCIwcuZK09NhRs0O2m3NM76JPFCodU/+n6pgGEXuDeeuFv2Lm2J5bIWmbflMoaRVOD4h
         cldAGWtHNqsO7P09FoCYK3WRVm77i+V9Rul7+L6VtGJB9gAx5lrlhmB4xAeACCQx/SJ8
         Fd8431NSPv2lOx1GCHe3BDehdW60t7oS2yG++xDTFzLcZp4seJx796giBN0rdXeeU3jl
         eMMA==
X-Gm-Message-State: APjAAAWoIs2SvCjDTnPub9/ReS47Qgow9E+OTvrctU8ODexwYrqdPioX
        llsYpz2LgXP+34Pu2kharViyhk8t0Ae7uMBvGE+rMQ==
X-Google-Smtp-Source: APXvYqwdu01jCn8yBHyhCGhj3PkHuuweCuHkOnR+jBRccrFosPpUeYbXF75FgeL/SRzYzJ8DU5f6SjxP1mLZdGh5cfQ=
X-Received: by 2002:a9d:4801:: with SMTP id c1mr3138962otf.32.1573069935716;
 Wed, 06 Nov 2019 11:52:15 -0800 (PST)
MIME-Version: 1.0
References: <37d8ba3d-27c7-7636-0343-23ec56e4bee7@kernel.dk>
In-Reply-To: <37d8ba3d-27c7-7636-0343-23ec56e4bee7@kernel.dk>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 6 Nov 2019 20:51:48 +0100
Message-ID: <CAG48ez1_91Lk73sdpp1SiufOQShdP2zX6g9gMLW46gAvMioKOA@mail.gmail.com>
Subject: Re: [RFC] io_uring CQ ring backpressure
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On Wed, Nov 6, 2019 at 5:23 PM Jens Axboe <axboe@kernel.dk> wrote:
> Currently we drop completion events, if the CQ ring is full. That's fine
> for requests with bounded completion times, but it may make it harder to
> use io_uring with networked IO where request completion times are
> generally unbounded. Or with POLL, for example, which is also unbounded.
>
> This patch adds IORING_SETUP_CQ_NODROP, which changes the behavior a bit
> for CQ ring overflows. First of all, it doesn't overflow the ring, it
> simply stores backlog of completions that we weren't able to put into
> the CQ ring. To prevent the backlog from growing indefinitely, if the
> backlog is non-empty, we apply back pressure on IO submissions. Any
> attempt to submit new IO with a non-empty backlog will get an -EBUSY
> return from the kernel.
>
> I think that makes for a pretty sane API in terms of how the application
> can handle it. With CQ_NODROP enabled, we'll never drop a completion
> event (well unless we're totally out of memory...), but we'll also not
> allow submissions with a completion backlog.
[...]
> +static void io_cqring_overflow(struct io_ring_ctx *ctx, u64 ki_user_data,
> +                              long res)
> +       __must_hold(&ctx->completion_lock)
> +{
> +       struct cqe_drop *drop;
> +
> +       if (!(ctx->flags & IORING_SETUP_CQ_NODROP)) {
> +log_overflow:
> +               WRITE_ONCE(ctx->rings->cq_overflow,
> +                               atomic_inc_return(&ctx->cached_cq_overflow));
> +               return;
> +       }
> +
> +       drop = kmalloc(sizeof(*drop), GFP_ATOMIC);
> +       if (!drop)
> +               goto log_overflow;
> +
> +       drop->user_data = ki_user_data;
> +       drop->res = res;
> +       list_add_tail(&drop->list, &ctx->cq_overflow_list);
> +}

This could potentially consume moderately large amounts of atomic
memory quickly and without any guarantee that the memory will be freed
anytime soon, right? That seems moderately bad. Is there no way to
e.g. pre-reserve memory for completion events, or something like that?
