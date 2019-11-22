Return-Path: <SRS0=nrYQ=ZO=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B41C43215
	for <io-uring@archiver.kernel.org>; Fri, 22 Nov 2019 11:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18CF82070E
	for <io-uring@archiver.kernel.org>; Fri, 22 Nov 2019 11:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLqvOYBk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbfKVKzD (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:55:03 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37658 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbfKVKzB (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 22 Nov 2019 05:55:01 -0500
Received: by mail-lj1-f194.google.com with SMTP id d5so6864711ljl.4
        for <io-uring@vger.kernel.org>; Fri, 22 Nov 2019 02:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=498IUNcuLTL8lMzACi1Zq8l11fatfpA2Ns4YmTx7eJU=;
        b=hLqvOYBk43USuC3WaKfkD3GaRZfKlIIpK1LySyLvygVTN3eDhjASmIEoVuInkMd2zG
         drvSSxJlbJ4pF0EEc3BxGSi5wSXpFTMCQpjuZc5nY3jTTLbCyHig1lwMI1jRQseNdEcN
         swOQlWBzQBk6lxymP+xyuzNpbVWYcGPjxghQow9TGZzMr8sHTpHyYGZxF3p8uL7Iofu5
         4n5IDwZBKX0Yxa2Ym9gS2VL+OPsIr3agHkP7q9+kSDe7NIFWJsNzqAhMVq0pbvBtKyBq
         8XuOf3wfnnX7Rhb2nrKyipS2y+gFmRPOpGp4Ji8Pqg1pTP95yl7aIpWZpXrQvqurfq0S
         r6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=498IUNcuLTL8lMzACi1Zq8l11fatfpA2Ns4YmTx7eJU=;
        b=YzZJYCbH+TGxzwnUAqiy5BerxHeQUCKNdbF8F1QGowxsE1DzAOxri4Zq5qHzdvUalw
         j/qpryXnSBnQFXEfJV2HivJtY3Wu7QHUjRKwQKy7KBKI5pjY69uEPSBwlj3gYy3pkYoy
         4gLWxYkbm/tp9Wo7A9kCwUI3jRnZvEAdz3otUFUxVFBXwe+QNAlDuVK9uCis9Jgsw2zG
         3D74fnM1+40ygWGqXpxDtlIsVPHBkZr/z1UnEvYgJiLV+gosicC+5jvJngfoXpBwD+Vp
         hKWiPLg9bDJq9DA1kGltvYNDcbWn4oaDXwP1Vix6d0Kj1Bq9AuyviGFhWCRMz3M/4thA
         Ql/g==
X-Gm-Message-State: APjAAAVOL4/ktbJuDX3jonhZc6t4do6mtzOGf/gKi5MjyWwGJjF7txnf
        QnqFYPWjZbnU5TphMb3riekjwvA7xSo=
X-Google-Smtp-Source: APXvYqzP7K1Kn2rg54NirqhjNZZsGOV9tOx3gny9a1QEaTpAE7l3wC2MNT6L/0IQE7ubwZW12YKvFA==
X-Received: by 2002:a2e:b537:: with SMTP id z23mr11777137ljm.129.1574420098097;
        Fri, 22 Nov 2019 02:54:58 -0800 (PST)
Received: from [172.31.190.83] ([86.57.146.226])
        by smtp.gmail.com with ESMTPSA id d5sm2654567ljc.51.2019.11.22.02.54.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Nov 2019 02:54:57 -0800 (PST)
Subject: Re: [PATCH RESEND] io_uring: a small optimization for
 REQ_F_DRAIN_LINK
To:     JackieLiu <jackieliu@byteisland.com>
Cc:     axboe@kernel.dk, io-uring@vger.kernel.org
References: <20191122060129.40251-1-jackieliu@byteisland.com>
 <20191122060129.40251-2-jackieliu@byteisland.com>
 <4132c196-afd5-4ac8-0842-2746cc9e4a6f@gmail.com>
 <01E7FC11-C19D-40FE-A471-5E1FAD2ED3D8@byteisland.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Message-ID: <e1f680d8-47bc-b921-e8ed-47c3960dec52@gmail.com>
Date:   Fri, 22 Nov 2019 13:54:55 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <01E7FC11-C19D-40FE-A471-5E1FAD2ED3D8@byteisland.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/22/2019 1:26 PM, JackieLiu wrote:
>> Not sure about that. It's 1 CMP + 1 SETcc/STORE, which works pretty fast
>> as @drain_next is hot (especially after read) and there is no write-read
>> dependency close. For yours, there is likely always 3 CMPs in the way.
>>
>> Did you benchmarked it somehow or compared assembly?
> 
> It is only theoretically possible. In most cases, our drain_link 
> and drain_next are both false, so only two CMPs are needed, and modern CPUs
> have branch predictions. Perhaps these judgments can be optimized.
> 
My bad, right, 2 CMPs in the common way.

> Your code is very nice, when I reading and understanding your code,
> I want to try if there is any other way to optimize it. 
> 
> Sometimes you don't need to reset drain_next, such as drain_link == true && 
> drain_next == true, you don't need to set below one more time.

We may think to change like below, but I'd rather rely on a compiler to
optimise it for us (i.e. knowing the target architecture). Everything
else is a really rare/slow path in my opinion, so shouldn't be of concern.

-	req->ctx->drain_next = (req->flags & REQ_F_DRAIN_LINK);
+	if (req->flags & REQ_F_DRAIN_LINK)
+		req->ctx->drain_next = true;

If the goal is to micro-optimise things, it's better to think how to
toss the whole scheme to reduce number of CMPs and memory read/writes in
the hot path, including setting REQ_F_DRAIN_LINK in submit_sqe().

Though, there are still heavier things happening around.

-- 
Pavel Begunkov
