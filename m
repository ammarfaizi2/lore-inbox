Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292705AbSCJBcg>; Sat, 9 Mar 2002 20:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292707AbSCJBcQ>; Sat, 9 Mar 2002 20:32:16 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:38149 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S292705AbSCJBcD>;
	Sat, 9 Mar 2002 20:32:03 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: barryn@pobox.com (Barry K. Nathan)
Cc: linux-kernel@vger.kernel.org, Alan.Cox@linux.org
Subject: Re: [PATCH] 2.2.21-pre[34] pl2303.c non-modular compile fix 
In-Reply-To: Your message of "Sat, 09 Mar 2002 05:19:10 -0800."
             <20020309131910.50C6D8959A@cx518206-b.irvn1.occa.home.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 10 Mar 2002 12:31:49 +1100
Message-ID: <23198.1015723909@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Mar 2002 05:19:10 -0800 (PST), 
barryn@pobox.com (Barry K. Nathan) wrote:
>The pl2303 driver won't compile for me in Linux 2.2.21-pre3 or -pre4 if
>modules are disabled. This might not be the right fix, but it allows the
>driver to compile and work for me.
>
>-Barry K. Nathan <barryn@pobox.com>
>
>diff -ruN linux-2.2.21-pre3/drivers/usb/serial/pl2303.c linux-2.2.21-pre3-bknA-1/drivers/usb/serial/pl2303.c
>--- linux-2.2.21-pre3/drivers/usb/serial/pl2303.c	Sun Mar  3 23:20:11 2002
>+++ linux-2.2.21-pre3-bknA-1/drivers/usb/serial/pl2303.c	Sat Mar  9 04:45:08 2002
>@@ -818,7 +818,9 @@
> module_exit(pl2303_exit);
> 
> MODULE_DESCRIPTION(DRIVER_DESC);
>+#ifdef CONFIG_MODULES
> MODULE_LICENSE("GPL");
>+#endif
> 
> MODULE_PARM(debug, "i");
> MODULE_PARM_DESC(debug, "Debug enabled or not");

The correct patch is to module.h.  MODULE_LICENSE was added to
2.2.21-pre* as a compatibility patch but was incomplete.

Index: 21-pre4.1/include/linux/module.h
--- 21-pre4.1/include/linux/module.h Thu, 03 Jan 2002 20:12:00 +1100 kaos (linux-2.2/F/51_module.h 1.1.7.2.3.2 644)
+++ 21-pre4.1(w)/include/linux/module.h Sun, 10 Mar 2002 12:29:09 +1100 kaos (linux-2.2/F/51_module.h 1.1.7.2.3.2 644)
@@ -181,6 +181,7 @@ const char __module_device[] __attribute
 	s	string
 */
 
+/* Dummy macro for 2.2/2.4 compatibility */
 #define MODULE_LICENSE(var)
 
 #define MODULE_PARM(var,type)			\
@@ -221,6 +222,7 @@ const char __module_using_checksums[] __
 #define MODULE_AUTHOR(name)
 #define MODULE_DESCRIPTION(desc)
 #define MODULE_SUPPORTED_DEVICE(name)
+#define MODULE_LICENSE(var)
 #define MODULE_PARM(var,type)
 #define MODULE_PARM_DESC(var,desc)
 #define THIS_MODULE		NULL

