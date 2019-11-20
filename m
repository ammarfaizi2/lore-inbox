Return-Path: <SRS0=jdTg=ZM=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5A7C432C3
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 14:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 531D32070B
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 14:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPiijuZC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbfKTO2P (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 20 Nov 2019 09:28:15 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40649 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730467AbfKTO2O (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 20 Nov 2019 09:28:14 -0500
Received: by mail-lf1-f65.google.com with SMTP id v24so9442326lfi.7
        for <io-uring@vger.kernel.org>; Wed, 20 Nov 2019 06:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=dAhUAAY6PT2OHVmf33rrczMxlghQNhws1yiBLPdexgs=;
        b=iPiijuZC6LN7zW+WoHCG9if5JmVnM30Cmi8BOzjXVFGCkqZBO+gdk1pl1aDtcvlVey
         5SKhZoDfM6wTLHIND4Jlb9F/ClXXDatqjbSNBp+ZZvxDTxeQwfaJOSYDlihDRJgjhQNQ
         ldC5z6G9hHVL0KvsJVG2NUh6di318XUH+pMeRwQLHvmuQyNnSVr5OcG9LinyGcw6X/bS
         1j3e8JplgPUndaSPmPIHB3thBh1iM9oQYILCsyYoKC0j1XITw6SBCbcNvej6jCiz0Bbv
         tQgXUI8JX87jCMukcBoxdhR7tTuBmyJE8t4Bl+ljQCQEuPSpzYMYAAgiBaNsQbuL+Hjo
         09GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dAhUAAY6PT2OHVmf33rrczMxlghQNhws1yiBLPdexgs=;
        b=RLGUqyb/MO/00CVsmwVn1AhaMJ4fx6WG3+8jpoLY7zBlTxxvjklqEFq9YdAHnetwho
         ahEp6vK4gSi7IsIsTNAebs4jaNI0PH40LAgzOYLsvGqMoGH0ZuToGKUfc3Jt6Eorg58T
         yGsQ86gLY7FvSA50HWrxVC/8noWwp742uDa7xX+QGecG2IQVgh/e6bkBx/fRBIk2G1zq
         5PRgdmMJMbKUfK+c1n2REVFaHOlPtok5XMR5GTx9qzn2QxHdbJwK9PMhhIviiaojxSIv
         T2hjx3ankD9rJcLNOU54p1XARa2mEk4wy/cALcUs42AtJ6iHLDGDniqt750Iwzjd3QgH
         /Krw==
X-Gm-Message-State: APjAAAW1qqPYrmh66zDDh2HOH1hEcQ+FIdbovlXXPv5ssrW3nxSgybnD
        7fEz10IDRjpLbkOGqDoTHUp96vFD
X-Google-Smtp-Source: APXvYqz/HcgZtBd9FMp05kaHRC1US6aEyGy6KJdmWajxjoSOtcwCwkZW52E9CNLDCgWd6ZZLrU5Qkg==
X-Received: by 2002:a19:4318:: with SMTP id q24mr3124278lfa.12.1574260092544;
        Wed, 20 Nov 2019 06:28:12 -0800 (PST)
Received: from [172.31.190.83] ([86.57.146.226])
        by smtp.gmail.com with ESMTPSA id k9sm13070697lfj.97.2019.11.20.06.28.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 06:28:11 -0800 (PST)
Subject: Re: io_uring: io_fail_links() should only consider first linked
 timeout
To:     Bob Liu <bob.liu@oracle.com>, Jens Axboe <axboe@kernel.dk>,
        io-uring@vger.kernel.org
References: <efca87b0-3b8a-9614-c4c7-a341a2882b58@kernel.dk>
 <b8b1c8cf-5120-c4b2-e74b-4d0545b7a1f8@gmail.com>
 <9f43d496-5864-19ab-2084-75a097c96a61@oracle.com>
 <6b39513b-0dec-f56f-992e-7c950cda803f@gmail.com>
 <11ab7750-6009-1228-af70-bc6b4604b245@oracle.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Message-ID: <2df3dc51-5707-efad-63a4-87c7e0931b36@gmail.com>
Date:   Wed, 20 Nov 2019 17:28:10 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <11ab7750-6009-1228-af70-bc6b4604b245@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/20/2019 5:03 PM, Bob Liu wrote:
> I see, thanks.
> As for me, it may better return -EINVAL in advance so as to skip a lot unnecessary code for those reqs.
> 
Hah, I removed similar check just yesterday (see [PATCH 3/4] "io_uring:
remove redundant check"). We don't care about performance of invalid
requests, and this one in hot-path. The fewer edge cases, the better.

Also, for the example below, I'd want to fail INVALID_REQ and cancel
valid ones, but not exit after processing invalid, or even worse
processing the rest without it.

INVALID_REQ -> VALID_REQ -> VALID_REQ.

> @@ -3176,6 +3176,7 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
> 
>                 if (!io_get_sqring(ctx, &req->submit)) {
> 		}
> ...
> +               if (unlikely(req_is_invalid(req)))
> +                       return -EINVAL;
> 

-- 
Pavel Begunkov
