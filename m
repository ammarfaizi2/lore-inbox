Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129521AbQKVQGq>; Wed, 22 Nov 2000 11:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131794AbQKVQGg>; Wed, 22 Nov 2000 11:06:36 -0500
Received: from smtp2.free.fr ([212.27.32.6]:63759 "EHLO smtp2.free.fr")
        by vger.kernel.org with ESMTP id <S129521AbQKVQGY>;
        Wed, 22 Nov 2000 11:06:24 -0500
To: "David S. Miller" <davem@redhat.com>
Subject: Re: [BUG] 2.2.1[78] : RTNETLINK lock not properly locking ?
Message-ID: <974907379.3a1be7f3a0987@imp.free.fr>
Date: Wed, 22 Nov 2000 16:36:19 +0100 (MET)
From: Willy Tarreau <willy.lkml@free.fr>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <974885943.3a1b9437847da@imp.free.fr> <200011220946.BAA07355@pizda.ninka.net> <974892477.3a1badbdefd2d@imp.free.fr> <200011221127.DAA07699@pizda.ninka.net>
In-Reply-To: <200011221127.DAA07699@pizda.ninka.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.3
X-Originating-IP: 195.6.58.78
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No, it guarentees that only one process may be in the middle
> of modifying interface configuration state, the same and only
> guarentee it makes in 2.4.x as well.

ok, Dave. But the code in dev_ioctl() actually is :

  rtnl_lock();
  ret = dev_ifsioc(&ifr, cmd);
  rtnl_unlock();

if only these lock/unlock guarantee this atomicity, then I can't
see why my A,B,C case could not work. If this is because the
kernel has been locked somewhere else, then why are the locks
still needed ? The author of rtnetlink.h has been very precautious
about the atomicity of these locks when CONFIG_RTNETLINK is set. I
don't understand why this could change in other cases. For this
reason, I don't know what to write in my code ...

Regards,
Willy
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
