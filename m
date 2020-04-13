Return-Path: <SRS0=xzJI=55=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E896FC2BA19
	for <io-uring@archiver.kernel.org>; Mon, 13 Apr 2020 15:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC62120732
	for <io-uring@archiver.kernel.org>; Mon, 13 Apr 2020 15:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLyE/QHY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730728AbgDMPqw (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 13 Apr 2020 11:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728597AbgDMPqv (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 13 Apr 2020 11:46:51 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B1BC0A3BDC
        for <io-uring@vger.kernel.org>; Mon, 13 Apr 2020 08:46:51 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id w20so9777366iob.2
        for <io-uring@vger.kernel.org>; Mon, 13 Apr 2020 08:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cDPCttrki8RSj39St2L6K48mZGgOW88Di1tRSy175X8=;
        b=lLyE/QHYNA5gY8O7M0l820OnTQeUs+JrbWQR5X0j6pRl+8mGY+Dg6IlFPVp0ZBhvIJ
         04WgiVKjabO4/6WEabMRlukbN6Y1DE3th50StIwsL41ba21FrN2V1lO8biLR60TGlMxX
         IsASuqcFIu0pZ03kPVN1QTR+OBJe/LTLC5Ulj+/S3sdHE0MnFHTGHQvuPykVyBEW9yUl
         l/KUEOpJR2QJeivYmhwA3eYqm3tCOBMYb9nDAih4y5UVd9RYxlBPA/qDhiJE1Psv5+hN
         xPSEVySGpyBKo8vqcdYWgt6V3XdkiajlXCzi/c+XaLohYeS68peQWUqSc0SxUIvNlghX
         mN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cDPCttrki8RSj39St2L6K48mZGgOW88Di1tRSy175X8=;
        b=kjb1Vh7XJDRNMtDBph4jX962GdCCxZ26ovvUdHO6K0SsCzArHjAa0RyJaAOumjOkxv
         4DAQzRRkLp4egBCxyrCSa90dY/B0q11uk8j0MPj13i7/PL6ke+SjAd1TlTg27YbOYv5f
         5yFNMqHIkPsgsucT4DlHp2M/P+f0b1p3MvYJDDmAu2aonSpPAShHLaWh8nvUjmG8Tp73
         S1pFPfjblQqhcmX1z3lnac2oxEnqPcvSrmgzFq68Df4PbIaULWzuZ2ODC/RFElUZUTbU
         xWyswAIt3LjV1RPFK09KOlphGjzUr13tpey/vAbOM5zfEobfawXQJPadvGzwYmAE6zEj
         xRzQ==
X-Gm-Message-State: AGi0PuafVuldRnIzh5CicvC9IIDt0bNz2RVg9YUv7Wwj2Nj8mcH4yZ0D
        6E52TReAOj2UM8hKQLJQMmdRD3LZ0hsnvi78OgKsSznneIU=
X-Google-Smtp-Source: APiQypIdQ2V+HJOhAvvDnh1bSjA/oHzFT6Yxd6Q09PSvL38Ej3QoiEIIdGhJ/Vs6/5C2J3/MAVbxIiOdH4Thmcrk2BY=
X-Received: by 2002:a5e:c64d:: with SMTP id s13mr3433446ioo.44.1586792810567;
 Mon, 13 Apr 2020 08:46:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200413071940.5156-1-xiaoguang.wang@linux.alibaba.com> <949512f3-9739-5514-2daa-1ee224d85b90@kernel.dk>
In-Reply-To: <949512f3-9739-5514-2daa-1ee224d85b90@kernel.dk>
From:   Hrvoje Zeba <zeba.hrvoje@gmail.com>
Date:   Mon, 13 Apr 2020 11:46:39 -0400
Message-ID: <CAEsUgYh9QHgfo2RfnAupOVu+BO5rDnQjU+78SnBTuiHtECHpqQ@mail.gmail.com>
Subject: Re: [LIBURING PATCH] sq_ring_needs_enter: check whether there are
 sqes when SQPOLL is not enabled
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        io-uring@vger.kernel.org, joseph.qi@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On Mon, Apr 13, 2020 at 11:29 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 4/13/20 1:19 AM, Xiaoguang Wang wrote:
> > Indeed I'm not sure this patch is necessary, robust applications
> > should not call io_uring_submit when there are not sqes to submmit.
> > But still try to add this check, I have seen some applications which
> > call io_uring_submit(), but there are not sqes to submit.
>
> Hmm, not sure it's worth complicating the submit path for that case.
> A high performant application should not call io_uring_submit() if
> it didn't queue anything new. Is this a common case you've seen?
>

My code calls io_uring_submit() even if there are no sqes to submit to
avoid spinning if there's nothing to do:

...
uint32_t sleep = (gt::user_contexts_waiting() > 0) ? 0 : 1;
auto res = io_uring_submit_and_wait(&m_io_uring, sleep);
...

-- 
I doubt, therefore I might be.
