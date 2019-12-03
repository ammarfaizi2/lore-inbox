Return-Path: <SRS0=jlnN=ZZ=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F98C432C0
	for <io-uring@archiver.kernel.org>; Tue,  3 Dec 2019 03:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97052206E0
	for <io-uring@archiver.kernel.org>; Tue,  3 Dec 2019 03:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="AGV6H1yx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfLCDD3 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 2 Dec 2019 22:03:29 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33370 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfLCDD3 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 2 Dec 2019 22:03:29 -0500
Received: by mail-pg1-f193.google.com with SMTP id 6so949187pgk.0
        for <io-uring@vger.kernel.org>; Mon, 02 Dec 2019 19:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SzWDjGzzObtQukWWdQ4Abcq2uACsEQvOpOexukNwvPw=;
        b=AGV6H1yxL6CRcPvWhJouZNijT0RkIGjC7hgOqKZGz0ZLoBdEnBQj5Mzq5R0zkxdIj6
         nkSaSqls0pLvRhemoGtSIvGr7KSy6oUmcE2+4YCKdwg/EMhBGqBx1m6ToN82W2z6gHpJ
         +Sesmwyr/iUp5z4taznLpTZUJXXl/VVFaznltXG0q/4nr+TTTsNAQKCs+0eRSxembZ1E
         4gtwxCogrochOpyqBFCBAKBb+wVG3hQa7W/aF/+oh+aXuPxbH633aL9v7vj5HfJR3gKw
         F+TkyXxF3yjneDkzBC81XMoaQjRFbvzrZcziMvqiqNCXvUSBDNTTf4IbX7lXjJw6FOiz
         PlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SzWDjGzzObtQukWWdQ4Abcq2uACsEQvOpOexukNwvPw=;
        b=ORw4DRtsRIEKcDFxNqcwfPGIWELS1qhpwSLlFJTgJsJjovxebK8bIRMfoTusr0c9ou
         lWwOoWdvmhj7DRXLCBu4Xv0w5eE7zRQWrX/siufifWSUtq35R7RZvQnoBsRr+IRx3MV5
         kBAxyPTbe0P3+7FgAygGfDn0WMBIbHtinvKWo264ri5KhoJKlQvzBtYCcu0DDEnv/kYT
         ZKJoQsY824CW246Yer/WaTRkHLncesvj56MypyNDiSv+DaLV5sWOynFgnY9ViP5wEYeb
         xpXdeG1MqXKzwdJqq3qW8ti9pHYrk99iE7yKUjnCU/scXzkr2kCINT0KdF2q+AXyBVNq
         DPdg==
X-Gm-Message-State: APjAAAVrYrn88pKJhkpiMZVeiFR7ztCJTI3yd2TQSNgd9qKvYgA/uPrT
        fQJBsCca3bxzOGNo+n1bgu8FXgZ/AreVgw==
X-Google-Smtp-Source: APXvYqyUxC51z2Ro+VOTu/9TJqzZuZYynwtbihaj0wAczkpTM7YS9V9XjkLe7CNEIQ97gs4wMnUi9Q==
X-Received: by 2002:a63:1014:: with SMTP id f20mr2834046pgl.279.1575342207628;
        Mon, 02 Dec 2019 19:03:27 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id m14sm725543pjf.10.2019.12.02.19.03.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2019 19:03:26 -0800 (PST)
Subject: Re: [PATCH 1/2] io_uring: remove parameter ctx of
 io_submit_state_start
To:     Jackie Liu <jackieliu@byteisland.com>
Cc:     io-uring@vger.kernel.org
References: <20191202091453.3038-1-jackieliu@byteisland.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <602c4ab9-1443-3270-7b7e-956d345a8719@kernel.dk>
Date:   Mon, 2 Dec 2019 20:03:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191202091453.3038-1-jackieliu@byteisland.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 12/2/19 1:14 AM, Jackie Liu wrote:
> From: Jackie Liu <liuyun01@kylinos.cn>
> 
> Parameter ctx we have never used, clean it up.

Thanks, applied 1-2.

> checkpatch.pl said:
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'

That's just checkpatch being annoying imho, they are 100% identical.

-- 
Jens Axboe

