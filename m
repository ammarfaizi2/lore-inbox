Return-Path: <SRS0=5JAm=EN=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89EAC388F7
	for <io-uring@archiver.kernel.org>; Sat,  7 Nov 2020 14:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F9A420719
	for <io-uring@archiver.kernel.org>; Sat,  7 Nov 2020 14:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qwTiHcHF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbgKGOJU (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 7 Nov 2020 09:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbgKGOJT (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 7 Nov 2020 09:09:19 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D762C0613CF
        for <io-uring@vger.kernel.org>; Sat,  7 Nov 2020 06:09:19 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id ed14so1850788qvb.4
        for <io-uring@vger.kernel.org>; Sat, 07 Nov 2020 06:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lYy5Q3j0/qHRIQpHmgQwRhPL3ZQjA9zi9iui5vgp2XM=;
        b=qwTiHcHFqwmH53Mhh5UOm1mKjP+otZw08ITadxSk/hsECmsTJAn1fDO0tAu49ETzJk
         NmrUVY13XOwZMONaPuC19V8xRP3qeX99MZyey+m47MODThRU+y78TdpOEY61UPwpVBxV
         v3Kx6UHczh7lmZIOZ+449czRObgbfT/PhSCS4vnvydVkxA3Xq8lVctqLimtPvJX0RgbP
         l5Asudnai4JmC5xj4h8SkplvOLuAjdgOmEQk4CdLHI4FcPLa+GY+FT4sPIRtSj9ZNjJe
         4gmSHIZ+mW9p7GxKYvA2+sWZwX2aE6L19um6CH7NHDzWWJvw63ax4tCYle22UsB/enfz
         eg5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lYy5Q3j0/qHRIQpHmgQwRhPL3ZQjA9zi9iui5vgp2XM=;
        b=eoemt5LXgKzB1x9ZwRHwnpAmIY8aIOLzd9jPWtBkvW+3gAntrf6ySPfCdRQvUaKNAa
         miFtNGKTjg8hbUnyu6nLF1x8mknE5KVtVJ3Tgn6/5kvKIHJVxnEPZ/oiRJuOJn9Tqm6d
         Wrq+XJ3qGwgxB4mwDAeB3gU0xkG18ONQCvM6PboOcD56VdNdKOQgNl+Ob3ZJoz4/kWgt
         TmnqvZ8aqkCU5poqnjVUcjkPA4UxF5Nygm6p1+fcOt6B7z/rG+bid7MkE/dtv7eQxHQB
         lcK2ymKHsjhKupGZY2p3BDo24QNiCxCH1qFpPdynEvfcBiSr/l2cg8xFO27jVxiCwvny
         fUqw==
X-Gm-Message-State: AOAM533e+YdFTi8mZ30FdPsERQDdc6c3xkAxE+eA6rODDCz++HXp0Gj3
        A7wRo7279fdXmG3lBjB+IeJPLqzQ4mq2TZC5brg=
X-Google-Smtp-Source: ABdhPJw3Ch9Ju0ovIX6cYrijkZ4KG5wapmCE//TeePjecrc6lfRKnGzXEsLhcmzHcXmrFB63U0rAg+Ju7slRxKNS0As=
X-Received: by 2002:ad4:5381:: with SMTP id i1mr6262924qvv.21.1604758158633;
 Sat, 07 Nov 2020 06:09:18 -0800 (PST)
MIME-Version: 1.0
References: <CAAss7+pgQN7uPFaLakd+K4yZH6TRcMHELQV0wAA2NUxPpYEL_Q@mail.gmail.com>
 <CAAss7+rt_mkHhGY=kkduDK58jVZy73yZx8qFYEPOU9JjGaCs=g@mail.gmail.com> <c5d77fb0-ea86-10a4-5314-42aed9ef5a18@gmail.com>
In-Reply-To: <c5d77fb0-ea86-10a4-5314-42aed9ef5a18@gmail.com>
From:   Josef <josef.grieb@gmail.com>
Date:   Sat, 7 Nov 2020 15:09:07 +0100
Message-ID: <CAAss7+pux3gjusGOsAdRr3Txr+dRRUfxnBrzd2eM2KtN+6-FVw@mail.gmail.com>
Subject: Re: Using SQPOLL for-5.11/io_uring kernel NULL pointer dereference
To:     Pavel Begunkov <asml.silence@gmail.com>,
        io-uring <io-uring@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     norman@apache.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

> I haven't got the first email, is it "kernel NULL pointer dereference"
> as in the subject or just freeze?

that's weird..probably the size of the attached log file is too big...
here dmesg log file
https://gist.github.com/1Jo1/3d0bcefc18f097265f0dc1ef054a87c0

> - did you locate which test hangs it? If so what it uses? e.g. SQPOLL
> sharing, IOPOLL., etc.

yes, it uses SQPOLL, without sharing, IPOLL is not enabled, and Async
Flag is enabled

> - is it send/recvmsg, send/recv you use? any other?

no the tests which occurs the error use these operations: OP_READ,
OP_WRITE, OP_POLL_ADD, OP_POLL_REMOVE, OP_CLOSE, OP_ACCEPT, OP_TIMEOUT
(OP_READ, OP_WRITE and OP_CLOSE async flag is enabled)

> - does this happen often?

yeah quite often

> - you may try `funcgraph __io_sq_thread -H` or even with `io_sq_thread`
> (funcgraph is from bpftools). Or catch that with some other tools.

I'm not quite familiar with these tools( kernel debugging in general)
I'll take a look tomorrow


ernel NULL pointer dereference"
> as in the subject or just freeze?
>
> also
> - anything in dmesg? (>5 min after freeze)
> - did you locate which test hangs it? If so what it uses? e.g. SQPOLL
> sharing, IOPOLL., etc.
> - is it send/recvmsg, send/recv you use? any other?
> - does this happen often?
> - you may try `funcgraph __io_sq_thread -H` or even with `io_sq_thread`
> (funcgraph is from bpftools). Or catch that with some other tools.
>
> --
> Pavel Begunkov
