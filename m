Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263343AbTIGPeR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 11:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263348AbTIGPeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 11:34:17 -0400
Received: from [65.248.4.67] ([65.248.4.67]:17857 "EHLO verdesmares.com")
	by vger.kernel.org with ESMTP id S263343AbTIGPeP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 11:34:15 -0400
Message-ID: <000a01c38db1$76b4e400$f8e4a7c8@bsb.virtua.com.br>
From: "Breno" <brenosp@brasilsec.com.br>
To: "Marcelo" <marcelo@conectiva.com.br>
Cc: "Kernel List" <linux-kernel@vger.kernel.org>
Subject: mswap.patch - 2.4.20
Date: Wed, 8 Oct 2003 12:33:01 -0300
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0007_01C38D98.5031EB20"
X-XTmail: http://www.verdesmares.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0007_01C38D98.5031EB20
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi ,


I dis this small patch , because i need to know information about swap´s
consume.

patch for kernel 2.4.20


thanks

------=_NextPart_000_0007_01C38D98.5031EB20
Content-Type: text/plain;
	name="mswap.patch.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="mswap.patch.txt"

--- memoryo.c	Thu Feb 13 17:35:20 2003
+++ memory.c	Wed Oct  8 08:53:30 2003
@@ -49,6 +49,7 @@
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
 #include <asm/tlb.h>
+#include <linux/sched.h>
=20
 unsigned long max_mapnr;
 unsigned long num_physpages;
@@ -1504,3 +1505,28 @@
 	}
 	return page;
 }
+
+int show_swap_usage(void)
+{
+    struct task_struct *p =3D NULL;
+   =20
+    for_each_task(p)
+    {
+	if(p !=3D NULL)
+	{
+	    if(p->pid !=3D 1)
+	    {
+		if(p->mm !=3D NULL)
+		{
+		    if(p->nswap > 0)
+		    {
+			printk(KERN_CRIT"Process name: %s pid %d\n",p->comm,p->pid);
+			printk(KERN_CRIT"Nswap: %lu Totalvm %lu Cswap =
%lu\n",p->nswap,p->mm->total_vm,p->cnswap);
+			return 0;
+		    }
+		}
+	    }
+	}
+    }
+    return 0;
+}=09

------=_NextPart_000_0007_01C38D98.5031EB20--

