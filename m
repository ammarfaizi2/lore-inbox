Return-Path: <SRS0=Xlws=24=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1BFC33C9B
	for <io-uring@archiver.kernel.org>; Tue,  7 Jan 2020 17:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E529A214D8
	for <io-uring@archiver.kernel.org>; Tue,  7 Jan 2020 17:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="APnBX3xi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbgAGRDK (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 7 Jan 2020 12:03:10 -0500
Received: from mail-io1-f53.google.com ([209.85.166.53]:45531 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728425AbgAGRDK (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 7 Jan 2020 12:03:10 -0500
Received: by mail-io1-f53.google.com with SMTP id i11so2931ioi.12
        for <io-uring@vger.kernel.org>; Tue, 07 Jan 2020 09:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yuCPGN5ltIi9ToyvfT1B3Z6meGbkDm5bTI9RM16HMkE=;
        b=APnBX3ximAuUIBEX8AS2/wvamE1ubhqqBZ35sIxAgsPOFrL+BKe4onVJgFGlUw8I1c
         SdoZd7YXYjIyCgQp+yjME3Hx3vmy62nST5v7xHnhMOfaELWASv3RbpgKBjCHHlb2Sb+H
         tFZzexpa4gk2JeTo4geqQrpugmuU+26zTI/lbgFiyVWD/RtYH/PHF9tjEGxNvDtAqNPn
         8PXKQ7IvcaTinwdDieVmLdnUdpPaywsYtaxpGxgfw/7Kxd+JgN3JB8n7vTstfTPRf2J2
         wZJlKDhIwPGbSp65yY5mIV7TpNwB2vCPp/WSsKzuYR5CD3igyPVw7XlylS6fqqNXsSy8
         2x8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yuCPGN5ltIi9ToyvfT1B3Z6meGbkDm5bTI9RM16HMkE=;
        b=UXrawuKSSLmP1wkKI+vVS6/Qfoqyv3BVrodhwZfJvufjBCl3BLZ4sreKK56mAqjpFk
         cEW+15MQNlepacVUD0Us7g+58pVXWvMBfKx9oS/QVCWf8e/uZ68DJLsIOYwpH9dB2rpT
         AaZzyON7V9mDaHVKPKoqOuaA4CzowyKOQgMqzlDWX8RPNxbzcFARD+GTaY1dpMe5tl4R
         fIS70Tl2gEBZ6ftQpj2Uhw1MA5GQbZETb+P6uyhTkHMr92Dld7gjxexTO8Vj0HI7OWC2
         n14wfTQuZlYY9Q+DX3Nr6UDEywtS07yHERYvpL1M7kTwnuwTcoZmVUcS+fYGKkChJI4+
         Minw==
X-Gm-Message-State: APjAAAWkwm6sb297yKIAcV+cGimYC3EK/zooBQXau88395CyYahMPVlL
        nzP2YTM8eWkzRCj8euAGP1i6Lw==
X-Google-Smtp-Source: APXvYqzdB+ofu0kVmJA44d34y3Pv+AEzKmUy2lLY6HIJ2JwrL+bA8fuo94EBafrNKvx8AapBOFLwlA==
X-Received: by 2002:a6b:7201:: with SMTP id n1mr64850957ioc.37.1578416589140;
        Tue, 07 Jan 2020 09:03:09 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 75sm48079ila.61.2020.01.07.09.03.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 09:03:08 -0800 (PST)
Subject: Re: [PATCH -next] io_uring: Remove unnecessary null check
To:     YueHaibing <yuehaibing@huawei.com>, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200107142244.41260-1-yuehaibing@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4373ff3f-686c-8e82-af5c-8225ae16da41@kernel.dk>
Date:   Tue, 7 Jan 2020 10:03:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200107142244.41260-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 1/7/20 7:22 AM, YueHaibing wrote:
> Null check kfree is redundant, so remove it.
> This is detected by coccinelle.

Applied, thanks.

-- 
Jens Axboe

