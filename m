Return-Path: <SRS0=enxk=4Q=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C02AC3F2CD
	for <io-uring@archiver.kernel.org>; Fri, 28 Feb 2020 14:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 466A724680
	for <io-uring@archiver.kernel.org>; Fri, 28 Feb 2020 14:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="rWrSmWBw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgB1OHp (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 28 Feb 2020 09:07:45 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:44374 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgB1OHo (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 28 Feb 2020 09:07:44 -0500
Received: by mail-io1-f66.google.com with SMTP id z16so3476265iod.11
        for <io-uring@vger.kernel.org>; Fri, 28 Feb 2020 06:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=I7VerJ00XbCTcblHyPJ69M92GIZbyH5sXHBHO8MfbXs=;
        b=rWrSmWBw+wdWnmSjjN/+a/VrD+Me3zwNHa1YstG0cUa4pLQY9dOEym2Pt+r5GWD0RR
         TgdPmcxP9tDcONyWTxncu7Y8Yo5w9IrC7U1IvEG875njLn4ctGvwHFtJ0hQQEuMeF6UA
         e8P2XbBMR2Tjoku4hsPGLbbt7LbmIvJvPEuq0vkaHg//UgVtlgoGMIjqOfrNFfTHirdg
         w0/mKJvi6YL1/95xkxCUkEw1GWT66CZJ11EUks15OJyQCbJl8gZHEI8mFwrYjFPMUD8I
         Si4+e36oePjA332KVhrffzobAmijt3VvHknbOQYAP+4uhIAbCHP0SDXi41BSyhglxbJc
         bMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I7VerJ00XbCTcblHyPJ69M92GIZbyH5sXHBHO8MfbXs=;
        b=hjwCEe/GiYHM9c4t2WL3Mt/crdVISAjicTYrZDH1//Ik2X0ZQdZG6DIXgfFJouhZex
         graBg08ZuA5jjhE4cVEjSTpx8Ts0nz8LrShg3/8AsBrqczECmcKqJE5kpryxjnImogC2
         AO5KRZBklsWmdjWOazoqlNGxxX521dsoP5Flv/kUHDSanicOiaMdbKJBs01B3cnjU0gW
         LyNlRl/3zwegMauaSxlUOSic4tvpW1aCxY+PD5/Wm8RljAoSEETC+bRvvyEhoWBoZD7Y
         R9Hvevo3UzNCYX9jUjf0TF90AbJGL2x0cs4Q0MWqM9etBugYocz34KYEvQep6spp4jEp
         uDzA==
X-Gm-Message-State: APjAAAUoqgIxV1yD7XeXTY58lLk5wvx7vpvcVBS9+JtTljHIqV8rQ45U
        fQOjSZ7KH2emkJHWnh6Cxz3IOizA2es=
X-Google-Smtp-Source: APXvYqxpCXjDDiNPmKXR7riZh8TXh7PX9WKpJG5aV+07+wY9DKu0swvs2nfdHuc9LR/AnncyYvogog==
X-Received: by 2002:a02:a48e:: with SMTP id d14mr3495360jam.30.1582898862847;
        Fri, 28 Feb 2020 06:07:42 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id v4sm3092221ill.31.2020.02.28.06.07.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2020 06:07:42 -0800 (PST)
Subject: Re: [PATCH 0/5] random io-wq and io_uring bits
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
References: <cover.1582874853.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <15c68c0e-fe14-e38f-ec51-ede94fe79ff2@kernel.dk>
Date:   Fri, 28 Feb 2020 07:07:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <cover.1582874853.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 2/28/20 12:36 AM, Pavel Begunkov wrote:
> A bunch of unconnected patches, easy and straightworward.
> Probably could even be picked separately.
> 
> The only thing could be of concern is [PATCH 4/5]. I assumed that
> work setup is short (switch creds, mm, fs, files with task_[un]lock),
> and arm a timeout after it's done.

That's totally fine in terms of timing, the reason it was done in a
callback was so we didn't have a small gap where a cancellation
would trigger via the timeout, but the request wasn't locatable yet.

But you retain that, so I think it should be fine.

-- 
Jens Axboe

