Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312944AbSDCBiA>; Tue, 2 Apr 2002 20:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312951AbSDCBht>; Tue, 2 Apr 2002 20:37:49 -0500
Received: from PPP-177-125.bng.vsnl.net.in ([203.197.177.125]:51461 "EHLO
	srin.homelinux.net") by vger.kernel.org with ESMTP
	id <S312944AbSDCBhm>; Tue, 2 Apr 2002 20:37:42 -0500
Content-Type: text/plain; charset=US-ASCII
From: Sridhar N <srin@symonds.net>
To: linux-kernel@vger.kernel.org
Subject: Stepping through entry.S
Date: Wed, 3 Apr 2002 07:55:31 +0530
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <02040307072600.03031@srin.homelinux.net>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
	I was trying to trace the handling of the system calls, and to step through 
the entry.S on i386 machine.  I basically used this:

	srin_entryS_debug_mesg: 		#My addition
		.asciz "some relevant message\n"
		ALIGN
	tracesys:			#haven't changed anything here..
		.
		.
		.
		jae tracesys_exit
		pushl $srin_entryS_debug_mesg		#just this
		call SYMBOL_NAME(printk)	# and this
		call *SYMBOL_NAME(sys_call_table)(,%eax,4)
		movl %eax,EAX(%esp)		# save the return value
	tracesys_exit:

Shouldn't this call printk everytime a system call is made or atleast crash 
the kernel if something is dead wrong ? ( It isn't .. everything seems normal 
as though the printk isn't there )  Also,  how can  i know the values in the 
specific registers in that file ? Specifically, whenever a system call is 
made, what registers store what values ? I'm using kernel 2.4.7 on a K6-2.

Sridhar	

