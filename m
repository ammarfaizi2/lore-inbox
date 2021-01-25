Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C437DC433E0
	for <io-uring@archiver.kernel.org>; Mon, 25 Jan 2021 02:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E78E22C9F
	for <io-uring@archiver.kernel.org>; Mon, 25 Jan 2021 02:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbhAYCQ7 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sun, 24 Jan 2021 21:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbhAYCP2 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sun, 24 Jan 2021 21:15:28 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56923C061573
        for <io-uring@vger.kernel.org>; Sun, 24 Jan 2021 18:14:47 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id kx7so7425328pjb.2
        for <io-uring@vger.kernel.org>; Sun, 24 Jan 2021 18:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=3GdZzw46kNdjktXMP42s3j55+/TA3B0c+2ZwbJSawas=;
        b=JyVYmSSPN0cZDY5AylWrIvQSPCCUmhWXtxunZxQGRqr/523/qlsxRdkPmw6sitfO3R
         8NkM7gCzgT7EBenXgB3N9UKG1EfgcuqtOCCpCKrX0BmAOUe6ENEmlHgRbebfSMqcaEz9
         5i5ETIDv3Cq1xYLpX1eAh9i0kDqOts38BdVQkZo7PHGjFQFA2vD5ck9tr+dUlF4QAQt1
         VCR61LTZmwSAt6fZy+dPQTpW36bn3NWeWoU4BkGBQLPypI0WdXOnIIcW1jaCYsC0UIiX
         Hr6oUKCLt4zCWDgN39dDJ3yKIEzNzePN6cj/X5Rc4yFlgHsFY/GnEq/lIzD7PjMO/X0F
         BI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3GdZzw46kNdjktXMP42s3j55+/TA3B0c+2ZwbJSawas=;
        b=ppWgIjGeeTjiVft6EqjrG/1keOGyOkerBcoq3H0NAtOzqYJWAt/oFTTyckpAiTwe6W
         MAL14FUUN+dFW1011qIvQoob0SDYA/GbeO4ZYM1JUJ5yJ0H6rsFh/RTcMXgmmo7MAjB/
         BETYMK55sEKqjMPeBwDXcPCT55OrldOrwZiXZ5fXJ/T2RJzzjGGaTjaAm+OIq6zW5ijI
         ujBiMI8IowiFXj+2oi6j3EQ3Qxy7RfKj7jNPsnig+AZPUi4N8cGc80RJMSXQz4R3YRo/
         0nGT8pePZs0t4FD8cEgpzlEXFv3qYIaq06xmzvFON2dVb3+obdxN7cNNuRzgBE1BCQQc
         97pg==
X-Gm-Message-State: AOAM530grg1cnjL6kTl+7Fjycx/Uhv1Bzdn0fCpRcCbshmJHxkIwr3uI
        ILtZki7JNbeMf8/AZQ796oej6qid6oo=
X-Google-Smtp-Source: ABdhPJzvy8LOduUZPVQL2cyMCdWQtYGPJNC7lwofLLm8u1+hHD6btRyzw3PIJq2jUdqvWjpc2kw8sA==
X-Received: by 2002:a17:902:854b:b029:db:c725:edcd with SMTP id d11-20020a170902854bb02900dbc725edcdmr17585937plo.64.1611540886522;
        Sun, 24 Jan 2021 18:14:46 -0800 (PST)
Received: from B-D1K7ML85-0059.local ([47.89.83.84])
        by smtp.gmail.com with ESMTPSA id bj18sm16210774pjb.40.2021.01.24.18.14.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jan 2021 18:14:45 -0800 (PST)
Subject: Re: [PATCH 0/3] files cancellation cleanup
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
References: <cover.1611109718.git.asml.silence@gmail.com>
 <246d838d-0fce-d3c3-dcfc-9cbf9fa72de1@gmail.com>
 <55e5491c-73c3-8d13-e3d1-056a2506f285@gmail.com>
From:   Joseph Qi <jiangqi903@gmail.com>
Message-ID: <4ddd9aa4-bbdd-9730-f1b9-7a26ccaaf842@gmail.com>
Date:   Mon, 25 Jan 2021 10:14:42 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <55e5491c-73c3-8d13-e3d1-056a2506f285@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org



On 1/23/21 5:49 AM, Pavel Begunkov wrote:
> On 22/01/2021 09:45, Joseph Qi wrote:
>> Seems this series can also resolve a possible deadlock case I'm looking
>> into.
> 
> It removes dead code, I believe your issue is solved by
> ("io_uring: get rid of intermediate IORING_OP_CLOSE stage")
> https://git.kernel.dk/cgit/linux-block/commit/?h=for-5.12/io_uring&id=7be8ba3b656cb4e0158b2c859b949f34a96aa94f
> 
I've tested the above commit and the mentioned possible deadlock still
exists.

> Did you try this series in particular, or tested for-5.12/io_uring
> and see that the issue is gone there?
> 
I don't have this tree locally and it takes too long to clone it down.
Will check once it is ready.

Thanks,
Joseph

>> CPU0:
>> ...
>> io_kill_linked_timeout  // &ctx->completion_lock
>> io_commit_cqring
>> __io_queue_deferred
>> __io_queue_async_work
>> io_wq_enqueue
>> io_wqe_enqueue  // &wqe->lock
>>
>> CPU1:
>> ...
>> __io_uring_files_cancel
>> io_wq_cancel_cb
>> io_wqe_cancel_pending_work  // &wqe->lock
>> io_cancel_task_cb  // &ctx->completion_lock
>>
