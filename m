Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316840AbSGHK5M>; Mon, 8 Jul 2002 06:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316842AbSGHK5L>; Mon, 8 Jul 2002 06:57:11 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:25360 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S316840AbSGHK5K>;
	Mon, 8 Jul 2002 06:57:10 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Peter Oberparleiter <oberpapr@softhome.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.18/2.5.24 kernel/module.c - minor bugs 
In-reply-to: Your message of "Mon, 08 Jul 2002 10:27:50 +0200."
             <200207080828.g688Sdo51968@d06relay02.portsmouth.uk.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 08 Jul 2002 20:59:37 +1000
Message-ID: <17075.1026125977@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jul 2002 10:27:50 +0200, 
Peter Oberparleiter <oberpapr@softhome.net> wrote:
>this patch fixes two minor bugs in kernel/module.c in current linux
>kernel versions (2.4.18/2.5.24) which could cause problems in some
>rare situations:
>1. A size-check in sys_create_module is off by one. The check reads
>2. In case "struct module" used by insmod is larger than the one used
>by the kernel (e.g. newer version), module loading will fail.

Looks good.  Linus/Marcelo, please apply.

========================================
--- linux-2.4.17/kernel/module.c	Sun Nov 11 20:23:14 2001
+++ linux-2.4.17-modfix/kernel/module.c	Mon Jul  8 09:50:57 2002
@@ -303,7 +303,7 @@
 		error = namelen;
 		goto err0;
 	}
-	if (size < sizeof(struct module)+namelen) {
+	if (size < sizeof(struct module)+namelen+1) {
 		error = -EINVAL;
 		goto err1;
 	}
@@ -482,10 +482,10 @@
 		error = n_namelen;
 		goto err2;
 	}
-	if (namelen != n_namelen || strcmp(n_name, mod_tmp.name) != 0) {
+	if (namelen != n_namelen || strcmp(n_name, name_tmp) != 0) {
 		printk(KERN_ERR "init_module: changed module name to "
 				"`%s' from `%s'\n",
-		       n_name, mod_tmp.name);
+		       n_name, name_tmp);
 		goto err3;
 	}
 
========================================


>Regards,
>  Peter Oberparleiter

