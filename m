Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0BAC433DB
	for <io-uring@archiver.kernel.org>; Thu,  4 Mar 2021 11:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CB4D64E51
	for <io-uring@archiver.kernel.org>; Thu,  4 Mar 2021 11:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbhCDLPL (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 4 Mar 2021 06:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239514AbhCDLOj (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 4 Mar 2021 06:14:39 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21040C061574
        for <io-uring@vger.kernel.org>; Thu,  4 Mar 2021 03:13:59 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id a18so18977600wrc.13
        for <io-uring@vger.kernel.org>; Thu, 04 Mar 2021 03:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XHyKrwKq5fM3r5AB9uFmBKte7bjeOG4uqO0BOTAF9iM=;
        b=t0+/ozwJOMXGEwWqXoKLUJbZqK+mDJmV77TlWnFnbAsMQTn7g4lw29sBgVmBneyB3Y
         lVZT6snMo/Iy1Degs5UxnKjV/FWU9VdVqpmp4LwNUwY67W5Qh47GPbjWjUmOJsrw+iK3
         eKcFMASTtZJFcCBgdmiL+MBNpRYo3FYktADMATtPNIeBN1twpUbGK5q9qoL7PbJFE1fT
         JNfL0g7/MOai8LhTWTq7R7yOy0PzpphvUWqYF/wQj+R3vZvCW93GONOnV/PyMvq/d1HN
         uadfKpNP187UYv45lI8EFq20hRInPhVVsK3oppPRgI+33y7P0M3a8KjdEChfvyEqWICs
         n2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XHyKrwKq5fM3r5AB9uFmBKte7bjeOG4uqO0BOTAF9iM=;
        b=kpRCE3/L6mamQjFL2vhdtUuegsp2aMw5MYsz8td6msxaiREYi4eZOZwWlnbapj+Vfz
         sg9BEBV2bFsUqFxLpCLScqRDpAlcC7Iz8IkLXhG7SUHgJYqTVAsbi2px5hdNrCqwZ62h
         zrwyQrKETm307ekdxBoKYvvH1xmxJtPQea6IgmY0XeI8/vVcXE/z11LrBSxc/eleA4sY
         R0UEvkMmOUOSxll2K9qoWBkFwwA3lbvn2NFVERWvpJ+iorE8QE+zQkYRPJiN1d5ISO3h
         DnwoMIOVZ/pTctsEsaRorte/4kaNoLOhQfFVngvLFN4wYK8aeU3vHcnKtszStnCFecqc
         HdhQ==
X-Gm-Message-State: AOAM532CPfhuyulWB/54+l2208w3RxgeMUdbTqQnBLIdv+rXQlBGNTWH
        1p4FXhB2HKcdcSdZnoycPKwsjIwXk+QuByi3XBk=
X-Google-Smtp-Source: ABdhPJxvnPsChJuZZkZHA7KIyT8WcIkX1Wnhrb+H3ITh1Q2I09oASAvRbI09lvplRSkwhHVHI5XSPf7PG641Utl7wyk=
X-Received: by 2002:a5d:4286:: with SMTP id k6mr3456316wrq.278.1614856437853;
 Thu, 04 Mar 2021 03:13:57 -0800 (PST)
MIME-Version: 1.0
References: <20210302160734.99610-1-joshi.k@samsung.com> <CGME20210302161005epcas5p23f28fe21bab5a3e07b9b382dd2406fdc@epcas5p2.samsung.com>
 <20210302160734.99610-3-joshi.k@samsung.com> <BYAPR04MB496566944851825B251CA93686989@BYAPR04MB4965.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB496566944851825B251CA93686989@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Kanchan Joshi <joshiiitr@gmail.com>
Date:   Thu, 4 Mar 2021 16:43:30 +0530
Message-ID: <CA+1E3rLCSWDmLa1rrZ986xnbx6fcsGgBE6NPP59eJj4swY+gQg@mail.gmail.com>
Subject: Re: [RFC 2/3] nvme: passthrough helper with callback
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Kanchan Joshi <joshi.k@samsung.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "anuj20.g@samsung.com" <anuj20.g@samsung.com>,
        "javier.gonz@samsung.com" <javier.gonz@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On Wed, Mar 3, 2021 at 8:52 PM Chaitanya Kulkarni
<Chaitanya.Kulkarni@wdc.com> wrote:
>
> On 3/2/21 23:22, Kanchan Joshi wrote:
> > -void nvme_execute_passthru_rq(struct request *rq)
> > +void nvme_execute_passthru_rq_common(struct request *rq,
> > +                     rq_end_io_fn *done)
> >  {
> >       struct nvme_command *cmd = nvme_req(rq)->cmd;
> >       struct nvme_ctrl *ctrl = nvme_req(rq)->ctrl;
> > @@ -1135,9 +1136,17 @@ void nvme_execute_passthru_rq(struct request *rq)
> >       u32 effects;
> >
> >       effects = nvme_passthru_start(ctrl, ns, cmd->common.opcode);
> > -     blk_execute_rq(disk, rq, 0);
> > +     if (!done)
> > +             blk_execute_rq(disk, rq, 0);
> > +     else
> > +             blk_execute_rq_nowait(disk, rq, 0, done);
> >       nvme_passthru_end(ctrl, effects);
>
> This needs a detailed explanation in order to prove the correctness.

Do you see something wrong here?
blk_execute_rq() employs the same helper (i.e. nowait one) and uses
additional completion-variable to make it sync.
