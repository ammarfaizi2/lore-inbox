Return-Path: <SRS0=qbp9=ZY=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45945C432C0
	for <io-uring@archiver.kernel.org>; Mon,  2 Dec 2019 15:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FED72073C
	for <io-uring@archiver.kernel.org>; Mon,  2 Dec 2019 15:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfLBPWE (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 2 Dec 2019 10:22:04 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:33962 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727432AbfLBPWC (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 2 Dec 2019 10:22:02 -0500
Received: by mail-io1-f69.google.com with SMTP id a13so26235665iol.1
        for <io-uring@vger.kernel.org>; Mon, 02 Dec 2019 07:22:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=yoaw0PwFg2A6gDglB5LznPWl+Lud/RfolRLMztLbYOM=;
        b=Xw64YgYBEmr5YuUwrfHh9xP6B9gOdWBIr/KdMlngOPpWfd9poI8GuC5RUaYhN62INy
         V6IBfbBhEGM3qn4oVX09cTWWsP2v5H5U2m2b5Cmun7siuYSKZBzFOJIuotnx1mj3BnOF
         HogJ6CNrBJme3Y2v1+dxhkcbYGsKPJrXmCqU0q/tmsUwuQHRTPs7Fr0+DY4kBic6xVtp
         GEtb0nHplBaYv9i6Q1aEJGqYgHze12XaP7K+PKV31lGtzD7uTGEPQOhJ2dHgh2JskMfA
         gBEEfXAy3xXg85iGMq5WH6//AUhIZ7GYo9sW69/1eE7XU03dnhcknnkeHZ7e8lmDql3o
         iMwg==
X-Gm-Message-State: APjAAAW5rsCGgQn6oVWUWbyPzEbCEwNI9qg1kRyfgJY+XJG9euwcM8Vx
        F3eQFp2B9Vv6j5UQRSBJUVqvyV+Mm+XZbCIKSw76mCNq37zx
X-Google-Smtp-Source: APXvYqygl3XRg/RBFqVukkdgwZRNVl2uCNOuiX78gKyVxsKxIvwL0CTDPj2IidIQmxtbhRnxA50TBWTRjZbP0m4y1guFs+uD5e2O
MIME-Version: 1.0
X-Received: by 2002:a02:962c:: with SMTP id c41mr29142298jai.74.1575300120660;
 Mon, 02 Dec 2019 07:22:00 -0800 (PST)
Date:   Mon, 02 Dec 2019 07:22:00 -0800
In-Reply-To: <000000000000da160a0598b2c704@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001b5b540598ba2498@google.com>
Subject: Re: general protection fault in override_creds
From:   syzbot <syzbot+5320383e16029ba057ff@syzkaller.appspotmail.com>
To:     Anna.Schumaker@Netapp.com, Anna.Schumaker@netapp.com,
        axboe@kernel.dk, casey@schaufler-ca.com, dhowells@redhat.com,
        dvyukov@google.com, io-uring@vger.kernel.org, jannh@google.com,
        keescook@chromium.org, kstewart@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, neilb@suse.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

syzbot has bisected this bug to:

commit 181e448d8709e517c9c7b523fcd209f24eb38ca7
Author: Jens Axboe <axboe@kernel.dk>
Date:   Mon Nov 25 15:52:30 2019 +0000

     io_uring: async workers should inherit the user creds

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10424ceae00000
start commit:   b94ae8ad Merge tag 'seccomp-v5.5-rc1' of git://git.kernel...
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=12424ceae00000
console output: https://syzkaller.appspot.com/x/log.txt?x=14424ceae00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ff560c3de405258c
dashboard link: https://syzkaller.appspot.com/bug?extid=5320383e16029ba057ff
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12dd682ae00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16290abce00000

Reported-by: syzbot+5320383e16029ba057ff@syzkaller.appspotmail.com
Fixes: 181e448d8709 ("io_uring: async workers should inherit the user  
creds")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
