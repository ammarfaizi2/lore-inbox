Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311492AbSCNDNi>; Wed, 13 Mar 2002 22:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311493AbSCNDN3>; Wed, 13 Mar 2002 22:13:29 -0500
Received: from mx1.sac.fedex.com ([199.81.208.10]:4115 "EHLO mx1.sac.fedex.com")
	by vger.kernel.org with ESMTP id <S311492AbSCNDNL>;
	Wed, 13 Mar 2002 22:13:11 -0500
Date: Thu, 14 Mar 2002 11:22:27 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Linux Kernel <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Jeff Chua <jchua@fedex.com>
Subject: [PATCH] 2.4.19-pre3 ide_xlate_1024_hook ???
Message-ID: <Pine.LNX.4.44.0203141053220.13816-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 03/14/2002
 11:12:59 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 03/14/2002
 11:13:03 AM,
	Serialize complete at 03/14/2002 11:13:03 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It seems that the "ide_xlate_1024_hook" is redundant in
./drivers/ide/ide-probe.c

It's not used anywhere by the kernel, and it caused "depmod" to fail
with unknown ide_xlate_1024_hook symbol.


Jeff

Patch ...

--- ./drivers/ide/ide-probe.c.org       Thu Mar 14 11:01:20 2002
+++ ./drivers/ide/ide-probe.c   Thu Mar 14 11:03:16 2002
@@ -987,7 +987,6 @@
 }

 #ifdef MODULE
-extern int (*ide_xlate_1024_hook)(kdev_t, int, int, const char *);

 int init_module (void)
 {
@@ -997,14 +996,12 @@
                ide_unregister(index);
        ideprobe_init();
        create_proc_ide_interfaces();
-       ide_xlate_1024_hook = ide_xlate_1024;
        return 0;
 }

 void cleanup_module (void)
 {
        ide_probe = NULL;
-       ide_xlate_1024_hook = 0;
 }
 MODULE_LICENSE("GPL");
 #endif /* MODULE */


