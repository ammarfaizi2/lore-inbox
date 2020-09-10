Return-Path: <SRS0=leQB=CT=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A031FC433E2
	for <io-uring@archiver.kernel.org>; Thu, 10 Sep 2020 15:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59AC82075A
	for <io-uring@archiver.kernel.org>; Thu, 10 Sep 2020 15:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="eL1UUhUP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731153AbgIJPCn (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 10 Sep 2020 11:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731209AbgIJPBf (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 10 Sep 2020 11:01:35 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8912AC061756
        for <io-uring@vger.kernel.org>; Thu, 10 Sep 2020 08:01:00 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id t13so5927894ile.9
        for <io-uring@vger.kernel.org>; Thu, 10 Sep 2020 08:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g8IsxiV1ueWEQz6BLlqMkwuvjDWOokg6+dgBBmYPiUA=;
        b=eL1UUhUP3n/OcUfLdDU2axu79loj80NNiyaFR6qPBxOULyC1fmwfmsn7o8WVtpCxKN
         kfrdsVKxPwFf3Kz8aVm/tORsx+VyWDj4Kag+BQGrL1fcwoG17A7pI56Of1PhhRIJo7E2
         NTrkqLu0SBNVwRx03PZJl85VNQ/OpbidTCQessWoLIBlT1VDxV/OxDV9Sbebugjyoe5z
         3v6ytXwlLXXNKbp3VB1PguqGLKmqd19jTef64Wrw7tNzeHCGXFUBDsURYIRCakk7P1/e
         UqOEyaU/ZDPGhS0AG2zgBwe8CQOFJ/2VOYBndeGVRawo8aIuv1bMwMqFJhaZCgVSY5Pp
         txfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g8IsxiV1ueWEQz6BLlqMkwuvjDWOokg6+dgBBmYPiUA=;
        b=ItuGbYlahKfEsPMeT5WQxqQ5OsVNO7cXU0x5ephhMSKY9hsYn9aPJqxis4j15U9VED
         Zfh33m0R1wjx1x4sQgTGscbvT6eWVCy9Wv7TOr0N0D+QVWCPbGwxyu+Qa4FK47DNXw3E
         BZTd6cKzIVljkUZEFhi6NRhy0Z5+1nqXolEoSTgf1IKLLXSh49My30MjIaPrdGIMygeL
         B8onKClgLxhevBkegkrUYAwflHvdDHb670eZGMZ/Adm46V7PjCI1e0hnoRBYT/oGRRBP
         D8p095M2xWb44SFJ296IyutTZKpcIm72hhX6OmXCvhhBoA4tFtk04vDVBoBfbcRV0RiG
         EmQQ==
X-Gm-Message-State: AOAM530F7ctQ/DQsD+imATAUyNH8AGvf3sP3IFL13U1OX/ny5vps/zdL
        f/+TrUggRKCzrxtX3Ts2ZD6o5Q==
X-Google-Smtp-Source: ABdhPJyYk0HGjzKP1qGp+CMcvZ+HTl9nR65rGuUz90NUc/BPKeR63KmBoopkYHmOHokkgOwyestcfg==
X-Received: by 2002:a92:d0d0:: with SMTP id y16mr1668509ila.158.1599750059704;
        Thu, 10 Sep 2020 08:00:59 -0700 (PDT)
Received: from [192.168.1.10] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id y19sm3127724ili.47.2020.09.10.08.00.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 08:00:59 -0700 (PDT)
Subject: Re: [RFC PATCH for-next] io_uring: support multiple rings to share
 same poll thread by specifying same cpu
To:     Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        io-uring@vger.kernel.org
Cc:     asml.silence@gmail.com, joseph.qi@linux.alibaba.com
References: <20200910070359.14683-1-xiaoguang.wang@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d926108a-eda2-3041-0afc-7c82f0c0ac70@kernel.dk>
Date:   Thu, 10 Sep 2020 09:00:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200910070359.14683-1-xiaoguang.wang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 9/10/20 1:03 AM, Xiaoguang Wang wrote:
> We have already supported multiple rings to share one same poll thread
> by passing IORING_SETUP_ATTACH_WQ, but it's not that convenient to use.
> IORING_SETUP_ATTACH_WQ needs users to ensure that a parent ring instance
> has already existed, that means it will require app to regulate the
> creation oder between uring instances.
> 
> Currently we can make this a bit simpler, for those rings which will
> have SQPOLL enabled and are willing to be bound to one same cpu, add a
> capability that these rings can share one poll thread by specifying
> a new IORING_SETUP_SQPOLL_PERCPU flag, then we have 3 cases
>   1, IORING_SETUP_ATTACH_WQ: if user specifies this flag, we'll always
> try to attach this ring to an existing ring's corresponding poll thread,
> no matter whether IORING_SETUP_SQ_AFF or IORING_SETUP_SQPOLL_PERCPU is
> set.
>   2, IORING_SETUP_SQ_AFF and IORING_SETUP_SQPOLL_PERCPU are both enabled,
> for this case, we'll create a single poll thread to be shared by these
> rings, and this poll thread is bound to a fixed cpu.
>   3, for any other cases, we'll just create one new poll thread for the
> corresponding ring.
> 
> And for case 2, don't need to regulate creation oder of multiple uring
> instances, we use a mutex to synchronize creation, for example, say five
> rings which all have IORING_SETUP_SQ_AFF & IORING_SETUP_SQPOLL_PERCPU
> enabled, and are willing to be bound same cpu, one ring that gets the
> mutex lock will create one poll thread, the other four rings will just
> attach themselves the previous created poll thread.
> 
> To implement above function, add one global hlist_head hash table, only
> sqd that is created for IORING_SETUP_SQ_AFF & IORING_SETUP_SQPOLL_PERCPU
> will be added to this global list, and its search key are current->files
> and cpu number.

Can you resend this against the current tree? Looks like it's against
something that is outdated. That'll make it easier to test and review.

-- 
Jens Axboe

