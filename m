Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265168AbTBVPfo>; Sat, 22 Feb 2003 10:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265773AbTBVPfo>; Sat, 22 Feb 2003 10:35:44 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:52930 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S265168AbTBVPfn>;
	Sat, 22 Feb 2003 10:35:43 -0500
Date: Sat, 22 Feb 2003 16:45:48 +0100 (MET)
From: Mikael Pettersson <mikpe@user.it.uu.se>
Message-Id: <200302221545.h1MFjmkW006417@harpo.it.uu.se>
To: davidsen@tmr.com, linux-kernel@vger.kernel.org
Subject: Re: Module loading on demand
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Feb 2003 08:43:29 -0500 (EST), Bill Davidsen wrote:
>I note that with "new modules" modules no longer seem to load as needed 
>but must be loaded by hand or explicitly in modprobe.conf.

If this is the RedHat system you mentioned in your post on sym53c8xx
loading oddity, then you need apply the fix below which I posted to
LKML on Jan 19th.

===snip===
If you're running a RedHat system, you'll also need the following
patch to /etc/rc.d/rc.sysinit. Without it the kernel's modprobe and
hotplug functionalities will be disabled by rc.sysinit.

--- /etc/rc.d/rc.sysinit.~1~	2002-08-22 23:10:52.000000000 +0200
+++ /etc/rc.d/rc.sysinit	2003-01-14 03:04:57.000000000 +0100
@@ -334,7 +334,7 @@
     IN_INITLOG=
 fi
 
-if ! grep -iq nomodules /proc/cmdline 2>/dev/null && [ -f /proc/ksyms ]; then
+if ! grep -iq nomodules /proc/cmdline 2>/dev/null && [ -f /proc/modules ]; then
     USEMODULES=y
 fi
 

(RedHat users should also comment out or remove the /sbin/update line in
/etc/inittab, but that's unrelated to the use of modules.)
===snip===

/Mikael
