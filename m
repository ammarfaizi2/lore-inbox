Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315480AbSFTUk5>; Thu, 20 Jun 2002 16:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315485AbSFTUk4>; Thu, 20 Jun 2002 16:40:56 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:54166 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S315480AbSFTUkz>; Thu, 20 Jun 2002 16:40:55 -0400
Date: Thu, 20 Jun 2002 15:40:57 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200206202040.PAA23348@tomcat.admin.navo.hpc.mil>
To: linux-kernel@vger.kernel.org
Subject: Re: kernel upgrade on the fly
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

zaimi@pegasus.rutgers.edu:
> 
> Thanks for the responses especially Rob. I was trying to find previous
> threads about this and could not find them. Agreed, swsusp is a step
> further to that goal; the way that memory is saved though may not make it
> necessarily easier, at least in the current state of swsusp.
> 
> As you were mentioning, the processes information needs
> to be summarised and saved in such a way that the new kernel can pick up
> and construct its own queues of processes independent on the differences
> between the kernels being swapped.
> 
> Well, this does touch the idea of having migrating processes from one
> machine to others in a network. In fact, I dont understand why is it so
> hard to reparent a process. If it can be reparented within a machine, then
> it can migrate to other machines as well, no?

No.

Reparenting a process only changes the identity of the parent reference of a
process.

Migrating to another machine has to handle (at a minimum):

1. open files - file id, file pointer values must be moved.
2. network connections must be redirected, existing queues must be transferred
3. shared memory segment references must be transferred, possibly even the
   file referenced by mmap operations (see item 5)
4. semaphores must be transferred
5. disk files may have to be transferred (currently open files in /tmp ?)
6. pipes to other processes must be re-established, as the current contents
   of any pipe buffers, and even the other process(s) attached to the pipe
7. process kernel stack must be preserved (current syscall activity?) and
   process control block state
8. the curren process data must be transferred (memory image, shared
   library references)
9. recreating the same/equivalent process context (pid, ppid,uid,gid, and
   all the kernel setup may/will have to be transferred)

A lot of things NOT mentioned (what about the active buffer cache for open
files... shared file access...)
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
