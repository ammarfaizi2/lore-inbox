Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59096C47094
	for <io-uring@archiver.kernel.org>; Thu, 10 Jun 2021 14:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39DA4610E6
	for <io-uring@archiver.kernel.org>; Thu, 10 Jun 2021 14:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhFJO3L (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 10 Jun 2021 10:29:11 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:60282 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbhFJO3K (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 10 Jun 2021 10:29:10 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lrLeK-005eYA-SA; Thu, 10 Jun 2021 08:27:12 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lrLeJ-002BZf-W0; Thu, 10 Jun 2021 08:27:12 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Olivier Langlois <olivier@trillion01.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        "Pavel Begunkov\>" <asml.silence@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>
References: <192c9697e379bf084636a8213108be6c3b948d0b.camel@trillion01.com>
        <9692dbb420eef43a9775f425cb8f6f33c9ba2db9.camel@trillion01.com>
        <87h7i694ij.fsf_-_@disp2133>
        <CAHk-=wjC7GmCHTkoz2_CkgSc_Cgy19qwSQgJGXz+v2f=KT3UOw@mail.gmail.com>
        <198e912402486f66214146d4eabad8cb3f010a8e.camel@trillion01.com>
        <87eeda7nqe.fsf@disp2133>
        <b8434a8987672ab16f9fb755c1fc4d51e0f4004a.camel@trillion01.com>
Date:   Thu, 10 Jun 2021 09:26:47 -0500
In-Reply-To: <b8434a8987672ab16f9fb755c1fc4d51e0f4004a.camel@trillion01.com>
        (Olivier Langlois's message of "Wed, 09 Jun 2021 17:26:30 -0400")
Message-ID: <87pmwt6biw.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lrLeJ-002BZf-W0;;;mid=<87pmwt6biw.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX199QinEjQu0zfzLvNcJi/BI0qDO2ZVou6s=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC] coredump: Do not interrupt dump for TIF_NOTIFY_SIGNAL
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Olivier Langlois <olivier@trillion01.com> writes:

> On Wed, 2021-06-09 at 16:05 -0500, Eric W. Biederman wrote:
>> > 
>> > So the TIF_NOTIFY_SIGNAL does get set WHILE the core dump is
>> > written.
>> 
>> Did you mean?
>> 
>> So the TIF_NOTIFY_SIGNAL does _not_ get set WHILE the core dump is
>> written.
>> 
>> 
> Absolutely not. I did really mean what I have said. Bear with me that,
> I am not qualifying myself as an expert kernel dev yet so feel free to
> correct me if I say some heresy...

No.  I was just asking to make certain I understood what you said.

I thought you said you were getting a consistent 0 byte coredump,
and that implied that TIF_NOTIFY_SIGNAL was coming in before
the coredump even started.

> io_uring is placing my task in my TCP socket wait queue because it
> wants to read data from it.
>
> The task returns to user space and core dump with a SEGV.
>
> now my understanding is that the code that is waking up tasks, it is
> the NIC driver interrupt handler which can occur while the core dump is
> written.
>
> does that make sense?
>
> my testing is telling me that this is exactly what happens...

If you are getting partial coredumps that completely makes sense.



I was hoping that by this time Jens or Oleg would have been able to
chime in and at least confirm I am not missing something subtle.

I was afraid for a little bit that the file system code in called in
dump_emit would be checking signal_pending.  After looking into that I
see that the filesystem code very reasonably limits itself to testing
fatal_signal_pending (because by definition disk I/O on unix is not
interruptible).

So I will spin up a good version of my patch (based on your patch)
so we can unbreak coredumps.

Eric

