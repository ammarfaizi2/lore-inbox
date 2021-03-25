Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A405C433C1
	for <io-uring@archiver.kernel.org>; Thu, 25 Mar 2021 20:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F70061A28
	for <io-uring@archiver.kernel.org>; Thu, 25 Mar 2021 20:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbhCYUuV (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 25 Mar 2021 16:50:21 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:36240 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbhCYUuB (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 25 Mar 2021 16:50:01 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lPWvY-007dw1-5f; Thu, 25 Mar 2021 14:50:00 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lPWvX-007lPx-DU; Thu, 25 Mar 2021 14:49:59 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        io-uring <io-uring@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Metzmacher <metze@samba.org>
References: <20210325164343.807498-1-axboe@kernel.dk>
        <m1ft0j3u5k.fsf@fess.ebiederm.org>
        <CAHk-=wjOXiEAjGLbn2mWRsxqpAYUPcwCj2x5WgEAh=gj+o0t4Q@mail.gmail.com>
        <CAHk-=wg1XpX=iAv=1HCUReMbEgeN5UogZ4_tbi+ehaHZG6d==g@mail.gmail.com>
        <3a1c02a5-db6d-e3e1-6ff5-69dd7cd61258@kernel.dk>
        <m1zgyr2ddh.fsf@fess.ebiederm.org> <20210325204014.GD28349@redhat.com>
Date:   Thu, 25 Mar 2021 15:48:59 -0500
In-Reply-To: <20210325204014.GD28349@redhat.com> (Oleg Nesterov's message of
        "Thu, 25 Mar 2021 21:40:15 +0100")
Message-ID: <m135wj0xj8.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lPWvX-007lPx-DU;;;mid=<m135wj0xj8.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+s4dSqXk5VKFAiX0d5kYypYa8oLuycJ/k=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 0/2] Don't show PF_IO_WORKER in /proc/<pid>/task/
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 03/25, Eric W. Biederman wrote:
>>
>> So looking quickly the flip side of the coin is gdb (and other
>> debuggers) needs a way to know these threads are special, so it can know
>> not to attach.
>
> may be,
>
>> I suspect getting -EPERM (or possibly a different error code) when
>> attempting attach is the right was to know that a thread is not
>> available to be debugged.
>
> may be.
>
> But I don't think we can blame gdb. The kernel changed the rules, and this
> broke gdb. IOW, I don't agree this is gdb bug.

My point would be it is not strictly a regression either.  It is gdb not
handling new functionality.

If we can be backwards compatible and make ptrace_attach work that is
preferable.  If we can't saying the handful of ptrace using applications
need an upgrade to support processes that use io_uring may be
acceptable.

I don't see any easy to implement path that is guaranteed to work.

Eric



