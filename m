Return-Path: <SRS0=R86o=DV=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7A4C433DF
	for <io-uring@archiver.kernel.org>; Wed, 14 Oct 2020 17:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C3D82222A
	for <io-uring@archiver.kernel.org>; Wed, 14 Oct 2020 17:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nCDOAyyX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbgJNRCM (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 14 Oct 2020 13:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731220AbgJNRCM (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 14 Oct 2020 13:02:12 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280FEC061755
        for <io-uring@vger.kernel.org>; Wed, 14 Oct 2020 10:02:12 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id l8so6078243ioh.11
        for <io-uring@vger.kernel.org>; Wed, 14 Oct 2020 10:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=1FmEIkrqfL0T3fOHDc6OHU2lmhTkM3AhohF3xQ/xB7E=;
        b=nCDOAyyXhiRZZz7rZ9wEUHslojMwI/MOxw3Lqtua2iKHYhXaotVSr69c6pqSs3JDno
         rbr5GpWiK0EIzhRtNZ9JiywfQClnnP2K4YumKU0T1RM048fq9rOlrkCw/hKjK9omGufF
         b7/VGcG7jMw8dHgKIeFxZnexkgwDEQyf2fBRXWWPqLse5diN0XaK8n4ux1Jsp4OImgbF
         BUHvFyPwqLDJRpSHpQXTEi9YJw6YGFmJR3mtFhPKyQXo2ZC5l6zhLLWW7tMIWGg2kz9C
         p/q/mXzv/8HGDQfX7cD8HoderJFuPXQJXMGxpKj8yxJX58xe1QGCWilXPbbc03Dx6GRr
         VJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1FmEIkrqfL0T3fOHDc6OHU2lmhTkM3AhohF3xQ/xB7E=;
        b=pqd8ZcZioHMDFJ/BqcDCy3gb1tIAXh1NjOtnRXu50nals1I1Xk7VbJV+LdrHQPqDUu
         f5Ne/z4/WOBsWJSQnSXnhikYQ3FYEo2t43CTE80L1dIhoWNYof/KuztQXu7L8Efed2vL
         BJowpJYSWtGhiGAOB0C51xyqGFW5XdJgihtj7byYUfX27+w/mGjFUEDFP0598inT8LYH
         qBFo4qgBB7myetf122nUUAkc0pdbrSve6gvGB8ORekyzjPgivD3kmwlbHqc52tJg5k92
         XJMZRiajKNVWYADu0DJ9UCiiF6yVi7uUyIAthytd7R+s2KrN4sEoFFYBGC8uQfZsP/Tc
         bTdA==
X-Gm-Message-State: AOAM533509v0pJluhMTFRI+ZHdJbM3VKnMZh4rtszig4UXIWSfq+HdlZ
        FiGcraCxNL7y3acwcTW+g1iY9A==
X-Google-Smtp-Source: ABdhPJzhd+/16ZvJiUYYfs9WNkd1c88ZyLGztYQfhm8605zQRwoONNTABR+sxO8FM05H4pLYKZakxg==
X-Received: by 2002:a05:6638:dcc:: with SMTP id m12mr395388jaj.30.1602694930981;
        Wed, 14 Oct 2020 10:02:10 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id n9sm2447180ilj.74.2020.10.14.10.02.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 10:02:10 -0700 (PDT)
Subject: Re: general protection fault in __se_sys_io_uring_register
To:     syzbot <syzbot+4520eff3d84059553f13@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
References: <0000000000000c3be205b1a4782f@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7fccdc0f-bcd8-505d-f0dd-672471be30f6@kernel.dk>
Date:   Wed, 14 Oct 2020 11:02:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0000000000000c3be205b1a4782f@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

#syz dup: general protection fault in __do_sys_io_uring_register

-- 
Jens Axboe

