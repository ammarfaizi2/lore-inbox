Return-Path: <SRS0=ex/T=ZC=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1127DC17442
	for <io-uring@archiver.kernel.org>; Sun, 10 Nov 2019 15:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D57A6215EA
	for <io-uring@archiver.kernel.org>; Sun, 10 Nov 2019 15:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="iT76+jqd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfKJPqL (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sun, 10 Nov 2019 10:46:11 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39408 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbfKJPqL (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sun, 10 Nov 2019 10:46:11 -0500
Received: by mail-pf1-f194.google.com with SMTP id x28so8669232pfo.6
        for <io-uring@vger.kernel.org>; Sun, 10 Nov 2019 07:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=2GQxyegm0e037btzeEVrHaTSoeZSraQmKEF2HPtcINM=;
        b=iT76+jqdNNWdjCQpvuTo3yccQOGR0HF+Vv8uFc80bOjg5+6/QCNi9N4XCDxrlmtZQZ
         jTDXAvm6Ni5EyKsKAO64wIdHFKHZfVHypp/Akr4g0KVcgTuC1g+F2b1RAQsbzb9j20LF
         iOybYFb60Cb2ex2uQ8h6ecwW9fS8Yumwkr8OArCiwjoT/GP6QXb7TYFGn9of+RMjRwmL
         Z7tIFtXCBDI4bs0FHdfquiMmEJdYS1kbWI9beyWOK93RQa9p5Ifj+b3wARLX2xhL/hXQ
         //Wv7q/9XFN8ofBdUy24esQtUFUCQq7sadQtnaxWYlIqrdP341tJ1WUFT/u2T8Fk8Uni
         QCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2GQxyegm0e037btzeEVrHaTSoeZSraQmKEF2HPtcINM=;
        b=Hamom58mQtfNZcjcbHLyD5HmF6bEvzzI1A/19iscg+lmK0tN/ET/p7L6uNfFwDjulb
         77Ayc8XFJ4QUgxEJLA+mFQj5Zt5pJJTvkUvohsScg9OC6u73T7E4hhVfc6Vsc4w1RPh3
         i4LTXJDp8tsPLkDFSeSjlLOyEMJVSNt1VVPQ6yx48NKhd/JRl/KqPCRm0HjhNCzoEfTD
         GOs2yCk6JOTfwDV77fsuNkOETDpfbGtG1gWwtLUuu46cjfKo/ccMeowC/yk9yv22fiNK
         bxa/nl5HJgn3jr5iHeqsCWNKSFO0A74/mNyUGQncDVKnnGo6Qpw1poeoDApTuUONYfhx
         JWPQ==
X-Gm-Message-State: APjAAAVMx8M9KdXkByWjsK4nkyw7ymbhJO/i3DaYQBQy25tSEHxXcVhV
        5uwc0avJKE/+oxD3m6L+WU8z9g==
X-Google-Smtp-Source: APXvYqxavNec6jVy0ssikQL5rcqDsZqRzOK/WiO6T6ozJAH7dR1eaCKDtNe/a15zS8npgO7vYxaorA==
X-Received: by 2002:aa7:9295:: with SMTP id j21mr7289159pfa.50.1573400769979;
        Sun, 10 Nov 2019 07:46:09 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id j126sm13804259pfg.4.2019.11.10.07.46.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Nov 2019 07:46:08 -0800 (PST)
Subject: Re: KASAN: invalid-free in io_sqe_files_unregister
To:     syzbot <syzbot+3254bc44113ae1e331ee@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
References: <000000000000e11df90596fc9955@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e3ed8352-23ca-246d-088c-878f9da82c76@kernel.dk>
Date:   Sun, 10 Nov 2019 08:46:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <000000000000e11df90596fc9955@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/10/19 4:49 AM, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit 65e19f54d29cd8559ce60cfd0d751bef7afbdc5c
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Sat Oct 26 13:20:21 2019 +0000
> 
>       io_uring: support for larger fixed file sets
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=154f483ce00000
> start commit:   5591cf00 Add linux-next specific files for 20191108
> git tree:       linux-next
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=174f483ce00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=134f483ce00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e1036c6ef52866f9
> dashboard link: https://syzkaller.appspot.com/bug?extid=3254bc44113ae1e331ee
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=116bb33ae00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=173f133ae00000
> 
> Reported-by: syzbot+3254bc44113ae1e331ee@syzkaller.appspotmail.com
> Fixes: 65e19f54d29c ("io_uring: support for larger fixed file sets")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Thanks, I queued up a fix:

https://git.kernel.dk/cgit/linux-block/commit/?h=for-5.5/io_uring&id=fc2a85cb02efd7bdbd09ea5d2d9847937da7bff7

-- 
Jens Axboe

