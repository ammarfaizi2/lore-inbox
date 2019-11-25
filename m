Return-Path: <SRS0=pC3Y=ZR=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403C7C432C0
	for <io-uring@archiver.kernel.org>; Mon, 25 Nov 2019 19:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E99D02071E
	for <io-uring@archiver.kernel.org>; Mon, 25 Nov 2019 19:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="FT1QQV4w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfKYTmt (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 25 Nov 2019 14:42:49 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:36639 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfKYTmt (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 25 Nov 2019 14:42:49 -0500
Received: by mail-io1-f68.google.com with SMTP id s3so17676992ioe.3
        for <io-uring@vger.kernel.org>; Mon, 25 Nov 2019 11:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=B1Bi8hqVfQsDHhQj9zSvVEaf+zaMtKm9RTMtiE0/naI=;
        b=FT1QQV4wQmx0o1h0UgphUeH8CewTZBbPvZKJI0+YwB3f7UeyaHWtFi+y8BFi1Ux5Em
         AufRQyT0W2h2FBgBOFZPczbWsQlKo3MeOX5tu9tnwK2jE/xhNYnLDGS/WkfX89GeRv73
         N7R9YN9mWM6rLCt3I4Q25HZc7J7CdYfGpjJYIYvffH1IxZC6exHr2hUC7jwJJuAO21uz
         jH0vKt9Tqymgv4LnNArpretgrvQ2LCVoJHY2W/TANQ+OEZAnBWF9IMmf5NPtjQQ7JMxS
         hxMHcPYKhuzzJu6Jq1OFcQ/sL+KUe3jZ7BWMWh+9ZdfDxaUD4vYT1T+aCtcjY9rebbLE
         WzRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B1Bi8hqVfQsDHhQj9zSvVEaf+zaMtKm9RTMtiE0/naI=;
        b=M1cEi9iIAWKkS+cLLP6RVMNhGrGZrHa5DiIqSB5oe1MDzClbaDDrwNG31pwROtbNVH
         TNhNlpnJ4wktnkPv9/r6hgxawL4PS0R68H9uK7XaZ3frde4kJ/NQas9rWVeSbxeu6Jwi
         Snx43hOZwixJEsI3JmfJcU/udifz3GI70sdVQcYWT+dJsxys3uav1zrPcfecArRniTuI
         YIiEQq12+W0SALyqT3nGkPHcU8oWYjw8MVologU0k/v85Dm5j6KCWIoZhSLjQKOhJXSO
         cWDfgxvHXgkHvCU+LEH/fscNLU7oJV7i0RGPVnJBqo+p+fVVe0PrG55fVF/I3DG3S6Jc
         HLeQ==
X-Gm-Message-State: APjAAAWZwUnoZA4TShW8eyx8DTkg673gXvHkCuBOEIdmgbMZzNHG+gRl
        hL+4pNEuq/PEh3j10JICYB/ycCf+owEtBw==
X-Google-Smtp-Source: APXvYqy3DPEJ8hT34jjIXSkfHFOupEvFz0flKLVnInj9inNFDwlT5H59+pqWrsWKys3yka9AJ6KfkA==
X-Received: by 2002:a5d:8c8d:: with SMTP id g13mr28523711ion.100.1574710967041;
        Mon, 25 Nov 2019 11:42:47 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id m85sm2468849ilh.16.2019.11.25.11.42.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Nov 2019 11:42:46 -0800 (PST)
Subject: Re: [PATCH] Remove superfluous check for sqe->off in io_accept()
To:     Hrvoje Zeba <zeba.hrvoje@gmail.com>, io-uring@vger.kernel.org
References: <20191125194022.441739-1-zeba.hrvoje@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a3833628-50e2-5c44-6e14-5894bd8ccf32@kernel.dk>
Date:   Mon, 25 Nov 2019 12:42:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191125194022.441739-1-zeba.hrvoje@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/25/19 12:40 PM, Hrvoje Zeba wrote:
> This field contains a pointer to addrlen and checking to see if it's set
> returns -EINVAL if the caller sets addr & addrlen pointers.

Thanks, applied with a Fixes tag added (and io_uring: prefix on subject).

-- 
Jens Axboe

