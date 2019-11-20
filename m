Return-Path: <SRS0=BBHt=ZN=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E098C43215
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 02:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35BFE2075A
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 02:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="P+8GKf5p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbfKUCDX (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 20 Nov 2019 21:03:23 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:33445 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfKUCDW (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 20 Nov 2019 21:03:22 -0500
Received: by mail-pj1-f66.google.com with SMTP id o14so718925pjr.0
        for <io-uring@vger.kernel.org>; Wed, 20 Nov 2019 18:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Gp/Ui8f8tv4ueoXfUBvkONnnh3Mrqk+Wo1InbaqzqJc=;
        b=P+8GKf5pxL7ALvGG8CKna7mHP0jBF10FWJVvSJdfdpAGPkRfh9Q/moxNw2dbPDNca+
         13dsYDNZptLZPdd2Ipk1/h3RDawadESIL8QAY8r1V5NNY/m8eYGmnWohUDtPCMI5yyI/
         /pAWuhOunAWud0FY/i0NHiD3DmjN/nmjBmTScOU0Pw4TqM9Alzrb9hB9spKLmPPPjD6p
         0XccCKAS6L84TwFK5PoKjPXPMYmE7HdU944Bi9pWOIfe2alsgv7N3NBzpaGutGBihjL7
         q/DKmQNXMtkMa5qY5gAZDepT+yrxBP0sN6jRrq/85BViXjypXbloqCFMn1NJUDeYQrzC
         LlCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Gp/Ui8f8tv4ueoXfUBvkONnnh3Mrqk+Wo1InbaqzqJc=;
        b=rDTvX2U4Aw09DJf0GkPszXOt1P4kUjruyVeLlY6WCu2iOGoNGExIQ2KnoaG9OMwyat
         uHXUkzKDQGBzVLdoCr7jZIlv/5JEjwbYZorN4pcjLYh41u1V3KJ+26qQIXCQSRKW20+3
         Bhrw1QV8lvxQuIY5EBiVXGSZ0n0beGjEmBSGhm4j/668uYPNdxnMI4WDuNsqrSciDAE2
         93Bdcrg9ulv7ql0A9J0H60qH9d7liLP7XpMGMhnSow9pOu7ORFU4DcznhmaYSDoYcFns
         f8JnuHn7CvpZlUeoWUNtGwDdm5mefeh3FdhYhTSDU+r/ei172En2CSGJU/pGHttXXrfB
         39sA==
X-Gm-Message-State: APjAAAXEkMxhITzzkvrwSxmBIXCsATk5YvDsjTDWchxnuuH216a4O0nD
        ow8n1XdIYMhh6o1ZdSvqfMbjFpHm0vu4Jw==
X-Google-Smtp-Source: APXvYqwQhmGeLsVJaHoNM/9wUF8/Kdbrgl4BPCM7nrnqkNkzNJiGE18Jl+fQN3fz0xkDasxFVCcmYQ==
X-Received: by 2002:a17:902:9a02:: with SMTP id v2mr6062454plp.221.1574301800075;
        Wed, 20 Nov 2019 18:03:20 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id y4sm536289pgy.27.2019.11.20.18.03.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 18:03:18 -0800 (PST)
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
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7ae652ee-0274-b8c6-9597-9dd82f939d9b@kernel.dk>
Date:   Wed, 20 Nov 2019 16:14:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <FCFA70EC-AC49-4B36-8A07-D2E2D2F1D4FA@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/20/19 6:57 PM, Jackie Liu wrote:
>> @@ -2957,15 +2975,14 @@ static void io_queue_sqe(struct io_kiocb *req)
>> 	int ret;
>>
>> 	ret = io_req_defer(req);
>> -	if (ret) {
>> -		if (ret != -EIOCBQUEUED) {
>> -			io_cqring_add_event(req, ret);
>> -			if (req->flags & REQ_F_LINK)
>> -				req->flags |= REQ_F_FAIL_LINK;
>> -			io_double_put_req(req);
>> -		}
>> -	} else
>> +	if (!ret) {
>> 		__io_queue_sqe(req);
>> +	} else if (ret != -EIOCBQUEUED) {
>> +		io_cqring_add_event(req, ret);
>> +		if (req->flags & REQ_F_LINK)
>> +			req->flags |= REQ_F_FAIL_LINK;
>> +		io_double_put_req(req);
>> +	}
>> }
> 
> Hmm.. Why we need rewrite there? clear code? Seems to be unrelated to
> this issue.

We don't need to, and the previous patch touched it, but it's much
easier to read after this change. Before it was:

if (ret) {
	if (ret != -EIOCBQUEUED) {
		...
	}
} else {
	...
}

which is now just

if (!ret) {
	...
} else if (ret != -EIOCBQUEUED) {
	...
}

not related to the change really, but kind of silly to make a separate
patch for imho.

-- 
Jens Axboe

