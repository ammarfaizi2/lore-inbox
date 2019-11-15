Return-Path: <SRS0=yjkE=ZH=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551BEC432C3
	for <io-uring@archiver.kernel.org>; Fri, 15 Nov 2019 09:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25B4520732
	for <io-uring@archiver.kernel.org>; Fri, 15 Nov 2019 09:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAxgTl8j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfKOJkG (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 15 Nov 2019 04:40:06 -0500
Received: from mail-lj1-f170.google.com ([209.85.208.170]:44371 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfKOJkG (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 15 Nov 2019 04:40:06 -0500
Received: by mail-lj1-f170.google.com with SMTP id g3so9952669ljl.11;
        Fri, 15 Nov 2019 01:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I2bY8wt44U8gioXslAWPn4SYSC87I8ddc2E8Vr5B1O8=;
        b=fAxgTl8jg0+RgGouq+X0RuB/Qa2RIj07JqtPgIjxKUGEYy41OUalLRSGLdVmG4p6CE
         YbHB189zeZoc36pTjUMQzzh2zOKvbPy5KFrGKHz7NQ9+/vH36VrNc4ayKqyzn0Onvjuu
         5vvnjG5Bx0XXM5p/kVFC7W7Oc1maaDZTgji4bqhPs14vJCF0FaZrIl+u8tJBbigiN5tq
         1yVXrHsG5Myiy29XyLsC4d2XVBlPq2degCiBMch4Lh0uGAJ+P8pRCbNVOJVrOIyF5hWh
         /32HHjpm5wo8RwHTjc2XOB1n5D41AU+wNCgxqdU+NvWFBZxLqi5xVqt6SGsrl+1kJeP/
         S0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I2bY8wt44U8gioXslAWPn4SYSC87I8ddc2E8Vr5B1O8=;
        b=GweTl3rbCbXvBXA+raQZ1pgdc6j32YmeyzUtbuuZAsESDrssywHTnGKdRSaeKLBbFK
         nmIZfO32YThIY8QCMrmIq+XpKO1vKOt3lE8rLY2mDs215GuMzdvifm6++ErJCZblnjOD
         815ZiEJjkRPsl980R9l811wf1onv35+Qwtsyw5PSDsVint8tk+7MacerMaaBTKCT2K4Q
         eU8CQcAtau19DLkLWi3mE3sstWTelibi0l5rNsv7rxTnA1ilY6fVDM13hAV4ZOKjlv8u
         9B4FOujdfkZhWhOnFxKBmJqMUjM+/9KHPidhDT0w2lFfi9ABa5spnoWW9VImIz1OGz8U
         jSYQ==
X-Gm-Message-State: APjAAAVqTVIDBs/YvfGZdj3Cjl8beKh/bCRRM20driZGhjpejW3R5vEe
        p9oRGF0vy8n6vd72dFYe1aiwiRju
X-Google-Smtp-Source: APXvYqwE4izGIZu2wzmyollnmujJrbxz6DyP9k1peKUm0dMaerDS582LkgreFOefXzIt/g1EnlTW7Q==
X-Received: by 2002:a2e:9f4c:: with SMTP id v12mr1645813ljk.167.1573810804047;
        Fri, 15 Nov 2019 01:40:04 -0800 (PST)
Received: from [172.31.190.83] ([86.57.146.226])
        by smtp.gmail.com with ESMTPSA id b80sm4162838lfg.49.2019.11.15.01.40.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 01:40:03 -0800 (PST)
Subject: Re: [PATCHSET 0/2] io_uring support for linked timeouts
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     zeba.hrvoje@gmail.com, liuyun01@kylinos.cn
References: <20191105211130.6130-1-axboe@kernel.dk>
 <4566889a-7e12-9bfd-b2a1-716d8b934684@gmail.com>
 <9b6cd06b-cd6c-d7e5-157b-32c1e2e9ceac@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Message-ID: <3c0ef10d-9524-e2e2-abf2-e1b0bcee9223@gmail.com>
Date:   Fri, 15 Nov 2019 12:40:02 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <9b6cd06b-cd6c-d7e5-157b-32c1e2e9ceac@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

>> Finally got to this patch. I think, find it adding too many edge cases
>> and it isn't integrated consistently into what we have now. I would love
>> to hear your vision, but I'd try to implement them in such a way, that it
>> doesn't need to modify the framework, at least for some particular case.
>> In other words, as opcodes could have been added from the outside with a
>> function table.
> 
> I agree, it could do with a bit of cleanup. Incrementals would be
> appreciated!
> 
>> Also, it's not so consistent with the userspace API as well.
>>
>> 1. If we specified drain for the timeout, should its start be delayed
>> until then? I would prefer so.
>>
>> E.g. send_msg + drained linked_timeout, which would set a timeout from the
>> start of the send.
> 
> What cases would that apply to, what would the timeout even do in this
> case? The point of the linked timeout is to abort the previous command.
> Maybe I'm not following what you mean here.
> 
Hmm, got it a bit wrong with defer. io_queue_link_head() can defer it
without setting timeout. However, it seems that io_wq_submit_work()
won't set a timer, as it uses __io_submit_sqe(), but not
__io_queue_sqe(), which handles all this with linked timeouts.

Indeed, maybe it be, that you wanted to place it in __io_submit_sqe?

>> 2. Why it could be only the second one in a link? May we want to cancel
>> from a certain point?
>> e.g. "op1 -> op2 -> timeout -> op3" cancels op2 and op3
> 
> Logically it need not be the second, it just has to follow another
> request. Is there a bug there?
> 
__io_queue_sqe looks only for the second one in a link. Other linked
timeouts will be ignored, if I get the code right.

Also linking may (or __may not__) be an issue. As you remember, the head
is linked through link_list, and all following with list.
i.e. req_head.link_list <-> req.list <-> req.list <-> req.list

free_req() (last time I saw it), expects that timeout's previous request
is linked with link_list. If a timeout can fire in the middle of a link
(during execution), this could be not the case. But it depends on when
we set an timeout.

BTW, personally I'd link them all through link_list. E.g. may get rid of
splicing in free_req(). I'll try to make it later.

>> 3. It's a bit strange, that the timeout affects a request from the left,
>> and after as an consequence cancels everything on the right (i.e. chain).
>> Could we place it in the head? So it would affect all requests on the right
>> from it.
> 
> But that's how links work, though. If you keep linking, then everything
> that depends on X will fail, if X itself isn't succesful.
> 
Right. That's about what userspace API would be saner. To place timeout
on the left of a request, or on the right, with the same resulting effect.

Let put this question away until the others are clear.

>> 4. I'd prefer to handle it as a new generic command and setting a timer
>> in __io_submit_sqe().
>>
>> I believe we can do it more gracefully, and at the same moment giving
>> more freedom to the user. What do you think?
> 
> I just think we need to make sure the ground rules are sane. I'm going
> to write a few test cases to make sure we do the right thing.
> 

-- 
Pavel Begunkov

