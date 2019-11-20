Return-Path: <SRS0=jdTg=ZM=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF48C432C3
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 15:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D25820898
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 15:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="YU6wrYpw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbfKTPGH (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 20 Nov 2019 10:06:07 -0500
Received: from mail-io1-f41.google.com ([209.85.166.41]:42941 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728030AbfKTPGG (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 20 Nov 2019 10:06:06 -0500
Received: by mail-io1-f41.google.com with SMTP id k13so27960320ioa.9
        for <io-uring@vger.kernel.org>; Wed, 20 Nov 2019 07:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=V3iSOP953fNY84UUktwa9/QyS6n2Hp0ZtQbh7qMbkRI=;
        b=YU6wrYpwjw30ume9fuWdjIq2zP+SMKrBtmVjh272PrWepaeibhlNHlwRdIl3TOu3NN
         ynnzwG7z6YwZPS9XjNoBN4yB1nUmACjIFgXibj+ZtELrOxfuhMcWPoMrvjIiB7v2pFeu
         FOZbizFa3TVVJDuZYDNSefeGcqT8eAC6z15FNcx1mM++Ba67f52csSpAXxZ+Sz/AygUH
         mPQEd7nfQyFEf6WtjZJ/gnem4Tf+VMV5uOm9KJwAUyjiVEt2u+xInQ/xiClCJeaTCh5K
         0JlmE6G2N0CGLd3uwdlKlG+/ca3wsedjCFUgaKY/aJbGcKyWm296zBXavgLcNfD155Jk
         oJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V3iSOP953fNY84UUktwa9/QyS6n2Hp0ZtQbh7qMbkRI=;
        b=CDUu9SurX+vGGqMfrjyW0yBt2h39qFReQ+Cv+o0v/DVXWwZHBhenpvH4ngH8yYWohG
         DimVZEJ28KF8dkHEY2dxxmnOSLCy6XBBQIBombaUaVB6enK46Ir+iG4JjjIxdembVtcY
         GEgx0oKOE2ytbPUs2aX+vBKMgkO5inoUIsh9xmTXA+WP6I1l4BU0D/uQ1/kSmAZMAWw2
         ZJRJwzb+Mxv7zwxuvM3blJ5SJv2Xy855fxjw2R1nG+jmBrESTG5KLOptLWf/A74kXJuE
         4nbcLvJ3j8OXzrMj2s+8PtlfD7bg5OoXrqyuya6gDeut9qYKaPZI9U+Icn1ob5Ea7QS/
         cUSw==
X-Gm-Message-State: APjAAAUIFJRN4XHD5etpcfzkI2K8v1tgbjUKeWP6ow7YsUACTPewPUlO
        OLSbtzeT3CMuEQwOBvJMizKpDP5jP3C36w==
X-Google-Smtp-Source: APXvYqzibBZ+Yi8KbGJ3XSRkomBDaRm+s2C18w5QYS3RTdEe2Y8aEDrp5+WtSa3NKLfk/bzkIBT4dg==
X-Received: by 2002:a6b:7115:: with SMTP id q21mr2708446iog.167.1574262364802;
        Wed, 20 Nov 2019 07:06:04 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s5sm5116212iol.66.2019.11.20.07.06.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 07:06:03 -0800 (PST)
Subject: Re: io_uring: io_fail_links() should only consider first linked
 timeout
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
References: <efca87b0-3b8a-9614-c4c7-a341a2882b58@kernel.dk>
 <b8b1c8cf-5120-c4b2-e74b-4d0545b7a1f8@gmail.com>
 <f61f129e-8709-1b40-86eb-42cb672fe74f@kernel.dk>
 <4f4d9d3f-64cf-dd02-4e7f-364a9c04012b@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d98bf752-8ba6-9f84-42fb-b4c309b46987@kernel.dk>
Date:   Wed, 20 Nov 2019 08:06:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <4f4d9d3f-64cf-dd02-4e7f-364a9c04012b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/20/19 8:02 AM, Pavel Begunkov wrote:
> On 11/20/2019 5:22 PM, Jens Axboe wrote:
>>> However, this is only true if linked timeout isn't fired. Otherwise,
>>> there is another bug, which isn't fixed by either of the patches. We
>>> need to clear REQ_F_LINK_TIMEOUT in io_link_timeout_fn() as well.
>>>
>>> Let: REQ -> L_TIMEOUT1 -> L_TIMEOUT2
>>> 1. L_TIMEOUT1 fired before REQ is completed
>>>
>>> 2. io_link_timeout_fn() removes L_TIMEOUT1 from the list:
>>> REQ|REQ_F_LINK_TIMEOUT -> L_TIMEOUT2
>>>
>>> 3. free_req(REQ) then call io_link_cancel_timeout(L_TIMEOUT2)
>>> leaking it (as described in my patch).
>>>
>>> P.S. haven't tried to test nor reproduce it yet.
>>
>> That's exactly the case I was worried about. In any case, it seems
>> prudent to handle it defensively.
>>
> Yeah, I've got from the patch that may have missed something.
> 
> Will you add this "should clear REQ_F_LINK_TIMEOUT in
> io_link_timeout_fn()" (e.g. in v2), or should I?

I'll add it in the v2.

-- 
Jens Axboe

