Return-Path: <SRS0=yioi=ZS=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C839EC432C0
	for <io-uring@archiver.kernel.org>; Tue, 26 Nov 2019 18:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A80920727
	for <io-uring@archiver.kernel.org>; Tue, 26 Nov 2019 18:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="YtJgMBkM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbfKZSRK (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 26 Nov 2019 13:17:10 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42051 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfKZSRK (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 26 Nov 2019 13:17:10 -0500
Received: by mail-pg1-f194.google.com with SMTP id i5so1121625pgj.9
        for <io-uring@vger.kernel.org>; Tue, 26 Nov 2019 10:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9h7U+x++jdUZb4s45/RCLZWEaWGQ6wogzBkHa5vWa1c=;
        b=YtJgMBkMNLBBUyohAKOr2QoA8hcEAC6cOCr86aCbV9SLFPrvzs48B0wVURW8hx7jwg
         S7NemHWmKB/ZO25Fr+7To27zSD3sPMLbnJzC6irFe7w4JHamjhZ2oHaPycvFYrEJ7lZV
         ytAItYERiAI4RUpXtGCh3g8asJbFtaabSeXn5YOfcCPIgQDF8krHH1U9+zIn15oI6ERB
         Om8HC9dbwRrWCSwWpRFwljfRTMEUbzi2Z2T5cJKbG/XMd8UGU3BuBuSiU9yMw/DYU9z8
         uhkIobyyHdOhgEhC8QtWnKHLc2dgfY/oE44cyoxa+ZHufFpm2+U7CNBkUiMXRdoZWPRC
         OwIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9h7U+x++jdUZb4s45/RCLZWEaWGQ6wogzBkHa5vWa1c=;
        b=pWt5/7uEdBshUwx0LzZTkeXj4oj+vlaaFiPdEbjbRCRaQ9lJQNvMfSFKTwtpNujf4f
         5CZWZSOl7J+LFYSwOnGdnO4SheOm1o8Qql6Y/DLjCNIaXLSgWSpRqEj8r8Bmdk3FB3Jn
         Lxuxe7a2M5lax4KKfQthSTO4DeqiGULPG7O4vQN0trK5VewiI7uv3Uf6o7htmhm/Svt6
         1Xds+tSH5GF8SazUwvQi4u2MzonModK6xAGZbrnHRSTHy0vX0JOaF23eaozyO9Aznyuh
         sSOswT3kxPIfHKbCI5J7lscZ7p1VDaeluG9h67Bo/lP9YuvyYjhsXd2ggDPXrIhl6yW8
         2FrQ==
X-Gm-Message-State: APjAAAVvfhHkw4ntOVr/Y20WvJGvGODrZJMJx2R/kkAAw9bxB3iqxHly
        nhpW1r3KNaIWpepvDootz17u0ea83coR5g==
X-Google-Smtp-Source: APXvYqzY85TIWjylJTTxHR8+Y1AIgEMNdTmM1zegjeA2L2+lHzTO4vxHHYtJw9wRX8NEN8DhDJt5XQ==
X-Received: by 2002:a63:364d:: with SMTP id d74mr40556554pga.408.1574792229426;
        Tue, 26 Nov 2019 10:17:09 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id q70sm4342162pjq.26.2019.11.26.10.17.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Nov 2019 10:17:08 -0800 (PST)
Subject: Re: [PATCH] io-wq: fix handling of NUMA node IDs
To:     Jann Horn <jannh@google.com>
Cc:     io-uring@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
References: <20191126181020.17593-1-jannh@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a61b62a2-8530-59ab-f96c-ccb4ad274d4a@kernel.dk>
Date:   Tue, 26 Nov 2019 11:17:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191126181020.17593-1-jannh@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/26/19 11:10 AM, Jann Horn wrote:
> There are several things that can go wrong in the current code on NUMA
> systems, especially if not all nodes are online all the time:
> 
>   - If the identifiers of the online nodes do not form a single contiguous
>     block starting at zero, wq->wqes will be too small, and OOB memory
>     accesses will occur e.g. in the loop in io_wq_create().
>   - If a node comes online between the call to num_online_nodes() and the
>     for_each_node() loop in io_wq_create(), an OOB write will occur.
>   - If a node comes online between io_wq_create() and io_wq_enqueue(), a
>     lookup is performed for an element that doesn't exist, and an OOB read
>     will probably occur.
> 
> Fix it by:
> 
>   - using nr_node_ids instead of num_online_nodes() for the allocation size;
>     nr_node_ids is calculated by setup_nr_node_ids() to be bigger than the
>     highest node ID that could possibly come online at some point, even if
>     those nodes' identifiers are not a contiguous block
>   - creating workers for all possible CPUs, not just all online ones
> 
> This is basically what the normal workqueue code also does, as far as I can
> tell.
> 
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> 
> Notes:
>      compile-tested only.
>      
>      While I think I probably got this stuff right, it might be good if
>      someone more familiar with the NUMA logic could give an opinion on this.
>      
>      An alternative might be to only allocate workers for online nodes, but
>      then we'd have to either fiddle together logic to create more workers
>      on demand or punt requests on newly-onlined nodes over to older nodes.
>      Both of those don't seem very nice to me.

I don't think caring about not-online nodes in terms of savings is worth
the trouble. I'll run this through the regular testing I have with no
and 2 nodes, thanks.

-- 
Jens Axboe

