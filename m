Return-Path: <SRS0=nrYQ=ZO=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D9BC432C0
	for <io-uring@archiver.kernel.org>; Fri, 22 Nov 2019 14:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C0020707
	for <io-uring@archiver.kernel.org>; Fri, 22 Nov 2019 14:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="NUYSjsEK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbfKVOYu (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 22 Nov 2019 09:24:50 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:34806 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfKVOYu (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 22 Nov 2019 09:24:50 -0500
Received: by mail-il1-f196.google.com with SMTP id p6so7130421ilp.1
        for <io-uring@vger.kernel.org>; Fri, 22 Nov 2019 06:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cCR5UP4Jr7O/jBTvtMPa3eMfbER2ad4DIRiNxwAEYyQ=;
        b=NUYSjsEKlQxASz1oVDXTLhU0ZWYHdKnuWZQhQR48FC6jttTJ5QtdcN2AwTYdh1SajW
         VSMwgGwguK+mUybpEAuDrJN7rqEqyVYmwLXQnAIyPm77MLMRl1BzvhjlJt6aY944OSo3
         xiQ2WzIp2Fq7v8kPMUzsxS9x1pHP6NJiX3hc1odGlyj1kUrSimHpm2/Wv0Z5AOyXZ0n+
         +NNOgBrZ8UzycI9pKK8U8xL9aDXKgumMMfRCZlQs6vE/cy2VX9BcFWJu39RVCv63t/Y4
         SenbGhEPN5WuCYVQOwWtzh7b6s4vz2sfGSd18b2YPUMjBpuxHjTQ/zginEz+aDUop5tx
         6A3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cCR5UP4Jr7O/jBTvtMPa3eMfbER2ad4DIRiNxwAEYyQ=;
        b=Z6u6HC/1EVUzuCahjl6R9McAsWIxQDpwOFCS2Vih6lRrHcvNxo5BkvdtwRWGZqZVvm
         ZCNlNtaCA0X0KHnq7ziA+g5+Q5NM3qH6jsRXflSkqky6ABrCzHLlt/W7EssXxqilZ9TU
         wm71s7/JBqvp//E7lzYIC1WaOgD11Z9pN6r81lJwVvyniN27HwyaBrHgODESyN4cKnlN
         4ds9n2SB7dHCDyQAwh8IZHW7vx3Wf2WlHPwbLwi1ayJ364BLt9z7ytYqjKEJw+Eiivkf
         EEbfWKS9fVI1qEHo/6M2F9lCZcfMkBTB9G5eAeyq4NDziyNX6R3Q4Cg35NjF/ZE1dsIr
         lr4Q==
X-Gm-Message-State: APjAAAUU7Y/S8sx0jHiSr0c+LyrAltVaTRYe8HeqsHJ23D15wBTA8NTM
        c1BLLH3NUOvLF8D1GKQLGmRwcg==
X-Google-Smtp-Source: APXvYqwsoq8DMTkR6pGcAA+wt3LgX9INKpjqpoH5ZQxf9OXkI/Y6b8NWpY6Mubtep+rhRrNQAaQ3ew==
X-Received: by 2002:a92:5a0c:: with SMTP id o12mr17708442ilb.113.1574432687932;
        Fri, 22 Nov 2019 06:24:47 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c13sm998977iob.69.2019.11.22.06.24.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Nov 2019 06:24:46 -0800 (PST)
Subject: Re: [PATCH liburing v2] Update link_drain with new kernel method
To:     Jackie Liu <jackieliu@byteisland.com>
Cc:     asml.silence@gmail.com, io-uring@vger.kernel.org,
        liuyun01@kylinos.cn
References: <20191122081804.41292-1-jackieliu@byteisland.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f9fe0c91-c857-7211-4a40-62b6223235b1@kernel.dk>
Date:   Fri, 22 Nov 2019 07:24:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191122081804.41292-1-jackieliu@byteisland.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/22/19 1:18 AM, Jackie Liu wrote:
> From: Jackie Liu <liuyun01@kylinos.cn>
> 
> Now we are dealing with link-drain in a much simpler way,
> so the test program is updated as well.
> 
> Also fixed a bug that did not close fd when an error occurred.
> and some dead code has been modified, like commit e1420b89c do.

Applied, thanks.

-- 
Jens Axboe

