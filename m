Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270932AbRHSXjF>; Sun, 19 Aug 2001 19:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270933AbRHSXi4>; Sun, 19 Aug 2001 19:38:56 -0400
Received: from d-dialin-1524.addcom.de ([62.96.165.84]:51699 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S270932AbRHSXis>; Sun, 19 Aug 2001 19:38:48 -0400
Date: Mon, 20 Aug 2001 00:19:49 +0200 (CEST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: <kai@vaio>
To: Chris Oxenreider <oxenreid@state.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.4.9 build fails on Mandrake 8.0 ( make modules_install
 'isdn')
In-Reply-To: <Pine.SV4.4.10.10108191436230.4651-100000@dorthy>
Message-ID: <Pine.LNX.4.33.0108200019320.23800-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 19 Aug 2001, Chris Oxenreider wrote:

> depmod: *** Unresolved symbols in
> /lib/modules/2.4.9/kernel/drivers/isdn/eicon/eicon.o
> depmod: 	vsnprintf

This patch should fix it:

diff -u linux-2.4.9/kernel/ksyms.c linux-2.4.9.work/kernel/ksyms.c
--- linux-2.4.9/kernel/ksyms.c	Fri Aug 17 09:57:12 2001
+++ linux-2.4.9.work/kernel/ksyms.c	Mon Aug 20 00:16:58 2001
@@ -458,6 +458,8 @@
 EXPORT_SYMBOL(printk);
 EXPORT_SYMBOL(sprintf);
 EXPORT_SYMBOL(vsprintf);
+EXPORT_SYMBOL(snprintf);
+EXPORT_SYMBOL(vsnprintf);
 EXPORT_SYMBOL(kdevname);
 EXPORT_SYMBOL(bdevname);
 EXPORT_SYMBOL(cdevname);

--Kai


