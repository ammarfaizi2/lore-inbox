Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030411AbWFVVeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030411AbWFVVeq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 17:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030407AbWFVVep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 17:34:45 -0400
Received: from thunk.org ([69.25.196.29]:38308 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1030411AbWFVVeo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 17:34:44 -0400
Date: Thu, 22 Jun 2006 17:34:43 -0400
From: Theodore Tso <tytso@mit.edu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.17-mm1: UML failing w/o SKAS enabled
Message-ID: <20060622213443.GA22303@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060621034857.35cfe36f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <20060621034857.35cfe36f.akpm@osdl.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When I tried compiling 2.6.17-mm1 without SKAS support, it failed to
link:

arch/um/sys-i386/built-in.o: In function `__setup_host_supports_tls':tls.c:(.init.text+0x14): undefined reference to `check_host_supports_tls'
collect2: ld returned 1 exit status

This can fixed be addressed with the attached patch, but it the
resulting kernel still doesn't boot:

<tytso@candygram>       {/usr/projects/uml/linux-2.6.17-mm1}
35% ./linux
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...OK
Checking advanced syscall emulation patch for ptrace...OK
Checking for tmpfs mount on /dev/shm...OK
Checking PROT_EXEC mmap in /dev/shm/...OK
UML running in TT mode
tracing thread pid = 25812
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...OK
Checking advanced syscall emulation patch for ptrace...OK

<tytso@candygram>       {/usr/projects/uml/linux-2.6.17-mm1}
36%

If anyone has any suggestions, I'd appreciate them.

							- Ted



--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=fix-uml-no-skas

Index: linux-2.6.17-mm1/arch/um/os-Linux/sys-i386/Makefile
===================================================================
--- linux-2.6.17-mm1.orig/arch/um/os-Linux/sys-i386/Makefile	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.17-mm1/arch/um/os-Linux/sys-i386/Makefile	2006-06-22 17:28:59.000000000 -0400
@@ -3,7 +3,8 @@
 # Licensed under the GPL
 #
 
-obj-$(CONFIG_MODE_SKAS) = registers.o tls.o
+obj-$(CONFIG_MODE_SKAS) = registers.o
+obj-y = tls.o
 
 USER_OBJS := $(obj-y)
 

--vtzGhvizbBRQ85DL--
