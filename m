Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267135AbTBUEbp>; Thu, 20 Feb 2003 23:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267138AbTBUEbo>; Thu, 20 Feb 2003 23:31:44 -0500
Received: from [196.12.44.6] ([196.12.44.6]:12731 "EHLO students.iiit.net")
	by vger.kernel.org with ESMTP id <S267135AbTBUEbm>;
	Thu, 20 Feb 2003 23:31:42 -0500
Date: Fri, 21 Feb 2003 10:09:51 +0530 (IST)
From: Prasad <prasad_s@students.iiit.net>
To: Andrea Arcangeli <andrea@suse.de>
cc: Jeff Garzik <jgarzik@pobox.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Remote execution of syscalls (was  Re: Syscall from Kernel Space)
In-Reply-To: <20030220224532.GE31480@x30.school.suse.de>
Message-ID: <Pine.LNX.4.44.0302210959320.22616-100000@students.iiit.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am sorry for not being clear... but i think its time to tell you where i 
needed it.  I, as a graduating project am working on a distributed 
computing system, a part of which is "transparent process migration in 
non-distributed environments".  In my system i would like to ship the 
syscalls back to the original node(where the process originated). so for 
that i have a kernel thread that takes the requests and is supposed to 
execute the syscalls on behalf of the process (I have the idle task 
structure existing on the originating node even after the process is 
migrated to the other node).   And the question is how do i do that.  The 
idea I had was to execute the functions behind the syscalls directly, but 
again, these functions use a lot of 'current'.  Could you help me out of 
this situation!
	An alternative was that if get_current was called I would check if
the 'current' points to my kernel thread and if i have a remote syscall
pending, then i would return a pointer to the particular process's
task_struct.  This I think is a work-around that should work.  Please do
comment on this too.

Prasad.

On Thu, 20 Feb 2003, Andrea Arcangeli wrote:
> > 
> > He is talking about directly calling the function behind the syscall,
> > not actually executing a syscall itself.
> 
> this is not what I understood from your previous discussion also given
> you suggest not to do that when he can call sys_read/sys_write instead
> because they're just exported etc.. I just wanted to add a better
> "never".
> 
> > syscalls should be made from userspace, not the kernel.
> 
> This is what I tried to say.
> 
> Andrea
> 

-- 
Failure is not an option

