Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312269AbSDCRcA>; Wed, 3 Apr 2002 12:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312277AbSDCRbu>; Wed, 3 Apr 2002 12:31:50 -0500
Received: from air-2.osdl.org ([65.201.151.6]:16136 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S312269AbSDCRbl>;
	Wed, 3 Apr 2002 12:31:41 -0500
Date: Wed, 3 Apr 2002 09:29:28 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Sridhar N <srin@symonds.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Stepping through entry.S
In-Reply-To: <02040307072600.03031@srin.homelinux.net>
Message-ID: <Pine.LNX.4.33L2.0204030858010.22448-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Apr 2002, Sridhar N wrote:

| Hello (recycled)

| 	I was trying to trace the handling of the system calls, and to step through
| the entry.S on i386 machine.  I basically used this:
|
| 	srin_entryS_debug_mesg: 		#My addition
| 		.asciz "some relevant message\n"
| 		ALIGN
| 	tracesys:			#haven't changed anything here..
| 		.
| 		.
| 		.
| 		jae tracesys_exit
| 		pushl $srin_entryS_debug_mesg		#just this
| 		call SYMBOL_NAME(printk)	# and this
| 		call *SYMBOL_NAME(sys_call_table)(,%eax,4)
| 		movl %eax,EAX(%esp)		# save the return value
| 	tracesys_exit:
|
| Shouldn't this call printk everytime a system call is made or atleast crash
| the kernel if something is dead wrong ? ( It isn't .. everything seems normal
| as though the printk isn't there )  Also,  how can  i know the values in the
| specific registers in that file ? Specifically, whenever a system call is
| made, what registers store what values ? I'm using kernel 2.4.7 on a K6-2.

The tracesys: label (code) is only used if ptrace is enabled for
the task.  Is it enabled?  If not, you aren't executing this code
at all.

	testb $0x02,tsk_ptrace(%ebx)	# PT_TRACESYS
	jne tracesys

For the register interface, AFAIK, see the gcc docs, such as
Extensions to the C Language Family:
  http://gcc.gnu.org/onlinedocs/gcc-2.95.3/gcc_4.html
and search for /regparm/ .
<quote>
regparm (number)
 On the Intel 386, the regparm attribute causes the compiler to pass up
 to number integer arguments in registers EAX, EDX, and ECX instead of
 on the stack. Functions that take a variable number of arguments will
 continue to be passed all of their arguments on the stack.
</quote>
Someone please correct or add to this.  :)

-- 
~Randy

