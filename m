Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269117AbUJKPl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269117AbUJKPl4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 11:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269116AbUJKPlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 11:41:52 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:65477 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269117AbUJKPjI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 11:39:08 -0400
Subject: [PATCH] 2.6.9-rc4-mm1 compile fix for AMD64
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org
Content-Type: multipart/mixed; boundary="=-josL23SyTp+/0gV/6FUX"
Organization: 
Message-Id: <1097508594.12861.326.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 Oct 2004 08:29:54 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-josL23SyTp+/0gV/6FUX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Andrew,

I get following error while compiling 2.6.9-rc4-mm1 on my AMD64 machine.
Here is the patch to fix it.

  CC      arch/x86_64/mm/numa.o
arch/x86_64/mm/numa.c: In function `numa_setup':
arch/x86_64/mm/numa.c:332: error: `numa_fake' undeclared (first use in
this function)
arch/x86_64/mm/numa.c:332: error: (Each undeclared identifier is
reported only once
arch/x86_64/mm/numa.c:332: error: for each function it appears in.)
make[1]: *** [arch/x86_64/mm/numa.o] Error 1
make: *** [arch/x86_64/mm] Error 2
make: *** Waiting for unfinished jobs....
make: *** wait: No child processes.  Stop.


Thanks,
Badari



--=-josL23SyTp+/0gV/6FUX
Content-Disposition: attachment; filename=numa_fake_fix.patch
Content-Type: text/plain; name=numa_fake_fix.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux.org/arch/x86_64/mm/numa.c	2004-10-11 08:41:39.718812776 -0700
+++ linux/arch/x86_64/mm/numa.c	2004-10-11 08:41:58.485959736 -0700
@@ -328,11 +328,13 @@ __init int numa_setup(char *opt) 
 { 
 	if (!strcmp(opt,"off"))
 		numa_off = 1;
+#ifdef CONFIG_NUMA_EMU
 	if(!strncmp(opt, "fake=", 5)) {
 		numa_fake = simple_strtoul(opt+5,NULL,0); ;
 		if (numa_fake >= MAX_NUMNODES)
 			numa_fake = MAX_NUMNODES;
 	}
+#endif
 	return 1;
 } 
 

--=-josL23SyTp+/0gV/6FUX--

