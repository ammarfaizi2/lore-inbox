Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289715AbSAWHv2>; Wed, 23 Jan 2002 02:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289727AbSAWHvT>; Wed, 23 Jan 2002 02:51:19 -0500
Received: from sombre.2ka.mipt.ru ([194.85.82.77]:57228 "EHLO
	sombre.2ka.mipt.ru") by vger.kernel.org with ESMTP
	id <S289724AbSAWHvA>; Wed, 23 Jan 2002 02:51:00 -0500
Date: Wed, 23 Jan 2002 10:50:43 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Miles Lane <miles@megapathdsl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.2-pre3 -- parport_cs.c:327: In function `parport_config': `LP_MAJOR' undeclared (first use in this function)
Message-Id: <20020123105043.18eb56fd.johnpol@2ka.mipt.ru>
In-Reply-To: <1011771555.28121.0.camel@stomata.megapathdsl.net>
In-Reply-To: <1011771555.28121.0.camel@stomata.megapathdsl.net>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Jan 2002 23:39:12 -0800
Miles Lane <miles@megapathdsl.net> wrote:

> gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
> -pipe -mpreferred-stack-boundary=2 -march=athlon  -DMODULE   -c -o
> parport_cs.o parport_cs.c parport_cs.c: In function `parport_config':
> parport_cs.c:327: `LP_MAJOR' undeclared (first use in this function)
> parport_cs.c:327: (Each undeclared identifier is reported only once
> parport_cs.c:327: for each function it appears in.)
> parport_cs.c: At top level:
> parport_cs.c:109: warning: `parport_cs_ops' defined but not used
> make[2]: *** [parport_cs.o] Error 1
> make[2]: Leaving directory `/usr/src/linux/drivers/parport'
 
Try this patch, but it is given WITHOUT ANY WARRANTY.
I even cann't test to compile it.
And there is not ieee card here.
So, it was wrote with luck and common sense.
I hope it will help you.

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



	Evgeniy Polyakov ( s0mbre ).
