Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD67C433C1
	for <io-uring@archiver.kernel.org>; Thu, 25 Mar 2021 20:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB04F61A27
	for <io-uring@archiver.kernel.org>; Thu, 25 Mar 2021 20:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhCYUXC (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 25 Mar 2021 16:23:02 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:49264 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhCYUWf (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 25 Mar 2021 16:22:35 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lPWUx-00GDix-Cj; Thu, 25 Mar 2021 14:22:31 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1lPWUw-00086p-Jg; Thu, 25 Mar 2021 14:22:31 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        io-uring <io-uring@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Stefan Metzmacher <metze@samba.org>
References: <20210325164343.807498-1-axboe@kernel.dk>
        <m1ft0j3u5k.fsf@fess.ebiederm.org>
        <CAHk-=wjOXiEAjGLbn2mWRsxqpAYUPcwCj2x5WgEAh=gj+o0t4Q@mail.gmail.com>
        <CAHk-=wg1XpX=iAv=1HCUReMbEgeN5UogZ4_tbi+ehaHZG6d==g@mail.gmail.com>
        <3a1c02a5-db6d-e3e1-6ff5-69dd7cd61258@kernel.dk>
Date:   Thu, 25 Mar 2021 15:21:30 -0500
In-Reply-To: <3a1c02a5-db6d-e3e1-6ff5-69dd7cd61258@kernel.dk> (Jens Axboe's
        message of "Thu, 25 Mar 2021 13:46:46 -0600")
Message-ID: <m1zgyr2ddh.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lPWUw-00086p-Jg;;;mid=<m1zgyr2ddh.fsf@fess.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19McYpu4UMpmJM1/6UzapWqyVIobH1ipzY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 0/2] Don't show PF_IO_WORKER in /proc/<pid>/task/
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> On 3/25/21 1:42 PM, Linus Torvalds wrote:
>> On Thu, Mar 25, 2021 at 12:38 PM Linus Torvalds
>> <torvalds@linux-foundation.org> wrote:
>>>
>>> I don't know what the gdb logic is, but maybe there's some other
>>> option that makes gdb not react to them?
>> 
>> .. maybe we could have a different name for them under the task/
>> subdirectory, for example (not  just the pid)? Although that probably
>> messes up 'ps' too..
>
> Heh, I can try, but my guess is that it would mess up _something_, if
> not ps/top.

Hmm.

So looking quickly the flip side of the coin is gdb (and other
debuggers) needs a way to know these threads are special, so it can know
not to attach.

I suspect getting -EPERM (or possibly a different error code) when
attempting attach is the right was to know that a thread is not
available to be debugged.

Eric

