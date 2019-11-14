Return-Path: <SRS0=FaGP=ZG=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76984C432C3
	for <io-uring@archiver.kernel.org>; Thu, 14 Nov 2019 02:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 929D4206F0
	for <io-uring@archiver.kernel.org>; Thu, 14 Nov 2019 02:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="yAHzjJzf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfKNCv2 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 13 Nov 2019 21:51:28 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37870 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbfKNCv1 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 13 Nov 2019 21:51:27 -0500
Received: by mail-pg1-f195.google.com with SMTP id z24so2701666pgu.4
        for <io-uring@vger.kernel.org>; Wed, 13 Nov 2019 18:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I9M4medQF8UYWswT5xLlVa3DMrf4mnwCakq/MvX0sjM=;
        b=yAHzjJzfJpQOZt/SZP4Snc/x84/UWwhLMyQMRFnkQl42cRArKGOQS9dzEpRlqUYRoK
         sJs4zqrCbeGnwz5oMLOg3Mrn7RJ/0wVao4D+KeQCqk4cyC2htQkJIRb8vHYT68a4s8ix
         hHwCyov97ZvHxJ6feWrLV0o/UgES999fnMKpQRkdfOZvJHuC2sCQr2nckveZ48sSAp8H
         ew9kM6ZHWJotPsrjwwGl120EZDobv4Lyg9GGH/5g80TwuON/ZKZ5YjK5bBhzpiUJ5kZ/
         sxhf9mviU5JzUBVSCwDQiHOtPKy6Oi9uPMCuXlR6PykiPMpHwv5XN7s6KI1TKzJ0wDag
         yq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I9M4medQF8UYWswT5xLlVa3DMrf4mnwCakq/MvX0sjM=;
        b=FEi+FgsnSkjEJ5v4gFgQQ9KnXZX3xNgrKxtSCCdrEDnM+1/3yCJAvG9Mvg3uiC7WnB
         moez2NsqPg2iByTm0KeyS9qjWSAji19KPua9c7Co3Rth5CdJOJ093wnNKwg812o1IQcW
         O1PbjBdwvaVQ9OLIYhb04JfmK4KarCg3UKiSPQGhmI+0dbo09yttGBqJlipRFdWdKvIy
         kpKnzm9JuAutCYemRyg0jAZH0TcOAsHFvN60zHQi0j50ZhjP5Sg46LoxoMOBcrlxtk7J
         53X7CbRTHUTkqLxzCbwRXtKvkrqZYH9n4a3Ra7gt9FQjpYafrTP19CLM3RYjnrJ5bJV1
         EO8g==
X-Gm-Message-State: APjAAAUSA+egpox6xxXpEbWxU5hZjNlS0j9k+OGhC81gYND/3RPKZSu7
        iaAflyi9c8uFkxK7ws8kfp3fhuubXxQ=
X-Google-Smtp-Source: APXvYqzuarDwiiope1icfS/vlA5mW6esTTnqfysu7M0vEZsHWFqbsi4W2ZpInEr/+x/B3ukRY7xSrQ==
X-Received: by 2002:a17:90a:fc91:: with SMTP id ci17mr9149190pjb.13.1573699885072;
        Wed, 13 Nov 2019 18:51:25 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1133::11d6? ([2620:10d:c090:180::f679])
        by smtp.gmail.com with ESMTPSA id z7sm3999888pgk.10.2019.11.13.18.51.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 18:51:23 -0800 (PST)
Subject: Re: [PATCH 3/3] io-wq: ensure free/busy list browsing see all items
To:     paulmck@kernel.org
Cc:     io-uring@vger.kernel.org
References: <20191113213206.2415-1-axboe@kernel.dk>
 <20191113213206.2415-4-axboe@kernel.dk>
 <20191113234251.GH2865@paulmck-ThinkPad-P72>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ca6289dd-7a33-9068-2efa-34720f35afbb@kernel.dk>
Date:   Wed, 13 Nov 2019 19:51:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191113234251.GH2865@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/13/19 4:42 PM, Paul E. McKenney wrote:
> On Wed, Nov 13, 2019 at 02:32:06PM -0700, Jens Axboe wrote:
>> We have two lists for workers in io-wq, a busy and a free list. For
>> certain operations we want to browse all workers, and we currently do
>> that by browsing the two separate lists. But since these lists are RCU
>> protected, we can potentially miss workers if they move between the two
>> lists while we're browsing them.
>>
>> Add a third list, all_list, that simply holds all workers. A worker is
>> added to that list when it starts, and removed when it exits. This makes
>> the worker iteration cleaner, too.
>>
>> Reported-by: Paul E. McKenney <paulmck@kernel.org>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> H/T to Olof for asking the question, by the way!
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

Thanks! And yes, hat tip to Olof for sure.

-- 
Jens Axboe

