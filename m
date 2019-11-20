Return-Path: <SRS0=jdTg=ZM=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F9EC432C0
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 15:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9158120731
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 15:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pWiYtmic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbfKTPCR (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 20 Nov 2019 10:02:17 -0500
Received: from mail-lj1-f173.google.com ([209.85.208.173]:38050 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728096AbfKTPCR (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 20 Nov 2019 10:02:17 -0500
Received: by mail-lj1-f173.google.com with SMTP id v8so27884348ljh.5
        for <io-uring@vger.kernel.org>; Wed, 20 Nov 2019 07:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=+57EaYV4OU/9QXkZiL9URs9DHdjz95iEt0HRomoIOF0=;
        b=pWiYtmicf9Fn69QKozEZNqIw9vQzo5x0572FuTIGbXCAKsSt2iH+2zvM1oZJR6WYIw
         PfycExG5NZzCsLxrtvjtVhZhGwu5vQQ6ySQq1aQWuOUfywTv3EX1RZ2DtAiTqaoTe4xL
         NQwxFMugt1zSUtk4a1uGFrnlNb0s3+E/n21cYhFdmdvlQ5lDzflBRhfvf+J0i5i4I27z
         gfuIUiNn9msp1pXSmE/nhhC1gX8oZJYiLzutlZjgVXPANYByJxAgIlcbZ9hxrFO1bs0/
         IscU8Yr409vY2L8JFLJbhEq1VMZUYM1/m8+cK0QrHEB2t3CG7piL/w4L2gHQFVi+yG2S
         KmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+57EaYV4OU/9QXkZiL9URs9DHdjz95iEt0HRomoIOF0=;
        b=R9dJBHEQNGcxLHyLePb0ABIPIYP7Yl63N52PzrJDC2CKx0tiWBLNO+dGRllEGjarrl
         vj8rND8dfm+yVGgwZtWvq4iQX9SzwH6oHZ5dhh6IKhLeRQxy1qkbYiUaXR1Hzv2niFiT
         C/dm2JXamagZycmW9RN9bvBGhOIQQ26kRg7A1ctm5+Rtccqh9M16irfUniqYVjKYl4co
         yLW8oymUxDkuQT/XYPgbcrhzXFfzvn+yLsYdjPlL70SvcTAAp9vrL5xwCWsx6X0In+oL
         YlO2HB7qBeR9LZ9HUtCZ9Ad70Eg/+8PSP5Uk1VFgVylspfD0p02Q1Sh61QcYklsz0jJf
         3XSA==
X-Gm-Message-State: APjAAAVVZS5sAbkUNZbLacxZML4gqIQAeC8OuuB53RDxdlg3y1CJa1Yy
        5Iq638QQdF0A5W9xjBc4Sw1OpD/5
X-Google-Smtp-Source: APXvYqycX5d5DoVwEicCkWMMuTUlIdSwItPnT8rlT5Yvwo6jlLSmWCUKxqN9bZrEugXUa1FND6+1Vw==
X-Received: by 2002:a2e:95c5:: with SMTP id y5mr3207406ljh.184.1574262134554;
        Wed, 20 Nov 2019 07:02:14 -0800 (PST)
Received: from [172.31.190.83] ([86.57.146.226])
        by smtp.gmail.com with ESMTPSA id r12sm984612lfc.28.2019.11.20.07.02.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 07:02:13 -0800 (PST)
Subject: Re: io_uring: io_fail_links() should only consider first linked
 timeout
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
References: <efca87b0-3b8a-9614-c4c7-a341a2882b58@kernel.dk>
 <b8b1c8cf-5120-c4b2-e74b-4d0545b7a1f8@gmail.com>
 <f61f129e-8709-1b40-86eb-42cb672fe74f@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Message-ID: <4f4d9d3f-64cf-dd02-4e7f-364a9c04012b@gmail.com>
Date:   Wed, 20 Nov 2019 18:02:12 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <f61f129e-8709-1b40-86eb-42cb672fe74f@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/20/2019 5:22 PM, Jens Axboe wrote:
>> However, this is only true if linked timeout isn't fired. Otherwise,
>> there is another bug, which isn't fixed by either of the patches. We
>> need to clear REQ_F_LINK_TIMEOUT in io_link_timeout_fn() as well.
>>
>> Let: REQ -> L_TIMEOUT1 -> L_TIMEOUT2
>> 1. L_TIMEOUT1 fired before REQ is completed
>>
>> 2. io_link_timeout_fn() removes L_TIMEOUT1 from the list:
>> REQ|REQ_F_LINK_TIMEOUT -> L_TIMEOUT2
>>
>> 3. free_req(REQ) then call io_link_cancel_timeout(L_TIMEOUT2)
>> leaking it (as described in my patch).
>>
>> P.S. haven't tried to test nor reproduce it yet.
> 
> That's exactly the case I was worried about. In any case, it seems
> prudent to handle it defensively.
> 
Yeah, I've got from the patch that may have missed something.

Will you add this "should clear REQ_F_LINK_TIMEOUT in
io_link_timeout_fn()" (e.g. in v2), or should I?

-- 
Pavel Begunkov
