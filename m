Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286934AbSBKDWP>; Sun, 10 Feb 2002 22:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286942AbSBKDWF>; Sun, 10 Feb 2002 22:22:05 -0500
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:24849 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S286934AbSBKDVx>; Sun, 10 Feb 2002 22:21:53 -0500
Subject: [PATCH] Re: 2.5.2-pre3 -- parport_cs.c:327: In function
	`parport_config': `LP_MAJOR' undeclared (first use in this function)
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>, Dave Jones <davej@suse.de>
Cc: johnpol@2ka.mipt.ru
In-Reply-To: <20020123105043.18eb56fd.johnpol@2ka.mipt.ru>
In-Reply-To: <1011771555.28121.0.camel@stomata.megapathdsl.net> 
	<20020123105043.18eb56fd.johnpol@2ka.mipt.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Evolution/1.1.0.99 (Preview Release)
Date: 10 Feb 2002 19:18:53 -0800
Message-Id: <1013397534.29598.32.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David, 

This problem is still there is 2.5.4-pre6.
Can you accept this patch into your tree
and, if it looks right to you, attempt to 
get the patch accepted into the "trivial and 
obviously correct tiny patches" tree, if there 
is one, yet?  Patch is by Evgeniy Polyakov.

	Miles

On Tue, 2002-01-22 at 23:50, Evgeniy Polyakov wrote:
> On 22 Jan 2002 23:39:12 -0800
> Miles Lane <miles@megapathdsl.net> wrote:
> 
> > gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
> > -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
> > -pipe -mpreferred-stack-boundary=2 -march=athlon  -DMODULE   -c -o
> > parport_cs.o parport_cs.c parport_cs.c: In function `parport_config':
> > parport_cs.c:327: `LP_MAJOR' undeclared (first use in this function)
> > parport_cs.c:327: (Each undeclared identifier is reported only once
> > parport_cs.c:327: for each function it appears in.)
> > parport_cs.c: At top level:
> > parport_cs.c:109: warning: `parport_cs_ops' defined but not used
> > make[2]: *** [parport_cs.o] Error 1
> > make[2]: Leaving directory `/usr/src/linux/drivers/parport'
>  
> Try this patch, but it is given WITHOUT ANY WARRANTY.
> I even cann't test to compile it.
> And there is not ieee card here.
> So, it was wrote with luck and common sense.
> I hope it will help you.
> 
--- ./drivers/parport/parport_cs.c~     Sun Sep 30 23:26:08 2001
+++ ./drivers/parport/parport_cs.c      Wed Jan 23 10:49:30 2002
@@ -45,6 +45,7 @@
 #include <linux/string.h>
 #include <linux/timer.h>
 #include <linux/ioport.h>
+#include <linux/major.h>
 
 #include <linux/parport.h>
 #include <linux/parport_pc.h>
@@ -106,7 +107,9 @@
 static dev_link_t *dev_list = NULL;
 
 extern struct parport_operations parport_pc_ops;
-static struct parport_operations parport_cs_ops;
+/*static struct parport_operations parport_cs_ops;
+ * To make compiler happy.
+ */
 
 /*====================================================================*/



