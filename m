Return-Path: <SRS0=FaGP=ZG=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1E6C432C3
	for <io-uring@archiver.kernel.org>; Thu, 14 Nov 2019 15:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B4F2070E
	for <io-uring@archiver.kernel.org>; Thu, 14 Nov 2019 15:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="YYwFxPD3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfKNPTP (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 14 Nov 2019 10:19:15 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40282 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfKNPTP (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 14 Nov 2019 10:19:15 -0500
Received: by mail-lf1-f65.google.com with SMTP id j26so5365967lfh.7
        for <io-uring@vger.kernel.org>; Thu, 14 Nov 2019 07:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0NujF1wAXF2JIet6WLIXpPzdUrZwekW5h9mwXEr+UsI=;
        b=YYwFxPD3YUR34X4oiPjQohfpHR/s6FaTBaPnReoMP4yFgx+sgW1owlBpyNaD7rIfGC
         dUvFhybflk2eHVZjavhYVj1WfcrmNApq6bpHyo8ZFaCaCCVJM+KgpIN6Ce+wLeFSMwnh
         TcererLhO0iEEubqeqd2PNcozCbdt1Rb7va+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0NujF1wAXF2JIet6WLIXpPzdUrZwekW5h9mwXEr+UsI=;
        b=p34xkcXhKlwAiOqTkypXzIFysis6d6c+w2qdvo6CZcpFQO/7DjSZFJ4fHqg9Xl01mV
         f/a8wxcV6kT2cuEeStex83IHcK/9qf3oXeXSgp5erhRN9tzWpwlak1XN8cKHRHUmbfvJ
         8NFyHEbs439yxjKCb3qXr32FexRlrmC+FrhdfzyYysHr8HBngi0pFmnJLMpItpPvXOTq
         DDm80dtrqzv5xEzBNhXJW9hdG2exKC4ZDNuIAdR8lhXsoz7uON9Ebi4GBB/F22ZkkLee
         TPx1vnTwy5DwWjEdqDsgh8cviLzgnVY0i3iXwNSMNiL7a0mwrGH1LcHsBKJg804ozAYJ
         qqmw==
X-Gm-Message-State: APjAAAVQkO/QkFr+bzSLBqxVdaPkP93yCm6AbrCQF2fsVD8zbc9Lf4RP
        U4VVEnpgUVGGCReKLThMZJDCKQvWMy9gpeit
X-Google-Smtp-Source: APXvYqyCZZxBaGAWE0PNQnpZXLXjGCTqU2syj2jb6dXMNZVUaDASiCUu8KHB6xHiemlcWf9LlXXKhQ==
X-Received: by 2002:a05:6512:21e:: with SMTP id a30mr7682656lfo.76.1573744752947;
        Thu, 14 Nov 2019 07:19:12 -0800 (PST)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id a28sm2842754lfk.29.2019.11.14.07.19.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 07:19:12 -0800 (PST)
Subject: Re: [PATCH RFC] io_uring: make signalfd work with io_uring (and aio)
 POLL
To:     Jens Axboe <axboe@kernel.dk>, Jann Horn <jannh@google.com>
Cc:     io-uring@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <58059c9c-adf9-1683-99f5-7e45280aea87@kernel.dk>
 <58246851-fa45-a72d-2c42-7e56461ec04e@kernel.dk>
 <ec3526fb-948a-70c0-4a7b-866d6cd6a788@rasmusvillemoes.dk>
 <CAG48ez3dpphoQGy8G1-QgZpkMBA2oDjNcttQKJtw5pD62QYwhw@mail.gmail.com>
 <ea7a428d-a5bd-b48e-9680-82a26710ec83@rasmusvillemoes.dk>
 <e568a403-3712-4612-341a-a6f22af877ae@kernel.dk>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <0f74341f-76fa-93ee-c03e-554d02707053@rasmusvillemoes.dk>
Date:   Thu, 14 Nov 2019 16:19:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e568a403-3712-4612-341a-a6f22af877ae@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 14/11/2019 16.09, Jens Axboe wrote:
> On 11/14/19 7:12 AM, Rasmus Villemoes wrote:

>> So, I can't really think of anybody that might be relying on inheriting
>> a signalfd instead of just setting it up in the child, but changing the
>> semantics of it now seems rather dangerous. Also, I _can_ imagine
>> threads in a process sharing a signalfd (initial thread sets it up and
>> blocks the signals, all threads subsequently use that same fd), and for
>> that case it would be wrong for one thread to dequeue signals directed
>> at the initial thread. Plus the lifetime problems.
> 
> What if we just made it specific SFD_CLOEXEC?

O_CLOEXEC can be set and removed afterwards. Sure, we're far into
"nobody does that" land, but having signalfd() have wildly different
semantics based on whether it was initially created with O_CLOEXEC seems
rather dubious.

 I don't want to break
> existing applications, even if the use case is nonsensical, but it is
> important to allow signalfd to be properly used with use cases that are
> already in the kernel (aio with IOCB_CMD_POLL, io_uring with
> IORING_OP_POLL_ADD). Alternatively, if need be, we could add a specific
> SFD_ flag for this.

Yeah, if you want another signalfd flavour, adding it via a new SFD_
flag seems the way to go. Though I can't imagine the resulting code
would be very pretty.

Rasmus
