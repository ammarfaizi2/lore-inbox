Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263598AbUDEWgl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 18:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262984AbUDEWdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 18:33:39 -0400
Received: from smtp2.libero.it ([193.70.192.52]:23966 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id S263578AbUDEWcu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 18:32:50 -0400
Date: Tue, 6 Apr 2004 00:33:59 +0200
From: "Angelo Dell'Aera" <buffer@antifork.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel 2.6.5-mm1 : laptop-mode
Message-Id: <20040406003359.7d3d8d5a.buffer@antifork.org>
In-Reply-To: <20040405145209.4904aec5.akpm@osdl.org>
References: <20040405155055.3e9afab0.buffer@antifork.org>
	<20040405145209.4904aec5.akpm@osdl.org>
Organization: Antifork Research, Inc.
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-PGP-Program: GNU Privacy Guard (http://www.gnupg.org)
X-PGP-PublicKey: http://buffer.antifork.org/privacy/buffer-gpg.asc
X-PGP-Fingerprint: 48CC B0D8 C394 CD30 355F E36D A4E3 48CF 19C1 5CA2
X-Operating-System: GNU-Linux
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Apr 2004 14:52:09 -0700
Andrew Morton <akpm@osdl.org> wrote:

>"Angelo Dell'Aera" <buffer@antifork.org> wrote:
>>
>> After upgrading to 2.6.5-mm1 I noticed the script laptop_mode
>> failed to initiliaze laptop mode. It is due to the new position
>> of the sysctl laptop_mode under /proc. This is an update to the
>> documentation (and the script). Please apply.
>> ...
>>  
>> -Laptop-mode is controlled by the flag /proc/sys/vm/laptop_mode. When this
>> +Laptop-mode is controlled by the flag /proc/sys/fs/laptop_mode. When this
>
>erk.  No, that was not intended.  Looks like `patch' decided to move some code around
>for me.  I'll fix that up, thanks.  laptop_mode shall remain in /proc/sys/vm/

OK. Attached a patch which addresses this matter.

Regards.

--

Angelo Dell'Aera 'buffer' 
Antifork Research, Inc.	  	http://buffer.antifork.org




--- linux-2.6.5-mm1/kernel/sysctl.c.old	2004-04-06 00:26:15.000000000 +0200
+++ linux-2.6.5-mm1/kernel/sysctl.c	2004-04-06 00:28:29.000000000 +0200
@@ -744,6 +744,26 @@
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec
 	},
+	{
+		.ctl_name	= VM_LAPTOP_MODE,
+		.procname	= "laptop_mode",
+		.data		= &laptop_mode,
+		.maxlen		= sizeof(laptop_mode),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &zero,
+	},
+	{
+		.ctl_name	= VM_BLOCK_DUMP,
+		.procname	= "block_dump",
+		.data		= &block_dump,
+		.maxlen		= sizeof(block_dump),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &zero,
+	},
 	{ .ctl_name = 0 }
 };
 
@@ -854,26 +874,6 @@
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
 	},
-	{
-		.ctl_name	= VM_LAPTOP_MODE,
-		.procname	= "laptop_mode",
-		.data		= &laptop_mode,
-		.maxlen		= sizeof(laptop_mode),
-		.mode		= 0644,
-		.proc_handler	= &proc_dointvec,
-		.strategy	= &sysctl_intvec,
-		.extra1		= &zero,
-	},
-	{
-		.ctl_name	= VM_BLOCK_DUMP,
-		.procname	= "block_dump",
-		.data		= &block_dump,
-		.maxlen		= sizeof(block_dump),
-		.mode		= 0644,
-		.proc_handler	= &proc_dointvec,
-		.strategy	= &sysctl_intvec,
-		.extra1		= &zero,
-	},
 	{ .ctl_name = 0 }
 };
 



