Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC0FC433B4
	for <io-uring@archiver.kernel.org>; Wed, 31 Mar 2021 16:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21A8F6100C
	for <io-uring@archiver.kernel.org>; Wed, 31 Mar 2021 16:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbhCaQ2g (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 31 Mar 2021 12:28:36 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:45098 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbhCaQ2M (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 31 Mar 2021 12:28:12 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lRdhS-00HJ5m-1Q; Wed, 31 Mar 2021 10:28:10 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lRdhP-005qdR-K5; Wed, 31 Mar 2021 10:28:08 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Dmitry Kadashev <dkadashev@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        io-uring <io-uring@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
References: <20201116044529.1028783-1-dkadashev@gmail.com>
        <20201116044529.1028783-2-dkadashev@gmail.com>
        <027e8488-2654-12cd-d525-37f249954b4d@kernel.dk>
        <20210126225504.GM740243@zeniv-ca>
        <CAOKbgA4fTyiU4Xi7zqELT+WeU79S07JF4krhNv3Nq_DS61xa-A@mail.gmail.com>
        <20210201150042.GQ740243@zeniv-ca> <20210201152947.GR740243@zeniv-ca>
Date:   Wed, 31 Mar 2021 11:28:04 -0500
In-Reply-To: <20210201152947.GR740243@zeniv-ca> (Al Viro's message of "Mon, 1
        Feb 2021 15:29:47 +0000")
Message-ID: <m1ft0bqodn.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lRdhP-005qdR-K5;;;mid=<m1ft0bqodn.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18axJtBcCUniFz8RzQG8ulDljcYSflJCpE=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 1/2] fs: make do_mkdirat() take struct filename
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Mon, Feb 01, 2021 at 03:00:42PM +0000, Al Viro wrote:
>
>> The last one is the easiest to answer - we want to keep the imported strings
>> around for audit.  It's not so much a proper refcounting as it is "we might
>> want freeing delayed" implemented as refcount.
>
> BTW, regarding io_uring + audit interactions - just how is that supposed to
> work if you offload any work that might lead to audit records (on permission
> checks, etc.) to helper threads?

For people looking into these details.  Things have gotten much better
recently.

The big change is that io_uring helper threads are now proper
threads of the process that is using io_uring.  The io_uring helper
threads just happen to never execute any userspace code.

Eric


