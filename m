Return-Path: <SRS0=jdTg=ZM=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D29C432C3
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 12:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 368222251F
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 12:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaoEjLNM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbfKTMmw (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 20 Nov 2019 07:42:52 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38989 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729871AbfKTMmv (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 20 Nov 2019 07:42:51 -0500
Received: by mail-lj1-f194.google.com with SMTP id p18so27370581ljc.6
        for <io-uring@vger.kernel.org>; Wed, 20 Nov 2019 04:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=EFtXwyon43Z3dpKP9HAB5JxvCL+Cx8CiO4Bg85or/IU=;
        b=PaoEjLNMOYD/jewpcrNEtwU01G427C8yNeU01DZmKu18GSeG+feQeGmD1AW4stxi9i
         rSmJLar+xa54+PDUx373mkAM6LobXv0kYApVdp1xbYWZdXCn6q9DtdMoiFQo3yV7sRkt
         fGKamb/ygEo4rUicZY+E26T8r3ZeWmKtSzvKPIJTnBa/UJ1ubobEy1yxiLjNES3sFzGw
         I1d5TqIQMN/Ty+37GktWJE39Oe/OmWZ1uPQEvSJtl6vBxswrSzk9fsq+9EchE6HQ1DE5
         naV9R8nJZ6yoI5z/H3DYCUlPHrvVekffrIOjSTHq3EAjyXaC+CDMiSXLQkK65F6nrIx2
         C3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EFtXwyon43Z3dpKP9HAB5JxvCL+Cx8CiO4Bg85or/IU=;
        b=P8Q9P+rYNxcvZLrZkUlw/HiKVpL9Ev7UzEoc0Ap58FNmc8xbsNfLY5NZskxy/DCa+h
         Kd9F/NCEcHpTShfpGqJNGIa5+aA+qLIuqqgGBHict2nwJrln9A+yst93HPjb6BY04Gjr
         a6kZhP97oMUuy+l1FjXRUHzz+lFCZLzzJQcHFBnmEsmbSR1VxqweMDWeMzABx/6yFtfe
         HLG7/rhnSxfAapM2vRV4G9nM/W1CoWS5ZWQUVEp7SPOAxZknfFybnRDMGvp/5w7h+teF
         s6aa0dHHn5C+d/9MItHyGafiQo7s7fcTI2sBpMcH2og87cJwPpeFL6ubDKejxnrc5YAX
         4VRw==
X-Gm-Message-State: APjAAAWsOny25/KMsq9b4RTmvfeDOEROlnFMl5r9jiG3oJEbIOzpyLJe
        CLshKX7+uYvT5Xqk32FWKGJ2ZDaP
X-Google-Smtp-Source: APXvYqyk48Vknm6XUbKfU79IlgMGorWZTdAW57uGMvLsxGwJJkJo+QcdMQ+zECpHKxek5Wb0isGmxQ==
X-Received: by 2002:a2e:9151:: with SMTP id q17mr2676348ljg.156.1574253769622;
        Wed, 20 Nov 2019 04:42:49 -0800 (PST)
Received: from [172.31.190.83] ([86.57.146.226])
        by smtp.gmail.com with ESMTPSA id c22sm11785530ljk.43.2019.11.20.04.42.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 04:42:49 -0800 (PST)
Subject: Re: [PATCH 7/8] io_uring: fix sequencing issues with linked timeouts
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
References: <20191116015314.24276-1-axboe@kernel.dk>
 <20191116015314.24276-8-axboe@kernel.dk>
 <ccf48def-1a4a-9cb1-aa9a-467294487856@gmail.com>
 <b98a91cd-54c1-49ef-d75d-8007dcc470c1@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Message-ID: <66547def-073c-8c4f-da68-17be900a192d@gmail.com>
Date:   Wed, 20 Nov 2019 15:42:47 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <b98a91cd-54c1-49ef-d75d-8007dcc470c1@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/20/2019 1:13 AM, Jens Axboe wrote:
> On 11/19/19 1:51 PM, Pavel Begunkov wrote:
>> On 16/11/2019 04:53, Jens Axboe wrote:
>>> We have an issue with timeout links that are deeper in the submit chain,
>>> because we only handle it upfront, not from later submissions. Move the
>>> prep + issue of the timeout link to the async work prep handler, and do
>>> it normally for non-async queue. If we validate and prepare the timeout
>>> links upfront when we first see them, there's nothing stopping us from
>>> supporting any sort of nesting.
>>>
>>> Fixes: 2665abfd757f ("io_uring: add support for linked SQE timeouts")
>>> Reported-by: Pavel Begunkov <asml.silence@gmail.com>
>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>> ---
>>
>>> @@ -923,6 +942,7 @@ static void io_fail_links(struct io_kiocb *req)
>>>   			io_cqring_fill_event(link, -ECANCELED);
>>>   			__io_double_put_req(link);
>>>   		}
>>> +		kfree(sqe_to_free);
>>>   	}
>>>   
>>>   	io_commit_cqring(ctx);
>>> @@ -2668,8 +2688,12 @@ static void io_wq_submit_work(struct io_wq_work **workptr)
>>>   
>>>   	/* if a dependent link is ready, pass it back */
>>>   	if (!ret && nxt) {
>>> -		io_prep_async_work(nxt);
>>> +		struct io_kiocb *link;
>>> +
>>> +		io_prep_async_work(nxt, &link);
>>>   		*workptr = &nxt->work;
>> Are we safe here without synchronisation?
>> Probably io_link_timeout_fn() may miss the new value
>> (doing io-wq cancel).
> 
> Miss what new value? Don't follow that part.
> 

As I've got the idea of postponing:
at the moment of io_queue_linked_timeout(), a request should be either
in io-wq or completed. So, @nxt->work after the assignment above should
be visible to asynchronously called io_wq_cancel_work().

>>>  *workptr = &nxt->work;
However, there is no synchronisation for this assignment, and it could
be not visible from a parallel thread. Is it somehow handled in io-wq?

The pseudo code is below (th1, th2 - parallel threads)
th1: *workptr = &req->work;
// non-atomic assignment, the new value of workptr (i.e. &req->work)
// isn't yet propagated to th2

th1: io_queue_linked_timeout()
th2: io_linked_timeout_fn(), calls io_wq_cancel_work(), @req not found
th2: // memory model finally propagated *workptr = &req->work to @th2


Please, let me know if that's also not clear.

> This should be safe, by the time the request is findable, we have
> made the necessary setup in io_prep_async_work().
> 

-- 
Pavel Begunkov
