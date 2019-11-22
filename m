Return-Path: <SRS0=nrYQ=ZO=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A67AC432C0
	for <io-uring@archiver.kernel.org>; Fri, 22 Nov 2019 10:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4067020707
	for <io-uring@archiver.kernel.org>; Fri, 22 Nov 2019 10:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OF500KGz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfKVKFZ (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:05:25 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43200 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbfKVKFZ (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 22 Nov 2019 05:05:25 -0500
Received: by mail-lj1-f196.google.com with SMTP id y23so6654974ljh.10
        for <io-uring@vger.kernel.org>; Fri, 22 Nov 2019 02:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fK8nXGbqnwn6/kGKiosk9+jAWEArnZmA9NGQC4b8ed4=;
        b=OF500KGzLWUmM7r+vmO1DfzlYb4yRovOsnLpyJXpTOXAoTqvrG5J8Xeocv+lKvcFOf
         jh9yJmq/dK21U57GYEJXyKn65rdiiFw2sqtIahwSlVk3gy+fT6MYO7UK1spZpvQGSjNm
         RGWsN+jjs/q8a/9G3KrseAoUNma6nvI33BPdqTA9bam+UrZCeNv2W5lw9pyhGGWbaOtS
         BvkqLheJQOoV9gW6ssDmOSot/W2d8y980h7gbCVDDETqeLR8f5BDDU5hsSLoOxsNUTfB
         P2HN3GyTVmKtqx8WgejhzzKkB57gCDgMUvPd7K037UwWGzVJfVlvj+8xz5B00vPry4hG
         Tq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fK8nXGbqnwn6/kGKiosk9+jAWEArnZmA9NGQC4b8ed4=;
        b=Zq9JmHGfDsgGrBvR+px1rleF3nns/WHnEJ94DYAQG/igxoP5bMwqtTpIuwaOWIvFoH
         TstWkJcHqZmqODaSGbZ4SKtWj4k9T240XGr20mijUg396x5h9I6CpNajyg2a0Yb70ulD
         oH2xYbNz5Ytywiss6YdHcC/Hn08tY4WAv1gIt9EpoZ0i5raBAai2TjzX9ISq/iBauRls
         iomemZUuvDcbd6/ZkBOb1O3UapdxRQbYX/O/TQjD3BvwVeVwc/i4yA6hTbHlU3/+lM85
         LxZlUsLQKQZ/K6v1XKWFlMIXSrygd9wVWPDfa8zVUTGJDvWztE9riYRjN/riNndFsI/d
         ieDA==
X-Gm-Message-State: APjAAAWbP0FC7cfFExnIsug59omfPypwSwRB5iklzxsXdTyTpxJN6aYr
        2Jq5dIwY5zMFhREg7n4QrASziPpBReM=
X-Google-Smtp-Source: APXvYqzSjP49Rm7abK0kMQ5R8LceMS0tj2ZiR9L29zNZMqIw2KlSBNxaStdxW9WEh1WEXaYAuBkbEg==
X-Received: by 2002:a2e:7c10:: with SMTP id x16mr11598225ljc.120.1574417122774;
        Fri, 22 Nov 2019 02:05:22 -0800 (PST)
Received: from [172.31.190.83] ([86.57.146.226])
        by smtp.gmail.com with ESMTPSA id i8sm2814373lfl.80.2019.11.22.02.05.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Nov 2019 02:05:22 -0800 (PST)
Subject: Re: [PATCH RESEND] io_uring: a small optimization for
 REQ_F_DRAIN_LINK
To:     Jackie Liu <jackieliu@byteisland.com>, axboe@kernel.dk
Cc:     io-uring@vger.kernel.org, liuyun01@kylinos.cn
References: <20191122060129.40251-1-jackieliu@byteisland.com>
 <20191122060129.40251-2-jackieliu@byteisland.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Message-ID: <4132c196-afd5-4ac8-0842-2746cc9e4a6f@gmail.com>
Date:   Fri, 22 Nov 2019 13:05:20 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191122060129.40251-2-jackieliu@byteisland.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/22/2019 9:01 AM, Jackie Liu wrote:
> From: Jackie Liu <liuyun01@kylinos.cn>
> 
> We don't need to set drain_next every time, make a small judgment
> and add unlikely, it looks like there will be a little optimization.
> 
Not sure about that. It's 1 CMP + 1 SETcc/STORE, which works pretty fast
as @drain_next is hot (especially after read) and there is no write-read
dependency close. For yours, there is likely always 3 CMPs in the way.

Did you benchmarked it somehow or compared assembly?

> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> ---
>  resend that patch, because reject by mail-list.
> 
>  fs/io_uring.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 013e5ed..f4ec44a 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -2938,12 +2938,14 @@ static void __io_queue_sqe(struct io_kiocb *req)
>  static void io_queue_sqe(struct io_kiocb *req)
>  {
>  	int ret;
> +	bool drain_link = req->flags & REQ_F_DRAIN_LINK;
>  
> -	if (unlikely(req->ctx->drain_next)) {
> +	if (unlikely(req->ctx->drain_next && !drain_link)) {
>  		req->flags |= REQ_F_IO_DRAIN;
>  		req->ctx->drain_next = false;
> +	} else if (unlikely(drain_link)) {
> +		req->ctx->drain_next = true;
>  	}
> -	req->ctx->drain_next = (req->flags & REQ_F_DRAIN_LINK);
>  
>  	ret = io_req_defer(req);
>  	if (ret) {
> 

-- 
Pavel Begunkov
