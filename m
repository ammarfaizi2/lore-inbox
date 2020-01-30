Return-Path: <SRS0=DuQT=3T=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEABC2D0DB
	for <io-uring@archiver.kernel.org>; Thu, 30 Jan 2020 15:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F2F220674
	for <io-uring@archiver.kernel.org>; Thu, 30 Jan 2020 15:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="J10teDfw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgA3Pvw (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 30 Jan 2020 10:51:52 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:40943 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgA3Pvw (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 30 Jan 2020 10:51:52 -0500
Received: by mail-il1-f195.google.com with SMTP id i7so3451995ilr.7
        for <io-uring@vger.kernel.org>; Thu, 30 Jan 2020 07:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=5iA76UUiom0ktClLjhi7gsHikeYZLP8c9rJNeh0eaWE=;
        b=J10teDfw/2xWof/JRZ7i76l04RMKDxJxyQ5wphqeegMkotGEY9I86wmVw948T4trDO
         UBjAW0rAGtEPhnnRf81ubOeQGpLyjOPNXtHVknf0EASFZN1CMgYA9cH+O8q6CCHf2CuW
         /kgAVlODqCDe1acYEuCVZJaCzW8/UTM2VzIDEw826Odiu5vzakLImCN+a8b2eeqcgwT3
         k3DtKI0b9RHr6Ib01jX3RonWTN6Se5Rfb5P7/Nsc+dBHNZT/SQc1HnWY9lCDBxpuy9iD
         yYtwZcF9ldV3f9mvpb+550IEFue/novFx28oLmbz8okoX5i22a7C7hik5xyk0+I92/9/
         2reQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5iA76UUiom0ktClLjhi7gsHikeYZLP8c9rJNeh0eaWE=;
        b=EE1ZDHK2oPl8NlFCtee48FXBVCF+oiyD1oclG7LkGGk/QmFyKtyjO3kWUmq6Z1fhE+
         dyd7PX83XAPmjhOr52o02Q2WjI6fBRBZy89Y+MDds7imTKLJPxfWxCXZeTD980ion7Eb
         Vmfz7imcS8m/uorLluiF5aXtbYeeIij3yZQtmd2aYzWV6z/eyqonKCS+aSRbstuAiMjd
         wuolkTPqh2IOqid1XBXpSjZp02FpAvYXHfHBVz9y84Fxb8RcVXyqv5SR9kjSr9Ake439
         QKUQYVQE+NXjTWZboDbdh4LCkDHwWAEkFt4YbIoYOUXaLAl/V7CKFm6GDuKvTfHO44Qs
         61Lw==
X-Gm-Message-State: APjAAAWF0YKAMY2lX+u0GyP4Ko6uKmEVe7zBVETOqTyaxO8+jdQtEBHH
        miHhlIpbgk/Eci/Wgbz1yuzuSv4hMH0=
X-Google-Smtp-Source: APXvYqy3LGvOwv/9QkmYxhHUYDrwG3SqmVSd4EWE0tUmKwQ3xRapG7n4XlvInl4Uwfj+BTDxtUv60Q==
X-Received: by 2002:a92:50f:: with SMTP id q15mr5185826ile.47.1580399509469;
        Thu, 30 Jan 2020 07:51:49 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k23sm1999249ilg.83.2020.01.30.07.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2020 07:51:49 -0800 (PST)
Subject: Re: [PATCH] io_uring: add BUILD_BUG_ON() to assert the layout of
 struct io_uring_sqe
To:     Stefan Metzmacher <metze@samba.org>, io-uring@vger.kernel.org
References: <20200129132253.7638-1-metze@samba.org>
 <20200129133941.11016-1-metze@samba.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <285d990e-a3d9-a033-ba11-898c6522ef3a@kernel.dk>
Date:   Thu, 30 Jan 2020 08:51:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200129133941.11016-1-metze@samba.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 1/29/20 6:39 AM, Stefan Metzmacher wrote:
> With nesting of anonymous unions and structs it's hard to
> review layout changes. It's better to ask the compiler
> for these things.

I don't think I've once messed it up while adding new features,
but I'm fine with adding this as an extra safeguard. Realistically,
the regression tests would fail spectacularly if we ever did mess
this up.

-- 
Jens Axboe

