Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265706AbUHHXSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265706AbUHHXSs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 19:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265701AbUHHXSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 19:18:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:21702 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265706AbUHHXSn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 19:18:43 -0400
Date: Sun, 8 Aug 2004 16:17:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Brice.Goglin@ens-lyon.fr, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc3-mm2
Message-Id: <20040808161706.643bd7e8.akpm@osdl.org>
In-Reply-To: <20040808160456.7706bc97.akpm@osdl.org>
References: <20040808152936.1ce2eab8.akpm@osdl.org>
	<20040808225504.GD31602@ens-lyon.fr>
	<20040808160456.7706bc97.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> The below is probably wrongish, but it'll get you thorugh.

<actually looks>

This is the correct patch.

diff -puN arch/i386/kernel/nmi.c~nmi-build-fix arch/i386/kernel/nmi.c
--- 25/arch/i386/kernel/nmi.c~nmi-build-fix	2004-08-08 16:15:55.998033640 -0700
+++ 25-akpm/arch/i386/kernel/nmi.c	2004-08-08 16:15:56.003032880 -0700
@@ -549,13 +549,13 @@ static int unknown_nmi_panic_callback(st
 /*
  * proc handler for /proc/sys/kernel/unknown_nmi_panic
  */
-int proc_unknown_nmi_panic(ctl_table *table, int write,
-                struct file *file, void __user *buffer, size_t *length)
+int proc_unknown_nmi_panic(ctl_table *table, int write, struct file *file,
+			void __user *buffer, size_t *length, loff_t *ppos)
 {
 	int old_state;
 
 	old_state = unknown_nmi_panic;
-	proc_dointvec(table, write, file, buffer, length);
+	proc_dointvec(table, write, file, buffer, length, ppos);
 	if (!!old_state == !!unknown_nmi_panic)
 		return 0;
 
diff -puN kernel/sysctl.c~nmi-build-fix kernel/sysctl.c
--- 25/kernel/sysctl.c~nmi-build-fix	2004-08-08 16:15:56.000033336 -0700
+++ 25-akpm/kernel/sysctl.c	2004-08-08 16:15:56.004032728 -0700
@@ -69,7 +69,7 @@ extern int printk_ratelimit_burst;
 #if defined(CONFIG_X86_LOCAL_APIC) && defined(__i386__)
 int unknown_nmi_panic;
 extern int proc_unknown_nmi_panic(ctl_table *, int, struct file *,
-				  void __user *, size_t *);
+				  void __user *, size_t *, loff_t *);
 #endif
 
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
_

