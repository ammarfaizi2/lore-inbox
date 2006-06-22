Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbWFVVyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbWFVVyl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 17:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932663AbWFVVyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 17:54:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31141 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932167AbWFVVyk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 17:54:40 -0400
Date: Thu, 22 Jun 2006 14:57:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Theodore Tso <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>
Subject: Re: 2.6.17-mm1: UML failing w/o SKAS enabled
Message-Id: <20060622145743.2accfeaf.akpm@osdl.org>
In-Reply-To: <20060622213443.GA22303@thunk.org>
References: <20060621034857.35cfe36f.akpm@osdl.org>
	<20060622213443.GA22303@thunk.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso <tytso@mit.edu> wrote:
>
> When I tried compiling 2.6.17-mm1 without SKAS support, it failed to
> link:
> 
> arch/um/sys-i386/built-in.o: In function `__setup_host_supports_tls':tls.c:(.init.text+0x14): undefined reference to `check_host_supports_tls'
> collect2: ld returned 1 exit status
> 
> This can fixed be addressed with the attached patch,

--- linux-2.6.17-mm1.orig/arch/um/os-Linux/sys-i386/Makefile	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.17-mm1/arch/um/os-Linux/sys-i386/Makefile	2006-06-22 17:28:59.000000000 -0400
@@ -3,7 +3,8 @@
 # Licensed under the GPL
 #
 
-obj-$(CONFIG_MODE_SKAS) = registers.o tls.o
+obj-$(CONFIG_MODE_SKAS) = registers.o
+obj-y = tls.o
 
 USER_OBJS := $(obj-y)
 


hm, I don't see anything in -mm which could cause this.

> but it the
> resulting kernel still doesn't boot:
> 
> <tytso@candygram>       {/usr/projects/uml/linux-2.6.17-mm1}
> 35% ./linux
> Checking that ptrace can change system call numbers...OK
> Checking syscall emulation patch for ptrace...OK
> Checking advanced syscall emulation patch for ptrace...OK
> Checking for tmpfs mount on /dev/shm...OK
> Checking PROT_EXEC mmap in /dev/shm/...OK
> UML running in TT mode
> tracing thread pid = 25812
> Checking that ptrace can change system call numbers...OK
> Checking syscall emulation patch for ptrace...OK
> Checking advanced syscall emulation patch for ptrace...OK
> 
> <tytso@candygram>       {/usr/projects/uml/linux-2.6.17-mm1}
> 36%
> 
> If anyone has any suggestions, I'd appreciate them.
> 

It's not clear what actually happened - did it quietly exit, or what?

I haven't run UML in several years, alas.  I should work out how to do it
(again).   Links to any uml-for-dummies site would be appreciated ;)

