Return-Path: <SRS0=FaGP=ZG=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2BDC43141
	for <io-uring@archiver.kernel.org>; Thu, 14 Nov 2019 22:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC93D20723
	for <io-uring@archiver.kernel.org>; Thu, 14 Nov 2019 22:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="esgM0imz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfKNWhx (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 14 Nov 2019 17:37:53 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38301 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfKNWhx (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 14 Nov 2019 17:37:53 -0500
Received: by mail-pg1-f195.google.com with SMTP id 15so4703268pgh.5
        for <io-uring@vger.kernel.org>; Thu, 14 Nov 2019 14:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WHEKuRwdwFuaBKUDx31x4muu+MSJwHXWEO9GkaCswBE=;
        b=esgM0imzInnpYjllAU7+ABcJ/xWVzy+Z06dmrfdpTH3pKyibZ51cI9HIOGuAU+PyUg
         S9OOoGAEk7ze4ld2VSLXd2K5tZjarHv6YYQpsYeMecxvIp7vdib6T+49m/92ipUdeQW8
         9EBDzQ2h7f2mUMbqgQbXnYizs6GItlZ7eR8lFzDnz8cq6V52TskhC9BWyXJm8/ojNyYQ
         30bDW8FyFo/eLCTm4mnQPfNUi3hy0++kLaQ57KTWEKbU99suPDctA5CuYjM6Pj7ROnZe
         +erwM4i+u3PJ7MsYzyZmSJUofZu1En5kArwjjfna2CROB+7KXaLo0rfMxvSKLyJ4Chr9
         Ef1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WHEKuRwdwFuaBKUDx31x4muu+MSJwHXWEO9GkaCswBE=;
        b=ELjKe4Ncz9/QvsTfUdgstd9e6jlFU5paofKerXT2ehqV9hGrOkOG30K8LEDaUSDqsK
         JmDlictTIx2MyKmv4wKsMpb63gQh4pOL4lIdRe+xkTmMbtSQby9aU0Yk7Nf4E1xb+lMm
         TnZmlIkfFBUBDSalwJADkDk3DNs6MMPLSCPwI0KagWtQ1ROSTcCGLYaFu2Bj8jXSswwA
         xwoXiB5dVrdiE5O2Wh8p/yltcakpevN8TQ/WkzZ7YZ1tIdvyiGjIlVwy5HMzq261hdp8
         MAqDEN5B0HeApdnx9oxB6lWQPmJeL36EHoIOhOiN/+/Fv2wz2NI9/7sYdodW6+1eBCKi
         4kfg==
X-Gm-Message-State: APjAAAXh5jqym72WJKtHoIWJDCVAUVRJxChmi2tZAZ1s0KfJQCOMg+aU
        g4MWvRPuxOWVyuJsTSe0q2dhVA==
X-Google-Smtp-Source: APXvYqyr24GR4ZhsgU6PexCPatC0ERgkJRa5rZIq6gsr6UtAG4c/9nwdhOy8OxvgyD/+ejCteFdsrw==
X-Received: by 2002:a17:90a:de4:: with SMTP id 91mr15732947pjv.113.1573771070487;
        Thu, 14 Nov 2019 14:37:50 -0800 (PST)
Received: from ?IPv6:2600:380:755f:544d:7096:f49a:6c51:d149? ([2600:380:755f:544d:7096:f49a:6c51:d149])
        by smtp.gmail.com with ESMTPSA id e17sm8020947pfh.121.2019.11.14.14.37.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 14:37:49 -0800 (PST)
Subject: Re: [PATCHSET 0/2] io_uring support for linked timeouts
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     zeba.hrvoje@gmail.com, liuyun01@kylinos.cn
References: <20191105211130.6130-1-axboe@kernel.dk>
 <4566889a-7e12-9bfd-b2a1-716d8b934684@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9b6cd06b-cd6c-d7e5-157b-32c1e2e9ceac@kernel.dk>
Date:   Thu, 14 Nov 2019 15:37:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <4566889a-7e12-9bfd-b2a1-716d8b934684@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/14/19 2:24 PM, Pavel Begunkov wrote:
> On 06/11/2019 00:11, Jens Axboe wrote:
>> Anyway, this is support for IORING_OP_LINK_TIMEOUT. Unlike the timeouts
>> we have now that work on purely the CQ ring, these timeouts are
>> specifically tied to a specific command. They are meant to be used to
>> auto-cancel a request, if it hasn't finished in X amount of time. The
>> way to use then is to setup your command as you usually would, but then
>> mark is IOSQE_IO_LINK and add an IORING_OP_LINK_TIMEOUT right after it.
>> That's how linked commands work to begin with. The main difference here
>> is that links are normally only started once the dependent request
>> completes, but for IORING_OP_LINK_TIMEOUT they are armed as soon as we
>> start the dependent request.
>>
>> If the dependent request finishes before the linked timeout, the timeout
>> is canceled. If the timeout finishes before the dependent request, the
>> dependent request is attempted canceled.
>>
>> IORING_OP_LINK_TIMEOUT is setup just like IORING_OP_TIMEOUT in terms
>> of passing in the timespec associated with it.
>>
>> I added a bunch of test cases to liburing, currently residing in a
>> link-timeout branch. View them here:
>>
> 
> Finally got to this patch. I think, find it adding too many edge cases
> and it isn't integrated consistently into what we have now. I would love
> to hear your vision, but I'd try to implement them in such a way, that it
> doesn't need to modify the framework, at least for some particular case.
> In other words, as opcodes could have been added from the outside with a
> function table.

I agree, it could do with a bit of cleanup. Incrementals would be
appreciated!

> Also, it's not so consistent with the userspace API as well.
> 
> 1. If we specified drain for the timeout, should its start be delayed
> until then? I would prefer so.
>
> E.g. send_msg + drained linked_timeout, which would set a timeout from the
> start of the send.

What cases would that apply to, what would the timeout even do in this
case? The point of the linked timeout is to abort the previous command.
Maybe I'm not following what you mean here.

> 2. Why it could be only the second one in a link? May we want to cancel
> from a certain point?
> e.g. "op1 -> op2 -> timeout -> op3" cancels op2 and op3

Logically it need not be the second, it just has to follow another
request. Is there a bug there?

> 3. It's a bit strange, that the timeout affects a request from the left,
> and after as an consequence cancels everything on the right (i.e. chain).
> Could we place it in the head? So it would affect all requests on the right
> from it.

But that's how links work, though. If you keep linking, then everything
that depends on X will fail, if X itself isn't succesful.

> 4. I'd prefer to handle it as a new generic command and setting a timer
> in __io_submit_sqe().
> 
> I believe we can do it more gracefully, and at the same moment giving
> more freedom to the user. What do you think?

I just think we need to make sure the ground rules are sane. I'm going
to write a few test cases to make sure we do the right thing.

-- 
Jens Axboe

