Return-Path: <SRS0=S5qu=ZQ=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DE1C432C0
	for <io-uring@archiver.kernel.org>; Sun, 24 Nov 2019 17:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7CEB2071A
	for <io-uring@archiver.kernel.org>; Sun, 24 Nov 2019 17:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="a7cowjuD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfKXRKb (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sun, 24 Nov 2019 12:10:31 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38661 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbfKXRKb (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sun, 24 Nov 2019 12:10:31 -0500
Received: by mail-pl1-f195.google.com with SMTP id o8so1009418pls.5
        for <io-uring@vger.kernel.org>; Sun, 24 Nov 2019 09:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=drrY8giQceBs6v0bWdAyCKqYjW1qXPcuEBkQRLI+Wvs=;
        b=a7cowjuDYDxF+m7WKEn6vD5sj+wrBjC42m/bTjUP2ftjw5vZJcFeiQHnhSn4f069xP
         CPV7/Sh5DU2uCTosjbxOD5F7mdZU9Wea38VnbbuhL1Ohnw2Hac+kWB3lHx8EpWxj4x4W
         J08sC862PXOWqML+zzmin2XHLJxRhG10Qpma3ZAsv1C8IqeBtH6ezGzB9lJ1543yL8JN
         4E8vqp7fxurGEPIOIn/B5a1mR1a5k3s6a4JlYbWpKEutHjt+a0F0qfMZauchmmBPInU4
         vyQyVlEfBIFYcBcdi5ZtrpM0ZBwOVm/gh110sv2gEWYlndeQgAqXWwqwQs654cBdHJaR
         LDMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=drrY8giQceBs6v0bWdAyCKqYjW1qXPcuEBkQRLI+Wvs=;
        b=MZuqVtcC2A2l8V/rb71VUW6u8sOUK5aGQReff+a46/KmpU+fv7qnDzvpYVgyvdDK5j
         +MWi8tykCxZoX6U01M9ro4iDWbmqVoFVjr3BrM9lhoTK4dnqyUNgtCqiynGPSN/7qf9H
         yRKTwq48s3ENu1fAhhUWz6GVSPF3OZJaSwdz+4Zi9WkfmrtwKWw+Nc12vpEEgtcAv67S
         K5dQwpz1E1iVztBizZsWxtpDa36vx4P2OJFVtJW/fD0h2RrO4uTcINJwePhZ+HMwIHGL
         m9uVhCafO6DKAYeX49d/+qkvP9Rw3mN0NujBv5ucfIU8wuNqBVFfYB3axIpbDlBrdNeJ
         PjfA==
X-Gm-Message-State: APjAAAXhtt67lRM9N9fLPlicNlCxjZMJStcGrluQGbR0zBdoEAu7E6xC
        C/g7uu7M4bAZbWbpYgM7hvk8nzzVY2oreQ==
X-Google-Smtp-Source: APXvYqwzO/cRMPUzyIWGprC+q17LBEV3KuDj8xjlWb6mnkzdIaaoB9qRhh4gvI+rGLBvxE0g0JguTQ==
X-Received: by 2002:a17:902:8201:: with SMTP id x1mr24646180pln.193.1574615428447;
        Sun, 24 Nov 2019 09:10:28 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id f3sm5166514pgu.6.2019.11.24.09.10.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Nov 2019 09:10:27 -0800 (PST)
Subject: Re: [PATCH v2] io_uring: fix dead-hung for non-iter fixed rw
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
References: <cover.1574585281.git.asml.silence@gmail.com>
 <620023b272fef0fd76d0f91ff1876fa64864caa6.1574585281.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6a2fcf67-1267-a02a-98ce-435bbb2ca9bb@kernel.dk>
Date:   Sun, 24 Nov 2019 10:10:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <620023b272fef0fd76d0f91ff1876fa64864caa6.1574585281.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/24/19 1:58 AM, Pavel Begunkov wrote:
> Read/write requests to devices without implemented read/write_iter
> using fixed buffers causes general protection fault, which totally
> hangs a machine.
> 
> io_import_fixed() initialises iov_iter with bvec, but loop_rw_iter()
> accesses it as iovec, so dereferencing random address.
> 
> kmap() page by page in this case

This looks good to me, much cleaner/simpler. I've added a few pipe fixed
buffer tests to liburing as well. Didn't crash for me, but obvious
garbage coming out. I've flagged this for stable as well.

-- 
Jens Axboe

