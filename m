Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293276AbSC3XY3>; Sat, 30 Mar 2002 18:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293347AbSC3XYU>; Sat, 30 Mar 2002 18:24:20 -0500
Received: from salmon.maths.tcd.ie ([134.226.81.11]:47369 "HELO
	salmon.maths.tcd.ie") by vger.kernel.org with SMTP
	id <S293276AbSC3XYH>; Sat, 30 Mar 2002 18:24:07 -0500
Date: Sat, 30 Mar 2002 23:23:07 +0000
From: Timothy Murphy <tim@birdsnest.maths.tcd.ie>
To: linux-kernel@vger.kernel.org
Subject: linux-2.5.7
Message-ID: <20020330232307.A2673@birdsnest.maths.tcd.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sure this has been recognised,
but I would point out that sys_nfsservctl is not "undefined"
if NFSD is not chosen.

The following patch to .../arch/i386/kernel/entry.S corrects this,
though this is obviously not the right place to put it:

===============================================================
--- entry.S.bak	Mon Mar 18 20:37:09 2002
+++ entry.S	Thu Mar 28 15:59:20 2002
@@ -40,6 +40,11 @@
  * "current" is in register %ebx during any slow entries.
  */
 
+#if defined(CONFIG_NFSD) || defined(CONFIG_NFSD_MODULE)
+#else
+#define sys_nfsservctl		sys_ni_syscall
+#endif
+
 #include <linux/config.h>
 #include <linux/sys.h>
 #include <linux/linkage.h>
===============================================================

-- 
Timothy Murphy  
e-mail: tim@birdsnest.maths.tcd.ie
tel: 086-233 6090
s-mail: School of Mathematics, Trinity College, Dublin 2, Ireland
