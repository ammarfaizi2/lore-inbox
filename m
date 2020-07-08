Return-Path: <SRS0=yVW0=AT=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA1AC433E1
	for <io-uring@archiver.kernel.org>; Wed,  8 Jul 2020 22:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C52320772
	for <io-uring@archiver.kernel.org>; Wed,  8 Jul 2020 22:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="aKLNGyqb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgGHWdX (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 8 Jul 2020 18:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgGHWdW (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 8 Jul 2020 18:33:22 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD591C08C5C1
        for <io-uring@vger.kernel.org>; Wed,  8 Jul 2020 15:33:22 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o13so50977pgf.0
        for <io-uring@vger.kernel.org>; Wed, 08 Jul 2020 15:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cXCFTCxGdtV8MyFCzLPx+cLEa/wOMXI2VsbmUQ1pcc4=;
        b=aKLNGyqbfjlfypU3XSMi37ElWycSd5QOuRPRrHJZ4agy9sAPP83A9uImVzcMrPsCyW
         v4YrXUXCFMXFV1OPnsI6cv6ewTt2HnhMuY8YGdzuPwtivUTysB/nKgsLLCTDm5GGAfs4
         FwEZP9zGAZc1EbElR2XmPp0/xhwzO08Yc1gtgUKbC7+cN7/oLMht6hdbtTqJ1LHZFP75
         pK4yzqjIliJ8DsH8cNHobVsZaYyZWgTSGzQ7tS4t2UZYxVPxgNmD/45Rz9eSMRxIZ1Ta
         D477T9OBtjhr0bN/mqQaZX8WtKPXbQ+ZtnMtbID3Gat5wHy72kqpQR8TXvXdq5rk2wlR
         v1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cXCFTCxGdtV8MyFCzLPx+cLEa/wOMXI2VsbmUQ1pcc4=;
        b=NwcD0avkrV5MLvFuAe20hD4ITOvr0yFuXt3VzAhIFX4P2A9DWjKBTXoLyMx7L7Qp2u
         eVgXEHf47lra0ORvHod/rowA7W+mWp2NXOSNhVfqvbMzS/yTK7SkM0EcmR8Yuld9psc1
         H/9L+4Go2+Uyr/YlmEE2jQiJAx810eq4xNYVIn2pXEce46OxJbknu7T41mtxCpEcUYBL
         P7zYObt0g4B1mqDSH+wrJYNKlpoFdLodzzVDXpgO6G8uS5A9VLTiYuQGolYyewdgsQs6
         +mncukk3syDMDP4lZzQjsmBbWpskGjG7ciA2TRYpemZ+wXE+uVfcBnhh+/XIqpenawB3
         nqOw==
X-Gm-Message-State: AOAM530S0uKCX8InEsJklJFxYh1A3nxhY8svc7yC1uZ7tXkQE4CZnJda
        WPyvjRyyGr7mN7tESIChvMzomg==
X-Google-Smtp-Source: ABdhPJwmW+0eXcpEdnrPdMds8vC0mMjfwyN7OLN0bdEGS8KuBNIQf3vaSkBw9U+RNKl+HF922AzeHg==
X-Received: by 2002:a62:140e:: with SMTP id 14mr12167903pfu.196.1594247602171;
        Wed, 08 Jul 2020 15:33:22 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id s22sm697987pfm.164.2020.07.08.15.33.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 15:33:21 -0700 (PDT)
Subject: Re: [PATCH 0/2] Remove kiocb ki_complete
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>
References: <20200708222637.23046-1-willy@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <807e622e-429f-28a0-5756-765648fc5bcb@kernel.dk>
Date:   Wed, 8 Jul 2020 16:33:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200708222637.23046-1-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 7/8/20 4:26 PM, Matthew Wilcox (Oracle) wrote:
> Save a pointer in the kiocb by using a few bits in ki_flags to index
> a table of completion functions.

I ran polled and regular IO testing through io_uring, which exercises
both completions that we have in there, and it works just fine for
me.

Didn't test anything beyond that, outside of ensuring the kernel also
booted ;-)

-- 
Jens Axboe

