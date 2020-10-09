Return-Path: <SRS0=/ybh=DQ=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1F9C433E7
	for <io-uring@archiver.kernel.org>; Fri,  9 Oct 2020 15:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25B2322276
	for <io-uring@archiver.kernel.org>; Fri,  9 Oct 2020 15:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ZQ9oaMIT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389074AbgJIPGD (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 9 Oct 2020 11:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388851AbgJIPGD (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 9 Oct 2020 11:06:03 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B7EC0613D5
        for <io-uring@vger.kernel.org>; Fri,  9 Oct 2020 08:06:03 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id h6so7397057pgk.4
        for <io-uring@vger.kernel.org>; Fri, 09 Oct 2020 08:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=A4XLS9Sjb0ikJRP/ak6wlSN7JYLZDRt38oqZQ2jJOjA=;
        b=ZQ9oaMITG9omPFizmclPGoPCPuXbLk2d/ORRMFXeNE0/QT6egL2gMaCM4LeFjX8Zww
         lDMpImKE0EfQ5JsVDFcbn7ANWtSNGI+OvjKcqDgI3wl1WrewhTysMD65Mx9cyBRlSrh6
         bYq6VsNL3hF8Y2HAMLca3xgkkpZqIRv9Xyyj6hvtoOP/gd/VBull1kxw+haEkag1u8Z7
         rt3zteJuytSg7APNPVIRYgBYqpnZ2cJi3eEwjX/mHaYedJfW/9vrk7nFLVhv72If39jS
         Isd2PFli6inxukMCaR9YKJzg//S6dEycwkER8H8dUnW8coPYCyR+ByKPycNLCWe5k14j
         E4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A4XLS9Sjb0ikJRP/ak6wlSN7JYLZDRt38oqZQ2jJOjA=;
        b=Zq1vPLMKZ9Jc9dMC2x6hQjN53eOUodVHdxQThpcwMqUZ1zvV5S4edkfihDADg/6Kn+
         pszRrymEZIFKuNzZmZeVnj1iCiiBs3zAqylkoaOME+gDJiBntIBahhu05cN+ft9tptTm
         zhdEqdGDqVUqfta3oyIC4h4BzRn4QldlIUP3yH5/aRmMm0wAtlM0biMrKfLzA3ZE9Mdo
         5TW9Tgv4j5ytlRJrybIIfQSDi2n+YLPK0Izo5BQGVrQq+1LyOHixEjOG84CCetjiKHOb
         zJ4TPuhxcCDZJ1krWM7sFXPoa9FoXHqWAYgpnVktr275tS0j4DQ8taKtkc37kddqQmcH
         vKpg==
X-Gm-Message-State: AOAM533ds1zFF4gjJ14nTCrlCNU/eS4CulZ6wGowvJoEI9QsgzTSspCN
        CXc+Y1wkUI17YNtD6o3LlSjW6g==
X-Google-Smtp-Source: ABdhPJzGUj5KeKjBc2Qgt2BN1KwvpMRzspLOSifYIVUG7Bw8O2BUe8bxhTK94Ag06rFZrDfGNRgVTw==
X-Received: by 2002:a62:dd02:0:b029:142:2501:398c with SMTP id w2-20020a62dd020000b02901422501398cmr12263183pff.81.1602255963045;
        Fri, 09 Oct 2020 08:06:03 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id v3sm12779295pjk.23.2020.10.09.08.06.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 08:06:02 -0700 (PDT)
Subject: Re: inconsistent lock state in io_uring_add_task_file
To:     syzbot <syzbot+27c12725d8ff0bfe1a13@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
References: <000000000000358ba805b1385785@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d16d920c-b617-1586-5781-a4a79a80d9ad@kernel.dk>
Date:   Fri, 9 Oct 2020 09:06:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <000000000000358ba805b1385785@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

#syz fix: io_uring: no need to call xa_destroy() on empty xarray

-- 
Jens Axboe

