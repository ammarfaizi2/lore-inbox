Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261898AbTC1Bvo>; Thu, 27 Mar 2003 20:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261907AbTC1Bvo>; Thu, 27 Mar 2003 20:51:44 -0500
Received: from smtp-out.comcast.net ([24.153.64.109]:61331 "EHLO
	smtp.comcast.net") by vger.kernel.org with ESMTP id <S261898AbTC1Bvn>;
	Thu, 27 Mar 2003 20:51:43 -0500
Date: Thu, 27 Mar 2003 20:59:55 -0500
From: Tom Vier <tmv@comcast.net>
Subject: [PATCH] alpha ptrace fix Re: Linux 2.4.21-pre6
In-reply-to: <Pine.LNX.4.53L.0303262107480.2544@freak.distro.conectiva>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Reply-to: Tom Vier <tmv@comcast.net>
Message-id: <20030328015955.GA20780@zero>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.5.3i
References: <Pine.LNX.4.53L.0303262107480.2544@freak.distro.conectiva>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright posted this change for alpha that's needed for the ptrace fix.

-- 
Tom Vier <tmv@comcast.net>
DSA Key ID 0xE6CB97DA

--- linux/arch/alpha/kernel/entry.S.kmod	Tue Mar 18 18:17:46 2003
+++ linux-patched/arch/alpha/kernel/entry.S	Tue Mar 18 18:18:50 2003
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
