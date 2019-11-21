Return-Path: <SRS0=BBHt=ZN=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59AAC432C0
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 15:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA5AA20674
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 15:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="rCtiVDCD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfKUPXh (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 21 Nov 2019 10:23:37 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:37047 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfKUPXh (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 21 Nov 2019 10:23:37 -0500
Received: by mail-il1-f193.google.com with SMTP id s5so3648908iln.4
        for <io-uring@vger.kernel.org>; Thu, 21 Nov 2019 07:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UpfAosZS6iQlPtZZS9GXKULQxVlO0K11DjbUJSUYewE=;
        b=rCtiVDCD3lxmRPxU1AA7Qh4uQzIhda/H0PXcR08RSvomAmdrKFXtpa+cM0x8YLtPNO
         amwl58xEln7YqGdKcSc4J7A9wBGDWXvxwYX+fSCUP1pqLZ70pDi1yel0IfWoa+l9S6H8
         fPN5IKm3kBjTSJFjkjes/CqJuVrgF4tRLA/HcumE7e9wV9sIBYOiNrGeuBnmj6yr8n6l
         t/zy/hlgkrsXQievUH3GjMRnYoE3BU13IAN4v44OzI0a7zwG8YJ4wrxQY4+4hYgqQ2g0
         p/vVY1dbWcQaUCQMoxlnxKpWPAtD9GjVPg5QVOOyVwn5bIlr0dvcGT/4TvoW78oEa8ED
         GJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UpfAosZS6iQlPtZZS9GXKULQxVlO0K11DjbUJSUYewE=;
        b=lH/ghA+0ujyRvCLBt3EAcisNIPC21yg4aVfIgqFwOw5+18C1uez9YWnkfZyWQVneoJ
         LoT5nLozkg5a/o5g+LI6ZKg2bH18sBCAyXEm9NI8RCsmz6UndsYltKzrpdoQlpvaTYMJ
         52NOT8q9xyC3WL73+9dZkpYxGUtjFGs+EjyDdaIAzWiz5MVqaYdSQh5eAqyTOAaab0Nb
         SeQbThOPaiRAtq1SZTfrB5oUjeHblI/AiDVqhzEE0Wt6hokpcjNjRN/Ekjo+/RnVSomG
         mO5IXMU5wXUzos14h2ntglBWbZTIP2Tvv6MiVQ/rFzRxO3dpoSzHikusEr1mL2IEaTc7
         Rocg==
X-Gm-Message-State: APjAAAX8R8xsZXqREc8NB9uVeEgDcraw1UIdGo2VnnJpML1Hunkmjalj
        OqfJ2lAe06FGxFF6eWRDFkclsYUTxNQEuw==
X-Google-Smtp-Source: APXvYqwHNvfOBs35aMIxk7k5j+GzBpdj0SqfvpXEG6Go/5GcBFadBtvsSN8Fp4pVFBYQ6Lu8uZno5A==
X-Received: by 2002:a92:1b49:: with SMTP id b70mr10413090ilb.180.1574349815178;
        Thu, 21 Nov 2019 07:23:35 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id z10sm1293745ill.73.2019.11.21.07.23.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 07:23:34 -0800 (PST)
Subject: Re: [PATCH] io_uring: introduce add/post event and put function
To:     Bob Liu <bob.liu@oracle.com>
Cc:     io-uring@vger.kernel.org
References: <20191121090004.20139-1-bob.liu@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c8e29da5-7f87-5e1d-6f1a-9b0cf4120120@kernel.dk>
Date:   Thu, 21 Nov 2019 07:05:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191121090004.20139-1-bob.liu@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/21/19 2:00 AM, Bob Liu wrote:
> * Only complie-tested right now. *
> There are so many duplicated code doing add/post event and then put req.
> Put them to common funcs io_cqring_event_posted_and_put() and
> io_cqring_add_event_and_put().
> 
> Signed-off-by: Bob Liu <bob.liu@oracle.com>
> ---
>   fs/io_uring.c | 145 ++++++++++++++++++++++++++++++----------------------------
>   1 file changed, 74 insertions(+), 71 deletions(-)
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 299a218..816eef3 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -1039,6 +1039,56 @@ static void io_double_put_req(struct io_kiocb *req)
>   		io_free_req(req);
>   }
>   
> +/*
> + * Add event to io_cqring and put req.
> + */
> +static void io_cqring_add_event_and_put(struct io_kiocb *req, long ret,
> +		int should_fail_link, bool double_put, struct io_kiocb **nxt)
> +{
> +	if (should_fail_link == 1) {
> +		if (ret < 0 && (req->flags & REQ_F_LINK))
> +			req->flags |= REQ_F_FAIL_LINK;
> +	} else if (should_fail_link == 2) {
> +		/* Don't care about ret < 0 when should_fail_link == 2 */
> +		if (req->flags & REQ_F_LINK)
> +			req->flags |= REQ_F_FAIL_LINK;
> +	}
> +
> +	io_cqring_add_event(req, ret);
> +
> +	if (double_put)
> +		io_double_put_req(req);
> +	else {
> +		if (nxt)
> +			io_put_req_find_next(req, nxt);
> +		else
> +			io_put_req(req);
> +	}
> +}

I'd really like to clean up this part, as it's both duplicated a lot and
also fragile in terms of places forgetting to do part of the necessary
dance. However, this helper is a bit of a monster (and the other one as
well), it's hard to know what this does:

	io_cqring_add_event_and_put(req, ret, 1, false, nxt);

without looking up what '1' and 'false' might be. Having multiple int
values for should_fail_link is also a bit, well, tricky. Maybe it needs
to be two helpers?

And if it does need something like 'should_fail_link', I think that'd be
done cleaner by using some sort of mask. IO_PUT_ERROR_ON_NEGATIVE,
IO_PUT_ERROR_ALWAYS, or something like that. Then you can tell in the
caller what it's going to do, rather than having to look up if what '1'
or '2' as the argument means.

-- 
Jens Axboe

