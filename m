Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129153AbQKYCMK>; Fri, 24 Nov 2000 21:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130868AbQKYCL7>; Fri, 24 Nov 2000 21:11:59 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:53771 "HELO mail.ocs.com.au")
        by vger.kernel.org with SMTP id <S129153AbQKYCLk>;
        Fri, 24 Nov 2000 21:11:40 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Patch(?): isapnp_card_id tables for all isapnp drivers in 2.4.0-test11 
In-Reply-To: Your message of "Fri, 24 Nov 2000 15:37:33 -0800."
             <20001124153733.A1876@baldur.yggdrasil.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 25 Nov 2000 12:41:32 +1100
Message-ID: <4906.975116492@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2000 15:37:33 -0800, 
"Adam J. Richter" <adam@yggdrasil.com> wrote:
>	Note that this is not a "final" version.  I plan to go
>through all of the changes and bracket all of these new tables
>with #ifdef MODULE...#endif so they do not result in complaints
>about the table being defined static and never used in cases where
>the driver is compiled directly into the kernel.

This is cleaner.  Append MODULE_ONLY after __initdata and remove the
ifdef.  It increases the size of initdata in the kernel, compared to
ifdef, but since initdata is promptly reused as scratch space it should
not be a problem.

Index: 0-test11.1/include/linux/module.h
--- 0-test11.1/include/linux/module.h Sun, 12 Nov 2000 14:59:01 +1100 kaos (linux-2.4/W/33_module.h 1.1.2.1.2.1.2.1.2.1.1.3 644)
+++ 0-test11.1(w)/include/linux/module.h Sat, 25 Nov 2000 12:40:10 +1100 kaos (linux-2.4/W/33_module.h 1.1.2.1.2.1.2.1.2.1.1.3 644)
@@ -261,6 +261,7 @@ extern struct module __this_module;
 #define MOD_INC_USE_COUNT	__MOD_INC_USE_COUNT(THIS_MODULE)
 #define MOD_DEC_USE_COUNT	__MOD_DEC_USE_COUNT(THIS_MODULE)
 #define MOD_IN_USE		__MOD_IN_USE(THIS_MODULE)
+#define MODULE_ONLY		__attribute__ ((unused))
 
 #include <linux/version.h>
 static const char __module_kernel_version[] __attribute__((section(".modinfo"))) =
@@ -286,6 +287,7 @@ static const char __module_using_checksu
 #define MOD_INC_USE_COUNT	do { } while (0)
 #define MOD_DEC_USE_COUNT	do { } while (0)
 #define MOD_IN_USE		1
+#define MODULE_ONLY
 
 extern struct module *module_list;
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
