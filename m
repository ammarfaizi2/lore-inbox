Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264309AbUDSJRq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 05:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264319AbUDSJRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 05:17:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:32705 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264309AbUDSJRo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 05:17:44 -0400
Date: Mon, 19 Apr 2004 02:17:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc1-mm1 failure: kmod.o didn't compile with module-less
 setup
Message-Id: <20040419021723.3a8295ec.akpm@osdl.org>
In-Reply-To: <40839850.2010907@aitel.hist.no>
References: <20040418230131.285aa8ae.akpm@osdl.org>
	<40839850.2010907@aitel.hist.no>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting <helgehaf@aitel.hist.no> wrote:
>
> This one zonked out. I haven't configured module support, I simply
> compile a monolithic kernel tailored for this particular machine.
> I got this error, where 2.6.5-mm6 works well:
> 
>   CC      kernel/kmod.o
> kernel/kmod.c: In function `call_usermodehelper':
> kernel/kmod.c:253: error: `khelper_wq' undeclared (first use in this function)
> kernel/kmod.c:253: error: (Each undeclared identifier is reported only once
> kernel/kmod.c:253: error: for each function it appears in.)
> kernel/kmod.c: In function `usermodehelper_init':
> kernel/kmod.c:267: error: `khelper_wq' undeclared (first use in this function)
> make[1]: *** [kernel/kmod.o] Error 1
> make: *** [kernel] Error 2
> 


diff -puN kernel/kmod.c~use-workqueue-for-call_usermodehelper-fix kernel/kmod.c
--- 25/kernel/kmod.c~use-workqueue-for-call_usermodehelper-fix	2004-04-19 01:45:50.561866616 -0700
+++ 25-akpm/kernel/kmod.c	2004-04-19 01:45:56.323990640 -0700
@@ -40,9 +40,10 @@
 
 extern int max_threads;
 
-#ifdef CONFIG_KMOD
 static struct workqueue_struct *khelper_wq;
 
+#ifdef CONFIG_KMOD
+
 /*
 	modprobe_path is set via /proc/sys.
 */

_

