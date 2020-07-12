Return-Path: <SRS0=0kNa=AX=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5F5C433DF
	for <io-uring@archiver.kernel.org>; Sun, 12 Jul 2020 15:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3CF9206B6
	for <io-uring@archiver.kernel.org>; Sun, 12 Jul 2020 15:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="qx+VmWns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbgGLP7L (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sun, 12 Jul 2020 11:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728854AbgGLP7L (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sun, 12 Jul 2020 11:59:11 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0310AC061794
        for <io-uring@vger.kernel.org>; Sun, 12 Jul 2020 08:59:10 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id u5so4883312pfn.7
        for <io-uring@vger.kernel.org>; Sun, 12 Jul 2020 08:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=rCUr70PBm03rm1kcL7BHJsBV86MBxPVl+9xm7KFkHkM=;
        b=qx+VmWnsK36uyPoS6Z2EfVBqtWUjc99g8p3/LO7fVMNghcamb4OOPAkv5H8sRw+Y+a
         UjyzFhOvAGfuYm7pY6n5VJvQ33RHf84jO8nEUI81F1Md1CBW+Ag85eHPv0qBYdBMXNMg
         Mp7ZLpcKeFu2t+HVs+kz6aihC39H4ZA708/MVgpoflX1Siisxckagl3WgtzSSoD/Kklu
         ui6n6jtmMtwuXHswvejY0BNGl4BzCHXjd+ZFyEPkH98qUpHSuMnvrCYLUDXXSNxbjDwu
         FCVImmifQwWJHGtNwrdQwKcFwio5GdviSwG4Ob6tgAJbLSGX3QumwcEswN4p0fZ9FRuP
         OuIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rCUr70PBm03rm1kcL7BHJsBV86MBxPVl+9xm7KFkHkM=;
        b=C33J4k4G/i8qVMBFVudI8qSeqC/BcdQXFqt4+YhkUbQdqN0wCb4hBqU3vGtWfjoR5I
         tfckvUDwSwYYX7R0a64DqXvynJaiZ0+D6sqln6hHQPJhANE8CScozJ5Bjo9PNO8jVuX5
         KuGPbrEO4SoaXSo98v2Q82cYoEKaWEB9OGOi6crVAyoD3rCvZ8zjoHqSGIw0AX/JHLRb
         IQ5qCpCMAJ47/npYp6xLLvzlNoeD1/GAbFpmGjfa0HnYUspIK7MUQJOhtDtOs0/4qNnK
         8s46pJKHB+1A0yICUyd3bFhtEVFh2E/4qiW4CGKdqOkgSExnQJZwLyQnCohPcizAKJQI
         h90A==
X-Gm-Message-State: AOAM532gPzKHQScgjzokxpVkIQ2yRQlSSiV8V8xR3cMzKjnVFRnH8dhL
        +TlDqPbdP2lzgvkzogjZ+HBpywZgbA4IVg==
X-Google-Smtp-Source: ABdhPJy0wAXhBDQUxaDc89bDoaTn+gAoHPz5PDTKBXvKdMCcXK1Dv6UXTmiaVAR5pbMctycsgyYTGQ==
X-Received: by 2002:a63:5004:: with SMTP id e4mr43952786pgb.208.1594569549811;
        Sun, 12 Jul 2020 08:59:09 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id e5sm11518170pjy.26.2020.07.12.08.59.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2020 08:59:09 -0700 (PDT)
Subject: Re: [RFC 0/9] scrap 24 bytes from io_kiocb
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
References: <cover.1594546078.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <edfa9852-695d-d122-91f8-66a888b482c0@kernel.dk>
Date:   Sun, 12 Jul 2020 09:59:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cover.1594546078.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 7/12/20 3:41 AM, Pavel Begunkov wrote:
> Make io_kiocb slimmer by 24 bytes mainly by revising lists usage. The
> drawback is adding extra kmalloc in draining path, but that's a slow
> path, so meh. It also frees some space for the deferred completion path
> if would be needed in the future, but the main idea here is to shrink it
> to 3 cachelines in the end.
> 
> I'm not happy yet with a few details, so that's not final, but it would
> be lovely to hear some feedback.

I think it looks pretty good, most of the changes are straight forward.
Adding a completion entry that shares the submit space is a good idea,
and really helps bring it together.

From a quick look, the only part I'm not super crazy about is patch #3.
I'd probably rather use a generic list name and not unionize the tw
lists.

-- 
Jens Axboe

