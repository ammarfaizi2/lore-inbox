Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286426AbRLTWci>; Thu, 20 Dec 2001 17:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286423AbRLTWc3>; Thu, 20 Dec 2001 17:32:29 -0500
Received: from MORGOTH.MIT.EDU ([18.238.2.157]:23469 "EHLO morgoth.mit.edu")
	by vger.kernel.org with ESMTP id <S286426AbRLTWcN>;
	Thu, 20 Dec 2001 17:32:13 -0500
Date: Thu, 20 Dec 2001 17:32:21 -0500
From: Alex <akhripin@mit.edu>
To: linux-kernel@vger.kernel.org
Subject: Slight optimizations to entry.S patch
Message-ID: <20011220223221.GA17913@morgoth.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I was familiarizing (or trying to) myself with the i386 architecture code,
and saw a few possible optimizations. I think they can save a few cycles (not
that many). Can someone comment? Are the changes worthwhile?
-Alex K.

--- entry.S.orig	Thu Dec 20 16:57:39 2001
+++ entry.S	Thu Dec 20 17:20:29 2001
@@ -91,9 +91,9 @@
 	pushl %edi; \
 	pushl %esi; \
 	pushl %edx; \
+	movl $(__KERNEL_DS),%edx; \
 	pushl %ecx; \
 	pushl %ebx; \
-	movl $(__KERNEL_DS),%edx; \
 	movl %edx,%ds; \
 	movl %edx,%es;
 
@@ -141,13 +141,13 @@
 	movl EFLAGS(%esp),%ecx	# and this is cs..
 	movl %eax,EFLAGS(%esp)	#
 	movl %edx,EIP(%esp)	# Now we move them to their "normal" places
-	movl %ecx,CS(%esp)	#
 	movl %esp,%ebx
+	movl %ecx,CS(%esp)	#
 	pushl %ebx
 	andl $-8192,%ebx	# GET_CURRENT
 	movl exec_domain(%ebx),%edx	# Get the execution domain
-	movl 4(%edx),%edx	# Get the lcall7 handler for the domain
 	pushl $0x7
+	movl 4(%edx),%edx	# Get the lcall7 handler for the domain
 	call *%edx
 	addl $4, %esp
 	popl %eax
@@ -162,13 +162,13 @@
 	movl EFLAGS(%esp),%ecx	# and this is cs..
 	movl %eax,EFLAGS(%esp)	#
 	movl %edx,EIP(%esp)	# Now we move them to their "normal" places
-	movl %ecx,CS(%esp)	#
 	movl %esp,%ebx
+	movl %ecx,CS(%esp)	#
 	pushl %ebx
 	andl $-8192,%ebx	# GET_CURRENT
 	movl exec_domain(%ebx),%edx	# Get the execution domain
-	movl 4(%edx),%edx	# Get the lcall7 handler for the domain
 	pushl $0x27
+	movl 4(%edx),%edx	# Get the lcall7 handler for the domain
 	call *%edx
 	addl $4, %esp
 	popl %eax
