Return-Path: <SRS0=PUae=Y6=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BEFC5DF62
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 09:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9CC62178F
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 09:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o7bvIPX7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbfKFJH6 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 6 Nov 2019 04:07:58 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42539 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728256AbfKFJH6 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 6 Nov 2019 04:07:58 -0500
Received: by mail-lj1-f195.google.com with SMTP id n5so14166160ljc.9;
        Wed, 06 Nov 2019 01:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=zZ7MPSYFFcpgmm3jeH3xqH+uZ+rJjnrkw2QVPvW4MTk=;
        b=o7bvIPX7gNt1ZEr0dSZOiVQrr8ABP81oaLG/Rfc3pMKvfXGP3rwADdvLyQ7HX89mOR
         /RNrVoq9FgFFdrp/Fv90167FP+dJ8qXMuszfhY0ApxM+N5AC1juWe5XPrBQm/k26bCJe
         jDIuECd0PUVIQgw9AKVpyMA2H3xGC00C1aktv6R/6qwDo4+t1hq8dS5iCuNzK+t1oNS6
         t95zyC6D02g+t7tqDJ7I9ExZ2KuG5TMNy+TSR9xirxMwzywf2zpbLzozIdA04RgFf55i
         kQ0pqfnRkWq30fJZjmUxVtEXL8p+XkkB9SDWTrv28NCpUEumWyGH2SlqMbqXmJZ3As76
         MF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zZ7MPSYFFcpgmm3jeH3xqH+uZ+rJjnrkw2QVPvW4MTk=;
        b=aDl+aaFwAX6dbvM2jgbHkvXmzoplNpzQvUivxtL8pkAPhjKvk2+XgXtvodBMG2ooL/
         aNwAyc51hyQCglqXMoMdAMJfSsi8Pxj5P0yvKMiRsdaPtAgGPILcH7UIP6h31sBTcsEn
         WykA3E8HcmZp0A0zrwifhvepnv6UniO1Zw0413LNn7wGV8n+etP+D+3f6ON+P14s3VT9
         Xq4eDazVnW/W76pGQgAPVHE0HSv9i6o0VxERYVse5YHLlbHIy0NfmAeftu2GUmMiOZZg
         /BVgPUrL9jjv+dEomBu5p0UnQnTMdRF2eqOORrzqzZ4sTyw916Ck529NGmFhwLRgIZEf
         st9g==
X-Gm-Message-State: APjAAAUSU4r0tYGflzspO4bVYZEBeNe7VWOWv+OemZ6oCwmjz2V1pqNe
        KPMoMeU7d1CuCK5jxRgI+owM8Vdvh4E=
X-Google-Smtp-Source: APXvYqw/qe+NGjrMB+1kcGS8zJR3OC5pgfpUt4m0VpiKHfCOixbv/7L870d3Qg59fulAFmfq5mVZxA==
X-Received: by 2002:a2e:9449:: with SMTP id o9mr1039632ljh.110.1573031275355;
        Wed, 06 Nov 2019 01:07:55 -0800 (PST)
Received: from [172.31.190.83] ([86.57.146.226])
        by smtp.gmail.com with ESMTPSA id 1sm7081281ljr.46.2019.11.06.01.07.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 01:07:54 -0800 (PST)
Subject: Re: [PATCH v2 1/2] io_uring: Merge io_submit_sqes and io_ring_submit
To:     Bob Liu <bob.liu@oracle.com>, Jens Axboe <axboe@kernel.dk>,
        io-uring@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1572988512.git.asml.silence@gmail.com>
 <09fcce1a50f4d1a399b903e3669ba98ede408d9c.1572988512.git.asml.silence@gmail.com>
 <4654948b-caac-3dc8-904c-ceb0c245d7c3@oracle.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Message-ID: <62cc24d9-0ace-3a9e-f8ed-9c2b8b920ba0@gmail.com>
Date:   Wed, 6 Nov 2019 12:07:53 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <4654948b-caac-3dc8-904c-ceb0c245d7c3@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/6/2019 11:57 AM, Bob Liu wrote:
> On 11/6/19 5:22 AM, Pavel Begunkov wrote:
>> io_submit_sqes() and io_ring_submit() are doing the same stuff with
>> a little difference. Deduplicate them.
>>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>> ---
>>  fs/io_uring.c | 88 +++++++++++----------------------------------------
>>  1 file changed, 18 insertions(+), 70 deletions(-)
>>
>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>> index 7813bc7d5b61..ebe2a4edd644 100644
>> --- a/fs/io_uring.c
>> +++ b/fs/io_uring.c
>> @@ -2681,7 +2681,8 @@ static bool io_get_sqring(struct io_ring_ctx *ctx, struct sqe_submit *s)
>>  }
>>  
>>  static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
>> -			  struct mm_struct **mm)
>> +			  struct file *ring_file, int ring_fd,
>> +			  struct mm_struct **mm, bool async)
>>  {
>>  	struct io_submit_state state, *statep = NULL;
>>  	struct io_kiocb *link = NULL;
>> @@ -2732,10 +2733,12 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
>>  		}
>>  
>>  out:
>> +		s.ring_file = ring_file;
>> +		s.ring_fd = ring_fd;
>>  		s.has_user = *mm != NULL;
>> -		s.in_async = true;
>> -		s.needs_fixed_file = true;
>> -		trace_io_uring_submit_sqe(ctx, s.sqe->user_data, true, true);
>> +		s.in_async = async;
>> +		s.needs_fixed_file = async;
>> +		trace_io_uring_submit_sqe(ctx, s.sqe->user_data, true, async);
>>  		io_submit_sqe(ctx, &s, statep, &link);
>>  		submitted++;
>>  	}
>> @@ -2745,6 +2748,9 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
>>  	if (statep)
>>  		io_submit_state_end(&state);
>>  
>> +	 /* Commit SQ ring head once we've consumed and submitted all SQEs */
>> +	io_commit_sqring(ctx);
>> +
> 
> Then don't need io_commit_sqring() in io_sq_thread any more?
>
Right, thanks! I'll resend with the change.


> Anyway, looks good to me.
> Reviewed-by: Bob Liu <bob.liu@oracle.com>
> 
>>  	return submitted;
>>  }
>>  
>> @@ -2849,7 +2855,8 @@ static int io_sq_thread(void *data)
>>  		}
>>  
>>  		to_submit = min(to_submit, ctx->sq_entries);
>> -		inflight += io_submit_sqes(ctx, to_submit, &cur_mm);
>> +		inflight += io_submit_sqes(ctx, to_submit, NULL, -1, &cur_mm,
>> +					   true);
>>  
>>  		/* Commit SQ ring head once we've consumed all SQEs */
>>  		io_commit_sqring(ctx);
>> @@ -2866,69 +2873,6 @@ static int io_sq_thread(void *data)
>>  	return 0;
>>  }
>>  
>> -static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit,
>> -			  struct file *ring_file, int ring_fd)
>> -{
>> -	struct io_submit_state state, *statep = NULL;
>> -	struct io_kiocb *link = NULL;
>> -	struct io_kiocb *shadow_req = NULL;
>> -	bool prev_was_link = false;
>> -	int i, submit = 0;
>> -
>> -	if (to_submit > IO_PLUG_THRESHOLD) {
>> -		io_submit_state_start(&state, ctx, to_submit);
>> -		statep = &state;
>> -	}
>> -
>> -	for (i = 0; i < to_submit; i++) {
>> -		struct sqe_submit s;
>> -
>> -		if (!io_get_sqring(ctx, &s))
>> -			break;
>> -
>> -		/*
>> -		 * If previous wasn't linked and we have a linked command,
>> -		 * that's the end of the chain. Submit the previous link.
>> -		 */
>> -		if (!prev_was_link && link) {
>> -			io_queue_link_head(ctx, link, &link->submit, shadow_req);
>> -			link = NULL;
>> -			shadow_req = NULL;
>> -		}
>> -		prev_was_link = (s.sqe->flags & IOSQE_IO_LINK) != 0;
>> -
>> -		if (link && (s.sqe->flags & IOSQE_IO_DRAIN)) {
>> -			if (!shadow_req) {
>> -				shadow_req = io_get_req(ctx, NULL);
>> -				if (unlikely(!shadow_req))
>> -					goto out;
>> -				shadow_req->flags |= (REQ_F_IO_DRAIN | REQ_F_SHADOW_DRAIN);
>> -				refcount_dec(&shadow_req->refs);
>> -			}
>> -			shadow_req->sequence = s.sequence;
>> -		}
>> -
>> -out:
>> -		s.ring_file = ring_file;
>> -		s.has_user = true;
>> -		s.in_async = false;
>> -		s.needs_fixed_file = false;
>> -		s.ring_fd = ring_fd;
>> -		submit++;
>> -		trace_io_uring_submit_sqe(ctx, s.sqe->user_data, true, false);
>> -		io_submit_sqe(ctx, &s, statep, &link);
>> -	}
>> -
>> -	if (link)
>> -		io_queue_link_head(ctx, link, &link->submit, shadow_req);
>> -	if (statep)
>> -		io_submit_state_end(statep);
>> -
>> -	io_commit_sqring(ctx);
>> -
>> -	return submit;
>> -}
>> -
>>  struct io_wait_queue {
>>  	struct wait_queue_entry wq;
>>  	struct io_ring_ctx *ctx;
>> @@ -4049,10 +3993,14 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
>>  			wake_up(&ctx->sqo_wait);
>>  		submitted = to_submit;
>>  	} else if (to_submit) {
>> -		to_submit = min(to_submit, ctx->sq_entries);
>> +		struct mm_struct *cur_mm;
>>  
>> +		to_submit = min(to_submit, ctx->sq_entries);
>>  		mutex_lock(&ctx->uring_lock);
>> -		submitted = io_ring_submit(ctx, to_submit, f.file, fd);
>> +		/* already have mm, so io_submit_sqes() won't try to grab it */
>> +		cur_mm = ctx->sqo_mm;
>> +		submitted = io_submit_sqes(ctx, to_submit, f.file, fd,
>> +					   &cur_mm, false);
>>  		mutex_unlock(&ctx->uring_lock);
>>  	}
>>  	if (flags & IORING_ENTER_GETEVENTS) {
>>
> 
