Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266794AbSLJUx5>; Tue, 10 Dec 2002 15:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266795AbSLJUx5>; Tue, 10 Dec 2002 15:53:57 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:29397 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266794AbSLJUx4>;
	Tue, 10 Dec 2002 15:53:56 -0500
Message-ID: <3DF655DF.1040507@us.ibm.com>
Date: Tue, 10 Dec 2002 13:00:15 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "dhow >> David Howells" <dhowells@redhat.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix strange stack calculation for secondary cpus
Content-Type: multipart/mixed;
 boundary="------------020902030102020404000403"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020902030102020404000403
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

in arch/i386/kernel/smpboot.c:
stack_start.esp = (void *) (1024 + PAGE_SIZE + (char *)idle);

This causes problems when I switch to 4k stacks?  What is supposed to 
be going on here?  Why point esp into the middle of the stack?  If you 
wanted to do that, why not just use PAGE_SIZE>>2?

In any case, I think THREAD_SIZE needs to be here instead of PAGE_SIZE.
-- 
Dave Hansen
haveblue@us.ibm.com

--------------020902030102020404000403
Content-Type: text/plain;
 name="fix-esp-2.5.51.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-esp-2.5.51.patch"

--- linux-2.5.50/arch/i386/kernel/smpboot.c.bad	Tue Dec 10 12:56:10 2002
+++ linux-2.5.50/arch/i386/kernel/smpboot.c	Tue Dec 10 12:56:55 2002
@@ -806,7 +806,7 @@
 
 	/* So we see what's up   */
 	printk("Booting processor %d/%d eip %lx\n", cpu, apicid, start_eip);
-	stack_start.esp = (void *) (1024 + PAGE_SIZE + (char *)idle->thread_info);
+	stack_start.esp = (void *) (THREAD_SIZE + (char *)idle->thread_info);
 
 	/*
 	 * This grunge runs the startup process for

--------------020902030102020404000403--

