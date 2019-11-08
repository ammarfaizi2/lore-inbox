Return-Path: <SRS0=cPsQ=ZA=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3622EC5DF60
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 14:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06D3121D6C
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 14:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ZP6zARFy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfKHOMA (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 8 Nov 2019 09:12:00 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:38749 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfKHOMA (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 8 Nov 2019 09:12:00 -0500
Received: by mail-il1-f195.google.com with SMTP id u17so350387ilq.5
        for <io-uring@vger.kernel.org>; Fri, 08 Nov 2019 06:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GwzC03hkRNhwy19FucpFAOlngVk2ktIUeg8qqs69TEE=;
        b=ZP6zARFyDPFQjgm0dxKWIl2U2d5O8sExBpVjDv7YBJHHKNPElnw8zID9zxkZmHdVe0
         IHIxi5o8Ud2bIWuDxbJXTpNZOjE/wqIUdE2MADlmrGRPPmTfQVtWs+TGOQt54i3AeD5n
         RNNY1UKUuHpJtCtRa0CbcjXd7tR2rgtFtih9xSzNCDBT+MhNNs6fe/IN09gQctRhp/OA
         KC8fkhla/fNd+1/ln2uOrsuHm29jL8OA9A95RzAKQNMHskNFtUkcbahNuuFFjor4JG7U
         LJcs2WNxi+GRVNUkNuiL3KCnp2mLXsENsN0Fkqn8qn4tgJtxC9h7ySobClOtQCShX5Rq
         BfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GwzC03hkRNhwy19FucpFAOlngVk2ktIUeg8qqs69TEE=;
        b=QozbhjrQ+4ODkQuD3qmfQ7cbkvc8GcljQGRBzKJmRjik7x2QZYqc96dt5uENtoFsLI
         KWYTUmNqp0AmTfPiDxBV03N27BkMC2ERUSSmvX1v8VygryJx0btioTyyOFxF6WnmObYm
         JdemHFfPBhHlyfShHBU0+hn2Y0aQWE5OH1SJ928u9Em7GrR3nr4+PWw/TBtuU0ctXR4l
         iRU80xW4455khu4OB8XyQmjQqetFEIN3kKyniRaBOPH2m+5DcUULjSYkdV+U1itj3FAe
         rhlJhx0mxmF69PNUxnrUw+GIgnXB+KW935ivmz/y3ICULR4N7Q9V5N+Jdw/farrnV6Lq
         ZCHA==
X-Gm-Message-State: APjAAAVpJC4FPDdyIZYWMboEAN4xss1c//JRThWC3K9n4/gD2gXZemmB
        dltZ+QyaVKdwsVh1gLf3NOpsJ402yPI=
X-Google-Smtp-Source: APXvYqwjjosvGCmgvlmC3JaKpgbCJJ3/mKmcptnvtKHFBJJuJRLBoN0GNsamU4quPi9h2e6QTEmjGg==
X-Received: by 2002:a92:3651:: with SMTP id d17mr12885265ilf.268.1573222317539;
        Fri, 08 Nov 2019 06:11:57 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w2sm398477ilg.51.2019.11.08.06.11.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 06:11:56 -0800 (PST)
Subject: Re: [PATCH v2] io_uring: reduced function parameter ctx if possible
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     io-uring@vger.kernel.org
References: <1573198177-177651-1-git-send-email-liuyun01@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5c685b0e-077a-9472-0f2b-982ecfffe9d9@kernel.dk>
Date:   Fri, 8 Nov 2019 07:11:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1573198177-177651-1-git-send-email-liuyun01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/8/19 12:29 AM, Jackie Liu wrote:
> Many times, the core of the function is req, and req has already set
> req->ctx at initialization time, so there is no need to pass in from
> outside.
> 
> Cleanup, no function change.

I was curious if this patch netted us any improvements as well, but it
actually blows up the text segment a lot on my laptop. Before the
patch:

   text	   data	    bss	    dec	    hex	filename
  87504	  17588	    256	 105348	  19b84	fs/io_uring.o

and after:

   text	   data	    bss	    dec	    hex	filename
  99098	  17876	    256	 117230	  1c9ee	fs/io_uring.o

which seems really odd. I double checked just to be sure!

axboe@x1:~ $ gcc --version
gcc (Ubuntu 9.2.1-17ubuntu1~18.04.1) 9.2.1 20191102

-- 
Jens Axboe

