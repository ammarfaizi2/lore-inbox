Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154607-18252>; Thu, 19 Nov 1998 19:57:04 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:12572 "EHLO penguin.e-mind.com" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <154485-18252>; Thu, 19 Nov 1998 13:28:31 -0500
Date: Thu, 19 Nov 1998 20:22:48 +0100 (CET)
From: Andrea Arcangeli <andrea@e-mind.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.rutgers.edu
Subject: Re: entry.S mess with %ebx (&current pointer)
In-Reply-To: <Pine.LNX.3.95.981119095352.2684C-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.3.96.981119201731.1350A-100000@dragon.bogus>
X-PgP-Public-Key-URL: http://e-mind.com/~andrea/aa.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

On Thu, 19 Nov 1998, Linus Torvalds wrote:

>Good debugging, but the fix is incorrect (or at least unnecessarily slow).

Of course. I posted the working fix (that looked sane to me) because it
was late I had the train pending. I was going to discover _which_ syscall
was clobbering %ebx now, one second before to read your solution ;-). 

>This patch should fix it properly, please tell me whether that is true..

This allow the linking:

Index: arch/i386/kernel/entry.S
===================================================================
RCS file: /var/cvs/linux/arch/i386/kernel/entry.S,v
retrieving revision 1.1.1.1.16.3
diff -u -r1.1.1.1.16.3 entry.S
--- entry.S	1998/11/19 19:01:50	1.1.1.1.16.3
+++ entry.S	1998/11/19 19:16:33
@@ -151,7 +151,7 @@
 
 
 	ALIGN
-	.globl	ret_from_smpfork
+	.globl	ret_from_fork
 ret_from_fork:
 	GET_CURRENT(%ebx)
 #ifdef __SMP__


I have not yet rebooted but it' s sure right because the stall was caused
by the new forked processes a bit before return in userspace (infact this
morning I just verifyed that the asm of sys_fork() was saving %ebx right).
If there will be problems I' ll let you know... 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
