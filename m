Return-Path: <SRS0=vuSH=ZE=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB42C43331
	for <io-uring@archiver.kernel.org>; Tue, 12 Nov 2019 16:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B7BA21872
	for <io-uring@archiver.kernel.org>; Tue, 12 Nov 2019 16:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="wiYLfAlr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfKLQnl (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 12 Nov 2019 11:43:41 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38608 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfKLQnl (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 12 Nov 2019 11:43:41 -0500
Received: by mail-pl1-f195.google.com with SMTP id w8so9651628plq.5
        for <io-uring@vger.kernel.org>; Tue, 12 Nov 2019 08:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=2mntLGjBynSbRiA6lBdjXgzVUzQjxpPjHmpOopsy2XM=;
        b=wiYLfAlrSdepZoQQTrAkYoZQpw7eOwPlFZxV81UrAyZHk9h+fzRQo7U2jAqIad/Xt5
         ZeyhCB6pKxUz70+RAjida2eGqaJdSlLSu+d/J1Ycei2DhscUfxBgMeCQdnCU7I+j7Lyw
         Q+hYtD32Ymtroo5mTPnx1Z7Te9BJ7Wqbk2ZEmVLKl59np2eReUGxoU1Kfo2oRtFDYBM/
         8wtwcaQqO+F0Ud0fV3ERaiRcy2MKqgloY/qpfaAcO33UVczTYtNPdb8kGgt517vsHCVV
         ms89gxhyHIYlmusC+fsKQyBZGWxg8ME18U4tI1feJsJu5o4P8DY7WXGSMsCYPc2Pidua
         bkyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2mntLGjBynSbRiA6lBdjXgzVUzQjxpPjHmpOopsy2XM=;
        b=q9uu2q7CgLbrD4N0/242VPdCVBKW4XfrH4kOVPo35AGQk1DTh6TbsSLE7RpZxXQ62J
         eDxkLUTMk1Oyk0a95/AAjL3rIym+BYn7wcWPJLEc4+IVkog120ZJ0A2p9GtrJIGya2IP
         /0jEyTWsVH48q0ZM9gwQKAHPULOubf1aCVsoqM6gIdBkXQ5YkWFCBVouwXDVQqdJ8bTl
         F7JlucAjQywcBi3kWofvDz9g1EkPC2z6zF0yZnEsamRGnU84B6RQV/2Ew2BA4Pvoiq0c
         aDWNFDwDuQFrYxQqUyAAX77bZBkR4h4yAeN7nNgtV6cndWa+BzaRdBWOdqmNdDU0IPV4
         XfFw==
X-Gm-Message-State: APjAAAUWz7SdOzYlT+mfG8XmM48Bpu0ULhm6GvRXvtFNRmErFrCof6kI
        Pv3UuZNAFRdNcGts8cEKKIbC0hg0sq4=
X-Google-Smtp-Source: APXvYqw/py3pn5u3qymGhcoEPWbViDM0ZR1RtrwvJT1XThRkuq19VEYy2muX5bdVrcWmhoZ0jQDBJg==
X-Received: by 2002:a17:902:fe0f:: with SMTP id g15mr33133583plj.198.1573577018976;
        Tue, 12 Nov 2019 08:43:38 -0800 (PST)
Received: from [10.47.172.222] ([156.39.10.47])
        by smtp.gmail.com with ESMTPSA id 13sm7701525pgu.53.2019.11.12.08.43.37
        for <io-uring@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 08:43:38 -0800 (PST)
Subject: Re: [PATCH] io_uring: fix potential deadlock in io_poll_wake()
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
References: <4c601e0b-1ee7-d97e-54dc-2280d6643e30@kernel.dk>
Message-ID: <a6c76ea6-8fdf-04ab-ac5a-ff11707865c0@kernel.dk>
Date:   Tue, 12 Nov 2019 08:43:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <4c601e0b-1ee7-d97e-54dc-2280d6643e30@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/12/19 7:18 AM, Jens Axboe wrote:
> We attempt to run the poll completion inline, but we're using trylock to
> do so. This avoids a deadlock since we're grabbing the locks in reverse
> order at this point, we already hold the poll wq lock and we're trying
> to grab the completion lock, while the normal rules are the reverse of
> that order.
> 
> IO completion for a timeout link will need to grab the completion lock,
> so it's not safe to use from this particular context. If the poll
> request has a timeout link, don't attempt complete inline.

It's a shame to lose the inline run with a linked timer, I'm going to
send a v2 that retains this.

-- 
Jens Axboe

