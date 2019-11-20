Return-Path: <SRS0=jdTg=ZM=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F89C432C0
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 16:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9FBC206F4
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 16:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="wKsYZexC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729867AbfKTQ0b (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 20 Nov 2019 11:26:31 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:42007 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727885AbfKTQ0b (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 20 Nov 2019 11:26:31 -0500
Received: by mail-il1-f194.google.com with SMTP id n18so167604ilt.9
        for <io-uring@vger.kernel.org>; Wed, 20 Nov 2019 08:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=JENUqEEnkMucQYcuF3hzwhPPTtO+OEvYvVNGiZXej+g=;
        b=wKsYZexC5vSXvFpFtEIocMf7yXYGNIjjSpxvBiQ3kU+tGcaRX9fxHi1klf+UeIDRlf
         1BndtbOC9kePbT8EBdXp+tTwbg/cw7wze8ojHoMHEPMitRgfiFgIlxVEpl9JjEtaQqlw
         HrvOR1zHlx56yMYUvbGKZaywZibdxD/tf1Bfz6Ak4YebiOTMuI+c/hmEJdaGTduNE+yT
         uDAOZwl5QJvZuKwye8LMsrYCFHHZ/7w5s6PPOUqBI0yJTqY/VU42woyfOYHaDRY36gMO
         lIbMGLCb+U383g6ICFeMpzqktydwHsHc96E+L9DsX8DLPQJLLgsYOnPIitb6bDK0/m5Q
         GgnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JENUqEEnkMucQYcuF3hzwhPPTtO+OEvYvVNGiZXej+g=;
        b=fQUrt1xE7rKLKoZ96VX/b7EdIpcw9G8vzV0nKyrG4sAz3HFJFiHkuOMIlhdnq7dEos
         w98PxlYEgI7r5O7KYBhnupX1PFsJLya7vN8/5uqaQtedYK7OpkTE5I6tUbQS/yeOMmDd
         voeix7pfYAXaQjLvUFoBgkRh8apZHy2DQiaM2K2FgbwUVpk0tHdWFf2pfXbD5J+19hK9
         b5blkL0iTyumYvVZ9Q/cWj55jpJa/OXG/LQb+4as3GIHoYuen/RdxoYaqGnCSGZTCNAM
         SRwl2+Mn12Kg90hcsk55MOh6079Ke1oM02kMSIe6v3xdkCQarQZpa6oaby7wTo7qk1kO
         bYWQ==
X-Gm-Message-State: APjAAAXi/iZqbfC73xX5QLU1v6487TzJO6yAv3Pj90qljb/KQsOyCFRs
        u5qIA0/r+SaRhbTQ9N8cCvNXSQ==
X-Google-Smtp-Source: APXvYqw9AiyFurVMLfdttmCuAKXzB/ZMgeFzgo3mCBRzz20cZpDSuTxB1JfsmCsMEH8BHQeRHNt3kA==
X-Received: by 2002:a92:868f:: with SMTP id l15mr4459061ilh.199.1574267190503;
        Wed, 20 Nov 2019 08:26:30 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o184sm6622713ila.45.2019.11.20.08.26.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 08:26:29 -0800 (PST)
Subject: Re: INFO: trying to register non-static key in io_cqring_ev_posted
To:     syzbot <syzbot+0d818c0d39399188f393@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
References: <0000000000003a1f180597c93ffe@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3d507894-afcc-5b43-f8d6-ca7812a155e6@kernel.dk>
Date:   Wed, 20 Nov 2019 09:26:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <0000000000003a1f180597c93ffe@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/20/19 8:58 AM, syzbot wrote:
> syzbot has found a reproducer for the following crash on:
> 
> HEAD commit:    5d1131b4 Add linux-next specific files for 20191119
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=140b0412e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b60c562d89e5a8df
> dashboard link: https://syzkaller.appspot.com/bug?extid=0d818c0d39399188f393
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=169b29d2e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14b3956ae00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+0d818c0d39399188f393@syzkaller.appspotmail.com

Thanks, the below should fix it.


diff --git a/fs/io_uring.c b/fs/io_uring.c
index 100931b40301..066b59ffb54e 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -4568,12 +4568,18 @@ static int io_allocate_scq_urings(struct io_ring_ctx *ctx,
 	ctx->cq_entries = rings->cq_ring_entries;
 
 	size = array_size(sizeof(struct io_uring_sqe), p->sq_entries);
-	if (size == SIZE_MAX)
+	if (size == SIZE_MAX) {
+		io_mem_free(ctx->rings);
+		ctx->rings = NULL;
 		return -EOVERFLOW;
+	}
 
 	ctx->sq_sqes = io_mem_alloc(size);
-	if (!ctx->sq_sqes)
+	if (!ctx->sq_sqes) {
+		io_mem_free(ctx->rings);
+		ctx->rings = NULL;
 		return -ENOMEM;
+	}
 
 	return 0;
 }

-- 
Jens Axboe

