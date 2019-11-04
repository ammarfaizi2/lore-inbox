Return-Path: <SRS0=koBJ=Y4=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B747CA9EC9
	for <io-uring@archiver.kernel.org>; Mon,  4 Nov 2019 21:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB45620848
	for <io-uring@archiver.kernel.org>; Mon,  4 Nov 2019 21:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="z4c7ZJJV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbfKDVk2 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:40:28 -0500
Received: from mail-pf1-f170.google.com ([209.85.210.170]:42822 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728409AbfKDVk2 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 4 Nov 2019 16:40:28 -0500
Received: by mail-pf1-f170.google.com with SMTP id s5so5149827pfh.9
        for <io-uring@vger.kernel.org>; Mon, 04 Nov 2019 13:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=9wBYaBreerq6gM96GKnBnfiJBkGT1Qbx5MSJFFX5zz0=;
        b=z4c7ZJJVZmGNSJVQ/HLASUBJFyrlSFvnQiT/ZXkwB2lSc2lXjk/G7gdLaSz/cf17uA
         vELWr9a64bTt2StQion1nn1tnTTJhjVXHzoFoM33ccr0ci++T4IyHOXgXp3WQXHKEj80
         gChYJojksNW5rZsahCgj8FZNYzW9wTS4eTU/cR3RyVvX6nrb2xmGgE4JBZ20h8Xuhlfw
         Y3z8836ov/hnH+Rc0/grd5POSwz2Aq4qNRF8xakp58VHIkqxEjnepmbRmdYXbp0tLo9g
         uFtXA1oAwd7cmUEJT+OIZmcCp6QZuc9ZfmHKq7/dtJx2Kt4HRVFS8YRIhMnnmAZi3pNv
         Oy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9wBYaBreerq6gM96GKnBnfiJBkGT1Qbx5MSJFFX5zz0=;
        b=NhLi16wBzx37ebVN5ulcPsUvc6KBAcGmcsvNDVNQ3JJZcYKzuTSVNSZCO1LmplZmVv
         PEdS+MEPucdDhNxeMcjcBgBTH0ko2gYW39sn3LGW/OyHrXnJkMEdtA0gurmQNErYN5Ry
         8X31zsp8hHCkImT79VWFJvWkciXXGNV6EVQvRLUgC7iOGWoV1Z52zd7x2PcSc1KMwI5o
         N4LEiCVAVpPHp9D/yCNmB/TKT8YHjcoLCbEF8CT413txtNSUpiVTnYEXK1imPAWD2FFY
         vOcDpIAk2wQEUeeMoz1DcrqJ0ESi7k2xadylsCLzZRArufiTAmtjD4yzhOslL6sgBjK/
         Tauw==
X-Gm-Message-State: APjAAAX/QljPFhLjnz5b7sA4m2PuUdUNWntyn9O9aSSIMEIXNYp3hwOz
        J2lPGPKciDubVqgJo0FO5cx/ps7ZuAweRw==
X-Google-Smtp-Source: APXvYqzEcLW+Gs+itEce3h/ba7eEEmVMB2x/kjqfoPFDRySoHx9/3GofwQlLigyTexki+b6uyLMSJA==
X-Received: by 2002:a17:90a:195e:: with SMTP id 30mr1748322pjh.60.1572903627383;
        Mon, 04 Nov 2019 13:40:27 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id y144sm16952053pfb.188.2019.11.04.13.40.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 13:40:26 -0800 (PST)
Subject: Re: This list is now archived on lore.kernel.org
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        io-uring@vger.kernel.org
References: <20191104212144.sszfmbbxdddxt765@chatter.i7.local>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0797e1e6-a1f8-53ae-0b58-e2d703bf2d54@kernel.dk>
Date:   Mon, 4 Nov 2019 14:40:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191104212144.sszfmbbxdddxt765@chatter.i7.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/4/19 2:21 PM, Konstantin Ryabitsev wrote:
> Hello:
> 
> This list is now archived on lore.kernel.org:
> https://lore.kernel.org/io-uring/

Great, thanks! It's not on the index page yet, but I guess that
gets updated occasionally?

-- 
Jens Axboe

