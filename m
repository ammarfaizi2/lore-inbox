Return-Path: <SRS0=KDoC=Y5=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6C7C5DF62
	for <io-uring@archiver.kernel.org>; Tue,  5 Nov 2019 23:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB958217F4
	for <io-uring@archiver.kernel.org>; Tue,  5 Nov 2019 23:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="RIJkr9zS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbfKEXhG (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 5 Nov 2019 18:37:06 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42315 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbfKEXhF (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 5 Nov 2019 18:37:05 -0500
Received: by mail-pl1-f194.google.com with SMTP id j12so8532590plt.9
        for <io-uring@vger.kernel.org>; Tue, 05 Nov 2019 15:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=S9auKvEBV+sETFRScfOHE9qKwToRZk0DwQVCgin1pjI=;
        b=RIJkr9zSyIj1CHnDcygWA/9vvKZWqAW2lo74Ql+ezt50vcBSURve4kotRVR6MH4dlf
         vC9CGC1FqXM0eb0huTvLf0932S88Y7rR+bbOB4K+LONJRxxMCuWi2xh/y88l5v6NTrHa
         xaSS7Ru/wlbhvv7F/u9UAPnkBMAW/Fz8s9Yijm12JOFUz436tjkyMZl3WCAXHHc+k8Z2
         Ull0auvMwJDKemH3GiV6vykHWLmVT0wmYbdwTY6OMQok6svq6FkUqSCJwE2mimzuPiJg
         XWu28tSWmnEQ3PWA+74tHOEry6gMuejJR2vdBcN35Ak7WkGNOzZDD+IoTvC+brWj6xOX
         L9/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S9auKvEBV+sETFRScfOHE9qKwToRZk0DwQVCgin1pjI=;
        b=TtC99JV70h8ELDpi1guK4G9MlKC1ZTKcv5UvJ7D46A5OVSY20UX1rtXTSuV+xM7cK5
         5N1G5BkTM3yECz1Kxrja2OwpJOczkv/EnoiiPTLypcfBtyGGwnEBR6ZgIS2YxuRGaxDc
         OcwZPT7mnBUPAOhxXz85w6dqrvFh6B5beJCsN3TW6bCnhtsLzhaSLSY9LoeA6kzSCp83
         phWNaYeGNwPS6iDkZOpoLG46BK9jmmdimASI+7+eDrDrpwWGs3KMZnO321pgEqGdeJ6W
         6nZumKtyjO1upX2MPntmoEJ5wU5SiZiz9mgpC1tsnZdsIad79KR3QIpqvOIukDuklFYQ
         3atQ==
X-Gm-Message-State: APjAAAWhIMtswqkibfft7gMWMOaSXIREeZQw4lERItiJYIbwPDiR938N
        wShZ1pFa4I91ou1MXZFfiWTsdg==
X-Google-Smtp-Source: APXvYqyCGwOCnaBnVkkGbrJ03wjKeNCDjVSFvnr2vpVUd/DFdW9ljCGpq4IJ2aAocsNiyjh+TjJIOA==
X-Received: by 2002:a17:902:bcc2:: with SMTP id o2mr36554143pls.281.1572997023658;
        Tue, 05 Nov 2019 15:37:03 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1130::12c1? ([2620:10d:c090:180::d575])
        by smtp.gmail.com with ESMTPSA id x125sm24814559pfb.93.2019.11.05.15.37.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 15:37:02 -0800 (PST)
Subject: Re: [PATCH 3/3] io_uring: use inlined struct sqe_submit
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
References: <cover.1572993994.git.asml.silence@gmail.com>
 <e9f1f564ec60748c4ad266ec6bace9b2df392b58.1572993994.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <589994ea-6528-eac0-e0c6-b496ee5bebd2@kernel.dk>
Date:   Tue, 5 Nov 2019 16:37:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e9f1f564ec60748c4ad266ec6bace9b2df392b58.1572993994.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/5/19 4:04 PM, Pavel Begunkov wrote:
> @@ -2475,31 +2475,30 @@ static int __io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
>   	return ret;
>   }
>   
> -static int io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
> -			struct sqe_submit *s)
> +static int io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req)
>   {
>   	int ret;
>   
> -	ret = io_req_defer(ctx, req, s->sqe);
> +	ret = io_req_defer(ctx, req);
>   	if (ret) {
>   		if (ret != -EIOCBQUEUED) {
>   			io_free_req(req, NULL);
> -			io_cqring_add_event(ctx, s->sqe->user_data, ret);
> +			io_cqring_add_event(ctx, req->submit.sqe->user_data, ret);

Cases like these are now (or can be) use-after-free. Same with this one:

> @@ -2507,12 +2506,12 @@ static int io_queue_link_head(struct io_ring_ctx *ctx, struct io_kiocb *req,
>   	 * list.
>   	 */
>   	req->flags |= REQ_F_IO_DRAIN;
> -	ret = io_req_defer(ctx, req, s->sqe);
> +	ret = io_req_defer(ctx, req);
>   	if (ret) {
>   		if (ret != -EIOCBQUEUED) {
>   			io_free_req(req, NULL);
>   			__io_free_req(shadow);
> -			io_cqring_add_event(ctx, s->sqe->user_data, ret);
> +			io_cqring_add_event(ctx, req->submit.sqe->user_data, ret);
>   			return 0;

Free the req, then deref it...

-- 
Jens Axboe

