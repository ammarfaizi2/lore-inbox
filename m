Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268001AbUJSCc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268001AbUJSCc1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 22:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268293AbUJSCc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 22:32:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12162 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268001AbUJSCcS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 22:32:18 -0400
Message-ID: <41747CA6.7030400@pobox.com>
Date: Mon, 18 Oct 2004 22:32:06 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@gmx.de>
CC: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.9 BK build broken
References: <20041019021719.GA22924@merlin.emma.line.org>
In-Reply-To: <20041019021719.GA22924@merlin.emma.line.org>
Content-Type: multipart/mixed;
 boundary="------------010807080205050606060706"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010807080205050606060706
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Matthias Andree wrote:
> BitKeeper fails to build (error message with GCC 3.4, ICE with GCC 3.3):
> 
> Parent repository is bk://linux.bkbits.net/linux-2.5
> MD5KEY: 417454bfpfdm0m7rr7xnJadPA4ioZA
> 
> KEY of latest changeset:
> torvalds@ppc970.osdl.org|ChangeSet|20041018234151|19286
> 
> $ LANG=C make CC=/opt/gcc-3.4/bin/gcc
> ...
>   LDS     arch/i386/kernel/vsyscall.lds
>   AS      arch/i386/kernel/vsyscall-int80.o
>   SYSCALL arch/i386/kernel/vsyscall-int80.so
>   AS      arch/i386/kernel/vsyscall-sysenter.o
>   SYSCALL arch/i386/kernel/vsyscall-sysenter.so
>   AS      arch/i386/kernel/vsyscall.o
> In file included from include/linux/init.h:5,
>                  from arch/i386/kernel/vsyscall.S:1:
> include/linux/compiler.h:20: syntax error in macro parameter list
> make[1]: *** [arch/i386/kernel/vsyscall.o] Error 1
> make: *** [arch/i386/kernel] Error 2


I get an ICE here in -BK-latest, which the attached patch fixes (backs 
out Linus's change).

I _also_ get a similar failure, in the exact same place, in 2.6.9 
[release version] which does _not_ have Linus's change in it.  See 
http://lkml.org/lkml/2004/10/18/230 for the report.

Maybe the moral of the story is that
linux/init.h + linux/compiler.h + asm == boom ?

	Jeff



--------------010807080205050606060706
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== include/linux/compiler.h 1.31 vs edited =====
--- 1.31/include/linux/compiler.h	2004-10-18 18:50:37 -04:00
+++ edited/include/linux/compiler.h	2004-10-18 22:26:18 -04:00
@@ -17,7 +17,6 @@
 # define __iomem
 # define __chk_user_ptr(x) (void)0
 # define __chk_io_ptr(x) (void)0
-#define __builtin_warning(x, ...) (1)
 #endif
 
 #ifdef __KERNEL__

--------------010807080205050606060706--
