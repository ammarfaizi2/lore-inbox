Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287261AbRL2X6I>; Sat, 29 Dec 2001 18:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287269AbRL2X56>; Sat, 29 Dec 2001 18:57:58 -0500
Received: from net090s.hetnet.nl ([194.151.104.183]:35077 "EHLO hetnet.nl")
	by vger.kernel.org with ESMTP id <S287267AbRL2X5q>;
	Sat, 29 Dec 2001 18:57:46 -0500
Message-Id: <5.1.0.14.2.20011230004059.00a2ac90@pop.hetnet.nl>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 30 Dec 2001 00:56:25 +0100
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Henk de Groot <henk.de.groot@hetnet.nl>
Subject: Re: AX25/socket kernel PATCHes
Cc: linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <E16KNor-00059i-00@the-village.bc.nu>
In-Reply-To: <5.1.0.14.2.20011229174504.00a291b0@pop.hetnet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alan,

At 18:02 29-12-01 +0000, Alan Cox wrote:
>If you change
>
>                        if (skb2->nh.raw < skb2->data || skb2->nh.raw >= skb2->...
>                                if (net_ratelimit())
>
>So that it checks
>                        < skb2->data || nh.raw > ..
>
>Let me know if that fixes it. It shouldn't but it would be good to know if

I thought I understood but I'm not so sure anymore. I applied the following patch to dev.c:

--------------------------------------------------------------------------
--- linux/net/core/dev.c.orig   Sun Dec 30 00:31:43 2001
+++ linux/net/core/dev.c        Sun Dec 30 00:33:27 2001
@@ -940,7 +940,7 @@
                         */
                        skb2->mac.raw = skb2->data;
 
-                       if (skb2->nh.raw < skb2->data || skb2->nh.raw > skb2->tail) {
+                       if (skb2->nh.raw < skb2->data || nh.raw > skb2->tail) {
                                if (net_ratelimit())
                                        printk(KERN_DEBUG "protocol %04x is buggy, dev %s\n", skb2->protocol, dev->name);
                                skb2->nh.raw = skb2->data;
--------------------------------------------------------------------------

This however gives compilation errors, 'nh' undeclared. So no buggy messages anymore :-)...

It's easy for me to generate these buggy messages (each raw transmission seems to produce them) so if there is anything I can try out I'll be happy to do it.

Kind regards,

Henk.

P.S. I'm using a SuSE flavour of the kernel so I have to use the linux-2.4.16.tar.bz2 kernel with SuSE's suse-2.4.16-7.bz2 patches as there are no SuSE addaptations for the 2.4.17 kernel yet (at least last time I checked, i.e. yesterday).

