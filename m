Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281047AbRKKM4Q>; Sun, 11 Nov 2001 07:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281051AbRKKM4G>; Sun, 11 Nov 2001 07:56:06 -0500
Received: from d-dialin-1735.addcom.de ([62.96.166.55]:22254 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S281047AbRKKMzz>; Sun, 11 Nov 2001 07:55:55 -0500
Date: Sun, 11 Nov 2001 13:56:04 +0100 (CET)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: <kai@vaio>
To: "Mario 'BitKoenig' Holbe" <Mario.Holbe@RZ.TU-Ilmenau.DE>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: isdn: isdnloop support crashes kernel when compiled in
In-Reply-To: <20011110202652.B14401@darkside.ddts.net>
Message-ID: <Pine.LNX.4.33.0111111355170.23760-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Nov 2001, Mario 'BitKoenig' Holbe wrote:

> The isdnloop support for the ISDN subsystem crashes the kernel when
> compiled in the kernel directly (null pointer reference).
> I guess, this is because parameters are only given as MODULE_PARM().
> 
> I found that in the 2.4.12 kernel, if it's fixed already in higher
> kernels, please excuse me :)
> 
> If this is a feature and not a bug, should'nt it then be forced
> to be configured as a module in the Config.in?

It's a bug. The appended patch should fix it.

--Kai

diff -ur linux-2.4.15-pre2.patches/drivers/isdn/isdnloop/isdnloop.c linux-2.4.15-pre2.work/drivers/isdn/isdnloop/isdnloop.c
--- linux-2.4.15-pre2.patches/drivers/isdn/isdnloop/isdnloop.c	Sun Oct 21 00:17:11 2001
+++ linux-2.4.15-pre2.work/drivers/isdn/isdnloop/isdnloop.c	Sun Nov 11 13:37:36 2001
@@ -1542,7 +1542,11 @@
 	} else
 		strcpy(rev, " ??? ");
 	printk(KERN_NOTICE "isdnloop-ISDN-driver Rev%s\n", rev);
-	return (isdnloop_addcard(isdnloop_id));
+
+	if (isdnloop_id)
+		return (isdnloop_addcard(isdnloop_id));
+
+	return 0;
 }
 
 static void __exit

