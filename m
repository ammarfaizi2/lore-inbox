Return-Path: <SRS0=qtMo=5H=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E97BC54FCF
	for <io-uring@archiver.kernel.org>; Sun, 22 Mar 2020 17:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55F4320724
	for <io-uring@archiver.kernel.org>; Sun, 22 Mar 2020 17:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Nor6zKKF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgCVRFE (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sun, 22 Mar 2020 13:05:04 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36719 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgCVRFB (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sun, 22 Mar 2020 13:05:01 -0400
Received: by mail-pl1-f196.google.com with SMTP id g2so4835040plo.3
        for <io-uring@vger.kernel.org>; Sun, 22 Mar 2020 10:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=fRx3KO2qD4+O5ApjJxU5X5/ulUb2Awba8fbTnXXL7JY=;
        b=Nor6zKKF4GDfP3V+tc3dvu7Pcj2yzCbQ6bzSD7U3UHV8QpznP2UHkedBDzexXLAc8X
         Ea99OdKUA6yrcbQ23/2BWpOsm5IGI4Xc3pFGTJzopkzOAdSNt69KgD3geDcx92L6faQI
         Ytu7ycbG3v6XLOj0jwlA7hUb6+ev5CS/HajOrOlTQN6M4RYfCFTW4gWIAPE7QGvY0AMU
         OOEni94M51O18A7wBy5mizj9n3cOmCl3tL0hYte9CMuItgHYvoplMy1CqU+SDt1kmX2J
         Mtdl7N7doiXRdMtsmNcPAwgtrixwvx2Vr2veJk9ihpkWmKIyTjTEsAM4Bjk+SD+JkQ6A
         VG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fRx3KO2qD4+O5ApjJxU5X5/ulUb2Awba8fbTnXXL7JY=;
        b=RnrVxLhHlXXXWwQveP+nNe7cCc48VwdXSfZBHE2AIs7SOkyvIDt/Z2GgyfwpTt7In3
         e6cbM1EmlgIFGC8tecnQVDF7cKm3ruYawS56dAPU1+zpnEXT4sNrMaJRe7EH2Ag8FYdW
         Yu7RLJwFyhdSImVX+F0nRYqSWZgOqbzUqjUmkWenbroXx/OOqYXjJlbD8XJxNJspMuN6
         yiAQj8opr/InN2xUs1SD7WTT035nIZTWhsSjQKpEPEgRYqEACAzU09hOcT9UQzD7NUsK
         lpNxxHu8TRP5wdY7vL5SpmonxNLiNOvlg2/vrhIFMWEXbSrDP57utdK+Rs4VNmARyq41
         xGvA==
X-Gm-Message-State: ANhLgQ2+EzGkXCEHH0C5YoiSeCv+JcaqVVhD/vs5gdRBEhPXe7PxrQyx
        AMpkTcVGcA3gcW8Ys+xCFVgY2g==
X-Google-Smtp-Source: ADFU+vtpK8jhMAOPtr/h6vSmBHcZX31XZyST3vX0GDj4Z26MUGDns4bnWf3+wMziOsDOxmQpa+VHnA==
X-Received: by 2002:a17:90a:22a9:: with SMTP id s38mr20311200pjc.3.1584896698331;
        Sun, 22 Mar 2020 10:04:58 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id g69sm9884859pje.34.2020.03.22.10.04.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Mar 2020 10:04:57 -0700 (PDT)
Subject: Re: [PATCH 1/1] io-wq: close cancel gap for hashed linked work
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <b9bc821a0ff3bc52a60281d8a9005dff93f6dcc3.1584893591.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c7f352b4-0255-d87a-1fb4-0b55984df137@kernel.dk>
Date:   Sun, 22 Mar 2020 11:04:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <b9bc821a0ff3bc52a60281d8a9005dff93f6dcc3.1584893591.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 3/22/20 10:14 AM, Pavel Begunkov wrote:
> After io_assign_current_work() of a linked work, it can be decided to
> offloaded to another thread so doing io_wqe_enqueue(). However, until
> next io_assign_current_work() it can be cancelled, that isn't handled.
> 
> Don't assign it, if it's not going to be executed.

This needs a Fixes: line as well. I'm guessing like this:

Fixes: 60cf46ae6054 ("io-wq: hash dependent work")

but I didn't look too closely yet... Fix looks good, though.

-- 
Jens Axboe

