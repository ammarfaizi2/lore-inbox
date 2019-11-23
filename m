Return-Path: <SRS0=JfP8=ZP=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3D2C432C0
	for <io-uring@archiver.kernel.org>; Sat, 23 Nov 2019 22:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA672064B
	for <io-uring@archiver.kernel.org>; Sat, 23 Nov 2019 22:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="q1hnjF/1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfKWWwT (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 23 Nov 2019 17:52:19 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40030 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfKWWwS (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 23 Nov 2019 17:52:18 -0500
Received: by mail-pl1-f195.google.com with SMTP id f9so4766352plr.7
        for <io-uring@vger.kernel.org>; Sat, 23 Nov 2019 14:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=253rXmbcHMUnMzo2rz5S/az3QiZ8uGRt4vAggyUF2KE=;
        b=q1hnjF/1t0SHYJnBpWULxcsKXwvxggh1aUan8QM4mnTQ7w7nvRPf8fnftvYPwweYwu
         b0C1aKb+ikMAZ7eDqdDCfnmNvc9fC6Geo6+uLgPlZ/qWu0GhGL5kBzaAphIFhuJpqzBu
         MGw9G0+40ANCpSfTfxktahQvjiOr4c57mjLDpB08NaA0g0lDvWhWgmFMmYwkt7N52JtB
         +SMK4Dj1yKyKWQeh9D2gFuFWpoIFDL2mRctr3S4OGRks9tjLIsHEwMfVFJ7ITYFCN8fo
         RcRp2P7Azjxq4wRAWM+xtxqBFMzjTVytl9KGylE0G93ygxOa6OofrdVavTwI+lAJScL6
         NfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=253rXmbcHMUnMzo2rz5S/az3QiZ8uGRt4vAggyUF2KE=;
        b=Lzgsga+fEiu+hPmjOs9J9a7V+OeHLinDZD8ot1y8VI4NJm+TC0fnMDXfE3PzpWVv4w
         9cH8+Q9Wv0fz5t9Yp2p23zD8awdoIW9yDVtRyV3GmUf6DOQojtMZAYvcpQ0vUlrF7WxE
         +heWq4Cqn7xB6yF7N5ZUP9BniHjUVFosacl3j2PCZNP2k0djyFlTDTb0qPOK5gv86SnZ
         ah0pMVLlXvawrwA7vfufiUMGJYbVhmrJ3PZaZ9/8gAhS8JyxLgHPotAAuPwt5GuZNU0q
         FizawFjZiP6uJjOQ6lHdcaWuJSOPACtAKID4yx0nUy+LVeLtUgR1Dad79oLqzXt4uUGJ
         1QfQ==
X-Gm-Message-State: APjAAAUamYPbfD7yUgKoG2rw+RgLDLQa7+Y1KLTm77j2EGhf/En9TlYB
        9ozlXFXVd4SNxMxazuL3wGSMMnV1vKwWbQ==
X-Google-Smtp-Source: APXvYqyfTdPfRdLOSD75UZBYtBBMOv05CaerflUz1et+FaQUFNIc2OcRN+gz6B3MZOHhAA3uLbx2xA==
X-Received: by 2002:a17:902:a70b:: with SMTP id w11mr21553588plq.27.1574549535037;
        Sat, 23 Nov 2019 14:52:15 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id x21sm2689421pfi.122.2019.11.23.14.52.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Nov 2019 14:52:14 -0800 (PST)
Subject: Re: [PATCH] io_uring: Fix linked fixed-read/write
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
References: <38fe471ecc3212c334fa60ff88a73896f11ec355.1574548888.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5e30dba1-0411-5db4-2bb9-ebb80a8cdd6e@kernel.dk>
Date:   Sat, 23 Nov 2019 15:52:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <38fe471ecc3212c334fa60ff88a73896f11ec355.1574548888.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/23/19 3:42 PM, Pavel Begunkov wrote:
> Dependant links of a fixed-read/write are always cancelled. The reason
> is that io_complete_rw_common() uses req->result to decide whether to
> fail links, which is set as res=io_import_iovec(). However,
> io_import_fixed() doesn't return size, but error code.

See:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5e559561a8d7e6d4adfce6aa8fbf3daa3dec1577

Just not in the 5.5 branches. We probably do want to make it ssize_t to
be more proper, but IO in Linux is capped at 2G anyway so doesn't make
a difference right now.

-- 
Jens Axboe

