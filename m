Return-Path: <SRS0=KKPr=ZF=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A955C432C3
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 21:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E05B5206E5
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 21:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="rjjY5OmF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfKMVht (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:37:49 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:35506 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfKMVht (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 13 Nov 2019 16:37:49 -0500
Received: by mail-il1-f196.google.com with SMTP id z12so3245000ilp.2
        for <io-uring@vger.kernel.org>; Wed, 13 Nov 2019 13:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=USuwb/1QgwCAn7iXqIv9vv95ES+pjv+IfYMR8TNVsbQ=;
        b=rjjY5OmF5FSzF+HOfGOkqm3H04QAFs7yuI1y3hhhBiXmBYAO9OKpoIQViM9bkX+wjn
         jLZUPThyWHqWAAfLN84R02t1H0Nk5ssnWXz/juK23NTOiEXh3ns/nkiC8IpKL4HJNgXz
         8odvyRi/swybIOFSKg+srbbyeUfBye4rwadheZ85Bf49Ap03l5PZtAF9IihNJ/2WFGbG
         S1uT5MUPfMqRci8kIXGDnToHDbvAByahCiGDR6mRX7AhxqloaWvfyvSljG+v94FvxNM0
         GE8g50ADfDwgqytI1UoCjdlOJHUWuz/xVNrkrxp6mLwtte6rkmuIJn42GjOa/Di7kCjk
         L0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=USuwb/1QgwCAn7iXqIv9vv95ES+pjv+IfYMR8TNVsbQ=;
        b=LpRZP3xYvriE4o2A2cJc83K5waIWOY2N4KG5EEeRulSswjZjqwPpkMtGZxVT1CHU4L
         52JLT9kio6BOY1FyB/jxTtjZOheRhJaplN/xoC4l0OeVWD/IyBWREIC2ZeuVfGdgFG+O
         8WIpDufPYlMJcTX+57R2jhLEhKd3oiEJrDJrOQKZEKK5SO5QP3fsa1fvRruryqq2675s
         x98PFehTZ0HAaTaaXbck2uH2oaDcXMeAIZ0nSaMCcHmDB48G7KK04SNgfDzbQKjGFxRX
         IsaVg2hgB6JeVS/XS84UUbX7CSVrDh1/bpnGdFUX/QhcB2stgIcuH5Py+CwCb2OaJ2R2
         nGWQ==
X-Gm-Message-State: APjAAAU3xCAlq9tXO3aroZ5V7RAji+gjQnuGMNjZ5M0lLXt8xZP7j8yA
        1AZkbYvHwsyRyevlcTM/YPmD25mqgeE=
X-Google-Smtp-Source: APXvYqyNRT6aDLxqfEDXZtT+Qgktq+pE7OI7iUyYuURqbgg9uVrCcx7Q/WSnOoU4CgdHCt1rrkwUwg==
X-Received: by 2002:a92:5fd3:: with SMTP id i80mr6653119ill.275.1573681067727;
        Wed, 13 Nov 2019 13:37:47 -0800 (PST)
Received: from [192.168.1.163] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w1sm485498ilq.62.2019.11.13.13.37.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 13:37:47 -0800 (PST)
Subject: Re: [PATCH] io_uring: Fix getting file for timeout
From:   Jens Axboe <axboe@kernel.dk>
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
References: <f07037aafc5e272343fbf5f9eeb554d51a4353df.1573679112.git.asml.silence@gmail.com>
 <1bf6b2ce-4af6-1f3a-d576-85258256388e@kernel.dk>
Message-ID: <44d1d4d3-41e0-684c-8dcb-853f335b8fd4@kernel.dk>
Date:   Wed, 13 Nov 2019 14:37:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1bf6b2ce-4af6-1f3a-d576-85258256388e@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/13/19 2:33 PM, Jens Axboe wrote:
> On 11/13/19 2:11 PM, Pavel Begunkov wrote:
>> For timeout requests and bunch of others io_uring tries to grab a file
>> with specified fd, which is usually stdin/fd=0.
>> Update io_op_needs_file()
> 
> Good catch, thanks, applied.

Care to send one asap for 5.4 as well? It'd just be TIMEOUT for that
one, but we need it fixed there, too.

-- 
Jens Axboe

