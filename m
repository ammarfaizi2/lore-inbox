Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318292AbSIKCv4>; Tue, 10 Sep 2002 22:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318293AbSIKCv4>; Tue, 10 Sep 2002 22:51:56 -0400
Received: from triton.neptune.on.ca ([205.233.176.2]:56005 "EHLO
	triton.neptune.on.ca") by vger.kernel.org with ESMTP
	id <S318292AbSIKCvz>; Tue, 10 Sep 2002 22:51:55 -0400
Date: Tue, 10 Sep 2002 22:56:45 -0400 (EDT)
From: Steve Mickeler <steve@neptune.ca>
X-X-Sender: steve@triton.neptune.on.ca
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre6 tg3 compile errors
In-Reply-To: <3D7EAC65.8030101@mandrakesoft.com>
Message-ID: <Pine.LNX.4.44.0209102255040.3875-100000@triton.neptune.on.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


That seemed to have allowed a clean compile.

Heres the patch:

-----------------------------------------------------------------------------------------
diff -Naur linux-2.4.20-pre6/drivers/net/tg3.c linux-2.4.20-pre6-fixed/drivers/net/tg3.c
--- linux-2.4.20-pre6/drivers/net/tg3.c Tue Sep 10 21:53:24 2002
+++ linux-2.4.20-pre6-fixed/drivers/net/tg3.c   Tue Sep 10 21:44:53 2002
@@ -4878,8 +4878,10 @@

        rx_mode = tp->rx_mode & ~(RX_MODE_PROMISC |
                                  RX_MODE_KEEP_VLAN_TAG);
+#if TG3_VLAN_TAG_USED
        if (!tp->vlgrp)
                rx_mode |= RX_MODE_KEEP_VLAN_TAG;
+#endif

        if (dev->flags & IFF_PROMISC) {
                /* Promiscuous mode. */
-----------------------------------------------------------------------------------------



On Tue, 10 Sep 2002, Jeff Garzik wrote:

> Steve Mickeler wrote:
> > Ok, I applied the entire 2.4.20-pre6 and still get compile errors:
> >
> > gcc -D__KERNEL__ -I/usr/src/test/linux-2.4.20-pre6/include -Wall
> > -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> > -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686
> > -nostdinc -iwithprefix include -DKBUILD_BASENAME=tg3  -c -o tg3.o tg3.c
> >
> > tg3.c: In function `__tg3_set_rx_mode':
> > tg3.c:4881: structure has no member named `vlgrp'
>
>
> Wrap this line of code inside a
>
> #if TG3_VLAN_TAG_USED
> ...line 4881 here...
> #endif
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>



[-] Steve Mickeler [ steve@neptune.ca ]

[|] Todays root password is brought to you by /dev/random

[+] 1024D/9AA80CDF = 4103 9E35 2713 D432 924F  3C2E A7B9 A0FE 9AA8 0CDF

