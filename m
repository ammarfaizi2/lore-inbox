Return-Path: <SRS0=GIeg=ZU=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898A2C43215
	for <io-uring@archiver.kernel.org>; Thu, 28 Nov 2019 15:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C7B121787
	for <io-uring@archiver.kernel.org>; Thu, 28 Nov 2019 15:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N+fcqeko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfK1P3c (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 28 Nov 2019 10:29:32 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41687 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbfK1P3c (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 28 Nov 2019 10:29:32 -0500
Received: by mail-oi1-f196.google.com with SMTP id e9so23617539oif.8
        for <io-uring@vger.kernel.org>; Thu, 28 Nov 2019 07:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8jbWiJP8zuPwo1h57bhn9bSCas9rrkjtaMb7mPh1IdA=;
        b=N+fcqekoOxQDhlpJGKAWkheEt+gN07VZ81/73rXPn1PTzGgsLa3Rcmh9TY+xjk+3Ih
         qDS65BfoaV4kxITCwQ9aynD1HSih7wmCgb7HKN1o0H2yuxRclj9Ujkcv+DZ9XG9qqLfs
         gYcHNBi7EmNxtYpBo1DwprVnLxrTtjU6Ewc2Z1bEnBpr9dgcHgNpZdxeFGtuNGpYZLXB
         hvMrqTF858ayZPTPJw8NVYywiC4NY9H/sx9/Hg0jnT8HOwWZT4svLjw62xcIlt+rlAQX
         SzBMJVlbbVULZs/zzvLYp6VnC0pl64WDBL9U0f3CF54c3vg/K2F81DElVEZbPOtUntZY
         PnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8jbWiJP8zuPwo1h57bhn9bSCas9rrkjtaMb7mPh1IdA=;
        b=hvkBu1bBY+liiTz4n6d6reBVhR3bgFbN+iAbViWp6iFIFFDWS7ynhpUw/q8TSoowh7
         gPgRj4s29gM/uCu8W3seLaS5qooiHIaUl1iXaMWgVIIldUJ5xdaVbTUa+FbuI/71UYWE
         kSbPiAA/X42Pj5Z2YRwh5fxBCMD6kN5S2pP5C7u9ApkxOs9phdlaP2eJjw8sEUD4lgof
         jRz/RjQGgknGqstgvr6PdWxH9+brrIIM7s8Z3LQ587BX8kmLpYHEBiTSHMeP1E6vK+4/
         cEqKrAeRp7aiX/n7QRGx1R3JrHRq2uqPqIaEFnDtGRL/8TCGUtJ86k3LfFrjZ1qYhwRx
         GC7A==
X-Gm-Message-State: APjAAAUldGhKJbX3J8l5CH8G0VWMCDS5TnLGkwJLSNAnGhMrcwkG1pH+
        fTOk+g9t1we27A/BlrWAMDBVY4HbWAyHfE8gpkTM/A==
X-Google-Smtp-Source: APXvYqwQF8gySZpP3ML3y1V5QupQwMNy5TOx2Z2uDdHPjHuyVgwkY34m3prkUOx4mIROyml0+fITWq8uzCmVDZn6HVs=
X-Received: by 2002:aca:d783:: with SMTP id o125mr1403513oig.68.1574954969803;
 Thu, 28 Nov 2019 07:29:29 -0800 (PST)
MIME-Version: 1.0
References: <0000000000009f46d4059863fdea@google.com> <71b86056-944f-c5e1-b4cf-35833a82761c@kernel.dk>
In-Reply-To: <71b86056-944f-c5e1-b4cf-35833a82761c@kernel.dk>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 28 Nov 2019 16:29:03 +0100
Message-ID: <CAG48ez09ZN2v2rTvnSgybrZu7BAa28vcnkcOU=Z7549rbpqz1A@mail.gmail.com>
Subject: Re: INFO: trying to register non-static key in io_cqring_overflow_flush
To:     Jens Axboe <axboe@kernel.dk>,
        syzbot <syzbot+be9e13497969768c0e6e@syzkaller.appspotmail.com>
Cc:     io-uring <io-uring@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On Thu, Nov 28, 2019 at 4:19 PM Jens Axboe <axboe@kernel.dk> wrote:
> On 11/28/19 12:35 AM, syzbot wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    d7688697 Merge tag 'for-linus' of git://git.kernel.org/pub..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=145e5fcee00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=12f2051e3d8cdb3f
> > dashboard link: https://syzkaller.appspot.com/bug?extid=be9e13497969768c0e6e
> > compiler:       clang version 9.0.0 (/home/glider/llvm/clang
> > 80fee25776c2fb61e74c1ecb1a523375c2500b69)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=146c517ae00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16550b12e00000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+be9e13497969768c0e6e@syzkaller.appspotmail.com
>
> This is the same as:
>
> syzbot+0d818c0d39399188f393@syzkaller.appspotmail.com

syzbot listens to specific commands, see
<https://github.com/google/syzkaller/blob/master/docs/syzbot.md#status>
(linked in the report):

#syz dup: INFO: trying to register non-static key in io_cqring_ev_posted
