Return-Path: <SRS0=yjkE=ZH=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3D5C33C99
	for <io-uring@archiver.kernel.org>; Fri, 15 Nov 2019 21:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D3920729
	for <io-uring@archiver.kernel.org>; Fri, 15 Nov 2019 21:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573852666;
	bh=qwXMYN+xu7noiz7BZMj0L/NCUBPbWFAwfiIHmK57efM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XwUDx/7LVmQBVVVBYvEAa6MLr42wDN3FQ9otkeK+rfTw9JuxMRZWuZhyAUmL4DVmv
	 /VpxEYhc3r+tOHdjShnWPgwe0VOmmuOM9mgPgZOL24OGNfr3hYPFBRT12NkJLnVp0+
	 gV+gfDLx5+gf5EgfaQRirIbYJu5HAn5tgZ2PTSTY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfKOVRq (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 15 Nov 2019 16:17:46 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38432 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfKOVRp (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 15 Nov 2019 16:17:45 -0500
Received: by mail-lf1-f68.google.com with SMTP id q28so9038014lfa.5
        for <io-uring@vger.kernel.org>; Fri, 15 Nov 2019 13:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xLz3Xr8TvGk1oVGrR5pjuIrOELVV7mBaTprlBhmoJyk=;
        b=SbNXGQStFbr6YPNF0PX5qOYwuwzYSHH6C/gh2SfkUZ3bVCJAXxguUaymm8QDaGsGA9
         hiSl+MVdSwpN74B1S20lnglblgO8cAGGhj2lx2beFn8Dy/JoLnsMSaxtzsMo0d8FUYEf
         eAhtAW6zQRLQBmo3UrMpIgpFdNt58OCbgVOJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xLz3Xr8TvGk1oVGrR5pjuIrOELVV7mBaTprlBhmoJyk=;
        b=iJLenlSc3l3IcyRKcXfdQJYUUxKkWBinT7sWmYPuAXN7+itN/slf6PP6wGTbYIzLVn
         N4ORMaF2tnbD4e3c/6IyAj8RVD+SGGH2ZmH1897VP36LEVi18Rgsg8sfg0ywmHAKAu7t
         C9JNcNVf+LieNaGBIU7+8SBzkAyuQZ0tJJ1SQgSTXv20jeSvvQ0qXbWTUBSXWwPosTP7
         1TiH4zuwjFYEj1D3LqWNu8KXdKFVQTxhkJrUwNfSII449nkfiXVxZWgvm8K4iJ/aWk+X
         T24Or2ajNTGwb1fPVDjQbAXVeTnZC3gjSks56pki663wkGPYMHUp22xYRi9eIh1lHcyD
         j2JQ==
X-Gm-Message-State: APjAAAXfyuge0yoaFZvm1RCvezBLijKL/KTIcG7vwYQ1QpOV5WmwXSX3
        kIESfMPaMEdHsPz/WXB8CejcOFnNdAw=
X-Google-Smtp-Source: APXvYqyLlRkDleDFRzOsWsoRPURkzHRX/sHf2b9l9Lw8LgYi89SUPe/kgAX52E8Z5JClNe2nJjJnKw==
X-Received: by 2002:ac2:4ac1:: with SMTP id m1mr12669304lfp.182.1573852663415;
        Fri, 15 Nov 2019 13:17:43 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id d24sm4504566ljg.73.2019.11.15.13.17.42
        for <io-uring@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2019 13:17:42 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id q28so9037959lfa.5
        for <io-uring@vger.kernel.org>; Fri, 15 Nov 2019 13:17:42 -0800 (PST)
X-Received: by 2002:ac2:498a:: with SMTP id f10mr12685140lfl.170.1573852661750;
 Fri, 15 Nov 2019 13:17:41 -0800 (PST)
MIME-Version: 1.0
References: <749566df-9390-2b57-ca8e-7f3b6493eae8@kernel.dk>
In-Reply-To: <749566df-9390-2b57-ca8e-7f3b6493eae8@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Nov 2019 13:17:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjm-UQpZS2T03z2iVxCQUUQN5BGvzVguDStQw2WddM46Q@mail.gmail.com>
Message-ID: <CAHk-=wjm-UQpZS2T03z2iVxCQUUQN5BGvzVguDStQw2WddM46Q@mail.gmail.com>
Subject: Re: [GIT PULL] Fixes for 5.4-rc8/final
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On Fri, Nov 15, 2019 at 11:40 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> - Fix impossible-to-hit overflow merge condition, that still hit some
>   folks very rarely (Junichi)

Hmm. This sounded intriguing, so I looked at it.

It sounds like the 32-bit "bi_size" overflowed, which is one of the
things that bio_full() checks for.

However.

Looking at the *users* of bio_full(), it's not obvious that everything
is ok. For example, in __bio_add_pc_page(), the code does that

        if (((bio->bi_iter.bi_size + len) >> 9) > queue_max_hw_sectors(q))
                return 0;

*before* checking for the overflow condition.

So it could cause that bio_try_merge_pc_page() to be done despite the
overflow, and happily that path ends up having the bio_full() test
later anyway, but it does look a bit worrisome.

There's also __bio_add_page(), which does have a WARN_ON_ONCE(), but
then goes on and does the bi_size update regardless. Hmm.. It does
look like all callers either check bio_full() before, or do it with a
newly allocated bio.

             Linus
