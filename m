Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312327AbSCUAyc>; Wed, 20 Mar 2002 19:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312329AbSCUAyQ>; Wed, 20 Mar 2002 19:54:16 -0500
Received: from mx7.sac.fedex.com ([199.81.194.38]:7699 "EHLO mx7.sac.fedex.com")
	by vger.kernel.org with ESMTP id <S312327AbSCUAxz>;
	Wed, 20 Mar 2002 19:53:55 -0500
Date: Thu, 21 Mar 2002 09:03:14 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Marcelo Tosatti <marcelo@conectiva.com.br>, <andre@linux-ide.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Jeff Chua <jchua@fedex.com>,
        <andre@linux-ide.org>
Subject: [PATCH] 2.4.19-pre4 ide-probe
Message-ID: <Pine.LNX.4.44.0203210853510.24355-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 03/21/2002
 08:53:40 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 03/21/2002
 08:53:42 AM,
	Serialize complete at 03/21/2002 08:53:42 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Marcelo, Andre,

Someone apparently added the "hook", but it was never used in the kernel,

What is ide_xlate_1024 referring to?

Jeff

---------- Forwarded message ----------
Date: Thu, 14 Mar 2002 11:22:27 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>,
     Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Jeff Chua <jchua@fedex.com>
Subject: [PATCH] 2.4.19-pre3 ide_xlate_1024_hook ???


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



