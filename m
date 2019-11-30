Return-Path: <SRS0=jwyC=ZW=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4E4C432C0
	for <io-uring@archiver.kernel.org>; Sat, 30 Nov 2019 02:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DFCE20869
	for <io-uring@archiver.kernel.org>; Sat, 30 Nov 2019 02:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="lfOifZix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfK3CxW (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 29 Nov 2019 21:53:22 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46649 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbfK3CxW (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 29 Nov 2019 21:53:22 -0500
Received: by mail-pg1-f194.google.com with SMTP id k1so6991640pga.13
        for <io-uring@vger.kernel.org>; Fri, 29 Nov 2019 18:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TFNXTUbKkQdsHGg8rEPwlJHNNcDiA6+VrC+v3kUz144=;
        b=lfOifZixgeluiqt9HgkCHU543gbPmc7BLDzlBbbWKA1ABiSYw6UL8lLaPRaOjShWv1
         JG8osba32bC9HTKN7Ztjtz0cEo5l25YLNy4X5NMHl9chdBgF5R81Uj+k60bJsyREy+J0
         z+s5Zm3jLaCHp8vzVfJKAAgkSdAHMfh55hOrLI9OBZt1XCfdG2drmEbiY2OtluNUJl+2
         ug9cwtTW2nSgBfaMjA+FfPl6oTD6H5c5AjqfOILuQc8+XxkRp9hIZGkxDES1+3OXmHG0
         j7JuAJPV01wxz/PLlFvW9qtEDHnL7shZgGzWQQIbqRs5RXT4w40XGIZMUWmTpAgkXojD
         djaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TFNXTUbKkQdsHGg8rEPwlJHNNcDiA6+VrC+v3kUz144=;
        b=qgkgR/xKc9X4TImFv0YYlqlloCVu54KLj1FXJR6ZBUn3xC3HmFkO+56OP2O4mwhkpm
         fYINrbYBk9KSdGPs+BgrSldhWZOrkMlbc32FIm012N8/wuQGMac6imoyFQq9tijKabTg
         gDjHUWcL/7iNJANaIpw7pPQRzoXMb88kNMjUleYwsg1ZbtAt2TlQRHgWA1u2Y2nZQVed
         LVxBfCZQevfjxLrARSBKtPfbN/TCkGS8iupoNCR3KBrhL9AWQCgf1DAFdc29asVhmSL3
         9SAh8iimAbAe6e26q2cEjv3MCMaEpK6R2bTkcGYYhAJHBQamcagE5StufAcowvoIBW9z
         IH7g==
X-Gm-Message-State: APjAAAXWNFFZgnK2OLqGu9slzTfa9i3y7+kT4vig9EAxMK39fKRcSmda
        lRIFJMaDatywTD5SpOpCmVw2QQ==
X-Google-Smtp-Source: APXvYqyMx7MPL9ozDuQ/RDhHO1RF6Kj5cbHzID7wRax8WbQ7SuKgEtc14qT2e+/uyQnCoyp/y/U+Cw==
X-Received: by 2002:a63:ff1e:: with SMTP id k30mr19533259pgi.273.1575082400382;
        Fri, 29 Nov 2019 18:53:20 -0800 (PST)
Received: from ?IPv6:2605:e000:100e:8c61:9062:6a04:387d:c19c? ([2605:e000:100e:8c61:9062:6a04:387d:c19c])
        by smtp.gmail.com with ESMTPSA id a26sm25056083pff.155.2019.11.29.18.53.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2019 18:53:19 -0800 (PST)
Subject: Re: [PATCH -next] io_uring: Add missing include <linux/highmem.h>
To:     YueHaibing <yuehaibing@huawei.com>, viro@zeniv.linux.org.uk,
        asml.silence@gmail.com
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191130015042.17020-1-yuehaibing@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <70275fde-dbf8-4142-87bf-8d2e43564a45@kernel.dk>
Date:   Fri, 29 Nov 2019 18:53:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191130015042.17020-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/29/19 5:50 PM, YueHaibing wrote:
> Fix build error:
> 
> fs/io_uring.c:1628:21: error: implicit declaration of function 'kmap' [-Werror=implicit-function-declaration]
> fs/io_uring.c:1643:4: error: implicit declaration of function 'kunmap' [-Werror=implicit-function-declaration]
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 311ae9e159d8 ("io_uring: fix dead-hung for non-iter fixed rw")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   fs/io_uring.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 2c2e8c2..745eb00 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -69,6 +69,7 @@
>   #include <linux/nospec.h>
>   #include <linux/sizes.h>
>   #include <linux/hugetlb.h>
> +#include <linux/highmem.h>
>   
>   #define CREATE_TRACE_POINTS
>   #include <trace/events/io_uring.h>

Fix for this is already queued up, and now sent to Linus as well:

https://git.kernel.dk/cgit/linux-block/commit/?h=for-linus&id=aa4c3967756c6c576a38a23ac511be211462a6b7

-- 
Jens Axboe

