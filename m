Return-Path: <SRS0=KKPr=ZF=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7AEC43331
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 13:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2254222459
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 13:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RUwftyKp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfKMNor (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 13 Nov 2019 08:44:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22815 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726186AbfKMNor (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 13 Nov 2019 08:44:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573652686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p80STNkBaHfIDiOKcj4mo45U1Ks8G7boFmFmsXxYP8g=;
        b=RUwftyKp/oFCBC6jyWbcOYVA6JT+qZrf8+SDdXWVii7r0hDLNlJG6GJit1b18It2RA8mHo
        2c6Df9Kh3b1r7PEPKlib6tZ3LIc3v8hY0v65uA6s+aLkPTblgRMWohwL/yKtxV5paODLZX
        Nt7dHBRKIrI/g8m0jajSMeWcuxinpKk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-T9XoclYcN8ybCiqAXeJRRw-1; Wed, 13 Nov 2019 08:44:45 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60B65800686;
        Wed, 13 Nov 2019 13:44:44 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BC776046C;
        Wed, 13 Nov 2019 13:44:43 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org
Subject: Re: [liburing patch][v2] test: fix up dead code bugs
References: <x49eeycirmq.fsf@segfault.boston.devel.redhat.com>
        <x495zjoiquu.fsf@segfault.boston.devel.redhat.com>
        <66a766ab-e4c3-c268-9962-4376b29af69c@kernel.dk>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Wed, 13 Nov 2019 08:44:42 -0500
In-Reply-To: <66a766ab-e4c3-c268-9962-4376b29af69c@kernel.dk> (Jens Axboe's
        message of "Tue, 12 Nov 2019 17:14:21 -0700")
Message-ID: <x49a78z28mt.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: T9XoclYcN8ybCiqAXeJRRw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> On 11/12/19 4:04 PM, Jeff Moyer wrote:
>> Coverity pointed out some dead code.  Fix it.
>>=20
>> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
>>=20
>> ---
>> v2: Don't re-introduce dead-code! (Jens Axboe)
>
> That looks better - thanks, applied. BTW, totally gave away that you
> didn't run the tests after writing the patch, that's a black mark.

Yeah, sorry.  I usually am more disciplined.  I'll do better.

-Jeff

