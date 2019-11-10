Return-Path: <SRS0=ex/T=ZC=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36CDC17442
	for <io-uring@archiver.kernel.org>; Sun, 10 Nov 2019 11:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B998120B7C
	for <io-uring@archiver.kernel.org>; Sun, 10 Nov 2019 11:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfKJLtC (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sun, 10 Nov 2019 06:49:02 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:33796 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfKJLtB (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sun, 10 Nov 2019 06:49:01 -0500
Received: by mail-il1-f198.google.com with SMTP id m12so10473609ilq.1
        for <io-uring@vger.kernel.org>; Sun, 10 Nov 2019 03:49:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=muS40/M+U7unS7Nwdhba7+0opY/I2Z2pZGBBgPUq8C0=;
        b=Fg/PTwaP0noVHF5Na6hjzIk9qZdPp9dBu94updq7nSObJ8xfey978mYMWZzgsfXU9u
         vEcP4lyblsCXHcpOJM6BwdfpdNLZI5rI6wE2xCPT8gqTRm8nQdkj+AVnUwvP7ctAbVoh
         RnHKe3UD0pH+bjLeE/sxK+YFLZ6wI6ywA9rxSU0wWuLjtNg1FGpN7jQ31KfQpcdQOXS0
         xTPWpzJ3Lxv37p88TwnZxE9vkIHM3iLm9BtpGFIuIOxccRe52ATr52iPRcvVU4VNxx4v
         sP9bNEHL+N05X+QxTFsFEY5bHPiNTLFPN7X6eeIkgPA8Py4UKLwcomB4dGojGqLNNNcR
         /NAA==
X-Gm-Message-State: APjAAAVkAtqWc4z35h5KtJ8047Hh4xjsOfXyOCQzz+6PIv34hD8U47pz
        VTfHltbyleFcobPZ6Jb2PKIvd6CM8+bgqsEW/dtnM/OzMSgv
X-Google-Smtp-Source: APXvYqwG7iOuXUzrPn9C7IQw34I7LSwhAIRpMFyONIfQ9Z8ZWhdhx/QqVwYg/S2UFNW58oOzV3uQTeJdrwTJ/Pza/72hGbJAuyfE
MIME-Version: 1.0
X-Received: by 2002:a92:16d4:: with SMTP id 81mr24840022ilw.198.1573386541143;
 Sun, 10 Nov 2019 03:49:01 -0800 (PST)
Date:   Sun, 10 Nov 2019 03:49:01 -0800
In-Reply-To: <0000000000003659ef0596fa4cae@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e11df90596fc9955@google.com>
Subject: Re: KASAN: invalid-free in io_sqe_files_unregister
From:   syzbot <syzbot+3254bc44113ae1e331ee@syzkaller.appspotmail.com>
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

commit 65e19f54d29cd8559ce60cfd0d751bef7afbdc5c
Author: Jens Axboe <axboe@kernel.dk>
Date:   Sat Oct 26 13:20:21 2019 +0000

     io_uring: support for larger fixed file sets

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=154f483ce00000
start commit:   5591cf00 Add linux-next specific files for 20191108
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=174f483ce00000
console output: https://syzkaller.appspot.com/x/log.txt?x=134f483ce00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1036c6ef52866f9
dashboard link: https://syzkaller.appspot.com/bug?extid=3254bc44113ae1e331ee
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=116bb33ae00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=173f133ae00000

Reported-by: syzbot+3254bc44113ae1e331ee@syzkaller.appspotmail.com
Fixes: 65e19f54d29c ("io_uring: support for larger fixed file sets")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
