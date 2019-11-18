Return-Path: <SRS0=qbCF=ZK=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5406CC432C0
	for <io-uring@archiver.kernel.org>; Mon, 18 Nov 2019 14:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D5D2075E
	for <io-uring@archiver.kernel.org>; Mon, 18 Nov 2019 14:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="jlf0kzvt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfKROc2 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 18 Nov 2019 09:32:28 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:36093 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfKROc1 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 18 Nov 2019 09:32:27 -0500
Received: by mail-io1-f68.google.com with SMTP id s3so18983630ioe.3
        for <io-uring@vger.kernel.org>; Mon, 18 Nov 2019 06:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=YFuZXKHEZDZiros51MQ/+Eq9pFOMO+KvkdLuCUrnIk0=;
        b=jlf0kzvtz8qydTumwPYO91Fr9FrwFXxN0Ia5nBMhqPszOZ+ms4xNm37Ydm5IoKeXNA
         8YOvXWre6RWGi+dgNNoBCUKX3qXcNA45UrunzEPZV0XqENYAbnAxEHYXtZVcOU49M/Dz
         f7a7yQ4YsFi7r4NG3IeBHap3wyUk5RGHJHv8mKMZ489gdtJe5rF/IeQmDr8m+w1/s42e
         68BGt1IF2iFrlfwVymnsz0HdywbQ8fojWruGLurklxtBXf4MgbCHroSSki0RFbN8ragz
         i3WaXvhQaLI6nUpeJ2dyNBWm9gylzcpWIM2rvbkX6OJjag+fZEGFF8W3aA8n3pXgfrEP
         Dn7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YFuZXKHEZDZiros51MQ/+Eq9pFOMO+KvkdLuCUrnIk0=;
        b=iUvvH0dPrrYCB6IwPLRXkOJQqk7JaXaYBvo7G16yIJJGfb/kaNRvCZIZkRqZxl5+EY
         nbrL8A+jeg+69m81gHoBpBX60Ep+DTef0/tltyaeB8rc4LY3PxN3bjZa7bUNoD7W7gFt
         9p4kwMvXAHVMXNqNHNSLPvKYxde5V+9mZTkOOKvVfztF+hyVjCaz6cfyg0FIQnziOUgZ
         9CkIVh7AViIbxBMWEUX61Y0Wd2aF5mzuHUfhSkkizBrZGGVS4OtAamOOYSq2cs9yar+8
         jGGzXSvTZbdThHM0VS1zUkq0NzrhAoMq0px5SPO7N9a6/8KY4VqyyBflHQyBl0ZkrPl9
         RYfQ==
X-Gm-Message-State: APjAAAWYmLPlmPXvE2mkweLmOYtcFnhJYje5jiqlFeXkDaam0WTJ3vQX
        pFnlCCXKIou7DCGVGEnS/ub0EhOsJY4=
X-Google-Smtp-Source: APXvYqxm3z77Y8mKz/LZF3CGrb/zi+eK4ut1BRWFJ6ztF+923CgAwIjQvYmgATd8vRfrThF5hIJTBg==
X-Received: by 2002:a5e:8f0a:: with SMTP id c10mr13569291iok.115.1574087544911;
        Mon, 18 Nov 2019 06:32:24 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o11sm3619787ioo.58.2019.11.18.06.32.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 06:32:24 -0800 (PST)
Subject: Re: [PATCH v2] io_uring: provide fallback request for OOM situations
To:     Bob Liu <bob.liu@oracle.com>, io-uring@vger.kernel.org
References: <55798841-7303-525c-fe38-c3fb4fc47a65@kernel.dk>
 <d86e30fb-6c33-a9cf-40bf-28a0350eef52@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8fe5df76-d89b-5792-8f2f-8e1ccf74a4ba@kernel.dk>
Date:   Mon, 18 Nov 2019 07:32:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <d86e30fb-6c33-a9cf-40bf-28a0350eef52@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/17/19 11:57 PM, Bob Liu wrote:
> On 11/9/19 5:25 AM, Jens Axboe wrote:
>> One thing that really sucks for userspace APIs is if the kernel passes
>> back -ENOMEM/-EAGAIN for resource shortages. The application really has
>> no idea of what to do in those cases. Should it try and reap
>> completions? Probably a good idea. Will it solve the issue? Who knows.
>>
>> This patch adds a simple fallback mechanism if we fail to allocate
>> memory for a request. If we fail allocating memory from the slab for a
>> request, we punt to a pre-allocated request. There's just one of these
>> per io_ring_ctx, but the important part is if we ever return -EBUSY to
>> the application, the applications knows that it can wait for events and
>> make forward progress when events have completed. This is the important
>> part.
>>
> 
> I'm lost how -EBUSY will be returned if allocating from the pre-allocated request.
> Could you please explain a bit more?

The patch actually returns -EAGAIN, not -EBUSY... The last -EBUSY
mention in that commit message should be -EAGAIN.

But the point is that if you get a busy return back, then you know that
things are moving forward as we have a backup request. This is a similar
concept to the mempools we have in the kernel, have any kind of reserve
guarantees forward progress.

-- 
Jens Axboe

