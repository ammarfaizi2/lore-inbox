Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269717AbUJHKdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269717AbUJHKdN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 06:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269738AbUJHKdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 06:33:13 -0400
Received: from mail4.hitachi.co.jp ([133.145.228.5]:62698 "EHLO
	mail4.hitachi.co.jp") by vger.kernel.org with ESMTP id S269717AbUJHKdD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 06:33:03 -0400
Message-ID: <41666CF9.4040207@sdl.hitachi.co.jp>
Date: Fri, 08 Oct 2004 19:33:29 +0900
From: Hideo AOKI <aoki@sdl.hitachi.co.jp>
Organization: Systems Development Lab., Hitachi, Ltd.
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: ja
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm3: vm-thrashing-control-tuning
References: <20041007015139.6f5b833b.akpm@osdl.org>
In-Reply-To: <20041007015139.6f5b833b.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------030208040203050500000807"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030208040203050500000807
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc3/2.6.9-rc3-mm3/
[...]
> 
> Changes since 2.6.9-rc3-mm2:
> 
[...]
>  
> +vm-thrashing-control-tuning.patch
> 
>  /proc/sys/vm/swap_token_timeout

Hello, Andrew,

Thank you for applying my patch.

Since I made the patch for 2.6.9-rc3, the patch caused trouble 
to sysctl code in -mm tree.

Attached patch fixes this issue.

I am very sorry for the trouble.


Best regards,

Hideo AOKI

Systems Development Laboratory, Hitachi, Ltd.

--------------030208040203050500000807
Content-Type: text/plain;
 name="vm-thrashing-control-tuning-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm-thrashing-control-tuning-fix.patch"

Signed-off-by: Hideo Aoki <aoki@sdl.hitachi.co.jp>

 include/linux/sysctl.h |    2 +-
 kernel/sysctl.c        |   18 +++++++++---------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff -uprN linux-2.6.9-rc3-mm3/include/linux/sysctl.h linux-2.6.9-rc3-mm3-fix/include/linux/sysctl.h
--- linux-2.6.9-rc3-mm3/include/linux/sysctl.h	2004-10-08 14:42:27.000000000 +0900
+++ linux-2.6.9-rc3-mm3-fix/include/linux/sysctl.h	2004-10-08 14:53:33.000000000 +0900
@@ -168,7 +168,7 @@ enum
 	VM_VFS_CACHE_PRESSURE=26, /* dcache/icache reclaim pressure */
 	VM_LEGACY_VA_LAYOUT=27, /* legacy/compatibility virtual address space layout */
  	VM_HEAP_STACK_GAP=28,	/* int: page gap between heap and stack */
-	VM_SWAP_TOKEN_TIMEOUT=28, /* default time for token time out */
+	VM_SWAP_TOKEN_TIMEOUT=29, /* default time for token time out */
 };
 
 
diff -uprN linux-2.6.9-rc3-mm3/kernel/sysctl.c linux-2.6.9-rc3-mm3-fix/kernel/sysctl.c
--- linux-2.6.9-rc3-mm3/kernel/sysctl.c	2004-10-08 14:42:28.000000000 +0900
+++ linux-2.6.9-rc3-mm3-fix/kernel/sysctl.c	2004-10-08 18:16:25.000000000 +0900
@@ -624,15 +624,6 @@ static ctl_table kern_table[] = {
 		.proc_handler   = &proc_unknown_nmi_panic,
 	},
 #endif
-	{
-		.ctl_name	= VM_SWAP_TOKEN_TIMEOUT,
-		.procname	= "swap_token_timeout",
-		.data		= &swap_token_default_timeout,
-		.maxlen		= sizeof(swap_token_default_timeout),
-		.mode		= 0644,
-		.proc_handler	= &proc_dointvec_jiffies,
-		.strategy	= &sysctl_jiffies,
-	},
 	{ .ctl_name = 0 }
 };
 
@@ -822,6 +813,15 @@ static ctl_table vm_table[] = {
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
 	},
+	{
+		.ctl_name	= VM_SWAP_TOKEN_TIMEOUT,
+		.procname	= "swap_token_timeout",
+		.data		= &swap_token_default_timeout,
+		.maxlen		= sizeof(swap_token_default_timeout),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_jiffies,
+		.strategy	= &sysctl_jiffies,
+	},
 	{ .ctl_name = 0 }
 };
 

--------------030208040203050500000807--

