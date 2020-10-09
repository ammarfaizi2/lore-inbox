Return-Path: <SRS0=/ybh=DQ=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A15C4363D
	for <io-uring@archiver.kernel.org>; Fri,  9 Oct 2020 08:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F33E622227
	for <io-uring@archiver.kernel.org>; Fri,  9 Oct 2020 08:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732594AbgJIICC (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 9 Oct 2020 04:02:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:51602 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732742AbgJIIB7 (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Fri, 9 Oct 2020 04:01:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2C296AEAC;
        Fri,  9 Oct 2020 08:01:58 +0000 (UTC)
Date:   Fri, 9 Oct 2020 10:01:57 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Oleg Nesterov <oleg@redhat.com>
cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        io-uring@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de,
        live-patching@vger.kernel.org
Subject: Re: [PATCHSET RFC v3 0/6] Add support for TIF_NOTIFY_SIGNAL
In-Reply-To: <20201008145610.GK9995@redhat.com>
Message-ID: <alpine.LSU.2.21.2010090959260.23400@pobox.suse.cz>
References: <20201005150438.6628-1-axboe@kernel.dk> <20201008145610.GK9995@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On Thu, 8 Oct 2020, Oleg Nesterov wrote:

> On 10/05, Jens Axboe wrote:
> >
> > Hi,
> >
> > The goal is this patch series is to decouple TWA_SIGNAL based task_work
> > from real signals and signal delivery.
> 
> I think TIF_NOTIFY_SIGNAL can have more users. Say, we can move
> try_to_freeze() from get_signal() to tracehook_notify_signal(), kill
> fake_signal_wake_up(), and remove freezing() from recalc_sigpending().
> 
> Probably the same for TIF_PATCH_PENDING, klp_send_signals() can use
> set_notify_signal() rather than signal_wake_up().

Yes, that was my impression from the patch set too, when I accidentally 
noticed it.

Jens, could you CC our live patching ML when you submit v4, please? It 
would be a nice cleanup.

Thanks
Miroslav
