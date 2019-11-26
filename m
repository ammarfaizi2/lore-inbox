Return-Path: <SRS0=yioi=ZS=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2391C432C0
	for <io-uring@archiver.kernel.org>; Tue, 26 Nov 2019 04:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A01F520637
	for <io-uring@archiver.kernel.org>; Tue, 26 Nov 2019 04:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="L2XFUANL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbfKZEto (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 25 Nov 2019 23:49:44 -0500
Received: from mail-pl1-f179.google.com ([209.85.214.179]:38803 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729436AbfKZEto (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 25 Nov 2019 23:49:44 -0500
Received: by mail-pl1-f179.google.com with SMTP id o8so3194938pls.5
        for <io-uring@vger.kernel.org>; Mon, 25 Nov 2019 20:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=PhjyjTVFHrrZqrXHA9fmDWxZEKUzKIAwTWOGT1fayTM=;
        b=L2XFUANLR4Z+OiDNIoj9tvJBwC/WjgHrRtNUIUdwCeLxv4q4SD+NvEAS0GGzge5oUz
         RCEBMvhu2tCPlMsnsK9bUUIMERqzcoDNpwBIyqIsrcN2NbfZ+gYmaJmHr9AU2KvtmJIQ
         jXXIojNUI1Let4fEWitybwY2dTX3baef+xH6KI4dY5y+PLVZa9IcB7Fgs7IeeWOcw+Ne
         rVkRRH/baWnTOUAtqj58Aplj/JarztlZ0+7MSHNxiY5ENcRGF7mT+zOMD8uKtpel+VBr
         EM+kYaTeG3KvJi2R5iNsQsehTuC4yGdI+xeU33+CgHwF1nZudCAk2hx0Bosdq2NJKdNG
         wMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PhjyjTVFHrrZqrXHA9fmDWxZEKUzKIAwTWOGT1fayTM=;
        b=YpiMqbAyeVxVoR8QoGBvkZVycwwFV0blaYQCTpPNbJGLZmPNgjNI394ZiEENoY4N2k
         ACogi4HCfSZ8DsVfueDwlmZ9RsVkZJZ7E+5muam1CNJoORHrKA6HG1lAR+Kh4FecqRgT
         tCZ+3veIFkF1El/N0DembnhrEfz4rmDsiUE9vK6JujR/Sc+EC8D5hCM9TwSfZT274To2
         cWD6hA5iLAlV/lmFxbs6XnRFg9lSX9G7S4nH7bWwC6iuZ3D4wN7+U3o5ELmEoKzAwzxs
         xE35JEQZaXNufDKVRlkajZnR+5hXrahHfeTOh13qGgVi9pRY3pE3Ne/BRSeymcgY1mku
         qhow==
X-Gm-Message-State: APjAAAX2fn45tJUWRI7oxdgCHWra6lojuRX198m+dNd1bEV/C8FaccjP
        3jx3C7ZcZF0+W2cKGL08d01+peckurT6zw==
X-Google-Smtp-Source: APXvYqw0fzfVmOJTljjrlQgaToFS1Pnr/rlSaIWgC3dxhT7zeN8DfEV5IIVCXek4lJKbSOIZ5fwwYw==
X-Received: by 2002:a17:902:7b98:: with SMTP id w24mr32699190pll.307.1574743781628;
        Mon, 25 Nov 2019 20:49:41 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id z62sm10471135pfz.135.2019.11.25.20.49.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Nov 2019 20:49:40 -0800 (PST)
Subject: Re: [PATCHSET 0/3] io_uring minor cleanup
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
References: <cover.1574712375.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a662f440-5a0d-a1d0-b571-b11d0d5c9b14@kernel.dk>
Date:   Mon, 25 Nov 2019 21:49:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <cover.1574712375.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/25/19 1:14 PM, Pavel Begunkov wrote:
> A set of a bit bulky but straightward cleanups.
> The main part is removing/inlining struct sqe_submit.
> 
> Pavel Begunkov (3):
>    io_uring: store timeout's sqe->off in proper place
>    io_uring: inline struct sqe_submit
>    io_uring: cleanup io_import_fixed()
> 
>   fs/io_uring.c | 188 +++++++++++++++++++++++---------------------------
>   1 file changed, 87 insertions(+), 101 deletions(-)

That's a nice set of cleanups, with some space reclamation! Applied,
thanks.

-- 
Jens Axboe

