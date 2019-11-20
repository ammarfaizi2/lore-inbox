Return-Path: <SRS0=jdTg=ZM=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EC3C432C0
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 14:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C33302070B
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 14:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="FKuFRlqn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbfKTOZZ (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 20 Nov 2019 09:25:25 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:38157 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbfKTOZZ (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 20 Nov 2019 09:25:25 -0500
Received: by mail-il1-f196.google.com with SMTP id u17so23588860ilq.5
        for <io-uring@vger.kernel.org>; Wed, 20 Nov 2019 06:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=L3oSZ4PuTcYElbM0zQB/rET1dcduZp+Xgf3C39rq+/M=;
        b=FKuFRlqnEHf6Q0zO2wFESlRIhl2z73l6qwM8LZ8e/4kNfPcJMQYkH4g5z6geHffIYK
         GPuQOLNYWVXrvaZ6WsdhJtHsWoJrNija/HTrU1CrfnmhXfbTHoD5E3mSgwPmxjsdNWFd
         yH0s1ZTKvcoIDyClHTpH8hq7d0XGa/AtPpbAUk9tlzgMADETGGldGw1ogaSpcDudL8hI
         byjZ/taIup2VnjFIxlPSGCubyDP6lAB44+glEX7dNrGIT1q5RgkrVf1fqunSvTqJx9/E
         znCJ+EXTT4paHnhnTBnu3CyNVH1tDQq5MZzqkaR+q6kM+SA1XebaSIzLVinOQo38u7tR
         oN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L3oSZ4PuTcYElbM0zQB/rET1dcduZp+Xgf3C39rq+/M=;
        b=ua3rP6DiSoQekbpX42AU5viXHQvuGbqRWNtwa04PAfxgXNA4S8lwsRl6iGcJHGBkqb
         rplj+OAJcJISj+eyyqx2gVe7KFBSltiznXKACs3hJEzHZTUM/1v4efrY2p4FuFQ2IS0T
         MYkFf6Sx9Jl65af4LzsaRCmWqU5UMLZ8WcpbDr1CQhrw/f9sP5/uh0+7fx/tx8JEYYqs
         MqA5chJBquak+P8veb0snjUtkk4W45MaGWllqH6ZZhQi/2D/Apsr8B4cevPNKf2+Oqtg
         l0EH1aOYA7rE88pyatIYUsXmufpbxXx4+EmXgf5dxjzWho8AzPznGfcoZRkn0PXlVXv2
         29yA==
X-Gm-Message-State: APjAAAWRhM3KezHcf+SBpMto76yC3Zi2VlyI18xlkCBwesRfiaAXc86U
        WvC8mJdyVpXgEo+leYaexuX9Un7s1P25Uw==
X-Google-Smtp-Source: APXvYqyp5rGGCO4/lexfRpI1ByCTIp1hUTQR1cQmIcQGcw1eQzSTY0AvwETtwknYUa0q3vl671udiw==
X-Received: by 2002:a92:1613:: with SMTP id r19mr3692058ill.10.1574259922451;
        Wed, 20 Nov 2019 06:25:22 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id n12sm4940383iob.71.2019.11.20.06.25.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 06:25:21 -0800 (PST)
Subject: Re: [PATCH 1/4] io_uring: Always REQ_F_FREE_SQE for allocated sqe
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
References: <cover.1574195129.git.asml.silence@gmail.com>
 <d879b9ce9ea9d47129d8f0a093bc96ce5dc3f54d.1574195129.git.asml.silence@gmail.com>
 <0655d5c5-e241-034c-6ec2-ad97012fd2f1@kernel.dk>
 <4eea8a32-68dc-4d34-f69d-5a2281594844@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0383235e-1e16-a2bd-4dce-77bfaaf7a47a@kernel.dk>
Date:   Wed, 20 Nov 2019 07:25:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <4eea8a32-68dc-4d34-f69d-5a2281594844@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/20/19 2:03 AM, Pavel Begunkov wrote:
> On 11/20/2019 1:10 AM, Jens Axboe wrote:
>> and it is tempting as a cleanup, but it
>> also moves it into the fastpath instead of keeping it in the slow
>> link fail path. Any allocated sqe is normally freed when the work
>> is processed, which is generally also a better path to do it in as
>> we know we're not under locks/irq disabled.
> 
> Good point with locks/irq, but io_put_req() is usually called out of
> locking. Isn't it? E.g. @completion_lock is taken mainly by *add_cq_event().

It is, yes.

> SQE needs to be freed in any case, and there is only one extra "if",
> what we really should not worry about. There are much heavier parts.
> e.g. excessive atomics/locking, I'll send an RFC for that, if needed.
> 
> I find the complexity of much more concern here.

Fair enough, it's not a big addition and it does help clean it up.
I'll apply it.

-- 
Jens Axboe

