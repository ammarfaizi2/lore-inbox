Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263616AbTDDCtN (for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 21:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263621AbTDDCtN (for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 21:49:13 -0500
Received: from sj-core-2.cisco.com ([171.71.177.254]:45964 "EHLO
	sj-core-2.cisco.com") by vger.kernel.org with ESMTP id S263616AbTDDCtD (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 21:49:03 -0500
From: "Hua Zhong" <hzhong@cisco.com>
To: "Stephen Hemminger" <shemminger@osdl.org>, <akpm@digeo.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: Compile warning in 2.5.66-bk latest
Date: Thu, 3 Apr 2003 19:00:14 -0800
Message-ID: <CDEDIMAGFBEBKHDJPCLDMEKMDGAA.hzhong@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <1049408232.22772.1.camel@dell_ss3.pdx.osdl.net>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew:

It's probably another change set in the file (J_EXPECT_JH).

I don't have gcc 3.2 installed so I could not verify, but maybe the
following patch could fix it.

Maybe a better fix is to define all J_EXPECTxxx as sth like:

#define J_EXPECT(expr, why, params...)		__journal_expect(expr, why, ##
params)

as why is always needed.

diff -urN linux-2.5/include/linux/jbd.h linux-2.5-new/include/linux/jbd.h
--- linux-2.5/include/linux/jbd.h	Thu Apr  3 11:29:43 2003
+++ linux-2.5-new/include/linux/jbd.h	Thu Apr  3 21:48:25 2003
@@ -275,7 +275,7 @@
 	do {								     \
 		if (!(expr)) {						     \
 			printk(KERN_ERR "EXT3-fs unexpected failure: %s;\n", # expr); \
-			printk(KERN_ERR ## why);			     \
+			printk(KERN_ERR why);			     \
 		}							     \
 	} while (0)
 #define J_EXPECT(expr, why...)		__journal_expect(expr, ## why)

> -----Original Message-----
> From: Stephen Hemminger [mailto:shemminger@osdl.org]
> Sent: Thursday, April 03, 2003 2:17 PM
> To: Hua Zhong
> Cc: Linux Kernel Mailing List
> Subject: Compile warning in 2.5.66-bk latest
>
>
> Using gcc 3.2 with latest 2.5.66-bk
>
> gcc -Wp,-MD,drivers/block/.elevator.o.d -D__KERNEL__ -Iinclude
> -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
> -fno-common -pipe -mpreferred-stack-boundary=2 -march=pentium4
> -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include
> -DKBUILD_BASENAME=elevator -DKBUILD_MODNAME=elevator -c -o
> drivers/block/.tmp_elevator.o drivers/block/elevator.c
> fs/jbd/transaction.c:670:53: warning: pasting "KERN_ERR" and
> ""Possible IO failure.\n"" does not give a valid preprocessing token
>
>
>

