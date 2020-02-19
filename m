Return-Path: <SRS0=pRY1=4H=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA561C34056
	for <io-uring@archiver.kernel.org>; Wed, 19 Feb 2020 20:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A76A24656
	for <io-uring@archiver.kernel.org>; Wed, 19 Feb 2020 20:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="d7IDQNH8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgBSUJM (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 19 Feb 2020 15:09:12 -0500
Received: from mail-pl1-f181.google.com ([209.85.214.181]:34165 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgBSUJM (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 19 Feb 2020 15:09:12 -0500
Received: by mail-pl1-f181.google.com with SMTP id j7so527021plt.1
        for <io-uring@vger.kernel.org>; Wed, 19 Feb 2020 12:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=9Mge/5LrFyzcmBBOEMnpSfx8jOT5DLli0Sk+Rz08GOA=;
        b=d7IDQNH8VT2wXF/7Hz0CjtvD1r8optGWDzKpKcPrRZtQ3xOU6CnYbsog+HieHBHzG6
         WTiRFxV6NFuaVHiyNOH56AFvPDJSP0wKVWLZbjK2T5ZYsmQ134g2BsCp3ut1qyTnwVWu
         ahDwbaMNIfErcHYOg0eOj+1pdzKqJn/hmNUYsAhZo9HyiSSUcpK8zxdJqPI2VJc4Jwbj
         IoitNYw+eXhhXks7q+D0kjqtLnTHUnfmCE/imQeZmyyuNCxRDJWRUMbjJ6M1EPxMUWNq
         aOumO9JI6dFN2o0dnYRSBuTBYAvMhJkETr8Exr9L0S3ireQOuJjp8nzq0uTS7EsFhz+1
         tVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9Mge/5LrFyzcmBBOEMnpSfx8jOT5DLli0Sk+Rz08GOA=;
        b=KvrTALfGznN+HmJDRE8NyQJGFM40YobbJUvb/0nxH1Qg4/gkPAnXS0qntnowyO44vS
         sdkJrCXQPSBtAhJQtEshNGm/AHtGbBooNnBZ3Vo3hi96JdrKbjAIUdHIBqff7mtPbuKO
         paCd0B1EUeuhAbhp7VmYVaGFIvUDu5utyD9zX4CiTikhU6n5GDHNdOHr/b6LyqvZfgmi
         ezF3z9gP0cGesYgBsZueHqFcifNTT820ix/us+ZchqL4RM37zl645a152R2S967xZj92
         4e2I2VC4PaBXmdhhiQpakW6coidpjJEfuaa2aX4vQYuqhdPiDNZ3e15PuWT1ezhtEou1
         I1cQ==
X-Gm-Message-State: APjAAAWx9lDnjAdg//V9Okb/+gieST3dPfXt/I6pPQviO5XDNc3ZlD5K
        Ol8JEhm3vv3x6irEdp/fbxmE+w==
X-Google-Smtp-Source: APXvYqyoVpTuzXiL91kY7op+oNqMzHgU49U1wgFs7uewxJmh/qhd1l/c5bdlGz+88mvpcrDgPbvamw==
X-Received: by 2002:a17:902:bd88:: with SMTP id q8mr26182095pls.13.1582142950628;
        Wed, 19 Feb 2020 12:09:10 -0800 (PST)
Received: from ?IPv6:2605:e000:100e:8c61:f1aa:b818:cddd:a786? ([2605:e000:100e:8c61:f1aa:b818:cddd:a786])
        by smtp.gmail.com with ESMTPSA id k1sm467607pfg.66.2020.02.19.12.09.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 12:09:10 -0800 (PST)
Subject: Re: crash on accept
To:     Glauber Costa <glauber@scylladb.com>, io-uring@vger.kernel.org,
        Avi Kivity <avi@scylladb.com>
References: <CAD-J=zZnmnjgC9Epd5muON2dx6reCzYMzJBD=jFekxB9mgp6GA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ec98e47f-a08f-59ba-d878-60b8cd787a1f@kernel.dk>
Date:   Wed, 19 Feb 2020 12:09:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAD-J=zZnmnjgC9Epd5muON2dx6reCzYMzJBD=jFekxB9mgp6GA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 2/19/20 9:23 AM, Glauber Costa wrote:
> Hi,
> 
> I started using af0a72622a1fb7179cf86ae714d52abadf7d8635 today so I could consume the new fast poll flag, and one of my tests that was previously passing now crashes

Thanks for testing the new stuff! As always, would really appreciate a
test case that I can run, makes my job so much easier.

-- 
Jens Axboe

