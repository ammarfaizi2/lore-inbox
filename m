Return-Path: <SRS0=FaGP=ZG=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFE8C432C3
	for <io-uring@archiver.kernel.org>; Thu, 14 Nov 2019 21:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07B8D20715
	for <io-uring@archiver.kernel.org>; Thu, 14 Nov 2019 21:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="LMmnLFcI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfKNVZr (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 14 Nov 2019 16:25:47 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:39823 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfKNVZr (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 14 Nov 2019 16:25:47 -0500
Received: by mail-io1-f65.google.com with SMTP id k1so8502266ioj.6
        for <io-uring@vger.kernel.org>; Thu, 14 Nov 2019 13:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=YRvnGayy7F3kTH/WIgMIWXmCPWBJ8YxNztbnXloQqC8=;
        b=LMmnLFcIY/IH6qG2caqMfMNgsYbZURw9cmChiIVw1bEJkAuN6aQpsfSMAlDu9q9iD2
         ZYoDkP3PUDXPLL5/1TUH+oQL9ePJvRBcvZ1OXnWiJ1ExkxscUmKTHCYQqQ9+LHQhmf03
         tFldf3Q6KADOdvE0ZPT59qs0x0+LiBJm950ER31sF16LL6QO5/WqXHyQdEdfHK1+nTeY
         RUGAdY1fCfHql7IDUeuD1UiE9GZ5FsUyDYXwMIi+GSHhMNpYcaN3gK5HPyDGwc7Psx1D
         nMMo/I3N9JY7DsNhy5O3wLBy4hGYLJvNcqQKkNLRXfqB6BhFqBpQdg2Ny+FJdb8HUwjk
         KMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YRvnGayy7F3kTH/WIgMIWXmCPWBJ8YxNztbnXloQqC8=;
        b=uUneePYTMByEdsCaqs50M73xQ/6qKCc1zMuCjLwMjOIAJvLVMzl5tzWc8bTH7alHB1
         /xPTMPVjTSkdQJ9v6pUlMFhuf+DevTXEe0KecYdgRBTFc94OmB7lxnsh/gvxhVf1B0z9
         QdI1JJb0p2i59KYS0G8uMkr99RNJ3fkVY7GBQBixdU5zoWrwOZC8mDWi/xGPYee9aELE
         ER8RYFk8zbOuf53IWPv2I3Vu+Qg+mONWqz7yR7KB1Kp0bvA2jZ0ROiBtOVZhrwE2kyEx
         Gud4Q54qCCtm7glJ3l+fhpjydHL2WEV6h6Mr9xmIDWaOXLvTCPWwPHE6EsiFQm2/f0tJ
         nsrA==
X-Gm-Message-State: APjAAAW9AWaU1dxLWVnlcEKIAoxDbFFAp7GHeEQkmcm7/FFkuhRxlyKt
        s0z4ZV7CBXJKsBctE2y6p/He89SOSAc=
X-Google-Smtp-Source: APXvYqy6WSDAoJNUGzLh0YZi+P7Ad6hgtpwHYtj3osZF9M8HVwDkMou4xirXgK1XH2MkvFws2wUNWQ==
X-Received: by 2002:a02:6d48:: with SMTP id e8mr9345551jaf.72.1573766746067;
        Thu, 14 Nov 2019 13:25:46 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o4sm991549ilq.15.2019.11.14.13.25.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 13:25:45 -0800 (PST)
Subject: Re: [PATCH] io_uring: Fix LINK_TIMEOUT checks
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
References: <9a5eef46f7ed9f52f8de67d314651cd4a4234572.1573766402.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ef655254-b8ce-8ee3-a776-d44803557ad9@kernel.dk>
Date:   Thu, 14 Nov 2019 14:25:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <9a5eef46f7ed9f52f8de67d314651cd4a4234572.1573766402.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/14/19 2:20 PM, Pavel Begunkov wrote:
> If IORING_OP_LINK_TIMEOUT request is a head of a link or an individual
> request, pass it further through the submission path, where it will
> eventually fail in __io_submit_sqe(). So respecting links and drains.
> 
> The case, which is really need to be checked, is if a
> IORING_OP_LINK_TIMEOUT request is 3rd or later in a link, that is
> invalid from the user API perspective (judging by the code). Moreover,
> put/free and friends will try to io_link_cancel_timeout() such request,
> even though it wasn't initialised.

Care to add a test case for these to liburings test/link-timeout.c?

-- 
Jens Axboe

