Return-Path: <SRS0=BBHt=ZN=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869A9C432C0
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 05:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5978320715
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 05:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbfKUF4E (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 21 Nov 2019 00:56:04 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:36214 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfKUF4B (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 21 Nov 2019 00:56:01 -0500
Received: by mail-io1-f70.google.com with SMTP id z12so1443139iop.3
        for <io-uring@vger.kernel.org>; Wed, 20 Nov 2019 21:56:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=mfH1KiCJRKrkCk6Xo24N026hP3QeH2tnCMon9TkgaqE=;
        b=eup1m8vBxSA7rATUgwOg627QJWghBD0tZoarL6jOz1E7aTnReuwRGe+NrAdEAr3F7G
         AgGoteU3wBpXyHy+Uy2HuK6LR5TAjcQjg5+dmVXjSLigMjR3eDeBhJzpzY3kslg+9bew
         eVmKgEKSNZym+GiB5iE46MrTRea77D7yXeTTx7wvQZa5pUQclr4oTGi1ojDwdnEaqIyG
         ZEQ1LeFqSwQRigHKujcKzpM2mk7csj2xiZWpnjNEiwqsGQfQsW8l+24nnLNrE/Xmsi40
         M7fqVLG07RcQPfY0JwXK3v7ONCut5f0HOz/YTMs9pZx3ytF8nRxM0hRFpNMUeORlmOqO
         bvaw==
X-Gm-Message-State: APjAAAXpLRze5OyqWIlOfesQHaXz/Ksun+hTL8oQNB9rJFxTFg8hO3/r
        /FFrkFKLYSqJhG9pzac0WsOIe0fY/CGhxlDDlYKun5jjRYPE
X-Google-Smtp-Source: APXvYqwUKLMPCVsGilywR82DgOMl8S8nXlNM4DAw4/+MPXBC9kph9vWN1fhkX08eEJ5ztd1Hs8pxMXnFldFW3iiHqxZP+FOWzVdW
MIME-Version: 1.0
X-Received: by 2002:a6b:9245:: with SMTP id u66mr5976497iod.98.1574315760516;
 Wed, 20 Nov 2019 21:56:00 -0800 (PST)
Date:   Wed, 20 Nov 2019 21:56:00 -0800
In-Reply-To: <00000000000072cb6c0597635d04@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ab834f0597d4f337@google.com>
Subject: Re: INFO: trying to register non-static key in io_cqring_ev_posted
From:   syzbot <syzbot+0d818c0d39399188f393@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, liuyun01@kylinos.cn,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

syzbot has bisected this bug to:

commit 206aefde4f886fdeb3b6339aacab3a85fb74cb7e
Author: Jens Axboe <axboe@kernel.dk>
Date:   Fri Nov 8 01:27:42 2019 +0000

     io_uring: reduce/pack size of io_ring_ctx

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15f98af2e00000
start commit:   5d1131b4 Add linux-next specific files for 20191119
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=17f98af2e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=13f98af2e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b60c562d89e5a8df
dashboard link: https://syzkaller.appspot.com/bug?extid=0d818c0d39399188f393
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=169b29d2e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14b3956ae00000

Reported-by: syzbot+0d818c0d39399188f393@syzkaller.appspotmail.com
Fixes: 206aefde4f88 ("io_uring: reduce/pack size of io_ring_ctx")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
