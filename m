Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262911AbTCSCLd>; Tue, 18 Mar 2003 21:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262913AbTCSCLd>; Tue, 18 Mar 2003 21:11:33 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:30196 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S262911AbTCSCLc>; Tue, 18 Mar 2003 21:11:32 -0500
Date: Tue, 18 Mar 2003 18:21:36 -0800
From: Chris Wright <chris@wirex.com>
To: Tom Vier <tmv@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: alpha fails Re: 2.4.20 ptrace patch
Message-ID: <20030318182136.A25346@figure1.int.wirex.com>
Mail-Followup-To: Tom Vier <tmv@comcast.net>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.51.0303171141010.27605@skuld.mtroyal.ab.ca> <20030319014419.GA391@zero>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030319014419.GA391@zero>; from tmv@comcast.net on Tue, Mar 18, 2003 at 08:44:19PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Tom Vier (tmv@comcast.net) wrote:
> anyone have a quick fix?
> 
> kernel/kernel.o(.text+0x3488): In function `kernel_thread':
> : undefined reference to `arch_kernel_thread'
> kernel/kernel.o(.text+0x3490): In function `kernel_thread':
> : undefined reference to `arch_kernel_thread'
> make: *** [vmlinux] Error 1

Does this work (untested):

--- arch/alpha/kernel/entry.S.kmod	Tue Mar 18 18:17:46 2003
+++ arch/alpha/kernel/entry.S	Tue Mar 18 18:18:50 2003
@@ -234,8 +234,8 @@
  * arch_kernel_thread(fn, arg, clone_flags)
  */
 .align 3
-.globl	kernel_thread
-.ent	kernel_thread
+.globl	arch_kernel_thread
+.ent	arch_kernel_thread
 arch_kernel_thread:
 	ldgp	$29,0($27)	/* we can be called from a module */
 	.frame $30, 4*8, $26
@@ -265,7 +265,7 @@
 	mov	$0,$16
 	mov	$31,$26
 	jsr	$31,sys_exit
-.end	kernel_thread
+.end	arch_kernel_thread
 
 /*
  * __kernel_execve(path, argv, envp, regs)

-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
