Return-Path: <SRS0=jnAq=ZB=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5623FC43331
	for <io-uring@archiver.kernel.org>; Sat,  9 Nov 2019 14:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EF1B20869
	for <io-uring@archiver.kernel.org>; Sat,  9 Nov 2019 14:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="XTa/sdpV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfKIOXu (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 9 Nov 2019 09:23:50 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46670 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfKIOXu (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 9 Nov 2019 09:23:50 -0500
Received: by mail-pl1-f194.google.com with SMTP id l4so5565120plt.13
        for <io-uring@vger.kernel.org>; Sat, 09 Nov 2019 06:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=4fmby/QYRW0yMpQtBKFcxsErehCBHHpCyuKoLFHGHXQ=;
        b=XTa/sdpVT4lewu+rD7gSlha13mQL4Pj20H3bkpFSAsLQvh/zRkJ8wjYxTwsr5psIPN
         PVwyf8nEg3SH7UD27NJoPGKKaaO3N7JsPEhp/KdlfHAA7DDL0q9K0jhNZT7cGImkdVgK
         7b5MVocXcMPBkIIM9cOdXuO0pK4Lc2TLvww2UcpjNinWaPgelZYlallOBTOBab+GkCSD
         W5HYy94UvN8M3kM8hM95IIm7ITbSYiGGqSqibkSh3L5HXvFn//VlbLAoCXqQ1SblOz9W
         qlVf8lmK2cJRxZfsIfSisnZJZsE1ihUnfzw0hmEJyClWxfVrjlKvEsJey2I0Nsfvr6sM
         zPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4fmby/QYRW0yMpQtBKFcxsErehCBHHpCyuKoLFHGHXQ=;
        b=IKUD6F6W4b7TX4umCoPgzaaxkJCSGrUh26kkfrOseaWtWAFKC+QcUk/OPe8Tejns42
         qiQYty0xBQAsmnYq1ErIyS8kih/KwNNv/N/ZdKblENMTnNTPSt5n2iqePrk/VhHyMbhB
         nhgSX1nnHL77Z4kEyl4Z1fFS7cCZOOYyR00eBvgcV53mPiijx4ymJW1jZWCmNxFgrG2f
         Gy78uoJ9MTOSxXO7k16/H1gbqO7Ln9e1JgRgWskxjcfPOS6w/QFrBcBXvI6nGD74IHei
         0ptqe94JGtyBzjrA9rZE8V7g9itA354NN+kNGCLhl/Qt3WA4aIfUhkE2pQBr+ODSfs8l
         Djbw==
X-Gm-Message-State: APjAAAWLl65sA9o7fPcLvSSvbPjjJbdkVRLr8ACChqjhfvV7kqaYk+5A
        hcy1P5gucj7Ax0KJnGDy7XJLVb0zhHk=
X-Google-Smtp-Source: APXvYqxP8P9nEp/1OrBhOxnKLAzlJukmrNdyJppy0E0hQHZYg5ll11f7r19jl5uI/jNPlAr+s4/IgA==
X-Received: by 2002:a17:902:6ac6:: with SMTP id i6mr16215763plt.183.1573309427854;
        Sat, 09 Nov 2019 06:23:47 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id o15sm13586898pgn.49.2019.11.09.06.23.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Nov 2019 06:23:47 -0800 (PST)
Subject: Re: [PATCH RFC] io_uring: limit inflight IO
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
References: <e7f01b7b-5915-606f-b5b4-0d59f8e096b6@kernel.dk>
 <33958a03-6714-ce51-9856-1dcbf53f67d5@kernel.dk>
 <273391a6-1def-3c29-986c-8efca569fc16@gmail.com>
 <cc6b368b-10e3-504c-4895-feefe6311004@kernel.dk>
 <bdfdad32-91b7-7721-ccdf-0dd399e7e051@kernel.dk>
 <69985522-3e8e-102b-c8e9-ea9046cd22c6@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d8002007-7641-3e9d-0560-123358300e66@kernel.dk>
Date:   Sat, 9 Nov 2019 07:23:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <69985522-3e8e-102b-c8e9-ea9046cd22c6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/9/19 4:16 AM, Pavel Begunkov wrote:
>> I've been struggling a bit with how to make this reliable, and I'm not
>> so sure there's a way to do that. Let's say an application sets up a
>> ring with 8 sq entries, which would then default to 16 cq entries. With
>> this patch, we'd allow 16 ios inflight. But what if the application does
>>
>> for (i = 0; i < 32; i++) {
>> 	sqe = get_sqe();
>> 	prep_sqe();
>> 	submit_sqe();
>> }
>>
>> And then directly proceeds to:
>>
>> do {
>> 	get_completions();
>> } while (has_completions);
>>
>> As long as fewer than 16 requests complete before we start reaping,
>> we don't lose any events. Hence there's a risk of breaking existing
>> setups with this, even though I don't think that's a high risk.
>>
> 
> I think, this should be considered as an erroneous usage of the API.
> It's better to fail ASAP than to be surprised in a production
> system, because of non-deterministic nature of such code. Even worse
> with trying to debug such stuff.
> 
> As for me, cases like below are too far-fetched
> 
> for (i = 0; i < n; i++)
> 	submit_read_sqe()
> for (i = 0; i < n; i++) {
> 	device_allow_next_read()
> 	get_single_cqe()
> }

I can't really disagree with that, it's a use case that's bound to fail
every now and then...

But if we agree that's the case, then we should be able to just limit
based on the cq ring size in question.

Do we make it different fro CQ_NODROP and !CQ_NODROP or not? Because the
above case would work with CQ_NODROP, reliably. At least CQ_NODROP is
new so we get to set the rules for that one, they just have to make
sense.

-- 
Jens Axboe

