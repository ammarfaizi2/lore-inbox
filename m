Return-Path: <SRS0=koBJ=Y4=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB18ECA9EC9
	for <io-uring@archiver.kernel.org>; Mon,  4 Nov 2019 21:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72C2020848
	for <io-uring@archiver.kernel.org>; Mon,  4 Nov 2019 21:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572903787;
	bh=huWuXQnQHcZ4C2AKujwNQBnwPPnN0WsHeFe43cj79Eo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=n1wcDaVnqs2MoEAtI9V2L9iPo90AQn3ejN46xgFzFdFPNsGMPUpqPCeKKsRUvGLAT
	 dEs3WvOovQ+u+rmK2bx9I/rVcSyT3Bh8ve523sYV5+KwEgjV7eT86Cr6dHEjKU9rsA
	 OXSoWoYTWDJEYVYKKCohtjGhniPk6pd0ska0pGRw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbfKDVnH (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:43:07 -0500
Received: from mail-qk1-f180.google.com ([209.85.222.180]:36816 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728409AbfKDVnH (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 4 Nov 2019 16:43:07 -0500
Received: by mail-qk1-f180.google.com with SMTP id d13so19197010qko.3
        for <io-uring@vger.kernel.org>; Mon, 04 Nov 2019 13:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=huWuXQnQHcZ4C2AKujwNQBnwPPnN0WsHeFe43cj79Eo=;
        b=grN9XsmgTnXpB8YyCU0rnwbOOamvjj+OVO11Mh8JNtx+o0f6E2Me/Crpf0xQaobHPg
         cZRjFpPyVK3vxsUuKOrGTL1LBr/tkaPIbz808Xs59goyXUFDtwIMM8xTzgoTZ1L4tQQD
         HxPov00L/WLmWKjTt/IPUZIaJ7sOtkGKDdgzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=huWuXQnQHcZ4C2AKujwNQBnwPPnN0WsHeFe43cj79Eo=;
        b=JzTuVyR+GDpLNT6/jRSRo7Hi4y87NlE0Rq6NNUADDHhfh3icAav9TftepGp+uwTDl6
         YL8+7Rc89zk3iyKBdn2dbi35+mQWe7QIMW6J5lkbJzRwCfi55A+XvXYkEu7WRXiNIXqc
         Qr2aovWrXFoFVjn13f1ncsloXAujY85IXPb0AH26/EYQP2qWDXvTBrDfK1qiR26PXVCv
         vTYOJHaLBZM8sXsSHpCpMrd6rOlkY2Shk3ssMmojLxLS2Tty8v+2MABxdhqGqieoZp4B
         vZ6jNQkuvURk/eZmntNZq+sExukuMa9LSZNcd9plDo554yeuF+cyccmkEdZykcnvRpFx
         rt7Q==
X-Gm-Message-State: APjAAAV+IqST1AugFs3Ckj8zD8m90BlrJAei7gaq+p9sJ8XWiZCbbLCP
        mIVtYJbRdUH0QZuGTCf2lh9rlQ==
X-Google-Smtp-Source: APXvYqzlUDg2JmwH5Qj8OOUYnlZlYEKkUkW3Q4+veD9YT9h4LAwuOY1WoRaiIzqjVHMsDqOgpUVPnQ==
X-Received: by 2002:a05:620a:1266:: with SMTP id b6mr7557987qkl.149.1572903784569;
        Mon, 04 Nov 2019 13:43:04 -0800 (PST)
Received: from chatter.i7.local (107-179-243-71.cpe.teksavvy.com. [107.179.243.71])
        by smtp.gmail.com with ESMTPSA id t127sm9592714qkf.43.2019.11.04.13.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 13:43:03 -0800 (PST)
Date:   Mon, 4 Nov 2019 16:43:02 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org
Subject: Re: This list is now archived on lore.kernel.org
Message-ID: <20191104214302.3p6tood4gea7ssg3@chatter.i7.local>
References: <20191104212144.sszfmbbxdddxt765@chatter.i7.local>
 <0797e1e6-a1f8-53ae-0b58-e2d703bf2d54@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <0797e1e6-a1f8-53ae-0b58-e2d703bf2d54@kernel.dk>
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On Mon, Nov 04, 2019 at 02:40:24PM -0700, Jens Axboe wrote:
>> This list is now archived on lore.kernel.org:
>> https://lore.kernel.org/io-uring/
>
>Great, thanks! It's not on the index page yet, but I guess that
>gets updated occasionally?

It is -- do a forced refresh.

Best,
-K
