Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262764AbTDAT2J>; Tue, 1 Apr 2003 14:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262769AbTDAT2J>; Tue, 1 Apr 2003 14:28:09 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:10176 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262764AbTDAT2H>; Tue, 1 Apr 2003 14:28:07 -0500
Message-ID: <3E89E8C5.40300@us.ibm.com>
Date: Tue, 01 Apr 2003 11:30:13 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (2.5.66-mm2) War on warnings
References: <19200000.1049210557@[10.10.2.4]> <20030401152703.GA21986@gtf.org> <25070000.1049213622@[10.10.2.4]>
Content-Type: multipart/mixed;
 boundary="------------060807070705070900010408"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060807070705070900010408
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Martin J. Bligh wrote:
>>Personally, I feel statements like these are prone to continual error
>>and confusion.  I would prefer to break each test like this out into
>>separate assignment and test statements.  Combining them decreases
>>readability, while saving a paltry few extra bytes of source code.
>>
>>Sure, the gcc warning is silly, but the code is a bit obtuse too.
> 
> 
> True, I agree with this in general, and I think Andrew does too, from
> previous comments. I was just being lazy ;-) More appropriate patch below.
> Compile tested, but not run.
> 
> M.

Ok...  drivers/base/cpu.c had the double parens, unlike memblkc. & 
node.c  This patch will make them all more readable and consistent...

Down with warnings!!  We must liberate them, and set them free! ;)

-Matt

--------------060807070705070900010408
Content-Type: text/plain;
 name="sysfs_register_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sysfs_register_fix.patch"

diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.66-mm2/drivers/base/cpu.c linux-2.5.66-mm2+warnfix/drivers/base/cpu.c
--- linux-2.5.66-mm2/drivers/base/cpu.c	Tue Apr  1 11:22:06 2003
+++ linux-2.5.66-mm2+warnfix/drivers/base/cpu.c	Tue Apr  1 11:26:21 2003
@@ -49,8 +49,12 @@
 int __init cpu_dev_init(void)
 {
 	int error;
-	if (!(error = devclass_register(&cpu_devclass)))
-		if ((error = driver_register(&cpu_driver)))
+
+	error = devclass_register(&cpu_devclass);
+	if (!error) {
+		error = driver_register(&cpu_driver);
+		if (error)
 			devclass_unregister(&cpu_devclass);
+	}
 	return error;
 }
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.66-mm2/drivers/base/memblk.c linux-2.5.66-mm2+warnfix/drivers/base/memblk.c
--- linux-2.5.66-mm2/drivers/base/memblk.c	Tue Apr  1 11:22:06 2003
+++ linux-2.5.66-mm2+warnfix/drivers/base/memblk.c	Tue Apr  1 11:24:51 2003
@@ -50,9 +50,13 @@
 int __init register_memblk_type(void)
 {
 	int error;
-	if (!(error = devclass_register(&memblk_devclass)))
-		if (error = driver_register(&memblk_driver))
+
+	error = devclass_register(&memblk_devclass);
+	if (!error) {
+		error = driver_register(&memblk_driver);
+		if (error)
 			devclass_unregister(&memblk_devclass);
+	}
 	return error;
 }
 postcore_initcall(register_memblk_type);
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.66-mm2/drivers/base/node.c linux-2.5.66-mm2+warnfix/drivers/base/node.c
--- linux-2.5.66-mm2/drivers/base/node.c	Tue Apr  1 11:22:06 2003
+++ linux-2.5.66-mm2+warnfix/drivers/base/node.c	Tue Apr  1 11:24:51 2003
@@ -92,9 +92,13 @@
 int __init register_node_type(void)
 {
 	int error;
-	if (!(error = devclass_register(&node_devclass)))
-		if (error = driver_register(&node_driver))
+	
+	error = devclass_register(&node_devclass);
+	if (!error) {
+		error = driver_register(&node_driver);
+		if (error)
 			devclass_unregister(&node_devclass);
+	}
 	return error;
 }
 postcore_initcall(register_node_type);

--------------060807070705070900010408--

