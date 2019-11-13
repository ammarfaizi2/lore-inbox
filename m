Return-Path: <SRS0=KKPr=ZF=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7BCC432C3
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 21:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 961F9206E5
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 21:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="cbzzI4Pl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfKMVjQ (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:39:16 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:41211 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfKMVjQ (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 13 Nov 2019 16:39:16 -0500
Received: by mail-io1-f67.google.com with SMTP id r144so4289108iod.8
        for <io-uring@vger.kernel.org>; Wed, 13 Nov 2019 13:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=7psMZQWzaPG6Uwlutlz0olkrXDW5GI2EDX4+sbzEKdk=;
        b=cbzzI4Pl6WhP+DBBmeR21yo31NfqeCxndPsBsyl9ddy0juVfc5vCObOMMSTPWZt/Wb
         9c6M5TmMfXZfoyJTVZaF4A1zEDCnWhPpbtBECWZBooBB8ETElJi7BYPLdLJNtvdrzRgc
         YSlAD94Gz5Ou+28xleeYtmn2TiOjOC7wMoh3WDagwWAVhpNMk0SlJh4YLCXiDMNo4Wpb
         Zn9ZO7shaDBSsfij8NACD1+qs8eJxl07k0JU1fMztz1xWPgQv8J63WaQmPtShSqdvRlF
         afpAxp4H1s9UjJq7wWie1717jxEdckTF1asYLdXy0zMOdjsWhj/8D8qevbL/RM4HS/pM
         RWow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7psMZQWzaPG6Uwlutlz0olkrXDW5GI2EDX4+sbzEKdk=;
        b=kvppDqnyzomU7aQp5ixZVYy++QGY1u88EHbl6d/mRDcbJaOfS8dCQr4ldO2MaDALPO
         0RJeQVy+3QJpmKNqiWRU+KHT2bgJZggmcZctLNb1cx6RY3NFi5UqWXPG8cpLybVK++Cl
         rI3cmK8/uUVqUEmitUqe/iARej7LUAmKIhFLr1LRC50aZJ2eiuXmI/j5XH1HC0DlnjQH
         tx2SpYIoy4HMp3wMkd+H/fAlzfyBYNlsrwgJUjVhMKZibZJ8EkC23LioXNDe2ewJg0SB
         M0gGig9/82IB3d3LBdhqgsp6EYdHpcvw08PJNaQzj4kfmX72nExELv5tMnTT1/NN8CIc
         pUYw==
X-Gm-Message-State: APjAAAUknDIlB52fHdmiCYo5fGAN/PNTkaMX078qqqsW51kuc/I/D4Uh
        9rMUczD1bDTmUVszM3ZpfCadL1p3IV4=
X-Google-Smtp-Source: APXvYqweuoushbC5k5Ot2f9vHjb6LXv84JWg/0Of4tMwP3tVuNl840Ka1gYr54evREa24PSaMRy4Wg==
X-Received: by 2002:a02:a08:: with SMTP id 8mr4920938jaw.98.1573681153711;
        Wed, 13 Nov 2019 13:39:13 -0800 (PST)
Received: from [192.168.1.163] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l10sm459210ilm.67.2019.11.13.13.39.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 13:39:12 -0800 (PST)
Subject: Re: [liburing PATCH] io_uring: invalid fd for file-less operations
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
References: <b74f30f890ef054cff370f3f8fae68fd264e1c5e.1573680315.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bf481227-61c7-a76a-0f64-4101cc182f49@kernel.dk>
Date:   Wed, 13 Nov 2019 14:39:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <b74f30f890ef054cff370f3f8fae68fd264e1c5e.1573680315.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/13/19 2:27 PM, Pavel Begunkov wrote:
> If an operation doesn't need a file, set fd to an invalid value.
> This would help to spot an unwanted fdget() in the kernel, and is
> conceptually more correct (though negotiable)

I don't think that negotiable, if we don't need a valid fd, we should
just set it to -1. I've applied this patch, thanks.

-- 
Jens Axboe

