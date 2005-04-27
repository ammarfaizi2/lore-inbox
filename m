Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261830AbVD0RTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbVD0RTt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 13:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbVD0RSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 13:18:03 -0400
Received: from mail.kroah.org ([69.55.234.183]:17094 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261814AbVD0RR0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 13:17:26 -0400
Date: Wed, 27 Apr 2005 10:15:52 -0700
From: Greg KH <gregkh@suse.de>
To: blaisorblade@yahoo.it, user-mode-linux-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Cliff White <cliffw@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: [01/07] uml: add nfsd syscall when nfsd is modular
Message-ID: <20050427171552.GB3195@kroah.com>
References: <20050427171446.GA3195@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050427171446.GA3195@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------


This trick is useless, because sys_ni.c will handle this problem by itself,
like it does even on UML for other syscalls.
Also, it does not provide the NFSD syscall when NFSD is compiled as a module,
which is a big problem.

This should be merged currently in both 2.6.11-stable and the current tree.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 clean-linux-2.6.11-paolo/arch/um/kernel/sys_call_table.c |    8 +-------
 1 files changed, 1 insertion(+), 7 deletions(-)

diff -puN arch/um/kernel/sys_call_table.c~uml-nfsd-syscall arch/um/kernel/sys_call_table.c
--- clean-linux-2.6.11/arch/um/kernel/sys_call_table.c~uml-nfsd-syscall	2005-04-10 13:50:29.000000000 +0200
+++ clean-linux-2.6.11-paolo/arch/um/kernel/sys_call_table.c	2005-04-10 13:51:19.000000000 +0200
@@ -14,12 +14,6 @@
 #include "sysdep/syscalls.h"
 #include "kern_util.h"
 
-#ifdef CONFIG_NFSD
-#define NFSSERVCTL sys_nfsservctl
-#else
-#define NFSSERVCTL sys_ni_syscall
-#endif
-
 #define LAST_GENERIC_SYSCALL __NR_keyctl
 
 #if LAST_GENERIC_SYSCALL > LAST_ARCH_SYSCALL
@@ -190,7 +184,7 @@ syscall_handler_t *sys_call_table[] = {
 	[ __NR_getresuid ] = (syscall_handler_t *) sys_getresuid16,
 	[ __NR_query_module ] = (syscall_handler_t *) sys_ni_syscall,
 	[ __NR_poll ] = (syscall_handler_t *) sys_poll,
-	[ __NR_nfsservctl ] = (syscall_handler_t *) NFSSERVCTL,
+	[ __NR_nfsservctl ] = (syscall_handler_t *) sys_nfsservctl,
 	[ __NR_setresgid ] = (syscall_handler_t *) sys_setresgid16,
 	[ __NR_getresgid ] = (syscall_handler_t *) sys_getresgid16,
 	[ __NR_prctl ] = (syscall_handler_t *) sys_prctl,
_
