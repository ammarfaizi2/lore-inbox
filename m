Return-Path: <SRS0=KDoC=Y5=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14328C5DF60
	for <io-uring@archiver.kernel.org>; Tue,  5 Nov 2019 23:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE16621A49
	for <io-uring@archiver.kernel.org>; Tue,  5 Nov 2019 23:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="X8mPSlHL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730171AbfKEXhd (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 5 Nov 2019 18:37:33 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37187 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbfKEXhd (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 5 Nov 2019 18:37:33 -0500
Received: by mail-pl1-f195.google.com with SMTP id p13so10487817pll.4
        for <io-uring@vger.kernel.org>; Tue, 05 Nov 2019 15:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=j0E6XwYTZMIgiK93xPzO5B0BK9Fpheq/Pl9T4Mlq3w8=;
        b=X8mPSlHL7XNufQxWby9JeUZsmD6ahdgIT1Uuw2mECW/mTU/uGuramzbUCNvg2vhF8z
         EYK+EfG/Wi/dH5On8hrOem6lu1jeZUPmYpeOu+aUMi/r9aDifGrs9j94pttlcU1i2P6e
         qWVq1JdEiy0mO5gQeW9Ks4F7OzD8Epct9Uy7+nlha7E2jE2eC2px/EjfmhP/cE9btkXL
         1aYuMJUzhh+KYJZbryB0zNgVN+BethB+68YmNU8H7SDstK/c5arJmV25C/qBog9BiTbk
         Uq8gk/GgGDWlLWFQedDAeXTwjCLSYq85wA9IzSYtKQqxOSB2IKxVXqR7w5qGXZLFpAUG
         M3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j0E6XwYTZMIgiK93xPzO5B0BK9Fpheq/Pl9T4Mlq3w8=;
        b=CMhNS212YfgTAy+Z+mCN85yuk0+d1zCV8jtRBDQYfJFjc9YvVlaWYzJcEP7+xr3sZ3
         6giN18O62O9So/mZqosPX0EIxKO8EsMfMjvn1w0ajIBeRjZTd/h6A5s9Q2176nmkSgZr
         vj+02o25B692RLaiwTiXjFtKMvZfR4eEsYli+LSNSOY2kMqdUOK0kSksLl5kJM31je4W
         Z9Jzsjs/Jz0QQraBuD8qy/ObRBBOJQAeQjIR+AbX3b28Lou04apkIsrp/nojkQLFtYcd
         Wz3zuEFYTIKO5L/tK+Mf7aMR8roeVdUQRE8CHE896kHBVdEdmVLBaEj+oDu988THntrY
         TnWA==
X-Gm-Message-State: APjAAAWy4UqAaLdT+GUtUrhGxR/jSH4jEogqXbW80XXBYCc7iiRhpoKe
        neYMR6a3ud/Zek199PTlhA9Z1g==
X-Google-Smtp-Source: APXvYqw7bWOWs5y/df4AVIfcx+SW1nd02CV9AKbUz93vYBi4Nwi3B4gr7adMeLJCClk0kd7AmTXwzQ==
X-Received: by 2002:a17:902:ff07:: with SMTP id f7mr34874048plj.216.1572997052810;
        Tue, 05 Nov 2019 15:37:32 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1130::12c1? ([2620:10d:c090:180::d575])
        by smtp.gmail.com with ESMTPSA id f12sm19319339pfn.152.2019.11.05.15.37.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 15:37:32 -0800 (PST)
Subject: Re: [RFC 0/3] Inline sqe_submit
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
References: <cover.1572993994.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a0393f05-dff2-6c34-4ba1-f6dba67955d2@kernel.dk>
Date:   Tue, 5 Nov 2019 16:37:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <cover.1572993994.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/5/19 4:04 PM, Pavel Begunkov wrote:
> The proposal is to not pass struct sqe_submit as a separate entity,
> but always use req->submit instead, so there will be less stuff to
> care about. The reasoning begind is code simplification.
> 
> Also, I've got steady +1% throughput improvement for nop tests.
> Though, it's highly system-dependent, and I wouldn't count on it.
> 
> P.S. I'll double check the patches, if the idea is accepted.

I like the idea (a lot), makes the whole thing easier to follow as well.
Just one comment on patch 3, that needs fixing.

-- 
Jens Axboe

