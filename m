Return-Path: <SRS0=KKPr=ZF=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D425FC43331
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 00:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95CD2196E
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 00:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ploI0qbj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfKMAO0 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 12 Nov 2019 19:14:26 -0500
Received: from mail-pg1-f174.google.com ([209.85.215.174]:39158 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbfKMAO0 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 12 Nov 2019 19:14:26 -0500
Received: by mail-pg1-f174.google.com with SMTP id 29so104459pgm.6
        for <io-uring@vger.kernel.org>; Tue, 12 Nov 2019 16:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=6xDB0HhVbgZDTpCqg8ELorgt21bRtVJ7lCdchTuW5X8=;
        b=ploI0qbjDBceRb2fZojFfwVtQOQoBtg/E3wigSQ/Y+O65xm6WT6xkzYlnfoqw1RubY
         Hy6jdVEerNEiClhJgvaBWRze42bLlkmqTW8ccjt0Sm87AHbI65jnI0fcnjzi/58nS3/L
         jQjEcRcyHeJ+Uo7G3/2hQ12aehcHUPvmem0G1LSekJQT1L+d0k4crO859G0u2PigBfTo
         OGQVZiGZUWPZgDppvDdFYmcTbnJ6YbgfpJ5oM/wxnHP1WJFiXBOxonOeEoG4JALgwN2g
         JYUrX59rxn0Ovyl52mBg0/Jjorie3MNQB6K6XtSz6seyJUlfapu2OJtV1qiRG1fvmZ1H
         2AsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6xDB0HhVbgZDTpCqg8ELorgt21bRtVJ7lCdchTuW5X8=;
        b=U7enPVXw5HVzG34ifwH+nfFxgYuQ2xE94Yq31VLL7gDEh4+UdR4yywmgd63PfVjXL9
         tznHBZE8gsQY+eDBD/Xbf6VmwxefSjLCpEpkj3GAunpUO0N/zd05eIKW2JG8aELeIoau
         +H8Gqxw2ALiCGhwGLy79BDvBxrc9Vsby0BjPLuHG4DboTQvmP4iUEsilIeDCSuTiYnQp
         lMfh9phQFjWPhtOdjZHecHWc3cppeoDO4KmVjnXGPA2j1gS/5nmd9JEbSDkDGtHSTV5w
         ZiGHMcQh18v/HDg5CZrQYTrBn8wyPhmf4bvyC6QTY2auxM/XivRQoh2w3xQdbq6Attp+
         q3rA==
X-Gm-Message-State: APjAAAWs61ODQ7fWHfVcKi2gN2vS3rVcrXq0paGkOvPGGgAzeFZZudp4
        RivaelQt92d9m3BeNbiFEWMd+vOnUMQ=
X-Google-Smtp-Source: APXvYqyNm9BhlHO4ZnON+2iRwFA/COHoIuK0xM+B0GcE2KQJFoV2JSmJINNvmYdk04l1gB6J9nWJ2w==
X-Received: by 2002:a63:1323:: with SMTP id i35mr303567pgl.450.1573604064639;
        Tue, 12 Nov 2019 16:14:24 -0800 (PST)
Received: from [192.168.1.182] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id 1sm132498pgp.88.2019.11.12.16.14.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 16:14:23 -0800 (PST)
Subject: Re: [liburing patch][v2] test: fix up dead code bugs
To:     Jeff Moyer <jmoyer@redhat.com>, io-uring@vger.kernel.org
References: <x49eeycirmq.fsf@segfault.boston.devel.redhat.com>
 <x495zjoiquu.fsf@segfault.boston.devel.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <66a766ab-e4c3-c268-9962-4376b29af69c@kernel.dk>
Date:   Tue, 12 Nov 2019 17:14:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <x495zjoiquu.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/12/19 4:04 PM, Jeff Moyer wrote:
> Coverity pointed out some dead code.  Fix it.
> 
> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
> 
> ---
> v2: Don't re-introduce dead-code! (Jens Axboe)

That looks better - thanks, applied. BTW, totally gave away that you
didn't run the tests after writing the patch, that's a black mark.

-- 
Jens Axboe

