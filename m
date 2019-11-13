Return-Path: <SRS0=KKPr=ZF=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA838C43331
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 00:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 967CC2084E
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 00:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xw+K0G3R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfKMAAz (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 12 Nov 2019 19:00:55 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26018 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726970AbfKMAAz (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 12 Nov 2019 19:00:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573603254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xUMRZGjCEqqWS8w9hD4/rx/uRyIte3s0dn5vQgd7tV8=;
        b=Xw+K0G3R1QgYu3D9fbuenRK3UKXdHt2r2Yc/jPjr3yqByZW07mKwIKV4q7pnoyqgwC1cGD
        M9FxLzRcLUg91pbfIMZ9HfK8JoLs7u4A9PtqL9RWXjY3958NNwp4tdJ6v78k3ty7t1QnOz
        I90zfCxSIgmdbTurlbL0S99UcdAzWYU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-JGCaARfmMPafTjTZm8gfkg-1; Tue, 12 Nov 2019 19:00:53 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68052800EB3;
        Wed, 13 Nov 2019 00:00:52 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EC81460251;
        Wed, 13 Nov 2019 00:00:51 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org
Subject: Re: [liburing patch] test: fix up dead code bugs
References: <x49eeycirmq.fsf@segfault.boston.devel.redhat.com>
        <e5b2d365-cb99-7a40-f8fe-dd8b301c741b@kernel.dk>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Tue, 12 Nov 2019 19:00:50 -0500
In-Reply-To: <e5b2d365-cb99-7a40-f8fe-dd8b301c741b@kernel.dk> (Jens Axboe's
        message of "Tue, 12 Nov 2019 16:59:42 -0700")
Message-ID: <x49a790ir0t.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: JGCaARfmMPafTjTZm8gfkg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> On 11/12/19 3:47 PM, Jeff Moyer wrote:
>> Coverity pointed out some dead code.  Fix it.
>>=20
>> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
>>=20
>> diff --git a/test/fsync.c b/test/fsync.c
>> index e6e0898..3c67190 100644
>> --- a/test/fsync.c
>> +++ b/test/fsync.c
>> @@ -96,14 +96,14 @@ static int test_barrier_fsync(struct io_uring *ring)
>>   =09io_uring_sqe_set_flags(sqe, IOSQE_IO_DRAIN);
>>  =20
>>   =09ret =3D io_uring_submit(ring);
>> -=09if (ret < 5) {
>> -=09=09printf("Submitted only %d\n", ret);
>> -=09=09goto err;
>> -=09} else if (ret < 0) {
>> +=09if (ret < 0) {
>>   =09=09printf("sqe submit failed\n");
>>   =09=09if (ret =3D=3D EINVAL)
>>   =09=09=09printf("kernel may not support barrier fsync yet\n");
>>   =09=09goto err;
>> +=09} else if (ret < 0) {
>> +=09=09printf("Submitted only %d\n", ret);
>> +=09=09goto err;
>>   =09}
>
> Looks like you're adding new dead code :-)

Oops!  I'll fix that up.

-Jeff

