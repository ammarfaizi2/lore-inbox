Return-Path: <SRS0=8McV=5Q=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00C8C43331
	for <io-uring@archiver.kernel.org>; Tue, 31 Mar 2020 14:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 993CA2071A
	for <io-uring@archiver.kernel.org>; Tue, 31 Mar 2020 14:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="L2KJMeVu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730760AbgCaOWb (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 31 Mar 2020 10:22:31 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:33189 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730703AbgCaOWb (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 31 Mar 2020 10:22:31 -0400
Received: by mail-io1-f46.google.com with SMTP id o127so21880106iof.0
        for <io-uring@vger.kernel.org>; Tue, 31 Mar 2020 07:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=qQFGTDyBxcDayATHaOuFvfk+Gyope6YHv5LCdkBtJrY=;
        b=L2KJMeVus19JD3Q/ZaG6uMmOtt0+zDtCRmN05x/ep08FThqBaSU3sfgE56+YAk3eym
         GZNu554h5vhJp2KUk1ePO/sNCzLDME3EgAI3hRRb9bFQHcK3LfjCxmkBFuqley/ofR06
         HNlt72dkz2p+Y7v6MBwjJN81NzaEN5lOWT7UITeAI1qyfOkE7ZJvOQ1QZm5v54rRQl72
         LAGyCQmzvmw9awPwitsK/A3dLnCjYRiAlujFinmKMDBWhkV1/Tmta5M8eaBuFDO1H4yM
         iUuSulvvZipUbaSDOPOpLclSfmRRRh2coEOWLjoR4wCXRcbatch/Yw65s4tLQYd4SCJz
         k6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qQFGTDyBxcDayATHaOuFvfk+Gyope6YHv5LCdkBtJrY=;
        b=nqLq7guCKNG9kjSH0a/G9Qj4Nj5b/mNQBOWbyTVg1eI7c6pvKXXFLEoUt84wmhgG0W
         pz3WEHTV8WTbxlNwn0qY214AjLSdGnpgFuy26X4bJ4OMJJC0OBEaioWxMMT+f9zziyVn
         TdcdS5JF3twKC4XrRIu1wB96voA7mvhPw001VhN8Z8wJc55kLijyQL+9f7mZu8zW0lun
         lofoRTfXe5Cd1YVDpTgbecd118oUkyZ/vOeKHfRER9H9EU2PNZ5bX2yICg95aRw9Dk9X
         0bJcrrQb2oJ85acxlF2Kcj6aDYgJVaNhfpsxE5+03imN6gdMCSyidUFDl++nUgo+8mRc
         n/0g==
X-Gm-Message-State: ANhLgQ3wSNQEgNcYMM91lMa5WQ4H7OiVNo6PJK/0izcfQBvV+aBCx5+t
        stz5kFme2GoP/LXKOadg9FoPuUszJJF8Ew==
X-Google-Smtp-Source: ADFU+vvDrxWU5gf3h6P5KZgj1YTwzx95QIsqx7wCFMwyCQYG9CHl6sK5SJe9TJx4HZlXc8RM8a02dA==
X-Received: by 2002:a02:cc4e:: with SMTP id i14mr936434jaq.86.1585664548382;
        Tue, 31 Mar 2020 07:22:28 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c87sm5949838ilg.2.2020.03.31.07.22.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2020 07:22:27 -0700 (PDT)
Subject: Re: FW: [RFC PATCH 08/12] fs/io_uring: Use iovec_import() not
 import_iovec().
To:     David Laight <David.Laight@ACULAB.COM>,
        "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>
References: <518953cd20d84fc5b6fc4ab459bf3459@AcuMS.aculab.com>
 <081d0ffde944432194ed0caf9f1df77c@AcuMS.aculab.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <92c1ae21-7424-df4a-fc87-1b1cb003025a@kernel.dk>
Date:   Tue, 31 Mar 2020 08:22:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <081d0ffde944432194ed0caf9f1df77c@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 3/31/20 7:59 AM, David Laight wrote:
> Fixed cc address

Why don't you fix your commit message while you are at it.

-- 
Jens Axboe

