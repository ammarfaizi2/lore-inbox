Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262749AbVA1VeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262749AbVA1VeT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 16:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262761AbVA1VeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 16:34:19 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:15599 "EHLO
	prometheus.mvista.com") by vger.kernel.org with ESMTP
	id S262749AbVA1VeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 16:34:10 -0500
Date: Fri, 28 Jan 2005 13:34:00 -0800
From: Manish Lachwani <mlachwani@mvista.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mlachwani@mvista.com
Subject: [PATCH] Fix compile errors with 2.6.11-rc2
Message-ID: <20050128213400.GA20234@prometheus.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi !

When compiling 2.6.11-rc2:

...

  CC      kernel/stop_machine.o
In file included from include/linux/sysdev.h:24,
                 from include/linux/cpu.h:22,
                 from include/linux/stop_machine.h:8,
                 from kernel/stop_machine.c:1:
include/linux/kobject.h: In function `to_kset':
include/linux/kobject.h:116: warning: implicit declaration of function `container_of'
include/linux/kobject.h:116: error: parse error before "struct"
include/linux/kobject.h:117: warning: no return statement in function returning non-void
include/linux/kobject.h: In function `subsys_get':
include/linux/kobject.h:224: error: parse error before "struct"
include/linux/kobject.h:225: warning: no return statement in function returning non-void
make[1]: *** [kernel/stop_machine.o] Error 1
make: *** [kernel] Error 2

Attached patch fixes this.

Thanks
Manish Lachwani

--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="patch_kobject.patch"

Signed-off-by: Manish Lachwani <mlachwani@mvista.com>

Index: linux-2.6.11-rc2/include/linux/kobject.h
===================================================================
--- linux-2.6.11-rc2.orig/include/linux/kobject.h
+++ linux-2.6.11-rc2/include/linux/kobject.h
@@ -23,6 +23,7 @@
 #include <linux/rwsem.h>
 #include <linux/kref.h>
 #include <linux/kobject_uevent.h>
+#include <linux/kernel.h>
 #include <asm/atomic.h>
 
 #define KOBJ_NAME_LEN	20

--Kj7319i9nmIyA2yE--
