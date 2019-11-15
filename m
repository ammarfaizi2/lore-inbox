Return-Path: <SRS0=yjkE=ZH=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30419C432C3
	for <io-uring@archiver.kernel.org>; Fri, 15 Nov 2019 00:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F08072070E
	for <io-uring@archiver.kernel.org>; Fri, 15 Nov 2019 00:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="c2nblPu2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfKOAMJ (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 14 Nov 2019 19:12:09 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46204 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfKOAMJ (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 14 Nov 2019 19:12:09 -0500
Received: by mail-pg1-f194.google.com with SMTP id r18so4796577pgu.13
        for <io-uring@vger.kernel.org>; Thu, 14 Nov 2019 16:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=wAOdJ5xe7qJIvfeHy33XXSOGY3CiWmmVmYjcAHxXkcY=;
        b=c2nblPu27kUqsOf9tVwZtR6N8b+CokIDjNt+bJn8IntjD9Erf+keAJ2PnzYvoGXx80
         OPXIGEXGjsECil4kwRROC4EhxXL3UCtKVhaS+MA/ckDYWj8xT4JzazeTXvYsYGE6YxQI
         w/cde2+/oEDWlJvpBLdTC4vGTm0TnVneF5Tx5YZWRnT9YPgrlotsbGv2MIo0tUZP6DhO
         q4C4CxzXZfV7gD4ALPCTgCPyadYO55vkBv9lcFcn0zIXvvgylYJQQcezeZ2g/JkmAWSQ
         r7Zbvz5tmyWY73X0FxJt4eRcdSZriUoW5Wd7OqhMCXiMlLknbmWgaE2lDZdMDHKVSAAf
         LrcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wAOdJ5xe7qJIvfeHy33XXSOGY3CiWmmVmYjcAHxXkcY=;
        b=BK+/EdWUNFGnN9c0FIgXraAdpm9Qf9N4gVb47ZJcKHzpojv8EKJb9hTnAKGD6cr+Ba
         8nl9M5sLCLRlRjn4yNby31yxjyAq0hBDOVlPKDe/bZ7XexnVxsEUz2IhP1IQyodrWI7D
         jEZOmc+PITi3c4LBnqz7xLeF2md958j46xLaRu8DwQ2uwf8H70f7pRL4ShBneD923ZaJ
         cw8uc36m3xYAjt/5xmIjEKAWGB3CAM3+N8+h1DCQap0j+kiInzypTdf4j0NT3LK/lfxV
         OlaP4MmoqkNZD/mnoZy5RpQBIBcQI4qx+tnlIDgY8oYPozQ+CZoaCDKCBdwTB0Z0laOl
         ghkw==
X-Gm-Message-State: APjAAAWk/co3GWZzF4nAvFhIgAkqALywZ3vtVDVwa0YwPq2km1IRYJU1
        ft00L/DUQ8rpiWAr0C05uNunCql6eSI=
X-Google-Smtp-Source: APXvYqxao34beZ14iVEAYqACJGuW6LDkop2oW9gje5V+VnohnZYGXcrahvj1PzCTb3ub+WHpKR5VPg==
X-Received: by 2002:a62:fb02:: with SMTP id x2mr6899051pfm.254.1573776726678;
        Thu, 14 Nov 2019 16:12:06 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id f7sm9518424pfa.150.2019.11.14.16.12.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 16:12:05 -0800 (PST)
Subject: Re: [PATCH] io_uring: Fix LINK_TIMEOUT checks
From:   Jens Axboe <axboe@kernel.dk>
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
References: <9a5eef46f7ed9f52f8de67d314651cd4a4234572.1573766402.git.asml.silence@gmail.com>
 <ef655254-b8ce-8ee3-a776-d44803557ad9@kernel.dk>
Message-ID: <ea4f23f3-4751-2074-f553-d3db8b3c2bda@kernel.dk>
Date:   Thu, 14 Nov 2019 17:12:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ef655254-b8ce-8ee3-a776-d44803557ad9@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/14/19 2:25 PM, Jens Axboe wrote:
> On 11/14/19 2:20 PM, Pavel Begunkov wrote:
>> If IORING_OP_LINK_TIMEOUT request is a head of a link or an individual
>> request, pass it further through the submission path, where it will
>> eventually fail in __io_submit_sqe(). So respecting links and drains.
>>
>> The case, which is really need to be checked, is if a
>> IORING_OP_LINK_TIMEOUT request is 3rd or later in a link, that is
>> invalid from the user API perspective (judging by the code). Moreover,
>> put/free and friends will try to io_link_cancel_timeout() such request,
>> even though it wasn't initialised.
> 
> Care to add a test case for these to liburings test/link-timeout.c?

Wrote some test cases, I think that io_req_link_next() is just wrong.
The below should correct it. We shouldn't loop here at all, just find
the first one. That'll start that guy, sequence will continue, etc.

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 5ad652fa24b8..3230da399681 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -858,7 +858,7 @@ static void io_req_link_next(struct io_kiocb *req, struct io_kiocb **nxtptr)
 	 * safe side.
 	 */
 	nxt = list_first_entry_or_null(&req->link_list, struct io_kiocb, list);
-	while (nxt) {
+	if (nxt) {
 		list_del_init(&nxt->list);
 		if (!list_empty(&req->link_list)) {
 			INIT_LIST_HEAD(&nxt->link_list);
@@ -876,12 +876,12 @@ static void io_req_link_next(struct io_kiocb *req, struct io_kiocb **nxtptr)
 			/* we dropped this link, get next */
 			nxt = list_first_entry_or_null(&req->link_list,
 							struct io_kiocb, list);
-		} else if (nxtptr && io_wq_current_is_worker()) {
-			*nxtptr = nxt;
-			break;
-		} else {
-			io_queue_async_work(nxt);
-			break;
+		}
+		if (nxt) {
+			if (nxtptr && io_wq_current_is_worker())
+				*nxtptr = nxt;
+			else
+				io_queue_async_work(nxt);
 		}
 	}
 
-- 
Jens Axboe

