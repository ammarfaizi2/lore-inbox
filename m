Return-Path: <SRS0=GIeg=ZU=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38354C432C0
	for <io-uring@archiver.kernel.org>; Thu, 28 Nov 2019 10:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C7C216F4
	for <io-uring@archiver.kernel.org>; Thu, 28 Nov 2019 10:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u8f2cCPV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfK1KIN (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 28 Nov 2019 05:08:13 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43410 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfK1KIN (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 28 Nov 2019 05:08:13 -0500
Received: by mail-ot1-f65.google.com with SMTP id l14so21732264oti.10
        for <io-uring@vger.kernel.org>; Thu, 28 Nov 2019 02:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yNk3xsUZ+oSOk7bRz+4Bga5ws+iYwn78Pcl6qMinSnY=;
        b=u8f2cCPVHZdz5qbvTe0N+QH3BCTn+DwqVU0ovpjUW79cGc/UyyhtcJJDTeTFKMzGNO
         U8g5im8MNI4A0rVudkS7ji/3SJFqpbCmvfznJYiZK5BHS8n2zS7fCrB37gHSN5BMxlIB
         Q9gT6Xrlp24+3ZTzKcyyQ8IyiGi1lUW7SsjKh4JFC0rhSy/BiQbkvnKjoqP498OAKrwp
         FYX3Fu/Oa4snpMTCJl/SErXgEZQ8diNkkl9X0pw5X5vGUprmk4slAiXwJ4vnhEnyt65T
         BWpQ+reXf0KINt53gWxAaAWYw+La2rjfJFu3GlnYMs36ebMku6FnQIHhntTsfSiQ1jF3
         ObgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yNk3xsUZ+oSOk7bRz+4Bga5ws+iYwn78Pcl6qMinSnY=;
        b=mIuB+rib/tb1b1M7aqv/gVeK5ps2UyPei85xCMGs3RL48QIyoyp8hw+X4ngX81uD9R
         5C7nxLgLxIXpBmeeCyAFf4YWBQpLcbii1jiK3kbn5XHTJsq6alRYpC509u0+EroQaL04
         nRYZJlAI9h3KsqyCFzDFH8u0kiaOFrn6iRup/+ceZXNy1urOHOhUmgl5JvjRzwzPILIj
         XW6wR2nXO2EhMwZRZLwg7YIrfILIX1FG747Tlzuvma8V1ouSZAf474/iJ4JFpXp/d1Gp
         JeEGdV35MONX52hgheKGxOhoio3PduBKP0povYY6Kd2RBWTbyFhyhme/kOze10sajH3r
         zIhA==
X-Gm-Message-State: APjAAAUg7PQW2e2nYhfMkUHFDP694xWXr1IC0AWs2GMJK2X0EvYNswUu
        cx2ym9Ze7uxr2lzcKWM4PVuV6uXrJkMHyCL+Q8EPpw==
X-Google-Smtp-Source: APXvYqy2PMUfNncH77DaOJWnaAOzBzAJN4hv+1PXYJ8YkR9dHaty4QhojiAF5D2tEVm+0gdwe0n1c7sGXOEfpITUctg=
X-Received: by 2002:a9d:4801:: with SMTP id c1mr6749995otf.32.1574935692364;
 Thu, 28 Nov 2019 02:08:12 -0800 (PST)
MIME-Version: 1.0
References: <254505c9-2b76-ebeb-306c-02aaf1704b88@kernel.dk>
 <CAG48ez33ewwQB26cag+HhjbgGfQCdOLt6CvfmV1A5daCJoXiZQ@mail.gmail.com>
 <1d3a458a-fa79-5e33-b5ce-b473122f6d1a@kernel.dk> <CAG48ez2VBS4bVJqdCU9cUhYePYCiUURvXZWneBx2KGkg3L9d4g@mail.gmail.com>
 <f4144a96-58ef-fba7-79f0-e5178147b6bb@rasmusvillemoes.dk>
In-Reply-To: <f4144a96-58ef-fba7-79f0-e5178147b6bb@rasmusvillemoes.dk>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 28 Nov 2019 11:07:46 +0100
Message-ID: <CAG48ez1v5EmuSvn+LY8od_ZMt1QVdUWqi9DWLSp0CgMxkL=sNg@mail.gmail.com>
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

On Thu, Nov 28, 2019 at 10:02 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
> On 28/11/2019 00.27, Jann Horn wrote:
>
> > One more thing, though: We'll have to figure out some way to
> > invalidate the fd when the target goes through execve(), in particular
> > if it's a setuid execution. Otherwise we'll be able to just steal
> > signals that were intended for the other task, that's probably not
> > good.
> >
> > So we should:
> >  a) prevent using ->wait() on an old signalfd once the task has gone
> > through execve()
> >  b) kick off all existing waiters
> >  c) most importantly, prevent ->read() on an old signalfd once the
> > task has gone through execve()
> >
> > We probably want to avoid using the cred_guard_mutex here, since it is
> > quite broad and has some deadlocking issues; it might make sense to
> > put the update of ->self_exec_id in fs/exec.c under something like the
> > siglock,
>
> What prevents one from exec'ing a trivial helper 2^32-1 times before
> exec'ing into the victim binary?

Uh, yeah... that thing should probably become 64 bits wide, too.
