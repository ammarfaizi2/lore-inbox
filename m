Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbVB0CgU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbVB0CgU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 21:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbVB0CgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 21:36:20 -0500
Received: from imap.gmx.net ([213.165.64.20]:5864 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261332AbVB0CgO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 21:36:14 -0500
X-Authenticated: #264456
Date: Sun, 27 Feb 2005 03:36:29 +0100
From: Matthias Kunze <Matthias.Kunze@gmx-topmail.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] config option for default loglevel
Message-Id: <20050227033629.3b390822.Matthias.Kunze@gmx-topmail.de>
In-Reply-To: <20050226181552.126e3f25.akpm@osdl.org>
References: <20050226190556.0def242c.Matthias.Kunze@gmx-topmail.de>
	<20050226154505.43889139.akpm@osdl.org>
	<20050227030431.46496c7a.Matthias.Kunze@gmx-topmail.de>
	<20050226181552.126e3f25.akpm@osdl.org>
Reply-To: Matthias.Kunze@gmx-topmail.de
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sat, 26 Feb 2005 18:15:52 -0800 schrieb Andrew Morton <akpm@osdl.org>:
 
> I don't see a need for the compile-time option now..
> 

Well i would prefer to also have a compile-time option, but only a boot
paramter will also do the job.

diff -Naur linux-2.6.10/Documentation/kernel-parameters.txt linux-2.6.10-new/Documentation/kernel-parameters.txt
--- linux-2.6.10/Documentation/kernel-parameters.txt    2005-02-27 02:47:09.000000000 +0100
+++ linux-2.6.10-new/Documentation/kernel-parameters.txt        2005-02-27 02:52:36.000000000 +0100
@@ -634,6 +634,20 @@
        logibm.irq=     [HW,MOUSE] Logitech Bus Mouse Driver
                        Format: <irq>

+        loglevel=       All Kernel Messages with a loglevel smaller than the
+                        console loglevel will be printed to the console. It can
+                        also be changed with klogd or other programs. The
+                        loglevels are defined as follows:
+
+                        0 (KERN_EMERG)        system is unusable
+                        1 (KERN_ALERT)        action must be taken immediately
+                        2 (KERN_CRIT)         critical conditions
+                        3 (KERN_ERR)          error conditions
+                        4 (KERN_WARNING)      warning conditions
+                        5 (KERN_NOTICE)       normal but significant condition
+                        6 (KERN_INFO)         informational
+                        7 (KERN_DEBUG)        debug-level messages
+
        log_buf_len=n   Sets the size of the printk ring buffer, in bytes.
                        Format is n, nk, nM.  n must be a power of two.  The
                        default is set in kernel config.
diff -Naur linux-2.6.10/init/main.c linux-2.6.10-new/init/main.c
--- linux-2.6.10/init/main.c    2005-02-27 02:48:32.000000000 +0100
+++ linux-2.6.10-new/init/main.c        2005-02-27 02:39:08.000000000 +0100
@@ -209,6 +209,14 @@
 __setup("debug", debug_kernel);
 __setup("quiet", quiet_kernel);

+static int __init loglevel(char *str)
+{
+        get_option(&str, &console_loglevel);
+        return 1;
+}
+
+__setup("loglevel=", loglevel);
+
 /*
  * Unknown boot options get handed to init, unless they look like
  * failed parameters
