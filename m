Return-Path: <SRS0=JfP8=ZP=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E409AC43215
	for <io-uring@archiver.kernel.org>; Sat, 23 Nov 2019 23:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9A6720714
	for <io-uring@archiver.kernel.org>; Sat, 23 Nov 2019 23:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="GBh3ZuVO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfKWXIU (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 23 Nov 2019 18:08:20 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45716 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbfKWXIU (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 23 Nov 2019 18:08:20 -0500
Received: by mail-pl1-f195.google.com with SMTP id w7so4749830plz.12
        for <io-uring@vger.kernel.org>; Sat, 23 Nov 2019 15:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=+mIlooiIaKAccFDDYQcwdYz/FhRD0t6+x5/Et5v7VuA=;
        b=GBh3ZuVOv0dT1LxgwC+CXkoQ3nSRJ/QvggyAK59VHNiGs3h1hR3Ne9KZ4Eh4OCG4UV
         0pnAinJ6AFa9EnNOLycMheuAaM9rWXFGSIf0wRcozAmvg7fdaaAzVkx49/osAHIKYcHL
         b1F2pM+E1IPUf8ReoX8B2P0AX7BEbMiFMapbCXn6FjNVACp8ttBSUKy2PJfuIT9tq+sQ
         SifM8QauuqKrJzeflnKuKI6wUnkLjtpDLd75mPu64Q7qLfonGWeSBOuVCfdzFwjvwyuA
         QvMyC3iaNdCJVrqKKffiRfnHwJsuH9M8qC17BvCWIWViKSPbU+XKzSQwZ8wckfkBIE84
         r1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+mIlooiIaKAccFDDYQcwdYz/FhRD0t6+x5/Et5v7VuA=;
        b=nXR/4EzenRuFZocahmG6QKGjhVqR9oP9hOSxC7DTW0EbepJiz8sWzpA0A8vcT6TuPG
         jjd0X5Q7j6T8SGtU5M0MQE6UR/bNqYx2pP6DcChqeeC/QQX4cLhN0lsvrnP9V6vuJIWn
         /HyyfE+Ppkk5hLKkagjy9rq69jUv0rlZ2KmVo7UaPrTK3tUn/5odzR2yP2hL4ihzmJPL
         2E/XfX9xF1oR1tC38E61RQ+m5MCIttO7ZfcGD5bjnqUi/2CuBTNt9eOk6hvaNTlQNMen
         qm+glD7JYFMnFJfxHxkPqMhLKdsbkv1jvZxyFD6jzxUCHGI81qEdDDo7brNU/nrFna86
         iFKg==
X-Gm-Message-State: APjAAAUYBwmnb2VKFJyEd0Y7kP36G9OyU/hvXyLeLJJLEwjtVJuFSlsL
        0f9Y4STeG/QwfayAntOUCRYTBayZ7L6uyQ==
X-Google-Smtp-Source: APXvYqxW85/WsqR1hPdcq1p3eevrNqfacyONfILj6yiZKXaW2RdkyLZpVxVAQmXJJS5RvC+DdTL/Qw==
X-Received: by 2002:a17:902:9b8f:: with SMTP id y15mr20207397plp.54.1574550497840;
        Sat, 23 Nov 2019 15:08:17 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id d11sm2987098pfq.72.2019.11.23.15.08.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Nov 2019 15:08:17 -0800 (PST)
Subject: Re: [RFC 0/2] fix in-kernel segfault
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
References: <cover.1574549055.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fb952a30-3e42-fa81-f0ea-200b7acbf6a9@kernel.dk>
Date:   Sat, 23 Nov 2019 16:08:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <cover.1574549055.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/23/19 3:49 PM, Pavel Begunkov wrote:
> There is a bug hunging my system when run fixed-link with /dev/urandom
> instead of /dev/zero (see patch 1/2).
> 
> As for me, the easiest way to fix is to grab mm and use userspace
> address for this specific case (as it's done in patches). The other
> way is to kmap/vmap, but the first should be short-lived and the
> second needs mm anyway.
> 
> Ideas how to do it better way? Suggestions and corrections are welcome.

OK, took a quick look. kmap() etc doesn't need context, but the copy
does. How about just ensuring we grab the mm for cases that don't have
->read_iter() or ->write_iter() and then just map and copy in that
loop that handles that exact case? I think that's cleaner than what
you have.

-- 
Jens Axboe

