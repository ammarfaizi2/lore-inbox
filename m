Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S145160AbRA2Fnp>; Mon, 29 Jan 2001 00:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S145262AbRA2Fng>; Mon, 29 Jan 2001 00:43:36 -0500
Received: from webmail.metabyte.com ([216.218.208.53]:42249 "EHLO
	webmail.metabyte.com") by vger.kernel.org with ESMTP
	id <S145160AbRA2FnU>; Mon, 29 Jan 2001 00:43:20 -0500
Message-ID: <3A7502A2.C9899EF0@metabyte.com>
Date: Sun, 28 Jan 2001 21:41:54 -0800
From: Pete Zaitcev <zaitcev@metabyte.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.1-pre11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: dagb@cs.uit.no
Subject: Patch to run IrDA with no modules in 2.4.x
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Jan 2001 05:43:14.0231 (UTC) FILETIME=[5F4D0470:01C089B6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A minor problem here - module_init(irda_proto_init) got bracketed
by #ifdef MODULE and became ineffective if compiled without modules.

-- Pete

diff -ur -X dontdiff linux-2.4.1-pre11/net/irda/af_irda.c linux-2.4.1-pre11-p3/net/irda/af_irda.c
--- linux-2.4.1-pre11/net/irda/af_irda.c	Sat Nov 11 18:11:23 2000
+++ linux-2.4.1-pre11-p3/net/irda/af_irda.c	Sun Jan 28 21:31:16 2001
@@ -2409,6 +2409,7 @@
 #endif
 	return 0;
 }
+module_init(irda_proto_init);
 
 /*
  * Function irda_proto_cleanup (void)
@@ -2429,11 +2430,9 @@
 	
         return;
 }
-module_init(irda_proto_init);
 module_exit(irda_proto_cleanup);
  
 MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
 MODULE_DESCRIPTION("The Linux IrDA Protocol Subsystem"); 
 MODULE_PARM(irda_debug, "1l");
 #endif /* MODULE */
-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
