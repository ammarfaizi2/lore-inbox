Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263946AbUEXTdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263946AbUEXTdm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 15:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264198AbUEXTdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 15:33:42 -0400
Received: from zero.aec.at ([193.170.194.10]:34053 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263946AbUEXTdk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 15:33:40 -0400
To: Scott Robert Ladd <coyote@coyotegulch.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: NUMA Questions
References: <1Zt9u-86V-3@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Mon, 24 May 2004 21:33:36 +0200
In-Reply-To: <1Zt9u-86V-3@gated-at.bofh.it> (Scott Robert Ladd's message of
 "Mon, 24 May 2004 21:20:08 +0200")
Message-ID: <m3n03xd3hr.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scott Robert Ladd <coyote@coyotegulch.com> writes:

[hmm, didn't I answer this already?]

>
> Can anyone shed light on this?

The system calls were still missing on x86-64 in 2.6.7rc1. 

Apply this small patch.

-Andi

--- linux-2.6.7rc1/include/asm-x86_64/unistd.h	2004-05-23 15:41:56.000000000 +0200
+++ linux-2.6.7rc1-amd64/include/asm-x86_64/unistd.h	2004-05-24 01:31:42.000000000 +0200
@@ -535,11 +535,11 @@
 #define __NR_vserver		236
 __SYSCALL(__NR_vserver, sys_ni_syscall)
 #define __NR_mbind 		237
-__SYSCALL(__NR_mbind, sys_ni_syscall)
+__SYSCALL(__NR_mbind, sys_mbind)
 #define __NR_set_mempolicy 	238
-__SYSCALL(__NR_set_mempolicy, sys_ni_syscall)
+__SYSCALL(__NR_set_mempolicy, sys_set_mempolicy)
 #define __NR_get_mempolicy 	239
-__SYSCALL(__NR_get_mempolicy, sys_ni_syscall)
+__SYSCALL(__NR_get_mempolicy, sys_get_mempolicy)
 #define __NR_mq_open 		240
 __SYSCALL(__NR_mq_open, sys_mq_open)
 #define __NR_mq_unlink 		241

