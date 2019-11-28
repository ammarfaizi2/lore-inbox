Return-Path: <SRS0=GIeg=ZU=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C56FC432C0
	for <io-uring@archiver.kernel.org>; Thu, 28 Nov 2019 22:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11EE7206BF
	for <io-uring@archiver.kernel.org>; Thu, 28 Nov 2019 22:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y8Ea/smQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfK1Wra (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 28 Nov 2019 17:47:30 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42800 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbfK1Wra (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 28 Nov 2019 17:47:30 -0500
Received: by mail-ot1-f68.google.com with SMTP id 66so17241846otd.9
        for <io-uring@vger.kernel.org>; Thu, 28 Nov 2019 14:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CUk7v7UPe6VTRCevALfgnUC9KL2cGJpFHn8mL3idLe0=;
        b=Y8Ea/smQHjouC6SBRXFZkjwTn2tarmmechSnFeym66dooOOnkxhT2nHCmkSARtdQUe
         ZXdW78yhSFGWQa9ZEKD+TSdGevk4bhR+ccadD5qPzyAVHBSeBpKWvJNNtVxHxWYdKSlw
         tsLHHiQ1/WZPQ7fJQVfpJxtzU5skIztwBNzX5XZeRT1BCWYgL3D14cJyuo171iKI4apV
         7E/2u7t3FvJMNVr/zLBD1kmeCWN/E3GUMZmzjsEZ0yKeEv5iUJpSKP1JivJYGprcKcsb
         cVpqaAEL62COc9FyK1lg2vZAtfyTW3MfKZ4yqB7r/BorGWp6TDqqVlQRslci132N+iyF
         Zafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CUk7v7UPe6VTRCevALfgnUC9KL2cGJpFHn8mL3idLe0=;
        b=eWzySjCXXrkR/AfPoKIN/9Zj/S+LUnI0x5fGmyiSJKtz0uetC+yK+ptWXOUEi6b/1B
         z5I3PkfIVsC+gU/6DmVhCoWawIi1gSyYjYwlOwwInhYDW629ZeHIgtC5Fa6geGzlWb6j
         BnzaTWKsg+W63EuBCrYC/pi4JskP832YuAOWKFf8gwXxGe10V8sxYnBgMCN0s49bNne7
         aqpSBAKAQEwx7Qn3mefUCgyg2rKOzQXPECl2GlRerhkwcFWtN25BMoudbaRXPDa3TExy
         2UmaS9XCLGn7XQKwWYIcPVk0Ybh6mHD8fSWTrjASzTXtgSToxEV2XGpWCV5cQTi6ubwB
         tdCA==
X-Gm-Message-State: APjAAAUiskyAedOR9iX82k3kBcfk+tbFdwBKkLBEKX3zxoiZ63kqBjVW
        7DmZP0p6PxK//lId5lfvS03DcWCiArIQUNHYif9+BLqj9onnKg==
X-Google-Smtp-Source: APXvYqwtrGRoVpfoYUQbpfscgR1YvjNIoEJwTjGpNh374JxCwGJYz8mI0UDKMJGK2aEAi5yUqMGk7HFD34Er13qtUfQ=
X-Received: by 2002:a9d:4801:: with SMTP id c1mr8740496otf.32.1574981248999;
 Thu, 28 Nov 2019 14:47:28 -0800 (PST)
MIME-Version: 1.0
References: <254505c9-2b76-ebeb-306c-02aaf1704b88@kernel.dk>
 <CAG48ez33ewwQB26cag+HhjbgGfQCdOLt6CvfmV1A5daCJoXiZQ@mail.gmail.com>
 <1d3a458a-fa79-5e33-b5ce-b473122f6d1a@kernel.dk> <CAG48ez2VBS4bVJqdCU9cUhYePYCiUURvXZWneBx2KGkg3L9d4g@mail.gmail.com>
 <f4144a96-58ef-fba7-79f0-e5178147b6bb@rasmusvillemoes.dk> <CAG48ez1v5EmuSvn+LY8od_ZMt1QVdUWqi9DWLSp0CgMxkL=sNg@mail.gmail.com>
 <CAG48ez1FK6h4tEv=cGGtm84NXDkeiMV+woFmqQYPbcsOZjKxZw@mail.gmail.com>
In-Reply-To: <CAG48ez1FK6h4tEv=cGGtm84NXDkeiMV+woFmqQYPbcsOZjKxZw@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 28 Nov 2019 23:46:59 +0100
Message-ID: <CAG48ez11PjWtaFrPqtU6yPKsm0_0Sb3Te-8bvVQLEozDzx7cFw@mail.gmail.com>
Subject: Re: [PATCH RFC] signalfd: add support for SFD_TASK
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Jens Axboe <axboe@kernel.dk>, io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On Thu, Nov 28, 2019 at 8:18 PM Jann Horn <jannh@google.com> wrote:
> On Thu, Nov 28, 2019 at 11:07 AM Jann Horn <jannh@google.com> wrote:
> > On Thu, Nov 28, 2019 at 10:02 AM Rasmus Villemoes
> > <linux@rasmusvillemoes.dk> wrote:
> > > On 28/11/2019 00.27, Jann Horn wrote:
> > >
> > > > One more thing, though: We'll have to figure out some way to
> > > > invalidate the fd when the target goes through execve(), in particular
> > > > if it's a setuid execution. Otherwise we'll be able to just steal
> > > > signals that were intended for the other task, that's probably not
> > > > good.
> > > >
> > > > So we should:
> > > >  a) prevent using ->wait() on an old signalfd once the task has gone
> > > > through execve()
> > > >  b) kick off all existing waiters
> > > >  c) most importantly, prevent ->read() on an old signalfd once the
> > > > task has gone through execve()
> > > >
> > > > We probably want to avoid using the cred_guard_mutex here, since it is
> > > > quite broad and has some deadlocking issues; it might make sense to
> > > > put the update of ->self_exec_id in fs/exec.c under something like the
> > > > siglock,
> > >
> > > What prevents one from exec'ing a trivial helper 2^32-1 times before
> > > exec'ing into the victim binary?
> >
> > Uh, yeah... that thing should probably become 64 bits wide, too.
>
> Actually, that'd still be wrong even with the existing kernel code for
> two reasons:
>
>  - if you reparent to a subreaper, the existing exec_id comparison breaks

... actually, I was wrong about this, this case is fine because the
->exit_signal is reset in reparent_leader().
