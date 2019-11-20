Return-Path: <SRS0=jdTg=ZM=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D892C432C0
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 18:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0803B2089D
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 18:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="qK1RCOAJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfKTSPS (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 20 Nov 2019 13:15:18 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:35936 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727671AbfKTSPS (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 20 Nov 2019 13:15:18 -0500
Received: by mail-io1-f66.google.com with SMTP id s3so242413ioe.3
        for <io-uring@vger.kernel.org>; Wed, 20 Nov 2019 10:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=VRItj2iBLmvrGSLZIWZoWzoMGPZoCk/v8xIyduFmlRc=;
        b=qK1RCOAJMb7KGtVYTbedUxEnTfXAxFYnOBOsATHcEFAy792tjXy7vlQMAUj5XQNvdy
         373OrA434vM42yY6LowPMd6mAxshNICmrf2InpiRqIdX3qblxWCQEogtFEuSH6LrQEQj
         1IxYGsl579C8dgoP3BycBlBNfG8a127YiwvaAyJvuMbWwiZT5rxR680T8OaG3lP5nGob
         KSwhfrEkZCQqPj9Zfzx3xBEB0MJTVa0gMtwQwMgsOKpspFKwYJKmXqKeoY1LKsUA9OtP
         Xci3emKjsMZi/MzUKscLtER3jWrJNYqKd/5/na8KpKaDVf6nwriTt43v1+K+DYKqkLOg
         CE4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VRItj2iBLmvrGSLZIWZoWzoMGPZoCk/v8xIyduFmlRc=;
        b=G9febTUGTsiMgrinZp5GCV3nEKuqc/JK6aplAUoALpk6PJt63/6X+q5daQ+zGjS+6g
         lnMBJZ+cK7xc/rzj73WG+NHzUBq6Xj4s+b7Io7gXxlGDPBiuMw8Q82KBGXODhta7fsH5
         tKbOgRxu55ghYjwxM8pEogZOFwXNbSiW76WPrz9IjSUIfHqp99K+OnGORhc7CUvtqcv2
         ukcRNYcB9yHplsImUwTlXK9cdPSSCvc8U615z3x6MJ05kQzUDdiT1vEEbpbGAmrhIVDi
         cGXQcQ2DUEpY928SY7RqkgJ/CPheqijuY3zN9jx29hVAzvyhteqpzVl6e8qR9JdsJUS3
         SbMA==
X-Gm-Message-State: APjAAAWmoLPEwgcoacwHoBicMWdZhXqlHQl5zuHTEzz+9xjYBYUzidNn
        R5d8KJmAigL2G0O2Xo1QNXBoKGh3v8M+Bg==
X-Google-Smtp-Source: APXvYqywZZ0K9skJylxgQdRLZwDXzb59SVFpZ5ejCjzpycNGYeu7bLJlIszRxrjBPI++oCLiDUCZkg==
X-Received: by 2002:a02:ca57:: with SMTP id i23mr4257218jal.36.1574273716854;
        Wed, 20 Nov 2019 10:15:16 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id z4sm5155640ioj.76.2019.11.20.10.15.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 10:15:16 -0800 (PST)
Subject: Re: [PATCH 7/8] io_uring: fix sequencing issues with linked timeouts
From:   Jens Axboe <axboe@kernel.dk>
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
References: <20191116015314.24276-1-axboe@kernel.dk>
 <20191116015314.24276-8-axboe@kernel.dk>
 <ccf48def-1a4a-9cb1-aa9a-467294487856@gmail.com>
 <b98a91cd-54c1-49ef-d75d-8007dcc470c1@kernel.dk>
 <66547def-073c-8c4f-da68-17be900a192d@gmail.com>
 <f961fd7a-53f1-37fe-f540-10a220535517@kernel.dk>
Message-ID: <8d118dd4-a4d9-c7ff-0441-b07696601015@kernel.dk>
Date:   Wed, 20 Nov 2019 11:15:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <f961fd7a-53f1-37fe-f540-10a220535517@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/20/19 10:19 AM, Jens Axboe wrote:
> On 11/20/19 5:42 AM, Pavel Begunkov wrote:
>> On 11/20/2019 1:13 AM, Jens Axboe wrote:
>>> On 11/19/19 1:51 PM, Pavel Begunkov wrote:
>>>> On 16/11/2019 04:53, Jens Axboe wrote:
>>>>> We have an issue with timeout links that are deeper in the submit chain,
>>>>> because we only handle it upfront, not from later submissions. Move the
>>>>> prep + issue of the timeout link to the async work prep handler, and do
>>>>> it normally for non-async queue. If we validate and prepare the timeout
>>>>> links upfront when we first see them, there's nothing stopping us from
>>>>> supporting any sort of nesting.
>>>>>
>>>>> Fixes: 2665abfd757f ("io_uring: add support for linked SQE timeouts")
>>>>> Reported-by: Pavel Begunkov <asml.silence@gmail.com>
>>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>>> ---
>>>>
>>>>> @@ -923,6 +942,7 @@ static void io_fail_links(struct io_kiocb *req)
>>>>>     			io_cqring_fill_event(link, -ECANCELED);
>>>>>     			__io_double_put_req(link);
>>>>>     		}
>>>>> +		kfree(sqe_to_free);
>>>>>     	}
>>>>>     
>>>>>     	io_commit_cqring(ctx);
>>>>> @@ -2668,8 +2688,12 @@ static void io_wq_submit_work(struct io_wq_work **workptr)
>>>>>     
>>>>>     	/* if a dependent link is ready, pass it back */
>>>>>     	if (!ret && nxt) {
>>>>> -		io_prep_async_work(nxt);
>>>>> +		struct io_kiocb *link;
>>>>> +
>>>>> +		io_prep_async_work(nxt, &link);
>>>>>     		*workptr = &nxt->work;
>>>> Are we safe here without synchronisation?
>>>> Probably io_link_timeout_fn() may miss the new value
>>>> (doing io-wq cancel).
>>>
>>> Miss what new value? Don't follow that part.
>>>
>>
>> As I've got the idea of postponing:
>> at the moment of io_queue_linked_timeout(), a request should be either
>> in io-wq or completed. So, @nxt->work after the assignment above should
>> be visible to asynchronously called io_wq_cancel_work().
>>
>>>>>    *workptr = &nxt->work;
>> However, there is no synchronisation for this assignment, and it could
>> be not visible from a parallel thread. Is it somehow handled in io-wq?
>>
>> The pseudo code is below (th1, th2 - parallel threads)
>> th1: *workptr = &req->work;
>> // non-atomic assignment, the new value of workptr (i.e. &req->work)
>> // isn't yet propagated to th2
>>
>> th1: io_queue_linked_timeout()
>> th2: io_linked_timeout_fn(), calls io_wq_cancel_work(), @req not found
>> th2: // memory model finally propagated *workptr = &req->work to @th2
>>
>>
>> Please, let me know if that's also not clear.
> 
> OK, so I see what you're saying, but I don't think it's missing locking.
> There is, however, a gap where we won't be able to find the request.
> What we need is a way to assign the io-wq current work before we call
> io_queue_linked_timeout(). Something ala:
> 
> 	io_prep_async_work(nxt, &link);
> 	*workptr = &nxt->work;
> +	io_wq_assign_cur();
> 	if (link)
> 		io_queue_linked_timeout(link);
> 
> where io_wq_assign_cur() ensures that worker->cur_work is set to the new
> work, so we know it's discoverable before calling
> io_queue_linked_timeout(). Probably also needs to include the
> ->get_work() call as part of that, so moving the logic around a bit in
> io_worker_handle_work().
> 
> If we do that, then by the time we arm the linked timer, we know we'll
> be able to find the new work item. The old work is done at this point
> anyway, so doing this a bit earlier is fine.

Something like this, totally untested.


diff --git a/fs/io-wq.c b/fs/io-wq.c
index b4bc377dda61..2666384aaf44 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -427,6 +427,9 @@ static void io_worker_handle_work(struct io_worker *worker)
 		worker->cur_work = work;
 		spin_unlock_irq(&worker->lock);
 
+		if (work->flags & IO_WQ_WORK_CB)
+			work->cb.fn(work->cb.data);
+
 		if ((work->flags & IO_WQ_WORK_NEEDS_FILES) &&
 		    current->files != work->files) {
 			task_lock(current);
diff --git a/fs/io-wq.h b/fs/io-wq.h
index 4b29f922f80c..892989f3e41e 100644
--- a/fs/io-wq.h
+++ b/fs/io-wq.h
@@ -11,6 +11,7 @@ enum {
 	IO_WQ_WORK_NEEDS_FILES	= 16,
 	IO_WQ_WORK_UNBOUND	= 32,
 	IO_WQ_WORK_INTERNAL	= 64,
+	IO_WQ_WORK_CB		= 128,
 
 	IO_WQ_HASH_SHIFT	= 24,	/* upper 8 bits are used for hash key */
 };
@@ -21,8 +22,17 @@ enum io_wq_cancel {
 	IO_WQ_CANCEL_NOTFOUND,	/* work not found */
 };
 
+struct io_wq_work;
+struct io_wq_work_cb {
+	void (*fn)(void *data);
+	void *data;
+};
+
 struct io_wq_work {
-	struct list_head list;
+	union {
+		struct list_head list;
+		struct io_wq_work_cb cb;
+	};
 	void (*func)(struct io_wq_work **);
 	unsigned flags;
 	struct files_struct *files;
diff --git a/fs/io_uring.c b/fs/io_uring.c
index 066b59ffb54e..6f5745342eb2 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2654,6 +2654,13 @@ static int __io_submit_sqe(struct io_kiocb *req, struct io_kiocb **nxt,
 	return 0;
 }
 
+static void io_link_work_cb(void *data)
+{
+	struct io_kiocb *link = data;
+
+	io_queue_linked_timeout(link);
+}
+
 static void io_wq_submit_work(struct io_wq_work **workptr)
 {
 	struct io_wq_work *work = *workptr;
@@ -2700,8 +2707,11 @@ static void io_wq_submit_work(struct io_wq_work **workptr)
 
 		io_prep_async_work(nxt, &link);
 		*workptr = &nxt->work;
-		if (link)
-			io_queue_linked_timeout(link);
+		if (link) {
+			nxt->work.flags |= IO_WQ_WORK_CB;
+			nxt->work.cb.fn = io_link_work_cb;
+			nxt->work.cb.data = link;
+		}
 	}
 }
 

-- 
Jens Axboe

