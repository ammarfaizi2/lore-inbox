Return-Path: <SRS0=/tfB=DF=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E406BC2D0A8
	for <io-uring@archiver.kernel.org>; Mon, 28 Sep 2020 14:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F50F20774
	for <io-uring@archiver.kernel.org>; Mon, 28 Sep 2020 14:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="JiVrBmJ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgI1OmE (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 28 Sep 2020 10:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgI1OmE (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 28 Sep 2020 10:42:04 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6ECBC0613CE
        for <io-uring@vger.kernel.org>; Mon, 28 Sep 2020 07:42:03 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id o9so1459224ils.9
        for <io-uring@vger.kernel.org>; Mon, 28 Sep 2020 07:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=F34DFOadLWUrYUexx9pZf+zYffic8Ay3o02O0h/KIN0=;
        b=JiVrBmJ1Cyz1KGIH2v91GIUY9+L+DZ69rzBdIU3pBMqJBXXKyTi0md7EeDKaf570kn
         atTuuvNtsa0TeJrzNgAI+V2wJocWnoATQzOgRHsk0HHXu95TjpK0ywXjcqSUd+N2W9VH
         Ej4YXhL7rX5X8/+G5/wI+77r9atTtnT64CtlyQ0/IPvt6GkYSikR9PVbf1UZh3Qppscu
         gX768RyIQEICelF4f8e4F4UNHSPBO1L4DHtIny0BA9jI/HLgMqjh7af3Oa3oQyHZKq3I
         YT4R2BKSECg6NpyvPNIQDjEC011f250CMZw7ZnNJgkE6pncfcc0GkFfwFZFsWOHWVs5q
         XAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F34DFOadLWUrYUexx9pZf+zYffic8Ay3o02O0h/KIN0=;
        b=k0ESFzarNFONlGg1URSrQrJhS8UQepjOEOrkv2vVsIPEUzHgJ1Lx0hmjwaM9rRlesE
         aONEtqowjnMRbepmrFGrG2C+uNaNUHbn20PaLFdtD3uHhiqa/rWABIc38+YoiWOlyOuz
         hfiJCYkMMJHPgvTvAUH7nksOpbkTXg8sFIipa699MyGeiePBt/dVtHkyAAYCxgeZlPBY
         aY+CuL3urtRsQhu5hNr9S1nStum2bQrOO5I73bvy6XDVwbdJLiLDKTq4fhI9dCVMXwF5
         UTky3LU2B1S3n7oi7Sfv2ah5d1zUGqfctUUC2ooKqEEnYjcGeJuxXvVv4RQC+RSMAtIP
         9Kpw==
X-Gm-Message-State: AOAM530E7jYrzjEWxX08FATkq8SIs6Zzz/j95zOOdURkwhMQ9AbqLyiL
        tOuWOKdGh8SoeKGaz4Uq9SzD1w==
X-Google-Smtp-Source: ABdhPJz37pKpbU4jXuYy2tGgcf5RcPJkvzjXloILoPzePX5GnpjgmEsryGJ3i2XSWGkgPWsvpWEKDQ==
X-Received: by 2002:a92:9817:: with SMTP id l23mr1532021ili.131.1601304123000;
        Mon, 28 Sep 2020 07:42:03 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id v15sm704133ilg.0.2020.09.28.07.42.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2020 07:42:02 -0700 (PDT)
Subject: Re: general protection fault in io_poll_double_wake (2)
To:     syzbot <syzbot+81b3883093f772addf6d@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
References: <000000000000478f3a05b05a7539@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <835b294f-2d2b-082b-04dd-819e12095698@kernel.dk>
Date:   Mon, 28 Sep 2020 08:42:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <000000000000478f3a05b05a7539@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

#syz test: git://git.kernel.dk/linux-block io_uring-5.9

-- 
Jens Axboe

