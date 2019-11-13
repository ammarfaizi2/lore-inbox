Return-Path: <SRS0=KKPr=ZF=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E18C43215
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 19:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 236BA206D7
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 19:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfKMT3D (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 13 Nov 2019 14:29:03 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:56664 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727238AbfKMT3D (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 13 Nov 2019 14:29:03 -0500
Received: by mail-il1-f200.google.com with SMTP id e5so2727442ile.23
        for <io-uring@vger.kernel.org>; Wed, 13 Nov 2019 11:29:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Vq9AmQFAWjANpkLSXn1UHJxF9GMEPoT07hbuuO8TH2k=;
        b=Wp9f3oko9LDAavgQ6pqyKL+Ih2g6krjI7ZiWNPtokYcIPQYCaLX1z6KKY37quRNdbR
         H2d3SFNXuWmBABot8rgmIXOxzF9sqSz3yjeFmaJ/I5lhUieIvq/edddBDvsiQSNo2+ml
         bXdodFedc0uYcoW8nfT/dL2umvhLEwpSMK5SR+zrb74Zb1aFJMT8q4bvoH2h9vC2661Y
         vOXGtyoMZanpXC3Z0wLL+HaJ9InOdfNPDYbos2rwNuEjWFBmWnF7aAAJQ32OksSwFmOU
         ylRdVj5esBocYTw4L822QBJLixf2/I5IHLyMCu1V6WeSM3iAINyR1i7nIfMDeJ6MmJr8
         qHeA==
X-Gm-Message-State: APjAAAVDiTu+ajSPj5lWJYQcx/lq+RrqQH7ZP75bWJv1hW+U0g01XNpb
        GnLOjyVOEXs/PrzR4iwXN0GRIuP6DmNe+qwiPBumtmu/npDx
X-Google-Smtp-Source: APXvYqxYJ6dFAWRGXWIFkalwkp6O7/N3QafXX2n/eN0sV1s7imfVqRwzdni678vR3BjKeJq+wc64m4DR6PP6wl4S1UDWQ9YBHiIf
MIME-Version: 1.0
X-Received: by 2002:a02:58c8:: with SMTP id f191mr4260216jab.94.1573673340590;
 Wed, 13 Nov 2019 11:29:00 -0800 (PST)
Date:   Wed, 13 Nov 2019 11:29:00 -0800
In-Reply-To: <000000000000af7e9805973c6356@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000075646805973f60b5@google.com>
Subject: Re: general protection fault in io_commit_cqring
From:   syzbot <syzbot+21147d79607d724bd6f3@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

syzbot has bisected this bug to:

commit 1d7bb1d50fb4dc141c7431cc21fdd24ffcc83c76
Author: Jens Axboe <axboe@kernel.dk>
Date:   Wed Nov 6 18:31:17 2019 +0000

     io_uring: add support for backlogged CQ ring

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16a49802e00000
start commit:   4e8f108c Add linux-next specific files for 20191113
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=15a49802e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=11a49802e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ace1bcdd76242fd2
dashboard link: https://syzkaller.appspot.com/bug?extid=21147d79607d724bd6f3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1649e706e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11397f72e00000

Reported-by: syzbot+21147d79607d724bd6f3@syzkaller.appspotmail.com
Fixes: 1d7bb1d50fb4 ("io_uring: add support for backlogged CQ ring")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
