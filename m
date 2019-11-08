Return-Path: <SRS0=cPsQ=ZA=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA421C5DF60
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 18:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B369621882
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 18:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ZpMJhXq6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbfKHSTr (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 8 Nov 2019 13:19:47 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:37772 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfKHSTr (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 8 Nov 2019 13:19:47 -0500
Received: by mail-io1-f68.google.com with SMTP id 1so7369932iou.4
        for <io-uring@vger.kernel.org>; Fri, 08 Nov 2019 10:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fBb/GsIqxIs0+200iFfFk+JNHXZVGTkTQzuvYA2nrz4=;
        b=ZpMJhXq6pIr7PS9X0I6ecqd2ulgW8Ci9kiKozBlv3iFQKOcjWbpBmUTjh96/LbQbtI
         dKuP2bsqUUgTvX79UdDjxBFmTYd+mB4lrCn99ZaaXc82M/LzdNIeGwsGyMCN4SutWaxu
         zJpylSAarq8OaBOSYdXXEa6mWNDJ1iBI50yuCFCAZN+dGRTFbsNJLUHW9gjI7uEqoU6p
         6vEi4JD/fUxaM0ObouIz67SIzSuLSWqkwEwaHcKalmh0SkRn3Y1LEFklitFU8dmhH+Nl
         iOPgxAbkhbbAnXUORpOSCG1eg9NU+w8wOkLaycv1CLsSArd+bmxmY1y0ml6QhEJjxJ1h
         gqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fBb/GsIqxIs0+200iFfFk+JNHXZVGTkTQzuvYA2nrz4=;
        b=SkPG+OxVZy6Qd6thRj8cYYYvxL2JCz0fcmp7OzztqMQD7WBlqTNkVdTTdYiLiP2Jex
         DsG5C+bFxdH0EFmPbsduekh9CavW9hPw8EACo/Z0NhOIHJkfxeUoN4DwWhR0BDq6kHKe
         uph8CuK3kU9DaEQqd3qEpEWNnSsP2JwiopiaU6QADst8qi0k0e6yL+lleq6MCdDLsnB3
         mBp4fjRnxQsxLO/yTrzxzuvD2HdHCdjfncCpkDz/CdG7y3rYyRG6DlyQmbmqKexdUwLd
         oD/P03nDVn3740p7a2xpocxL8HqG88CNGsiiMqHvW4YHYjP7G7YVcZmN1Fox0NDSZbLJ
         I8TQ==
X-Gm-Message-State: APjAAAXCXQ2UwdhjHbgIfMa9OwcZyhQXf+febFmfNdeD4T0oNdGpru7n
        +mrBe30mBgeHeje4qH949DkImiSnLGY=
X-Google-Smtp-Source: APXvYqxOZ0xkaGH70j0HLH0ftY66XcbDplPOjJp6Lugd5gGWcOZ4SnFmN8FezeuIpyiFvC1sNJJ7GQ==
X-Received: by 2002:a6b:7516:: with SMTP id l22mr11857675ioh.264.1573237185467;
        Fri, 08 Nov 2019 10:19:45 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id q7sm54041ild.81.2019.11.08.10.19.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 10:19:44 -0800 (PST)
Subject: Re: [PATCH v4] io_uring: keep io_put_req only responsible for release
 and put req
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     io-uring@vger.kernel.org
References: <1573228236-69222-1-git-send-email-liuyun01@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0657acbe-941f-3aad-a8bf-f9f89a3bb1b7@kernel.dk>
Date:   Fri, 8 Nov 2019 11:19:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1573228236-69222-1-git-send-email-liuyun01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/8/19 8:50 AM, Jackie Liu wrote:
> We already have io_put_req_find_next to find the next req of the link.
> we should not use the io_put_req function to find them. They should be
> functions of the same level.

Applied, thanks.

-- 
Jens Axboe

