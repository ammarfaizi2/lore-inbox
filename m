Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287652AbSAELMy>; Sat, 5 Jan 2002 06:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288688AbSAELMm>; Sat, 5 Jan 2002 06:12:42 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:40934 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S287652AbSAELMb>; Sat, 5 Jan 2002 06:12:31 -0500
Date: Sat, 5 Jan 2002 03:12:28 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: tim@cyberelk.net, campbell@torque.net, andrea@e-mind.com,
        linux-kernel@vger.kernel.org
Subject: Patch: linux-2.5.2-pre8/drivers/parport/parport_cs.c need <linux/major.h> to compile
Message-ID: <20020105031228.A23728@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	linux-2.5.2/drivers/parport/parport_cs.c needed to include
<linux/major.h> to get LP_MAJOR in order to compile.  To address
a compiler warning, I also put an appropriate ifdef around the
declaration of a variable that is only used with certain kernel versions.

	I have not tested this code.  I only know that it now compiles.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="parport.diffs"

--- linux-2.5.2-pre8/drivers/parport/parport_cs.c	Sun Sep 30 12:26:08 2001
+++ linux/drivers/parport/parport_cs.c	Sat Jan  5 03:07:21 2002
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
+#if (LINUX_VERSION_CODE < VERSION(2,3,6))
 static struct parport_operations parport_cs_ops;
+#endif
 
 /*====================================================================*/
 

--xHFwDpU9dbj6ez1V--
