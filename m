Return-Path: <SRS0=5OhC=ZL=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4E9C432C0
	for <io-uring@archiver.kernel.org>; Tue, 19 Nov 2019 15:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C29A4222A2
	for <io-uring@archiver.kernel.org>; Tue, 19 Nov 2019 15:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="RwBME2Oo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbfKSPpc (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 19 Nov 2019 10:45:32 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:35674 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728095AbfKSPpa (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 19 Nov 2019 10:45:30 -0500
Received: by mail-io1-f65.google.com with SMTP id x21so23744746ior.2
        for <io-uring@vger.kernel.org>; Tue, 19 Nov 2019 07:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ILms/bB5JEtUXlffrq/EMHXcgXCQzsaG2M1qIBlKUaQ=;
        b=RwBME2OoqBztOI11Voq+RBDUpPBLExkw/VYGbmu1VlblBKOGHqNeO5L6Xz3qvALBPm
         HuOxueoQr47BxFCKxsxDLxuGY0n6u1XaRW+BP/AinVTaQCRqOv9pAcv+i4LLlefza6ys
         Mv829/6Gga0idOLiQo6yiK6DA35AzyH39OfCt/Mpl6b69udOzBI+266SvHciziY0ooTv
         gEkuD4zAx32J4Bjif1LvH5kbNk2cKV+bjd0PMIkw/p4J/dmZ/aI0ar+8YWjNRCwMAcg4
         PNnjDOv8HO+PWtQRtuQcJ3CVZ67QzJWtgNUY9Sh0Hg7WJBXdJ6n3iRhFDcyag4vDZPNU
         hoqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ILms/bB5JEtUXlffrq/EMHXcgXCQzsaG2M1qIBlKUaQ=;
        b=h3mjcfRv9v19Vp8wDYme2Stbx2eXXwRvGue54Yf/0MUPqmGwTJWGAjz3trFBFgAE9o
         NQoJlQLUXa/vYRD7UZ/SibX2vNaA+k2tcH9ZYyKvTPp+0hyasoF8BXw1ddd2q47UK8Bd
         hTzKkv+/gUfuYOE5p52RYLZBToIp/3URm2rBa0RNa/QUhuB7021BGD/xETCfwrnsSPnL
         fMauVyniuUgDCjvA+13T5sFqWnNHyGX52MeZ7uJge2+gAO3HGM6GlyEv+4/V5zbXWyaK
         ufSsMmEnUr3MzeoKE3yniWegDmKiybBiOTRci2jHTaSwhOek6/vKhH+PdlZ8DxIbFWuk
         jw+A==
X-Gm-Message-State: APjAAAXxUJeR79JMNJ6/rN79+4gjLrPaKv9B3yXZ/AGXJO0IPdKaRLbj
        zEL2Ms/A3+6h+XybrBzLc+Z/gXLHaJk=
X-Google-Smtp-Source: APXvYqznPJlg+TnJQNzJlFLlkHhxBEEmh+lvMVKVsCOsZH+6WUZXKFc57WfrzoCx/y5oaecfPWPWwQ==
X-Received: by 2002:a6b:400d:: with SMTP id k13mr19027339ioa.299.1574178328024;
        Tue, 19 Nov 2019 07:45:28 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s18sm5604075ilo.21.2019.11.19.07.45.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Nov 2019 07:45:26 -0800 (PST)
Subject: Re: [PATCH] io-wq: remove extra space characters
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20191119062216.qhxmnrt2rdioirja@kili.mountain>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ac841162-db41-0c8b-6ff8-d5b956961582@kernel.dk>
Date:   Tue, 19 Nov 2019 08:45:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191119062216.qhxmnrt2rdioirja@kili.mountain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/18/19 11:22 PM, Dan Carpenter wrote:
> These lines are indented an extra space character.

Thanks, applied.

> We often see this where the lines after a comment are indented one
> space extra.  I don't know if it's an editor thing maybe?

I think I can explain that. I recently decided to try and use the
vim auto-indent, to see if it'd make my life a little easier to
save on typing. Unfortunately it has a bug where it indents that
extra space following a comment form like:

/*
 * bla bla
 */

which is exactly what happened here. As diff doesn't show that
as extra whitespace you can miss that it happened.

-- 
Jens Axboe

