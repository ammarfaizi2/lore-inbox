Return-Path: <SRS0=BBHt=ZN=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542B0C432C0
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 02:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25679206A4
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 02:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="c63cxChE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbfKUCdx (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 20 Nov 2019 21:33:53 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:44003 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfKUCdx (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 20 Nov 2019 21:33:53 -0500
Received: by mail-pj1-f65.google.com with SMTP id a10so732473pju.10
        for <io-uring@vger.kernel.org>; Wed, 20 Nov 2019 18:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eq2OcbSgFU50j5+5pu07awk+kHx4eS64+TjWrpLwom8=;
        b=c63cxChEzOlsV62kkVVl40tSKw9iOU/Xr8VQv/r7e31I5iiukRjUvH3hh+A9p0xHPi
         ES3BXZXkue7KeVAy+xqpOqcaanAeN9SmnzKlxciM1rJVOZ3w1/YWVt+XQZG7Sh5Jgh+9
         QMoKPo70j3v2KBmRtZqC/1hx4B+ca3n3F4lMmYwoTSs7E+0HwLh7sRlEzE+/mXvGvWX+
         7pSAUxtbl04pVwpFmb813QkliFYsNi1D6lmPAHy/+YjaIR/oaPSQN0ga8I50wucapRRD
         MuNoj2QwLpyySor/PHenf1D5Je4n+C+XPyEUiE4nOf4U+n4NYzhA487pH+YD0KO+VcsR
         fuyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eq2OcbSgFU50j5+5pu07awk+kHx4eS64+TjWrpLwom8=;
        b=TDju2q9C5IZdpZFpu127xhckk+8QhkHCNBmVNuoWIAVokMG6KeNfwGPUy15gmENwi/
         zsbsG8JOpgBoMMGC/0fv+ecznUL4gbnm333obvqXMmns+Q6JfoA8HsLQAM9aYoIgqFC/
         B3Mazl5WOJ53xx12edx6p5qC55tKJLzmoZMuCfaGXSwFHhPiNP5PEsMuFheRu4eBd7eO
         moj6vE3JXLy77ysES4mneNGvUpdK+NIBa/d3vSfxjQsrWxQOaGCe7lY0ABwVz11zQmXH
         DEwVkU9Yr9mdCJkcEUAfefyyuOlN1ONW2T2DEDMDq3eXgtCXJ5hcuFt1q8OqQQHi2uu5
         spsg==
X-Gm-Message-State: APjAAAVv9ZigFqjXGc6BJMFVaoOH38L3R6VoJKYp6hchwPWvj5ZlZtV8
        uo0v01FDPdDkLC75QlxV0W+B+AHyZZJnGw==
X-Google-Smtp-Source: APXvYqxz4Gl6th38wDMUO9eT3S7/MUavYJQRvgn7EBLFCb+FeoEmBflrN7Ak3Wev2osqcfoAsgHd8w==
X-Received: by 2002:aa7:9a96:: with SMTP id w22mr8031869pfi.162.1574302201629;
        Wed, 20 Nov 2019 18:10:01 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id e17sm517045pgt.89.2019.11.20.18.10.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 18:10:00 -0800 (PST)
Subject: Re: [PATCH] io_uring: fix race with shadow drain deferrals
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     io-uring@vger.kernel.org
References: <27c153ee-cfc8-3251-a874-df85a033429a@kernel.dk>
 <cabb202a-a405-9f36-0363-1548f1b4dfd4@kernel.dk>
 <1C6D35BF-C89B-4AB9-83CD-0A6B676E4752@kylinos.cn>
 <890E4F5B-DDA2-40EF-B7AD-3C63EFA20D93@kylinos.cn>
 <b70c7e29-408c-af72-5dc1-85456c904c7a@kernel.dk>
 <2005c339-5ed3-6c2e-f011-5bc89dac3f5c@kernel.dk>
 <FCFA70EC-AC49-4B36-8A07-D2E2D2F1D4FA@kylinos.cn>
 <7ae652ee-0274-b8c6-9597-9dd82f939d9b@kernel.dk>
 <57EF3B0C-A6D3-45D5-A689-B8090F750C1E@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d240a63f-cf5f-10c5-c7ae-e4443ae420ff@kernel.dk>
Date:   Wed, 20 Nov 2019 16:03:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <57EF3B0C-A6D3-45D5-A689-B8090F750C1E@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/20/19 7:07 PM, Jackie Liu wrote:
> 
> 
>> 2019年11月21日 07:14，Jens Axboe <axboe@kernel.dk> 写道：
>>
>> On 11/20/19 6:57 PM, Jackie Liu wrote:
>>>> @@ -2957,15 +2975,14 @@ static void io_queue_sqe(struct io_kiocb *req)
>>>> 	int ret;
>>>>
>>>> 	ret = io_req_defer(req);
>>>> -	if (ret) {
>>>> -		if (ret != -EIOCBQUEUED) {
>>>> -			io_cqring_add_event(req, ret);
>>>> -			if (req->flags & REQ_F_LINK)
>>>> -				req->flags |= REQ_F_FAIL_LINK;
>>>> -			io_double_put_req(req);
>>>> -		}
>>>> -	} else
>>>> +	if (!ret) {
>>>> 		__io_queue_sqe(req);
>>>> +	} else if (ret != -EIOCBQUEUED) {
>>>> +		io_cqring_add_event(req, ret);
>>>> +		if (req->flags & REQ_F_LINK)
>>>> +			req->flags |= REQ_F_FAIL_LINK;
>>>> +		io_double_put_req(req);
>>>> +	}
>>>> }
>>>
>>> Hmm.. Why we need rewrite there? clear code? Seems to be unrelated to
>>> this issue.
>>
>> We don't need to, and the previous patch touched it, but it's much
>> easier to read after this change. Before it was:
>>
>> if (ret) {
>> 	if (ret != -EIOCBQUEUED) {
>> 		...
>> 	}
>> } else {
>> 	...
>> }
>>
>> which is now just
>>
>> if (!ret) {
>> 	...
>> } else if (ret != -EIOCBQUEUED) {
>> 	...
>> }
>>
>> not related to the change really, but kind of silly to make a separate
>> patch for imho.
>>
> 
> Understand, thanks for explaining and fixing this problem,
> And now, please add:
> 
> Reviewed-by: Jackie Liu <liuyun01@kylinos.cn>

Thanks for reviewing it, I've added your reviewed-by.

-- 
Jens Axboe

