Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130019AbQJaOQC>; Tue, 31 Oct 2000 09:16:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130079AbQJaOPw>; Tue, 31 Oct 2000 09:15:52 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:37381 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130019AbQJaOPl>;
	Tue, 31 Oct 2000 09:15:41 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Petko Manolov <petkan@dce.bg>
cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: changed section attributes 
In-Reply-To: Your message of "Tue, 31 Oct 2000 15:54:05 +0200."
             <39FECEFD.4F70A24F@dce.bg> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 01 Nov 2000 01:15:32 +1100
Message-ID: <16848.973001732@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2000 15:54:05 +0200, 
Petko Manolov <petkan@dce.bg> wrote:
>"Warning: Ignoring changed section attributes for .modinfo"
>
>Changing the declaration in linux/module.h to ".modinfo,"a""
>fixed the problem, but i noticed that the author said that
>"we want .modinfo to not be allocated"

Historically that was the only way of preventing the .modinfo section
from being included in modules when they were loaded into the kernel.
An alternative is to allow .modinfo to be allocated and have modutils
treat it as non-allocated.  This feature was added to modutils 2.3.19
on October 22 (bleeding edge toolchains for IA64 are "fun") so anybody
who is annoyed by the warning messages can apply this patch.

Index: 0-test10-pre7.1/include/linux/module.h
--- 0-test10-pre7.1/include/linux/module.h Tue, 31 Oct 2000 08:28:16 +1100 kaos (linux-2.4/W/33_module.h 1.1.2.1.2.1.2.1.2.1.1.1 644)
+++ 0-test10-pre7.1(w)/include/linux/module.h Wed, 01 Nov 2000 01:13:22 +1100 kaos (linux-2.4/W/33_module.h 1.1.2.1.2.1.2.1.2.1.1.1 644)
@@ -218,11 +218,6 @@
   MODULE_GENERIC_TABLE(type##_device,name)
 /* not put to .modinfo section to avoid section type conflicts */
 
-/* The attributes of a section are set the first time the section is
-   seen; we want .modinfo to not be allocated.  */
-
-__asm__(".section .modinfo\n\t.previous");
-
 /* Define the module variable, and usage macros.  */
 extern struct module __this_module;
 
Index: 0-test10-pre7.1/Documentation/Changes
--- 0-test10-pre7.1/Documentation/Changes Fri, 27 Oct 2000 22:11:48 +1100 kaos (linux-2.4/G/c/25_Changes 1.1.1.4.1.6 644)
+++ 0-test10-pre7.1(w)/Documentation/Changes Wed, 01 Nov 2000 01:13:03 +1100 kaos (linux-2.4/G/c/25_Changes 1.1.1.4.1.6 644)
@@ -52,7 +52,7 @@
 o  Gnu make               3.77                    # make --version
 o  binutils               2.9.1.0.25              # ld -v
 o  util-linux             2.10o                   # kbdrate -v
-o  modutils               2.3.18                  # insmod -V
+o  modutils               2.3.19                  # insmod -V
 o  e2fsprogs              1.19                    # tune2fs --version
 o  pcmcia-cs              3.1.21                  # cardmgr -V
 o  PPP                    2.4.0                   # pppd --version
@@ -284,7 +284,7 @@
 
 Modutils
 --------
-o  <ftp://ftp.kernel.org/pub/linux/utils/kernel/modutils/v2.3/modutils-2.3.18.tar.bz2>
+o  <ftp://ftp.kernel.org/pub/linux/utils/kernel/modutils/v2.3/modutils-2.3.19.tar.bz2>
 
 Mkinitrd
 --------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
