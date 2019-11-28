Return-Path: <SRS0=GIeg=ZU=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841C8C43215
	for <io-uring@archiver.kernel.org>; Thu, 28 Nov 2019 15:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C14021781
	for <io-uring@archiver.kernel.org>; Thu, 28 Nov 2019 15:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ghfm9r4D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfK1PSe (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 28 Nov 2019 10:18:34 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:47069 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbfK1PSe (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 28 Nov 2019 10:18:34 -0500
Received: by mail-pg1-f195.google.com with SMTP id k1so4684680pga.13
        for <io-uring@vger.kernel.org>; Thu, 28 Nov 2019 07:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Vz09qS99hyvV+5cErCqS+LojQyYSm3WMnbpZQwjAQlI=;
        b=ghfm9r4DFsb5fHfnc7g/ko5YJHWygsZv/hcBNlfcXpfFlyQiVMMlre6OpoJDyEbw8K
         Q4sx8HPS+CiM/ZpJ+APk4eKAqEJdDWSNmB43GmpDJ2+LW2A6DEpKnbHxBp3ijXaGOWv1
         sktDV5DC+ccHnARwl9EStR4Br0fwqX9bBHQ3155uy+xUB+yjfSKRPk+OXL9F4r2zywkW
         P8unVis3ScqzW8ZAzsZjRCAwHisRBGEVzMhrlcVt0djct49hzEi8VnFkkOzL13FVWu8Z
         /Xf0LC/h6I0YVUE+R5LoIKId8sa2tAaRzgk8TFvP5/nwRTjhbQ1Q7OZyviiab8oW8gJb
         JCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vz09qS99hyvV+5cErCqS+LojQyYSm3WMnbpZQwjAQlI=;
        b=e9GpfpteGNRuKZ9EjrsZP8/Sh3CPusuYZNuEUDzEG2aqeBOItRv/j+RAPDI0us2+Im
         k6yFDlYkYxqJ8v1dtACnJeORejBxpI5pASGLQgrAEPKmkTltwna+TCANgtU8dAUle3Y0
         I9PqR71BWxONMn/tLirXTeNc8FFtpN8rb0OwII5hmSxWbaqjrhwPjEzjsYmtljz+KEK3
         L6dBxRJrTHCkweU5V6ZVdihHnMXC/2Yui7wJDN8wwV8M0Y6Sut0yowvmm2bDJu0iv1Qf
         INUKsRRexfUqTznaiUPeOtSY/e5GtNKq7Ib5qIGRMdW45lvKe+NqM6NbZhrN1VGtE4Za
         tGsQ==
X-Gm-Message-State: APjAAAWlSYiB3iD9pjnIAsKzswJ+MDZJwMo0rdh3ByT5I1ILgD/aQTZG
        RMVF4bA99N1xntFbm/4Uw7l6Qg==
X-Google-Smtp-Source: APXvYqzDYfEjpOkxYsikOF3AlK0ttrBHAuqSaebABsl7aoIPyBRlEbusIMhiOewSWE05ceC8nHS3UA==
X-Received: by 2002:a65:6815:: with SMTP id l21mr11337032pgt.283.1574954312463;
        Thu, 28 Nov 2019 07:18:32 -0800 (PST)
Received: from ?IPv6:2605:e000:100e:8c61:bc69:2e63:573c:4afd? ([2605:e000:100e:8c61:bc69:2e63:573c:4afd])
        by smtp.gmail.com with ESMTPSA id w2sm21460471pgm.18.2019.11.28.07.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2019 07:18:31 -0800 (PST)
Subject: Re: INFO: trying to register non-static key in
 io_cqring_overflow_flush
To:     syzbot <syzbot+be9e13497969768c0e6e@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
References: <0000000000009f46d4059863fdea@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <71b86056-944f-c5e1-b4cf-35833a82761c@kernel.dk>
Date:   Thu, 28 Nov 2019 07:18:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <0000000000009f46d4059863fdea@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/28/19 12:35 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    d7688697 Merge tag 'for-linus' of git://git.kernel.org/pub..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=145e5fcee00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=12f2051e3d8cdb3f
> dashboard link: https://syzkaller.appspot.com/bug?extid=be9e13497969768c0e6e
> compiler:       clang version 9.0.0 (/home/glider/llvm/clang
> 80fee25776c2fb61e74c1ecb1a523375c2500b69)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=146c517ae00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16550b12e00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+be9e13497969768c0e6e@syzkaller.appspotmail.com

This is the same as:

syzbot+0d818c0d39399188f393@syzkaller.appspotmail.com

which is fixed by eb065d301e8c83643367bdb0898becc364046bda in my
for-5.5/io_uring-post branch, which will go upstream soon. Letting
you know so we don't have duplicate entries for this one.

-- 
Jens Axboe

