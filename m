Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286290AbRLJPlE>; Mon, 10 Dec 2001 10:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286287AbRLJPky>; Mon, 10 Dec 2001 10:40:54 -0500
Received: from cs.wustl.edu ([128.252.165.15]:56053 "EHLO
	taumsauk.cs.wustl.edu") by vger.kernel.org with ESMTP
	id <S286288AbRLJPkl>; Mon, 10 Dec 2001 10:40:41 -0500
From: Berkley Shands <berkley@cs.wustl.edu>
Date: Mon, 10 Dec 2001 09:40:39 -0600 (CST)
Message-Id: <200112101540.JAA0000013754@mudpuddle.cs.wustl.edu>
To: linux-kernel@vger.kernel.org
Subject: /proc/net/atm initialization
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	When ATM is enabled, and any driver is loaded with the kernel
(not as a module), the init of atm_proc_root has not been done
when the driver inits. this leaves the driver putting its /proc data
into /proc, not in /proc/net/atm.
	This bug has existed for quite some time, and the patch has been
out on the linux-atm list for a while. Since there is no ATM or /proc entry
in MAINTAINERS, the SubmittingPatches file says send it here. OK, 
here it is :-)

diff -Naur linux-2.4.16-clean/net/atm/proc.c linux/net/atm/proc.c
--- linux-2.4.16-clean/net/atm/proc.c	Wed Jul  4 13:50:38 2001
+++ linux/net/atm/proc.c	Mon Nov 26 10:22:45 2001
@@ -547,6 +547,11 @@
 	int digits,num;
 	int error;
 
+/* atm_proc_init isn't called until the end of the startup */
+/* so make the call now instead wuarl/wuapic */
+
+	if (! atm_proc_root)
+	   atm_proc_init();		/* force /proc/net/atm to exist */
 	error = -ENOMEM;
 	digits = 0;
 	for (num = dev->number; num; num /= 10) digits++;
@@ -588,9 +593,12 @@
 	struct proc_dir_entry *devices = NULL,*pvc = NULL,*svc = NULL;
 	struct proc_dir_entry *arp = NULL,*lec = NULL,*vc = NULL;
 
+	if (atm_proc_root)
+	   return 0;		/* already made wuarl/wuapic */
 	atm_proc_root = proc_mkdir("net/atm",NULL);
 	if (!atm_proc_root)
 		return -ENOMEM;
+
 	CREATE_ENTRY(devices);
 	CREATE_ENTRY(pvc);
 	CREATE_ENTRY(svc);


berkley (WU APIC driver NIC driver)
