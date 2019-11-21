Return-Path: <SRS0=BBHt=ZN=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6496BC432C0
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 15:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3462C206F4
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 15:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="fOciagjD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfKUPLa (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 21 Nov 2019 10:11:30 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:44887 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfKUPL3 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 21 Nov 2019 10:11:29 -0500
Received: by mail-io1-f65.google.com with SMTP id j20so3749487ioo.11
        for <io-uring@vger.kernel.org>; Thu, 21 Nov 2019 07:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BWX1gm9BS5Z0IAOvbqHZldFmJQfHA4G9NsIL3JsYM2o=;
        b=fOciagjDCSPMcto5KwxHBPRZe79CqoTar3MRze4P/43dN+d0cJoIcMybGYRo9ZJKRH
         nohRaOUIFLuoL+xI1zObb+AQvSwSjWiFegJRgQeVolXNZVJmUYFUZUB6kH+Jho/Cy8kl
         JR3BnVKvM8I+yX0KnkErSBnoDGd9FHF49JgADCRLg2SNs+1e6d3uXiJSldYiTBUmfool
         0J/r9DzMDNU+HrEdopAlhbfBhuhrOq4EHF2e3pZyu7s+ugXaCLpj96utEvHIzuQ7uYbf
         h/wkJ38HK24Vnk4sAp2VoAM9Po6oAjIJ4ItXySDPC76rdwaC0Fs29XNUXE/w6w7L79U2
         MU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BWX1gm9BS5Z0IAOvbqHZldFmJQfHA4G9NsIL3JsYM2o=;
        b=onEXniMYrbDif87XC+WpIVjTTj25vGKiZLQcYPvLYc8KBuGU0pnKzPawSU9UMMrum3
         T6IQykh/a0IhRdxDLP4/vggn6QS8LXUQfTppz9Lwg7GrEPxWTJ7Wx+TGgW9fdY3VOe+w
         kaq3FEwfzbaNfU95KzqupJHK2gEvKSfvoMltc2q11Mt1Fo8/k5Q22/OX5RlGylRYoRKF
         e8eCnQ7Q5MlcUcPo4AkUBpveVkK8GvEN8ZH4FxZUBAS/IcJz6J7aSRHQtO1jLiuSzhIL
         y/H3DOPC5YSLvNrYtxgyHsOOstTOmdvSpXhp6azJlAKHb10GrA1haeejU55MGqxtnawL
         vVTQ==
X-Gm-Message-State: APjAAAXB4oMz7jk2sUeNqhI2dnJKVEu6/PKyQhj9xBr2I8UKOQ5J14ri
        wopcWYxnOf/RAQt26xgbfuwU7gNCIl3bCQ==
X-Google-Smtp-Source: APXvYqz7mdXJ1+TgakaFy1e1M39D5UVX/YIS4XBhx6wAwiCavoeoYcKxbwi6YE+rTtnDfWuntcaTeQ==
X-Received: by 2002:a05:6638:345:: with SMTP id x5mr9123141jap.137.1574349087996;
        Thu, 21 Nov 2019 07:11:27 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k199sm1283968ilk.20.2019.11.21.07.11.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 07:11:26 -0800 (PST)
Subject: Re: [PATCH] io_uring: drain next sqe instead of shadowing
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Jackie Liu <liuyun01@kylinos.cn>
Cc:     io-uring@vger.kernel.org
References: <2005c339-5ed3-6c2e-f011-5bc89dac3f5c@kernel.dk>
 <5e8a8176e29a61ec79004521bc2ef28e4d9715b1.1574325863.git.asml.silence@gmail.com>
 <A12FD0FF-3C4F-46BE-8ABB-AA732002A9CA@kylinos.cn>
 <bb367887-ed2c-1da3-59f5-c66f12ab7c5c@gmail.com>
 <5dd68282.1c69fb81.110a.43a7SMTPIN_ADDED_BROKEN@mx.google.com>
 <6da3585e-b419-ea9b-4246-1ee5ca14f5b9@gmail.com>
 <5dd68820.1c69fb81.64e0b.4340SMTPIN_ADDED_BROKEN@mx.google.com>
 <b129f1ba-b82c-d8cf-7dbd-efd14fd3fe8f@kernel.dk>
 <5dd69c43.1c69fb81.6589a.b4f1SMTPIN_ADDED_BROKEN@mx.google.com>
 <1feba72a-08f9-14c3-91c6-7efe4d5b1d8b@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <dc17c870-d7e0-44c5-e27b-d358d04a3ddf@kernel.dk>
Date:   Thu, 21 Nov 2019 06:53:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1feba72a-08f9-14c3-91c6-7efe4d5b1d8b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/21/19 7:28 AM, Pavel Begunkov wrote:
>>>
>>> Was that a reviewed-by from you? It'd be nice to get these more
>>> formally so I can add the attributes. I'll drop the other patch.
>>
>> I want to do more tests. There is no test machine at this time, at least
>> until tomorrow morning.
>>
> BTW, aside from the locking problem, that it fixes another one. If
> allocation for a shadow req is failed, io_submit_sqes() just continues
> without it ignoring draining.

Indeed. BTW, your commit message is way too weak for this patch. It
doesn't explain why we're making this change at all. I'm going to fix
it up.

-- 
Jens Axboe

