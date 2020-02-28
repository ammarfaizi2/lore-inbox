Return-Path: <SRS0=enxk=4Q=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5198C3F2D2
	for <io-uring@archiver.kernel.org>; Fri, 28 Feb 2020 15:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6820424691
	for <io-uring@archiver.kernel.org>; Fri, 28 Feb 2020 15:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="HRJdx7UN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgB1PZ6 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 28 Feb 2020 10:25:58 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:38372 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgB1PZ6 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 28 Feb 2020 10:25:58 -0500
Received: by mail-il1-f195.google.com with SMTP id f5so3034612ilq.5
        for <io-uring@vger.kernel.org>; Fri, 28 Feb 2020 07:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=UxUEo8VZVMMSSOyaagrTJL5Nfl5EZ+5Dxk9wUCE7dIY=;
        b=HRJdx7UNPFaEurKKt98sBL9lFVaIhBdJBL1vFJukWJw7kwvKA8LNx7s/GHynf89uX8
         1IjWIUVzS4mb/voquxIdKzcCTY1vjy2qbFfGmTBYPMnX8a7HS2ikBTgksEd0EMd4PrPb
         0F1lxwIUhRlXP8YEyre9hrh5MPVxnvDVz87H6y4tVmBS+Kghh0dKGhX2WmiNDYRHizg1
         HSSyjmlsmAUR/S+zJb70X7qeBu9YE/ABWQftydtmgCglZyaWdJnlizIZwGKsyw4hXe7t
         +HsUwdnmwIHVFMg8e6PHaCmORnLIpecYiDqIziFrba6AvBWr/8A4CXvL7IfrbTNKg6q5
         tUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UxUEo8VZVMMSSOyaagrTJL5Nfl5EZ+5Dxk9wUCE7dIY=;
        b=cOFfk//XcKXgjlP+ipeWLUe1d+oa3Bkogo8Rrx1rZmpAUatWhu92/l9L7/NRr2i8nQ
         xF0ajGLOEnHQ39VpFgVLmDd4p3MHcE0fvrVYz0iG5mTUxQQeTSC5fpPbiiwiUv8CQ3eb
         hMOwfD6QL2Hd0GCw2eTvQpnJyNJbpoOzD7VfS2MrrnFO5Edt8HfsywUh6L1bQwY1Ojda
         Fxe5z9zTOem00MKawkDaYFsl4Ytuk6NfkX1+2spRR30cHex6BhC9gWqEXeGnFugWNEqz
         6rzkKLdwXmhoj1qbVcMojvoevT/Efvb0k2LYhsPeU10t9X7LyBahy/zwG7Ffvt7o1kE7
         30eg==
X-Gm-Message-State: APjAAAW5Hm/fkCGQ2s1l4eMmdWlpL5CxW70T9oip1Xj1+Iucenpa09eb
        fWsT8xCaiBtJ1dHEPgZfRzyzVw==
X-Google-Smtp-Source: APXvYqwtFEoC5ID1lcCVdG6GYkDBrOVEJnM1drnuWSCzc4+ix2SNh60uDIPa51MszxV/EfXRAjfkfQ==
X-Received: by 2002:a92:d244:: with SMTP id v4mr5070409ilg.114.1582903555745;
        Fri, 28 Feb 2020 07:25:55 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u5sm2319320ion.51.2020.02.28.07.25.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2020 07:25:55 -0800 (PST)
Subject: Re: Issue with splice 32-bit compatability?
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring <io-uring@vger.kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>
References: <ea81e4f4-59d2-fa8e-2b5c-0c215c378850@kernel.dk>
Message-ID: <1f39b13b-d3c0-d731-35f7-0aaadec1c14e@kernel.dk>
Date:   Fri, 28 Feb 2020 08:25:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <ea81e4f4-59d2-fa8e-2b5c-0c215c378850@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 2/28/20 8:16 AM, Jens Axboe wrote:
> Hey Pavel,
> 
> Since I yesterday found that weirdness with networking and using
> a separate flag for compat mode, I went to check everything else.
> Outside of all the syzbot reproducers not running in 32-bit mode,
> the only other error was splice:
> 
> splice: returned -29, expected 16384
> basic splice-copy failed
> test_splice failed -29 0
> Test splice failed with ret 227
> 
> Can you take a look? I just edit test/Makefile and src/Makefile and
> add -m32 to the CFLAGS for testing.

It's in the liburing prep, fixed it:

https://git.kernel.dk/cgit/liburing/commit/?id=566180209fc4d9e3ee8852315a4411ee0c3d5510

-- 
Jens Axboe

