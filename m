Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265060AbUD3FhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265060AbUD3FhY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 01:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265071AbUD3FhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 01:37:24 -0400
Received: from ozlabs.org ([203.10.76.45]:44931 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265060AbUD3FhW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 01:37:22 -0400
Date: Fri, 30 Apr 2004 15:33:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
       linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org,
       trivial@rustcorp.com.au
Subject: [TRIVIAL] ppc64 shmget() translation bugfix
Message-ID: <20040430053343.GC9949@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org,
	trivial@rustcorp.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply:

The 32->64 bit syscall translation layer on ppc64 incorrectly
sign-extends rather than zero-extending the second parameter to
shmget(), which should be a size_t.  This means that it is impossible
to shmget() more 2GB or more from a 32-bit process.

Index: working-2.6/arch/ppc64/kernel/sys_ppc32.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/sys_ppc32.c	2004-03-31 11:10:09.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/sys_ppc32.c	2004-04-30 15:18:51.421878128 +1000
@@ -1666,7 +1666,7 @@
 		err = sys_shmdt((char *)AA(ptr));
 		break;
 	case SHMGET:
-		err = sys_shmget(first, second, third);
+		err = sys_shmget(first, second_parm, third);
 		break;
 	case SHMCTL:
 		err = do_sys32_shmctl(first, second, (void *)AA(ptr));



-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
