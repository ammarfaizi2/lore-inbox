Return-Path: <SRS0=d1ug=4F=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D06C34022
	for <io-uring@archiver.kernel.org>; Mon, 17 Feb 2020 15:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0DEE2465A
	for <io-uring@archiver.kernel.org>; Mon, 17 Feb 2020 15:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMm3Jgv0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbgBQPkt (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 17 Feb 2020 10:40:49 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41252 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728873AbgBQPkt (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 17 Feb 2020 10:40:49 -0500
Received: by mail-lj1-f195.google.com with SMTP id h23so19367651ljc.8;
        Mon, 17 Feb 2020 07:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=DmHRbSfYnROEk3VeGAYDLtIxVXsHmUQrnBynpnBcksc=;
        b=gMm3Jgv0dC1nadTdp4j/enGN1SkcWoOzaGpub+EEQyUCg9ILDMF+2VimeBAVXOK5wo
         HoVzuKVdTMqXXSLaE5GX09blQXNCQlQkVJRnWpSpFLs6urRoN0Xwd3qNwymLKcb7yTGX
         YczzHSoPJ9+OwCNOiN13KcaNdao0Wg3r7aZdOQcIU+ERtQxUBpRLpIXr8eUlB7hMrqFD
         tv5b42BPrbI+LdtcQSJV8IKf5zA1mHh3miS1kc4h+w+Kj3fIggmFVfUSz5/YUkNDpBIp
         tCs0rEQQ5yReTUHjL1Ps3vBlugs36d72R6hzkQv9stUg8Fb9M5Qq7PUlPAXmngs8KJ9H
         6tfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DmHRbSfYnROEk3VeGAYDLtIxVXsHmUQrnBynpnBcksc=;
        b=NaqjU42seA8WHm1nU/NAsRmlfEqOhb7JIt6zFyy2NwUee0MGAFad7P+a7gwJJ46HGn
         QVPSGamZ3JNRRALouXkyPznEydeV3D8fd7oX0GJ0Nn67SpFwySyNUwvK7Wo6/DsiO1wc
         vIoSz0EPfxzxw5T09m9oEcI//tkxPVdbpLuYfGm4tkyOGH77t1czJwxjVqUQGPhrfea1
         Ab/JVpsYUsHuPrMvnTwTBDSBzoT7DW1Nu7WWxrmKjy0gLLToUC4uJOdKlAq9Y1v1ZuAf
         UobCBEw2hCFuwYy9OL+Ik7DcInR1tvRMeGb4vt95j8gT5y5Me1rRQIO6qEhTnHrFdy8V
         0qtQ==
X-Gm-Message-State: APjAAAV49noq1XbHy3IJiDkKrN10/Zq4r8R+ScHomvY34EIF2uKz9Smn
        Lsuo5MXWzsZsv71f17rFNOnQVSqsTarGCA==
X-Google-Smtp-Source: APXvYqyoqdt/GCnJHizzHYjlCSWEoPWya636QQ/jufRGIJYvOViPfLzBy6t0vY0d9nK8E/SZ70qVkA==
X-Received: by 2002:a2e:b80e:: with SMTP id u14mr10622676ljo.17.1581954046569;
        Mon, 17 Feb 2020 07:40:46 -0800 (PST)
Received: from [172.31.190.83] ([86.57.146.226])
        by smtp.gmail.com with ESMTPSA id w3sm632876ljo.66.2020.02.17.07.40.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2020 07:40:46 -0800 (PST)
Subject: Re: [PATCH v2 3/3] io_uring: add splice(2) support
To:     Stefan Metzmacher <metze@samba.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1581802973.git.asml.silence@gmail.com>
 <b33d7315f266225237dfd10f483162c51c2ed5bc.1581802973.git.asml.silence@gmail.com>
 <6d803558-ab09-1850-2c38-38848b8ddf27@samba.org>
From:   Pavel Begunkov <asml.silence@gmail.com>
Message-ID: <b44a4692-f43c-e625-3eb7-cc4e12041f48@gmail.com>
Date:   Mon, 17 Feb 2020 18:40:44 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <6d803558-ab09-1850-2c38-38848b8ddf27@samba.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 2/17/2020 6:18 PM, Stefan Metzmacher wrote:
> Hi Pavel,
> 
>> +static int io_splice_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
>> +{
>> +	struct io_splice* sp = &req->splice;
>> +	unsigned int valid_flags = SPLICE_F_FD_IN_FIXED | SPLICE_F_ALL;
>> +	int ret;
>> +
>> +	if (req->flags & REQ_F_NEED_CLEANUP)
>> +		return 0;
>> +
>> +	sp->file_in = NULL;
>> +	sp->off_in = READ_ONCE(sqe->off_in);
>> +	sp->off_out = READ_ONCE(sqe->off);
>> +	sp->len = READ_ONCE(sqe->len);
>> +	sp->flags = READ_ONCE(sqe->splice_flags);
>> +
>> +	if (unlikely(READ_ONCE(sqe->ioprio) || (sp->flags & ~valid_flags)))
>> +		return -EINVAL;
> 
> Why is ioprio not supported?

Because there is no way to set it without changing much of splice code.
It may be added later

BTW, it seems, only opcodes cares about ioprio are read*/write*.
recv*() and send*() don't reject it, but never use.

-- 
Pavel Begunkov
