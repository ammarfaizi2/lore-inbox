Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbTDZQtQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 12:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262134AbTDZQtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 12:49:16 -0400
Received: from d101.x-mailer.de ([212.162.12.2]:63974 "EHLO d101.x-mailer.de")
	by vger.kernel.org with ESMTP id S262100AbTDZQtJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 12:49:09 -0400
From: Andreas Gietl <a.gietl@e-admin.de>
Organization: e-admin internet gmbh
To: Andreas Haumer <andreas@xss.co.at>, Alan Cox <alan@redhat.com>
Subject: Re: Linux 2.4.21rc1-ac2
Date: Sat, 26 Apr 2003 19:01:11 +0200
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <200304251753.h3PHrqU08482@devserv.devel.redhat.com> <3EAA7F21.3070503@xss.co.at>
In-Reply-To: <3EAA7F21.3070503@xss.co.at>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304261901.11519.a.gietl@e-admin.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 26 April 2003 14:44, Andreas Haumer wrote:
> Hi!
>
> Here is a first test report for 2.4.21-rc1-ac2:
>
> *) Shutdown/Reboot problems in 2.4.21-rc1-ac1 due to
>    deadlock in ide_unregister_subdriver() seem to be
>    fixed!

i can confirm that, shutdown now works smoothly again.

As in 2.4.21-rc1 i had to add

--- include/linux/quotaops.h.orig       2003-04-15 20:31:50.000000000 -0700
+++ include/linux/quotaops.h    2003-04-15 20:31:59.000000000 -0700
@@ -185,6 +185,7 @@
  */
 #define sb_dquot_ops                           (NULL)
 #define sb_quotactl_ops                                (NULL)
+#define sync_dquots_dev(dev,type)              (NULL)
 #define DQUOT_INIT(inode)                      do { } while(0)
 #define DQUOT_DROP(inode)                      do { } while(0)
 #define DQUOT_ALLOC_INODE(inode)               (0)

to compile w/o quota-support.

>
> *) EXTRAVERSION in top-level Makefile was not updated
>
> *) Unresolved symbol "fc_type_trans" in iph5526.o
>    Fixed by the following patch:
>
> --- linux-2.4.21-rc1-ac2/net/802/fc.c.orig      Sat Apr 26 13:35:22 2003
> +++ linux-2.4.21-rc1-ac2/net/802/fc.c   Sat Apr 26 13:40:40 2003
> @@ -11,6 +11,8 @@
>   */
>
>  #include <linux/config.h>
> +#include <linux/module.h>
> +
>  #include <asm/uaccess.h>
>  #include <asm/system.h>
>  #include <linux/types.h>
> @@ -95,6 +97,8 @@
>         return 0;
>  #endif
>  }
> +
> +EXPORT_SYMBOL(fc_type_trans);
>
>  unsigned short
>  fc_type_trans(struct sk_buff *skb, struct net_device *dev)
>
> --- linux-2.4.21-rc1-ac2/net/802/Makefile.orig  Sat Apr 26 13:44:38 2003
> +++ linux-2.4.21-rc1-ac2/net/802/Makefile       Sat Apr 26 13:45:42 2003
> @@ -9,7 +9,7 @@
>
>  O_TARGET := 802.o
>
> -export-objs = llc_macinit.o p8022.o psnap.o
> +export-objs = llc_macinit.o p8022.o psnap.o fc.o
>
>  obj-y  = p8023.o
>
>
> No other problems found so far... :-)
>
> HTH
>
> - andreas

-- 
e-admin internet gmbh
Andreas Gietl                                            tel +49 941 3810884
Ludwig-Thoma-Strasse 35                      fax +49 89 244329104
93051 Regensburg                                  mobil +49 171 6070008

PGP/GPG-Key unter http://www.e-admin.de/gpg.html




