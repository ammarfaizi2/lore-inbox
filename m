Return-Path: <SRS0=GIeg=ZU=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A345C432C3
	for <io-uring@archiver.kernel.org>; Thu, 28 Nov 2019 17:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4701121739
	for <io-uring@archiver.kernel.org>; Thu, 28 Nov 2019 17:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0SVOpsKF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfK1RGc (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 28 Nov 2019 12:06:32 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34142 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbfK1RGb (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 28 Nov 2019 12:06:31 -0500
Received: by mail-pg1-f194.google.com with SMTP id z188so13157388pgb.1
        for <io-uring@vger.kernel.org>; Thu, 28 Nov 2019 09:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1imsgxsl3ywnARWtQwBa3rbLqViODjeJtSs8fpqWLOk=;
        b=0SVOpsKF/rm6XOc9rX2WI5ruSf8tRL3Y1ZBPEpoDH121sJ7yEBCx2gCLNFJkFV0uBu
         c7HOzlWp632OvavPVroeULxKs5eb4pJhXC9ZsjHzqXUcFDvohNcHEyAaHqKdI0bLWgLV
         fzG2W7VlcMpPg/ByPMsY7oMNI8BcnHKelIzWd26cs+AjNMmVzKNkY8IMa9/oGHbIa328
         z/U8bwCZGdU9x1eJoQJsq1406Tw2iarHo7x+W9+C4SoIhrrQhNF0HFS0KBezBOorToT1
         Ou+lOn9YfT/+ApWec9gVECHa0Li4bKX6b8lk1548Lrl3d3Ze5FBf5j5zZXdB+okS5azd
         Tivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1imsgxsl3ywnARWtQwBa3rbLqViODjeJtSs8fpqWLOk=;
        b=ktkMHgUvFetkDDoiHaleDDx1+v+Q393lvHOzX0MGnxnH2P8/uaNoCPAopPKfRx4Dik
         dNoY8kW/qyV66lTtvthM/dkli0nPzowMjpsIopZF+lPs03EVJUwrCquwFQ2+juGdXqX8
         G8NNpKOcGbeX920G0sLWnzVggcq6s4mxWC17aHfsH2iKqdIxwxn25t0HQqTsh+n+C5Q/
         JfOiLfjj2TSu1+zQTbaBC9xtnO73hATKPvVB2ZK93hqclF3Ccej74qRvPFaaMEmP1Abx
         zyVsPreGoE1FA85z/yJfpekCUQC/ib8kM6Rnv6XegI1YDTafecgFtx5PCguTBd+NKugx
         KY4A==
X-Gm-Message-State: APjAAAX71aK18Vfc6dXYJwuQIzIeIZ3pYCKcBXdGub/u78wGv4O3YWzj
        OgBgT4CvlddlQhALZiWGBA2w1XbnJmg/Cw==
X-Google-Smtp-Source: APXvYqw/ndjuCJGaOPR8gE8No2mNqL89C3zaSA4+ynOYaSPZVMH93zSCpG1tJ1c9U/h04d3eKbyrGg==
X-Received: by 2002:a63:4466:: with SMTP id t38mr12323393pgk.316.1574960790649;
        Thu, 28 Nov 2019 09:06:30 -0800 (PST)
Received: from ?IPv6:2605:e000:100e:8c61:a930:60a8:686e:252a? ([2605:e000:100e:8c61:a930:60a8:686e:252a])
        by smtp.gmail.com with ESMTPSA id a12sm21286896pfk.188.2019.11.28.09.06.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2019 09:06:29 -0800 (PST)
Subject: Re: [PATCH 1/1] io_uring: add mapping support for NOMMU archs
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     linux-block@vger.kernel.org, io-uring <io-uring@vger.kernel.org>
References: <20191128115322.416956-1-rpenyaev@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0371ebda-9ec7-e3fc-3d80-3160e84aa283@kernel.dk>
Date:   Thu, 28 Nov 2019 09:06:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191128115322.416956-1-rpenyaev@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/28/19 3:53 AM, Roman Penyaev wrote:
> That is a bit weird scenario but I find it interesting to run fio loads
> using LKL linux, where MMU is disabled.  Probably other real archs which
> run uClinux can also benefit from this patch.

Not that weird I think, and looks fine to me. I'll queue it up for 5.5,
thanks.

-- 
Jens Axboe

