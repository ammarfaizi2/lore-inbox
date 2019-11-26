Return-Path: <SRS0=yioi=ZS=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41925C432C0
	for <io-uring@archiver.kernel.org>; Tue, 26 Nov 2019 18:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E652080F
	for <io-uring@archiver.kernel.org>; Tue, 26 Nov 2019 18:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ULneCkb2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfKZS7V (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 26 Nov 2019 13:59:21 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34320 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfKZS7V (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 26 Nov 2019 13:59:21 -0500
Received: by mail-pg1-f196.google.com with SMTP id z188so9456514pgb.1
        for <io-uring@vger.kernel.org>; Tue, 26 Nov 2019 10:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lpDlhf6DorNLQUF/PIyOKVKXIZa4WWrxCg4qONRzx9M=;
        b=ULneCkb2VEyJIyU1vfhN9QwWBybslbxOjPMQvv03j9TgKQzBQtnDvyQguMhhY3hxDL
         8+vsAY4ANgpa350bsFEZ8tEgIOwiLzlmkrQPkXCIo3Fug2f4ocsYmCNkbSjZfhWR/ZkZ
         p2oyZGHTnrf8aMMBrh2jutN+eENntNcmW1XLNWqPmPwk9WRiR6EsepsX6Q7Jju/BFn5S
         x+DepsJNuNNkliWbkCpTm+NOlF84SFECoaHEsex9JzeDPWRDX8i584lqfJ7giqxj1KcB
         nnrAGKM47b7IhreFsXLDxzYF78rnsEy2wtTvj9zJc5ZHf8dw8nY36TTZriesSsZ+ng1o
         zbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lpDlhf6DorNLQUF/PIyOKVKXIZa4WWrxCg4qONRzx9M=;
        b=hOZOZCD7MQQPKsLBG0PSS7Xv/HoEFSL1SksBeITbRSQhZ9zHELXEPMUKDUq7/2M4BB
         9lTnD50Qh/bK9lfVHZFrtW+bGZsyBtfdqO0eF5cYoqgaSdVDib9PPA15tZ3ckZjcV4oX
         WqEKh++hnhmOEMdUVKas31u9PcdPezsVgZi3w8IxUEcZLBLoNKDhTb1iqOT/yEG7wKuN
         kjKJ5YnPUaOB2GK2V61lIJWo4rM3WEwlpWl9BsCrADATe8oVxqR1dcn5DwURAzsjpzqQ
         VEvykBE9TvyOO/ITfPmiJbK6KWPtVRe0tMJ+x5YITnGQptpHDTEN/WCZ3X985HyzhZSc
         9dvA==
X-Gm-Message-State: APjAAAXEmOicIhE1Qw7gle90zLhgukT/jH/zAt41e8Gm0FhJshZ258fi
        jxgddbSyqo26mxJNfrKaPyLpYw==
X-Google-Smtp-Source: APXvYqwtxM4DVbkAMyrY/ZNl2oqbgHtG2tITG9xIQfxiCy4Di8F1pU4rQnBMGhFKB9kFoexjh9wMiw==
X-Received: by 2002:a63:4562:: with SMTP id u34mr39766500pgk.399.1574794760341;
        Tue, 26 Nov 2019 10:59:20 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id w3sm1786625pfd.161.2019.11.26.10.59.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Nov 2019 10:59:19 -0800 (PST)
Subject: Re: [PATCH] io-wq: fix handling of NUMA node IDs
From:   Jens Axboe <axboe@kernel.dk>
To:     Jann Horn <jannh@google.com>
Cc:     io-uring@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
References: <20191126181020.17593-1-jannh@google.com>
 <a61b62a2-8530-59ab-f96c-ccb4ad274d4a@kernel.dk>
Message-ID: <357aa558-0ec9-5a47-8540-c56d04a506b1@kernel.dk>
Date:   Tue, 26 Nov 2019 11:59:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <a61b62a2-8530-59ab-f96c-ccb4ad274d4a@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/26/19 11:17 AM, Jens Axboe wrote:
> On 11/26/19 11:10 AM, Jann Horn wrote:
>> There are several things that can go wrong in the current code on NUMA
>> systems, especially if not all nodes are online all the time:
>>
>>    - If the identifiers of the online nodes do not form a single contiguous
>>      block starting at zero, wq->wqes will be too small, and OOB memory
>>      accesses will occur e.g. in the loop in io_wq_create().
>>    - If a node comes online between the call to num_online_nodes() and the
>>      for_each_node() loop in io_wq_create(), an OOB write will occur.
>>    - If a node comes online between io_wq_create() and io_wq_enqueue(), a
>>      lookup is performed for an element that doesn't exist, and an OOB read
>>      will probably occur.
>>
>> Fix it by:
>>
>>    - using nr_node_ids instead of num_online_nodes() for the allocation size;
>>      nr_node_ids is calculated by setup_nr_node_ids() to be bigger than the
>>      highest node ID that could possibly come online at some point, even if
>>      those nodes' identifiers are not a contiguous block
>>    - creating workers for all possible CPUs, not just all online ones
>>
>> This is basically what the normal workqueue code also does, as far as I can
>> tell.
>>
>> Signed-off-by: Jann Horn <jannh@google.com>
>> ---
>>
>> Notes:
>>       compile-tested only.
>>       
>>       While I think I probably got this stuff right, it might be good if
>>       someone more familiar with the NUMA logic could give an opinion on this.
>>       
>>       An alternative might be to only allocate workers for online nodes, but
>>       then we'd have to either fiddle together logic to create more workers
>>       on demand or punt requests on newly-onlined nodes over to older nodes.
>>       Both of those don't seem very nice to me.
> 
> I don't think caring about not-online nodes in terms of savings is worth
> the trouble. I'll run this through the regular testing I have with no
> and 2 nodes, thanks.

Tests fine for me in all configurations, applied.

-- 
Jens Axboe

