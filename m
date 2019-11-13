Return-Path: <SRS0=KKPr=ZF=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21769C432C3
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 21:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02BDE206E3
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 21:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="k1nWc1lT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfKMVdm (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:33:42 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:41155 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfKMVdm (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 13 Nov 2019 16:33:42 -0500
Received: by mail-io1-f67.google.com with SMTP id r144so4272262iod.8
        for <io-uring@vger.kernel.org>; Wed, 13 Nov 2019 13:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=2Efg47bjnaP5JEJlnrTbOu4UYQqqyxWN2z+maayalLo=;
        b=k1nWc1lT15qPOUC7xnLy7SUgscC5aPk5/DPVoToulDNNZMKDxtzsfVQAskA8BuEzFb
         BJ1oDldRy4MW/c8Bbe3YHYS1pOY2LDqiGyWteNrFCZEEels8wuwJDGeM1KyQzcypzQdj
         v+nfruIuJG+Z9niFTHl5uhZfDMVdWfgQgD/ZDahK5W7JnUIBnvFDAktE7visn4AnCHof
         ujo28LsjojkYLnTXbkDHSg2/uF+CrVIKQwVEM1Q2YtOl3NzP1HJjdByjIlOhCm2QjDJP
         vKMpFt3eOuaGlte6uguO0O/5KCdYhpmQs5hsrG1luVT7Bx69/QTGawA2TkdLnvDCtr5g
         CB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2Efg47bjnaP5JEJlnrTbOu4UYQqqyxWN2z+maayalLo=;
        b=PMQ51Sir9v3khCrAma7PvyUX8vAa2bPO+3fc9GeM8fz3aJqmRCmS/ajmIAaVKwepxc
         OOG1aU3FPgfpZcufvkpK+ra8HEHlgyQR0LejmI0S1zAAa2ywF1BvJMV4fWGb+2NPx5wU
         MXsuadAbKKayzOrlApUNQDy4KYp0KjD8T20sq7Zbcy4FpVBZEg3x+5sOb4h7LVuDTW+/
         YaiDJ41PunCu3zSnrlhzGoaa0r3VjhrFp8cfpGKN/VJJwG4LdQAUAUrOUVmI8wdDn/YB
         cLlDFQiZIiW4pA81pV1CKPhNgQHdurj4OzdrGqggQygqVA8TvzNEq15NUqE34i9TT/ur
         BcWw==
X-Gm-Message-State: APjAAAXU6zPHpEkYkpRkmTeCP+j/DjdP030DilSL9w7WVBJyOfi/s822
        NP1HSngWLV04OKsmfpiOeob0a5NiAnE=
X-Google-Smtp-Source: APXvYqzDMTaDOnIoYjEF1K056UNKZ+6CeGiWj/jwCETRMHoig9ruY/7T6tIP2lyIt1vXHtBZCY9yHw==
X-Received: by 2002:a6b:fe11:: with SMTP id x17mr1874688ioh.202.1573680821218;
        Wed, 13 Nov 2019 13:33:41 -0800 (PST)
Received: from [192.168.1.163] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s28sm317097ioa.88.2019.11.13.13.33.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 13:33:40 -0800 (PST)
Subject: Re: [PATCH] io_uring: Fix getting file for timeout
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
References: <f07037aafc5e272343fbf5f9eeb554d51a4353df.1573679112.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1bf6b2ce-4af6-1f3a-d576-85258256388e@kernel.dk>
Date:   Wed, 13 Nov 2019 14:33:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <f07037aafc5e272343fbf5f9eeb554d51a4353df.1573679112.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/13/19 2:11 PM, Pavel Begunkov wrote:
> For timeout requests and bunch of others io_uring tries to grab a file
> with specified fd, which is usually stdin/fd=0.
> Update io_op_needs_file()

Good catch, thanks, applied.

-- 
Jens Axboe

