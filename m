Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293409AbSCAEuq>; Thu, 28 Feb 2002 23:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293488AbSCAEsx>; Thu, 28 Feb 2002 23:48:53 -0500
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:57353 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S310357AbSCAEpx>; Thu, 28 Feb 2002 23:45:53 -0500
Message-ID: <3C7F065A.5060908@megapathdsl.net>
Date: Thu, 28 Feb 2002 20:40:58 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020217
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, davej@suse.com
CC: Philip.Blundell@pobox.com, tim@cyberelk.net
Subject: [PATCH] -- Needed since at least 2.5.2-pre8  -- Compile error in parport_cs.c: 327: `LP_MAJOR' undeclared
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As you can see, this problem has been known for a while:

 > Subject:  2.5.2-pre8 -- Compile error in parport_cs.c: 327: `LP_MAJOR'
 > From:     Miles Lane <miles@megapathdsl.net>
 > Date:     2002-01-05 8:29:55

parport_cs.c: In function `parport_config':
parport_cs.c:327: `LP_MAJOR' undeclared (first use in this function)
make[2]: *** [parport_cs.o] Error 1
make[2]: Leaving directory `/usr/src/linux/drivers/parport'

This patch is from Evgeniy Polyakov <johnpol@2ka.mipt.ru>.
Please apply, unless the parallel port maintainers spot a problem.

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


