Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275693AbRKFFRP>; Tue, 6 Nov 2001 00:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275082AbRKFFRG>; Tue, 6 Nov 2001 00:17:06 -0500
Received: from zero.tech9.net ([209.61.188.187]:27919 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S275693AbRKFFQx>;
	Tue, 6 Nov 2001 00:16:53 -0500
Subject: [PATCH] Re: 2.4.14 errors on full build - Y
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <17526.1005022179@ocs3.intra.ocs.com.au>
In-Reply-To: <17526.1005022179@ocs3.intra.ocs.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.100+cvs.2001.11.05.15.31 (Preview Release)
Date: 06 Nov 2001 00:16:52 -0500
Message-Id: <1005023814.1506.0.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-11-05 at 23:49, Keith Owens wrote:
> Doing a full build of 2.4.14 (everything set to Y where possible), got
> the usual collection of errors.  Some of these errors have been around
> for weeks, any chance of them getting fixed?
> [...]
>   drivers/block/ps2esdi.c:153: `THIS_MODULE' undeclared here (not in a function)
>   drivers/block/ps2esdi.c:153: initializer element is not constant
>   drivers/block/ps2esdi.c:153: (near initialization for `ps2esdi_fops.owner')
>   drivers/block/ps2esdi.c:157: initializer element is not constant
>   drivers/block/ps2esdi.c:157: (near initialization for `ps2esdi_fops')

Looks like this is just missing module.h ... simple fix attached. 
Linus, please apply.

diff -urN linux-2.4.14/drivers/block/ps2esdi.c linux/drivers/block/ps2esdi.c 
--- linux-2.4.14/drivers/block/ps2esdi.c	Mon Nov  5 20:11:00 2001
+++ linux/drivers/block/ps2esdi.c	Tue Nov  6 00:14:57 2001
@@ -47,6 +47,7 @@
 #include <linux/mca.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
+#include <linux/module.h>
 
 #include <asm/system.h>
 #include <asm/io.h>


	Robert Love

