Return-Path: <SRS0=cPsQ=ZA=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CECC43331
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 00:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16511214DB
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 00:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="RcJn5eCq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbfKHAG3 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 7 Nov 2019 19:06:29 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45848 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfKHAG3 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 7 Nov 2019 19:06:29 -0500
Received: by mail-pg1-f195.google.com with SMTP id w11so2945587pga.12
        for <io-uring@vger.kernel.org>; Thu, 07 Nov 2019 16:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XJnuuA/bjjO7hC9Y+qAE5Me9YS/JCWRIfp2sbdX9SnU=;
        b=RcJn5eCqN7B51R9N+elUb7ow15c661WVXf/wbBAeK7fBxTXCXUGRA3OA7aDtfNZguU
         xN1xfpXWmZL7Jfo+MCYlokmYO0qbbjcUBeFmohgP9gXil4GZLzWeAftUG9Zw6h8uPp4S
         BtyMVeWQZ3Kxffilsn+s1jmF/em1AL/7iiKX78OE36r/jjg4cqtYt74ffP3VD9y8fpSD
         PziB9e7eYDzhZ9Tz9zDKOaj/FkfDScRcpKBwDWJh2fdGxMp/6uRkg79BwVB2mzsgGGGb
         hF2G0a2xYiHixESrK/WB5lUGjyn7bTrhGdBBM1FtNlg7LXu2cS14hrcn8uU+GVmtKNzb
         nd/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XJnuuA/bjjO7hC9Y+qAE5Me9YS/JCWRIfp2sbdX9SnU=;
        b=MKqBY+jgSuQWPy5WkH5z8F/9tfMjn6vkagH07OIVoKYvA+VRqsRGz4LCXzqzu4796X
         jfB4alEndLqrfMuIAzWsN+73QZ+9G5yUyP81XnyDHFkz0XMP6Zh+WQ7ZMaU+nwDf2CM+
         UymRUQy6OxZqhP6vBXxukP8E22eafY4Hn08VNdmxwWHwo8JGOYlO9kSiAzLqOIqudkE2
         qRMByiGUPmuCBDK7kmSxHhj0TqHnSGXFccPlTBcyYNOlO8aR8b0/ar4n8cxeGHtuReel
         AnwFTL4Vpjp0wAbREdASL8+IQ3Oy82jhMbNGBTkQf1MoSbOGIEOBHPq52XuudYRzXKBX
         YgCw==
X-Gm-Message-State: APjAAAWDyxEIPwNEqhuI43QzHDBq0vXlJNObEb1T2F/zpPVUI4C2WkQG
        cyuoJiZ2sWvR5Vq8WOJEGj+gOmHuRN0=
X-Google-Smtp-Source: APXvYqyhpXOcRPS+cPihmJstp/H5G/mkyYRTYrPcxk60K7jM6TRW6S4RlcWAduhSGyhK1BGK85R+rw==
X-Received: by 2002:a62:7b0e:: with SMTP id w14mr2806341pfc.177.1573171588414;
        Thu, 07 Nov 2019 16:06:28 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id f5sm2736991pjq.24.2019.11.07.16.06.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 16:06:27 -0800 (PST)
Subject: Re: [PATCH] io_uring: reduce/pack size of io_ring_ctx
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     io-uring@vger.kernel.org
References: <1031c163-abd1-f42c-370d-8801f5fd2440@kernel.dk>
 <EB274748-0796-4D09-A568-D7A16A0C22D7@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <253b27a9-55a2-c88e-3ccb-625c104934bb@kernel.dk>
Date:   Thu, 7 Nov 2019 17:06:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <EB274748-0796-4D09-A568-D7A16A0C22D7@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/7/19 5:00 PM, Jackie Liu wrote:
> This patch looks good, but I prefer sqo_thread_started instead of sqo_done,
> because we are marking the thread started, not the end of the thread.
> 
> Anyway, Reviewed-by: Jackie Liu <liuyun01@kylinos.cn>

Yeah, let's retain the old name. I'll make that change and add your
reviewed-by, thanks.

-- 
Jens Axboe

