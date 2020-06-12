Return-Path: <SRS0=miIQ=7Z=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6FBC433E0
	for <io-uring@archiver.kernel.org>; Fri, 12 Jun 2020 17:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5610920801
	for <io-uring@archiver.kernel.org>; Fri, 12 Jun 2020 17:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0XWShTRP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgFLRCs (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 12 Jun 2020 13:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgFLRCr (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 12 Jun 2020 13:02:47 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26ACC03E96F
        for <io-uring@vger.kernel.org>; Fri, 12 Jun 2020 10:02:46 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id i12so3881673pju.3
        for <io-uring@vger.kernel.org>; Fri, 12 Jun 2020 10:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=qRfbB7/J0qEcaWdx5Xfn+KYit6hBq0/w62uJGSgrucc=;
        b=0XWShTRPGYZQ1AdxxUTqfh3XI7d+uH1gXxh9LekWFDrQc1blBrUqj2SfOuXQd710OL
         zOD08hBVD3ql8VI1WowTiYgvR36lEqRRxSbg1gSbdkgzLF5iRykJzMuYAlucQGF2O1HM
         kr7a4ythYGOiR1La8mH5yC/ZbOs9v5logVOqYRIBN004cI2k2NXjxS/1JyhcfiC9b0Mr
         VVdZYVTUa0yiWBUTjPi/gy/DfAw3qEZtHwygIX+Pk/fn8tTF4kE+iQrfBxDYX8/Y47qd
         MaTrLdNlAhvuznYcMvSbWJWY+mS5xkrUr3jl/WWE9VScj+suyip6AXnv7LziO2W+PuC7
         PogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qRfbB7/J0qEcaWdx5Xfn+KYit6hBq0/w62uJGSgrucc=;
        b=XBIiC4dg5dolmFzjhjBD9TCLeHWhh7sefehHc9TBjjkaTigvNXD1L78fqnImgGsJe+
         AoVqknVNsof446AunPrCm8ne6c9phyj1AuuCW4IbIFJ29DHvbNw9PUSMBIAleK/husPh
         xiFCksRAkdvKterTfnXHfplvtv7x7dY1NF5RKUWwmf4+EPV/H1NBpiQO66BnVirKuNby
         I3LI87j/m/UNlGrYU46BqJVqMx3KQq3I8ueiQNpOfEgENXbaaYY023yZVGhBt0X0zvs/
         RXC7baFZvJddJXIwa+MFdgNOc6OLOkqyCrMYPTkxVRdhapnMf/qO8DZeQfBY+vwV0WVG
         MOEA==
X-Gm-Message-State: AOAM531ixF6FSaF/02VLCVkxkcS/8XCNYXiDV1Mve96jZ1gTZwcH+/x1
        gayitSAbRxuobpBLOAgEp/vkHVdWbGThnw==
X-Google-Smtp-Source: ABdhPJywuOeAmMoQk/pK2wfGSJFvwSLEtxi0DTpZHe8YedfhNehVrkyjsTaXe+uZmWXIWvuWT6O34Q==
X-Received: by 2002:a17:90b:ecb:: with SMTP id gz11mr13933360pjb.207.1591981365709;
        Fri, 12 Jun 2020 10:02:45 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id m16sm6442436pfh.187.2020.06.12.10.02.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2020 10:02:45 -0700 (PDT)
Subject: Re: [RFC] do_iopoll() and *grab_env()
To:     Pavel Begunkov <asml.silence@gmail.com>,
        io-uring <io-uring@vger.kernel.org>
References: <12b44e81-332e-e53c-b5fa-09b7bf9cc082@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6f6e1aa2-87f6-b853-5009-bf0961065036@kernel.dk>
Date:   Fri, 12 Jun 2020 11:02:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <12b44e81-332e-e53c-b5fa-09b7bf9cc082@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 6/11/20 9:54 AM, Pavel Begunkov wrote:
> io_do_iopoll() can async punt a request with io_queue_async_work(),
> so doing io_req_work_grab_env(). The problem is that iopoll() can
> be called from who knows what context, e.g. from a completely
> different process with its own memory space, creds, etc.
> 
> io_do_iopoll() {
> 	ret = req->poll();
> 	if (ret == -EAGAIN)
> 		io_queue_async_work()
> 	...
> }
> 
> 
> I can't find it handled in io_uring. Can this even happen?
> Wouldn't it be better to complete them with -EAGAIN?

I don't think a plain -EAGAIN complete would be very useful, it's kind
of a shitty thing to pass back to userspace when it can be avoided. For
polled IO, we know we're doing O_DIRECT, or using fixed buffers. For the
latter, there's no problem in retrying, regardless of context. For the
former, I think we'd get -EFAULT mapping the IO at that point, which is
probably reasonable. I'd need to double check, though.

-- 
Jens Axboe

