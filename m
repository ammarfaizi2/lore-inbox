Return-Path: <SRS0=PUae=Y6=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9ABC5DF63
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 18:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CE41217D7
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 18:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Ad/Jn4kb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfKFSTM (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 6 Nov 2019 13:19:12 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:35426 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfKFSTM (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 6 Nov 2019 13:19:12 -0500
Received: by mail-io1-f65.google.com with SMTP id x21so12384895iol.2
        for <io-uring@vger.kernel.org>; Wed, 06 Nov 2019 10:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AVCvvj/Bzpo7G/F8NANL89VeLcgohXoVWpiNdF7oDcM=;
        b=Ad/Jn4kb8jBTYszgLQm5ysp9ROSapTbqb8P9O3Gdb460cmWSAsOXEof+h5bV4A/p3u
         GZElFKu0RK8Mr3F1HH8Qt7DFcz+T2nTs5fCtqJb8eEXaZRi774Ed5cWdPbruRBDP9/gS
         dRRC9prmSGRzYLjAUdS/gBNrevvtTORN2BdyjiOb+H9JJQgm+ZPfiugVnpvv3D3/6WQg
         wwFCy6siwk8Jd5lmY8aeV6QGScw/xeBp5GTZk3uFE2FoO9ACoCjpZhFzJXOkPJ62vqhg
         t2Na+dDqYR72c4anOCikillcWLJjjHB7h/xd1fEN6/aDLye2sb8oCKjHeINbmswffty4
         fR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AVCvvj/Bzpo7G/F8NANL89VeLcgohXoVWpiNdF7oDcM=;
        b=LEoI3gJkNTQtBDI+UjCDiwt8GAltM/5h2I+gsKWSPJYYzmDQWzYNmf8a+RlK8qrexg
         iefpFb3kReo0oZivt6skakea89iKfGK4WH6Y78T61lBLD1HG2loPueOuQyjtw28iM+ey
         aAKbgqwCUZ02/7LASOhnR/ickARbg3qdjHUPX5UwQ68E5Z1PGGMKd71Uo80m9eGTLAgo
         mj0R6XpLjCg5DTzaQKoXkj0cxEWKXZNiqx5fgqAi86DrqWETvOnTEbYw6uvWC4KNrDTD
         j75Y5e5lWiWpjvUa2vBbbOr64vYQDEsUxaljNj9QNTQoVjapV/h8bt/p8nBSsoIJ8NY6
         alVw==
X-Gm-Message-State: APjAAAUjuXPYAg+Eompr8lmAoS63gDDl6ilLjD+9XJoIO1PY7ao4lR0K
        +0yPT4WB8uVSyrU5p5fT0aS1Vt3bXHQ=
X-Google-Smtp-Source: APXvYqw6N1opvLyh945XNas+K8vW4Cn4j/sli71jMvBdLd8yjTe+PiMAVS0yHGDcB3G9izd4vLMfFA==
X-Received: by 2002:a02:a157:: with SMTP id m23mr8459257jah.135.1573064350967;
        Wed, 06 Nov 2019 10:19:10 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u21sm3608788ila.41.2019.11.06.10.19.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 10:19:09 -0800 (PST)
Subject: Re: [PATCH 1/1] io_uring: Remove extra io_commit_sqring()
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Bob Liu <bob.liu@oracle.com>
References: <ca020164c33381c602d3188d95e0d650a5c625ac.1573058949.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b16c107d-890c-6e15-ed24-0375a7cdb49a@kernel.dk>
Date:   Wed, 6 Nov 2019 11:19:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ca020164c33381c602d3188d95e0d650a5c625ac.1573058949.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/6/19 11:12 AM, Pavel Begunkov wrote:
> io_submit_sqes() calls io_commit_sqring() at the end, so there is no
> need for sq_thread to repeat it.
> 
> Fixes: 09c0eb1f1b93b9cf ("io_uring: Merge io_submit_sqes and
> io_ring_submit").

Thanks, I'm going to fold this one in with the offending commit.

-- 
Jens Axboe

