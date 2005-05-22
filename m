Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261293AbVEVDUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbVEVDUn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 23:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbVEVDUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 23:20:43 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:1352 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261293AbVEVDUQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 23:20:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MRgW0TTKcfR5TWCMmIvf4gYDBivxn1DgHXYquIJ9Hnkv/Ukng0QLYbVou9XlsXyxg58Z/5OgB6YIz7mRhZSGgMykx9D5Mq9lwvVTcCbwmfNyTUk7Ytnz/h19EOuMU8knhmn83ioo9Z+qlTARSeq5JFN8qlHoCDLXJFK1Adwi9qI=
Message-ID: <54b5dbf50505212020e595cd2@mail.gmail.com>
Date: Sun, 22 May 2005 08:50:16 +0530
From: AsterixTheGaul <asterixthegaul@gmail.com>
Reply-To: AsterixTheGaul <asterixthegaul@gmail.com>
To: Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH] Add sysfs support for the IPMI device interface
Cc: Philipp Matthias Hahn <pmhahn@titan.lahn.de>,
       Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <428DDF6C.5080701@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <428D208C.1000307@acm.org> <20050520065623.GA11075@titan.lahn.de>
	 <428DDF6C.5080701@acm.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the following compile problem with this change in linus' git repo....

  CC [M]  drivers/char/ipmi/ipmi_devintf.o
drivers/char/ipmi/ipmi_devintf.c: In function 'ipmi_new_smi':
drivers/char/ipmi/ipmi_devintf.c:532: warning: passing argument 1 of
'class_simple_device_add' from incompatible pointer type
drivers/char/ipmi/ipmi_devintf.c: In function 'ipmi_smi_gone':
drivers/char/ipmi/ipmi_devintf.c:537: warning: passing argument 1 of
'class_simple_device_remove' makes integer from pointer without a cast
drivers/char/ipmi/ipmi_devintf.c:537: error: too many arguments to
function 'class_simple_device_remove'
drivers/char/ipmi/ipmi_devintf.c: In function 'init_ipmi_devintf':
drivers/char/ipmi/ipmi_devintf.c:558: warning: assignment from
incompatible pointer type
drivers/char/ipmi/ipmi_devintf.c:566: warning: passing argument 1 of
'class_simple_destroy' from incompatible pointer type
drivers/char/ipmi/ipmi_devintf.c:580: warning: passing argument 1 of
'class_simple_destroy' from incompatible pointer type
drivers/char/ipmi/ipmi_devintf.c: In function 'cleanup_ipmi':
drivers/char/ipmi/ipmi_devintf.c:591: warning: passing argument 1 of
'class_simple_destroy' from incompatible pointer type
make[3]: *** [drivers/char/ipmi/ipmi_devintf.o] Error 1
make[2]: *** [drivers/char/ipmi] Error 2
make[1]: *** [drivers/char] Error 2
make: *** [drivers] Error 2

Following patch makes it compile...

signed-off AsterixTheGaul <asterixthegaul@gmail.com>


Compile fix  ipmi_devintf.c for problem introduced by the commit change
37e0915b701281182cea9fc90e894d10addf134a

---
commit 1f974bf04b1f2a01e189e01970cb744343ad1bb7
tree c7b157f4d23340a6d773b8d1385c0efb21d4b650
parent b5c44c2147a447f77e07fecdb087ae288e1f4e40
author AsterixTheGaul <asterixthegaul@gmail.com> Sat, 21 May 2005
20:16:39 +0530committer AsterixTheGaul <asterixthegaul@gmail.com> Sat,
21 May 2005 20:16:39 +0530

 char/ipmi/ipmi_devintf.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: drivers/char/ipmi/ipmi_devintf.c
===================================================================
--- ec1d95eb1e03e320fc5eb5cfb40379f2f4a7267d/drivers/char/ipmi/ipmi_devintf.c
 (mode:100644)
+++ c7b157f4d23340a6d773b8d1385c0efb21d4b650/drivers/char/ipmi/ipmi_devintf.c
 (mode:100644)
@@ -520,7 +520,7 @@
                 " interface.  Other values will set the major device number"
                 " to that value.");

-static struct class *ipmi_class;
+static struct class_simple *ipmi_class;





On 5/20/05, Corey Minyard <minyard@acm.org> wrote:
> Philipp Matthias Hahn wrote:
> 
> >
> >
> >What happend to Dimitry Torokovs comment in
> >http://marc.theaimsgroup.com/?l=linux-kernel&m=111232712029756&w=2
> >and your reply in
> >http://marc.theaimsgroup.com/?l=linux-kernel&m=111232954415119&w=2
> >According to linux/device.h:250, class_simple_device_add() has a
> >printf() like argument, so you don't need to snprintf() the name on your
> >own.
> >
> >
> Thank you.  My stupid mailer ate the tabs, and you fixed that, too.
> This looks good to go in.
> 
> -Corey
> 
> >Add support for sysfs to the IPMI device interface.
> >
> >Signed-off-by: Corey Minyard <minyard@acm.org>
> >Signed-off-by: Philipp Hahn <pmhahn@titan.lahn.de>
> >
> >Index: linux-2.6.12-rc1/drivers/char/ipmi/ipmi_devintf.c
> >===================================================================
> >--- linux-2.6.12-rc1.orig/drivers/char/ipmi/ipmi_devintf.c
> >+++ linux-2.6.12-rc1/drivers/char/ipmi/ipmi_devintf.c
> >@@ -44,6 +44,7 @@
> > #include <linux/ipmi.h>
> > #include <asm/semaphore.h>
> > #include <linux/init.h>
> >+#include <linux/device.h>
> >
> > #define IPMI_DEVINTF_VERSION "v33"
> >
> >@@ -519,15 +520,21 @@
> >                " interface.  Other values will set the major device number"
> >                " to that value.");
> >
> >+static struct class *ipmi_class;
> >+
> > static void ipmi_new_smi(int if_num)
> > {
> >-      devfs_mk_cdev(MKDEV(ipmi_major, if_num),
> >-                    S_IFCHR | S_IRUSR | S_IWUSR,
> >+      dev_t dev = MKDEV(ipmi_major, if_num);
> >+
> >+      devfs_mk_cdev(dev, S_IFCHR | S_IRUSR | S_IWUSR,
> >                     "ipmidev/%d", if_num);
> >+
> >+      class_simple_device_add(ipmi_class, dev, NULL, "ipmi%d", if_num);
> > }
> >
> > static void ipmi_smi_gone(int if_num)
> > {
> >+      class_simple_device_remove(ipmi_class, MKDEV(ipmi_major, if_num));
> >       devfs_remove("ipmidev/%d", if_num);
> > }
> >
> >@@ -548,8 +555,15 @@
> >       printk(KERN_INFO "ipmi device interface version "
> >              IPMI_DEVINTF_VERSION "\n");
> >
> >+      ipmi_class = class_simple_create(THIS_MODULE, "ipmi");
> >+      if (IS_ERR(ipmi_class)) {
> >+              printk(KERN_ERR "ipmi: can't register device class\n");
> >+              return PTR_ERR(ipmi_class);
> >+      }
> >+
> >       rv = register_chrdev(ipmi_major, DEVICE_NAME, &ipmi_fops);
> >       if (rv < 0) {
> >+              class_simple_destroy(ipmi_class);
> >               printk(KERN_ERR "ipmi: can't get major %d\n", ipmi_major);
> >               return rv;
> >       }
> >@@ -563,6 +577,7 @@
> >       rv = ipmi_smi_watcher_register(&smi_watcher);
> >       if (rv) {
> >               unregister_chrdev(ipmi_major, DEVICE_NAME);
> >+              class_simple_destroy(ipmi_class);
> >               printk(KERN_WARNING "ipmi: can't register smi watcher\n");
> >               return rv;
> >       }
> >@@ -573,6 +588,7 @@
> >
> > static __exit void cleanup_ipmi(void)
> > {
> >+      class_simple_destroy(ipmi_class);
> >       ipmi_smi_watcher_unregister(&smi_watcher);
> >       devfs_remove(DEVICE_NAME);
> >       unregister_chrdev(ipmi_major, DEVICE_NAME);
> >
> >BYtE
> >Philipp
> >
> >
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
