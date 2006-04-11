Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbWDKVUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbWDKVUj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 17:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbWDKVUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 17:20:39 -0400
Received: from smtp4-g19.free.fr ([212.27.42.30]:27352 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751106AbWDKVUi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 17:20:38 -0400
Message-ID: <443C1DA0.1030004@ccr.jussieu.fr>
Date: Tue, 11 Apr 2006 23:20:32 +0200
From: Bernard Pidoux <pidoux@ccr.jussieu.fr>
Organization: Universite Pierre & Marie Curie - Paris 6
User-Agent: Thunderbird 1.5 (X11/20060225)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Bernard Pidoux <bpidoux@free.fr>
Subject: [kernel 2.6] Patch for mxser.c driver
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

mxser driver in kernel 2.6.16 can compile but it does not drive the 
serial multiport adapter from Moxa.

According to Moxa documentation for version 1.8, msmknod script, 
downloaded from their support site, creates ttyM0-7 and cum0-7 tty 
devices with major numbers 30 and 35 by defaults.

However, in mxser.c major device numbers are still 174 and 175.

Here is a patch to change major tty device numbers to proper default values.


--- linux/drivers/char/mxser.c.old 2006-04-11 22:35:16.000000000 +0200
+++ linux/drivers/char/mxser.c     2006-04-11 22:36:49.000000000 +0200
@@ -68,8 +68,8 @@
  #include "mxser.h"

  #define        MXSER_VERSION   "1.8"
-#define        MXSERMAJOR       174
-#define        MXSERCUMAJOR     175
+#define        MXSERMAJOR       30
+#define        MXSERCUMAJOR     35

  #define        MXSER_EVENT_TXLOW        1
  #define        MXSER_EVENT_HANGUP       2


BTW, driver source that can be downloaded from Moxa support site will 
not compile :

  make -C /lib/modules/2.6.16/build SUBDIRS=/temp/mxser1.8/driver modules
make[1]: Entering directory `/usr/src/linux-2.6.16'
   CC [M]  /temp/mxser1.8/driver/mxser.o
/temp/mxser1.8/driver/mxser.c:722: warning: initialization from 
incompatible pointer type
/temp/mxser1.8/driver/mxser.c: In function 'mxser_init':
/temp/mxser1.8/driver/mxser.c:1035: warning: assignment from 
incompatible pointer type
/temp/mxser1.8/driver/mxser.c: In function 'mxser_ioctl':
/temp/mxser1.8/driver/mxser.c:1685: warning: implicit declaration of 
function 'verify_area'
/temp/mxser1.8/driver/mxser.c: In function 'mxser_receive_chars':
/temp/mxser1.8/driver/mxser.c:2631: error: 'struct tty_ldisc' has no 
member named 'receive_room'
/temp/mxser1.8/driver/mxser.c:2638: error: 'struct tty_struct' has no 
member named 'flip'
/temp/mxser1.8/driver/mxser.c:2639: error: 'struct tty_struct' has no 
member named 'flip'
/temp/mxser1.8/driver/mxser.c:2783: error: 'struct tty_struct' has no 
member named 'flip'
/temp/mxser1.8/driver/mxser.c:2783: error: 'struct tty_struct' has no 
member named 'flip'
make[2]: *** [/temp/mxser1.8/driver/mxser.o] Erreur 1
make[1]: *** [_module_/temp/mxser1.8/driver] Erreur 2
make[1]: Leaving directory `/usr/src/linux-2.6.16'
make: *** [module] Erreur 2

If any comments please Cc: to me.

Regards from,

Bernard Pidoux, f6bvp

http://f6bvp.org
http://rose.fpac.free.fr/MINI-HOWTO/
http://rose.fpac.free.fr/MINI-HOWTO-FR/

