Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCB4C48BCD
	for <io-uring@archiver.kernel.org>; Wed,  9 Jun 2021 15:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34CB461285
	for <io-uring@archiver.kernel.org>; Wed,  9 Jun 2021 15:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234202AbhFIPkk (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 9 Jun 2021 11:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234039AbhFIPkj (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 9 Jun 2021 11:40:39 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D07AC06175F
        for <io-uring@vger.kernel.org>; Wed,  9 Jun 2021 08:38:33 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id k7so39069153ejv.12
        for <io-uring@vger.kernel.org>; Wed, 09 Jun 2021 08:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=gnOFRl13pZicfKno1DPltChp8qv4w7SatL9EO+/xqmw=;
        b=ibAELY9aH8vjqMxBc+jXnXaxXlhkQHBphukUu4396dIq/AgRVe2On0FtHtLDTRIAZj
         x5/DtNixF+WuzPHfLcPhSfNMrIT7qVNc6NjXu7u3yH4QtTja9D8tN0Q9X/Huc3soviMm
         /Fm4KwYy4/CF4/OkQfun+9yMeHu+/L9s1HO+z8mHfLy6okvvmx8HwTXFrR4WwD5Vcj2Y
         X4bdAksWul2T7vEG3UvMS+r0uL3IqzqPu2pe8DlVD34ahVAkuMC+yn6W49ue3Xex0fup
         BPY3EVYtlUm1fSOhdin7AacBd9+wHwRGlQ0btt1YMuC9IW4v4S6mvZE2uu09/pJZmGgv
         NsKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gnOFRl13pZicfKno1DPltChp8qv4w7SatL9EO+/xqmw=;
        b=EzxIx1/gYo8YuKr76jrmAXwjG0YFZXnMgtH7P/QHj2SJ6Lkm+dwFEy3U/eNI2mcY15
         ukOS0G2+eM8DD0c4/11nukvQMt1fK70AnywaZ2pioI07qsVDgbwe7YjJ6eYjGau3jP1U
         HXt0ai09LWScaez7E7pNiHi6+JunmYR1UW5CRJE3pemejEYu0nk2PbTddTnHPZ2SgtkG
         zmRs2B0ywclO7uYpBPTBTh8QP++bMEUDclI2eSyDNjqAFe8VdC2wOqMwUcp+z2vQv5J9
         xUcEprkepWf7S1+LXpwjvCPxVpBNwg4mva1+cFUFd4FohX9cpoSHulfz1aVaiEiAAoBp
         v1Eg==
X-Gm-Message-State: AOAM532/EvG6at5GHOtDkpdrid3HGIy2XVhzKVBPqnLbJrnW6H4/GPhl
        h///mZ7ridA68VONSoHPA9GiaPwC3fs7jB/J
X-Google-Smtp-Source: ABdhPJwDfSJ4zxx9pMarqmFYt4W7tUQrO3HStdg5vHGizEFecEXqLT1XMR9NfH7+hfjdDpeis4VJ2w==
X-Received: by 2002:a17:906:c293:: with SMTP id r19mr510249ejz.252.1623253111522;
        Wed, 09 Jun 2021 08:38:31 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:310::2410? ([2620:10d:c093:600::2:f1a2])
        by smtp.gmail.com with ESMTPSA id f20sm48865edq.64.2021.06.09.08.38.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 08:38:31 -0700 (PDT)
Subject: Re: [PATCH] io_uring: fix blocking inline submission
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
References: <d60270856b8a4560a639ef5f76e55eb563633599.1623236455.git.asml.silence@gmail.com>
Message-ID: <b771a2d6-bd76-41cb-22e4-7a4b0f6ef73f@gmail.com>
Date:   Wed, 9 Jun 2021 16:38:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <d60270856b8a4560a639ef5f76e55eb563633599.1623236455.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 6/9/21 12:07 PM, Pavel Begunkov wrote:
> There is a complaint against sys_io_uring_enter() blocking if it submits
> stdin reads. The problem is in __io_file_supports_async(), which
> sees that it's a cdev and allows it to be processed inline.
> 
> Punt char devices using generic rules of io_file_supports_async(),
> including checking for presence of *_iter() versions of rw callbacks.
> Apparently, it will affect most of cdevs with some exceptions like
> null and zero devices.

Reported-by: Birk Hirdman <lonjil@gmail.com>

 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
> 
> "...For now, just ensure that anything potentially problematic is done
> inline". I believe this part is outdated, but what use cases we miss?
> Anything that we care about?
> 
> IMHO the best option is to do like in this patch and add
> (read,write)_iter(), to places we care about.
> 
> /dev/[u]random, consoles, any else?
> 
>  fs/io_uring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 42380ed563c4..44d1859f0dfb 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -2616,7 +2616,7 @@ static bool __io_file_supports_async(struct file *file, int rw)
>  			return true;
>  		return false;
>  	}
> -	if (S_ISCHR(mode) || S_ISSOCK(mode))
> +	if (S_ISSOCK(mode))
>  		return true;
>  	if (S_ISREG(mode)) {
>  		if (IS_ENABLED(CONFIG_BLOCK) &&
> 

-- 
Pavel Begunkov
