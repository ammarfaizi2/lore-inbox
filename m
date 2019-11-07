Return-Path: <SRS0=nqv2=Y7=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538D4C5DF61
	for <io-uring@archiver.kernel.org>; Thu,  7 Nov 2019 21:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E15A21D79
	for <io-uring@archiver.kernel.org>; Thu,  7 Nov 2019 21:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Fp/fitjc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfKGVYQ (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 7 Nov 2019 16:24:16 -0500
Received: from mail-il1-f179.google.com ([209.85.166.179]:42296 "EHLO
        mail-il1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbfKGVYQ (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 7 Nov 2019 16:24:16 -0500
Received: by mail-il1-f179.google.com with SMTP id n18so3165567ilt.9
        for <io-uring@vger.kernel.org>; Thu, 07 Nov 2019 13:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=eqHXhU0aJ2ZZmaMEDZYzYAX2Yoyd3TRYWnmqgLTwSIs=;
        b=Fp/fitjcm7cU3YYFXLTEmvloIBkc18HVBOHU5cmr6B2MVevdcfakNFNT7P8lL7H/Fi
         UC5q6nr/RXULl6shCH5chYghNyrQnXMnM2Fykb/c+NnPyCTF7UUkdHtVAvXsHBz580ST
         6wxoa1On6YjLOgI6Pq5Pxh3+SGAnG1bsD4ciNXLIw2OXR8tfJDg9+Y97nbUNHZBGy+ee
         ROOGt6fETtvvxiNb7jaWYpb6W8AJb/w3hF4wfAJK5mM9FZNGG3NCBKb5SfSxXsqn/ALx
         +ITvlcUcxyBSNl209zG2BwqyskR7qClQIE+5+btvIKY0udkuZvREG6BIQsPU3HMEarW3
         WIPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eqHXhU0aJ2ZZmaMEDZYzYAX2Yoyd3TRYWnmqgLTwSIs=;
        b=oqrZ+oHIA51LapZeV+B0bPcRhpuev3sb25vUPb+WMDHI3b1mNiONrn9m3lkbt7rcaU
         Mk7WxkhfK8d68dLv7rUKDkkTdPQyHgX5JczkjiaQsYwMS9sL7i5DurBD7DvhddeU0YOS
         ttzxoCM4CJX3gB8MaaUSOAMuewxKqOea8GqLsbBt41zTX6KcB/WxUYzRyCGfccruuPey
         xpYBMImfTiT1gcOp+acG56y4LqnMv63xMgUp6oCY5FggRdlj9oBT8MrO74Tml3MBV+fu
         Jv5G5OT3KPrZfJ5U1+2fhOTgBe4nXS87jZ/v3n6Qs3gBcL/WAIuoncrxK78hQIMMPxR2
         1HhA==
X-Gm-Message-State: APjAAAWn58e9sJB/GZs5k+fu9xPn6oSfBCFqtE4GB/MDI8zI5Xw8UN44
        2RmG0i79C5oi9LfJc0PxjVPAzT/1y/0=
X-Google-Smtp-Source: APXvYqxXYqSAV0BuczKf5aFHDWpgxqqJP91vN6tyjzV5Jx+zpbV29+xBNMa1xEo7xKtyxKtbLZ+cDw==
X-Received: by 2002:a92:8897:: with SMTP id m23mr7107606ilh.36.1573161854507;
        Thu, 07 Nov 2019 13:24:14 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id q144sm269770iod.64.2019.11.07.13.24.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 13:24:13 -0800 (PST)
Subject: Re: [liburing patch] document IORING_SETUP_CQSIZE
To:     Jeff Moyer <jmoyer@redhat.com>, io-uring@vger.kernel.org
References: <x49ftizz8ou.fsf@segfault.boston.devel.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b38ea97e-cdae-ff34-7592-fd24633eb8eb@kernel.dk>
Date:   Thu, 7 Nov 2019 14:24:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <x49ftizz8ou.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/7/19 2:18 PM, Jeff Moyer wrote:
> Add text in the io_uring_setup man page for the IORING_SETUP_CQSIZE
> option.

Applied, thanks Jeff.

-- 
Jens Axboe

