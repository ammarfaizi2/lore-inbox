Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264730AbTAVXvC>; Wed, 22 Jan 2003 18:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264739AbTAVXvC>; Wed, 22 Jan 2003 18:51:02 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:57754 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264730AbTAVXvB>;
	Wed, 22 Jan 2003 18:51:01 -0500
Message-ID: <3E2F2EC1.4090606@us.ibm.com>
Date: Wed, 22 Jan 2003 15:52:33 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: [patch][trivial] fix drivers/base/cpu.c
Content-Type: multipart/mixed;
 boundary="------------050105040306060502000102"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050105040306060502000102
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Both drivers/base/node.c & memblk.c check the return values of the 
devclass_register & driver_register calls.  cpu.c doesn't.  This little 
patch remedies that omission.

[mcd@arrakis push]$ diffstat sysfs_topo_cleanup-2.5.59.patch
  cpu.c |    4 ++--
  1 files changed, 2 insertions(+), 2 deletions(-)

Cheers!

-Matt

--------------050105040306060502000102
Content-Type: text/plain;
 name="sysfs_topo_cleanup-2.5.59.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sysfs_topo_cleanup-2.5.59.patch"

diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.58-vanilla/drivers/base/cpu.c linux-2.5.58-topo_cleanup/drivers/base/cpu.c
--- linux-2.5.58-vanilla/drivers/base/cpu.c	Mon Jan 13 21:58:28 2003
+++ linux-2.5.58-topo_cleanup/drivers/base/cpu.c	Thu Jan 16 16:48:23 2003
@@ -48,7 +48,7 @@
 
 static int __init register_cpu_type(void)
 {
-	devclass_register(&cpu_devclass);
-	return driver_register(&cpu_driver);
+	int error = devclass_register(&cpu_devclass);
+	return error ? error : driver_register(&cpu_driver);
 }
 postcore_initcall(register_cpu_type);

--------------050105040306060502000102--

