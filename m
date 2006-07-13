Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964777AbWGML6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbWGML6M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 07:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964778AbWGML6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 07:58:12 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:6858 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S964777AbWGML6L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 07:58:11 -0400
Subject: Re: Linker error with latest tree on EM64T
From: Marcel Holtmann <marcel@holtmann.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: jakub@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <1152788387.3024.32.camel@laptopd505.fenrus.org>
References: <1152788160.4838.2.camel@localhost>
	 <1152788387.3024.32.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Thu, 13 Jul 2006 13:58:02 +0200
Message-Id: <1152791882.4838.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arjan,

> > when trying to build the latest tree on an EM64T Dual-Core, I am getting
> > this error:
> > 
> >   LD      .tmp_vmlinux1
> > init/built-in.o: In function `try_name':
> > do_mounts.c:(.text+0x51d): undefined reference to `__stack_chk_fail'
> > init/built-in.o: In function `name_to_dev_t':
> > (.text+0x797): undefined reference to `__stack_chk_fail'
> > init/built-in.o: In function `mount_block_root':
> > (.init.text+0x823): undefined reference to `__stack_chk_fail'
> > init/built-in.o: In function `md_run_setup':
> > (.init.text+0x1131): undefined reference to `__stack_chk_fail'
> > init/built-in.o: In function `do_header':
> > initramfs.c:(.init.text+0x24a4): undefined reference to `__stack_chk_fail'
> > arch/x86_64/kernel/built-in.o:(.text+0x2f52): more undefined references to `__st
> > ack_chk_fail' follow
> > make: *** [.tmp_vmlinux1] Error 1
> 
> you are using ubuntu which has a compiler that adds -fstack-protector
> implicitly to the compiler options, yet you don't have a kernel that
> provides this infrastructure ;)
> (I have code for that but it's not merged yet, it's pending one gcc
> patch to get merged upstream)
> in the mean time.. I'm pretty sure Sam sent a patch to Linus that adds
> -fno-stack-protector...

I couldn't find such a patch in Sam's repository, but the following
worked for me:

diff --git a/Makefile b/Makefile
index 7c010f3..b4a2a80 100644
--- a/Makefile
+++ b/Makefile
@@ -308,7 +308,7 @@ LINUXINCLUDE    := -Iinclude \
 CPPFLAGS        := -D__KERNEL__ $(LINUXINCLUDE)
 
 CFLAGS          := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
-                   -fno-strict-aliasing -fno-common
+                   -fno-strict-aliasing -fno-common -fno-stack-protector
 # Force gcc to behave correct even for buggy distributions
 CFLAGS          += $(call cc-option, -fno-stack-protector-all \
                                      -fno-stack-protector)

Thanks for the quick answer.

Regards

Marcel


