Return-Path: <SRS0=pC3Y=ZR=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F3AC432C3
	for <io-uring@archiver.kernel.org>; Mon, 25 Nov 2019 22:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FC9120740
	for <io-uring@archiver.kernel.org>; Mon, 25 Nov 2019 22:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Mm1mKuU3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbfKYWTC (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 25 Nov 2019 17:19:02 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:33807 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfKYWTC (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 25 Nov 2019 17:19:02 -0500
Received: by mail-pj1-f67.google.com with SMTP id bo14so7265960pjb.1
        for <io-uring@vger.kernel.org>; Mon, 25 Nov 2019 14:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=grspVAXDmkE0dNZL/P1XqXodoDp9HEjt+Jc2GQOCYbk=;
        b=Mm1mKuU3clKjnlOVtjm02hwUVI9T6YnO6lc21REe00lsi4017mlSAOsU2BwzI4xbZC
         QO4VI5y6alVYrzE0saOXTLl1Lyqm+hfpmpMvukuNzSSnsunJ3DK6eYxBNAeAsbqKngrG
         NbcHfy5vGywSrKdvKbbrN+63F1bgKr+omWjUNfQOGZ4rl2QyiYbHSCwWZu4c02FyVnE6
         jo+c0mge9jOLYMnneFCn0aa2yeTiuR7V0+o/hiKPu24sWovpOAytPl/K4lvEiczl9iFJ
         mio4fcG5r8nOybSKYGiOfDGZ9YeG32TjYqnZhRu0P9LsAEmQMv1a5ecFRXNYIHNlOWKk
         XLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=grspVAXDmkE0dNZL/P1XqXodoDp9HEjt+Jc2GQOCYbk=;
        b=JFcsFO7FwP2azk1JV4nlXAoo5dOIB1SgIntbGW2ny/XKHuCx80RCIBOAt+x9X7aCcS
         SaEVeG0YzIsUQh/UZsy20T+sle9+82PQqtR3tS52+IVSOuMMEthpW9bpqenDGa6SUbGI
         5VCRrM7s3+HNX1uTquhUj0QBUopylBzuK+PjYYf5/zpLGnCzJ+2gPsjKHRRzp2/qy9eW
         a8nrNjVqfGhfqvN097Jls5Un6qKrisgjqe1JegvCCOrw9FdnPcU/FwgL8crKJYe1FuJf
         Eyv5jMUomYJy6Geut3DoikrykfXJPJpxhmKBk2+WYUOsgqBo01KYtASapHJk1yz8qYWi
         wCDg==
X-Gm-Message-State: APjAAAVDyEsrdiKijPlztKGXI4yBUnebq7W6GiSkUF+GkfB9EvO/MaKm
        BZhvJmgykCpj1JG3acgetPDs/3jxc2ShCg==
X-Google-Smtp-Source: APXvYqzG95HC/QXFdC9DLYA3mgNiiPBBRiANFrrkxXk66ABUw0Ol4pyGWx1t6lB+YMJvOkDBfxmc5A==
X-Received: by 2002:a17:902:ff15:: with SMTP id f21mr14744507plj.163.1574720340003;
        Mon, 25 Nov 2019 14:19:00 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id k14sm9852754pgt.54.2019.11.25.14.18.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Nov 2019 14:18:59 -0800 (PST)
Subject: Re: [PATCH] io_uring: Remove superfluous check for sqe->off in
 io_connect()
To:     Hrvoje Zeba <zeba.hrvoje@gmail.com>, io-uring@vger.kernel.org
References: <20191125220956.167347-1-zeba.hrvoje@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <500f88f9-cc5a-15d6-595e-394d44b66cb1@kernel.dk>
Date:   Mon, 25 Nov 2019 15:18:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191125220956.167347-1-zeba.hrvoje@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/25/19 3:09 PM, Hrvoje Zeba wrote:
> This field contains addrlen value and checking to see if it's set
> returns -EINVAL.

Folded in, thanks.

-- 
Jens Axboe

