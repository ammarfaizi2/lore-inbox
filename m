Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbUKJHEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbUKJHEv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 02:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbUKJHEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 02:04:51 -0500
Received: from fmr06.intel.com ([134.134.136.7]:52388 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261235AbUKJHEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 02:04:48 -0500
Subject: [PATCH] two sysdevs have same name
From: Li Shaohua <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Pallipadi Venkatesh <venkatesh.pallipadi@intel.com>
Content-Type: multipart/mixed; boundary="=-DlV2zSmxRKzIJ+dSvQiF"
Message-Id: <1100069919.25061.11.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 10 Nov 2004 14:58:39 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-DlV2zSmxRKzIJ+dSvQiF
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,
It takes me several days to debug a resume failure and I finally found
it's a mis-merge. Two sysdevs (previous PIT and Timer, after Venki's
HPET patch) use the same name 'timer'. Please feel free to select a
different name.

PS. I'm surprised sysdev_class_register doesn't return an error in such
situation.

Thanks,
Shaohua


===== arch/i386/kernel/timers/timer_pit.c 1.14 vs edited =====
--- 1.14/arch/i386/kernel/timers/timer_pit.c	2004-08-24 03:48:32 +08:00
+++ edited/arch/i386/kernel/timers/timer_pit.c	2004-11-10 14:46:12
+08:00
@@ -181,7 +181,7 @@ static int timer_resume(struct sys_devic
 }
 
 static struct sysdev_class timer_sysclass = {
-	set_kset_name("timer"),
+	set_kset_name("pit"),
 	.resume	= timer_resume,
 };
 

--=-DlV2zSmxRKzIJ+dSvQiF
Content-Disposition: attachment; filename=pit.patch
Content-Type: text/x-patch; name=pit.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

===== arch/i386/kernel/timers/timer_pit.c 1.14 vs edited =====
--- 1.14/arch/i386/kernel/timers/timer_pit.c	2004-08-24 03:48:32 +08:00
+++ edited/arch/i386/kernel/timers/timer_pit.c	2004-11-10 14:46:12 +08:00
@@ -181,7 +181,7 @@ static int timer_resume(struct sys_devic
 }
 
 static struct sysdev_class timer_sysclass = {
-	set_kset_name("timer"),
+	set_kset_name("pit"),
 	.resume	= timer_resume,
 };
 

--=-DlV2zSmxRKzIJ+dSvQiF--

