Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293469AbSBZCHe>; Mon, 25 Feb 2002 21:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293471AbSBZCH1>; Mon, 25 Feb 2002 21:07:27 -0500
Received: from dsl-65-185-109-125.telocity.com ([65.185.109.125]:40578 "EHLO
	ohdarn.net") by vger.kernel.org with ESMTP id <S293468AbSBZCHT>;
	Mon, 25 Feb 2002 21:07:19 -0500
Date: Mon, 25 Feb 2002 21:07:21 -0500
From: Michael Cohen <me@ohdarn.net>
To: linux-kernel@vger.kernel.org
Cc: marcelo@conectiva.com.br
Subject: Submissions for 2.4.19-pre [x86 Syscall Optimizations (Alexander Khripin)]
Message-Id: <20020225210721.2ffa8fb1.me@ohdarn.net>
Organization: OhDarn.net
X-Mailer: Sylpheed version 0.7.2 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the sixth of several mails containing patches to be included in 2.4.19.  Some are worthy of dicussion prior to inclusion and have been marked as such.  The majority of these patches were found on lkml; the remaining ones have URLs listed.

This one originated on lkml.

------
Michael Cohen
OhDarn.net

--- linux-virgin/arch/i386/kernel/entry.S	Sun Jan 13 17:54:54 2002
+++ linux-wli/arch/i386/kernel/entry.S	Sun Jan 13 18:09:36 2002
@@ -111,9 +111,9 @@
 	pushl %edi; \
 	pushl %esi; \
 	pushl %edx; \
+	movl $(__KERNEL_DS),%edx; \
 	pushl %ecx; \
 	pushl %ebx; \
-	movl $(__KERNEL_DS),%edx; \
 	movl %edx,%ds; \
 	movl %edx,%es;
 
@@ -161,13 +161,13 @@
 	movl EFLAGS(%esp),%ecx	# and this is cs..
 	movl %eax,EFLAGS(%esp)	#
 	movl %edx,EIP(%esp)	# Now we move them to their "normal" places
-	movl %ecx,CS(%esp)	#
 	movl %esp,%ebx
+	movl %ecx,CS(%esp) 	#
 	pushl %ebx
 	andl $-8192,%ebx	# GET_CURRENT
 	movl exec_domain(%ebx),%edx	# Get the execution domain
-	movl 4(%edx),%edx	# Get the lcall7 handler for the domain
 	pushl $0x7
+	movl 4(%edx),%edx # Get the lcall7 handler for the domain
 	call *%edx
 	addl $4, %esp
 	popl %eax
@@ -182,13 +182,13 @@
 	movl EFLAGS(%esp),%ecx	# and this is cs..
 	movl %eax,EFLAGS(%esp)	#
 	movl %edx,EIP(%esp)	# Now we move them to their "normal" places
-	movl %ecx,CS(%esp)	#
 	movl %esp,%ebx
+	movl %ecx,CS(%esp) 	#
 	pushl %ebx
 	andl $-8192,%ebx	# GET_CURRENT
 	movl exec_domain(%ebx),%edx	# Get the execution domain
-	movl 4(%edx),%edx	# Get the lcall7 handler for the domain
 	pushl $0x27
+	movl 4(%edx),%edx 	# Get the lcall7 handler for the domain
 	call *%edx
 	addl $4, %esp
 	popl %eax
