Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751316AbWCOUjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbWCOUjS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 15:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbWCOUjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 15:39:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:64682 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751316AbWCOUjR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 15:39:17 -0500
Date: Wed, 15 Mar 2006 21:39:16 +0100 (MET)
From: "Michael Kerrisk" <mtk-manpages@gmx.net>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel@vger.kernel.org, Daniel Jacobowitz <dan@debian.org>,
       Heiko Carstens <heiko.carstens@de.ibm.com>
MIME-Version: 1.0
References: <200603150415_MC3-1-BAB1-D3CE@compuserve.com>
Subject: Re: [RFC] Proposed manpage additions for ptrace(2)
X-Priority: 3 (Normal)
X-Authenticated: #24879014
Message-ID: <4882.1142455156@www011.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck,

> The following is what I propose to add the the manpages entry 
> for ptrace(2).  Some of it came from experimentation, some from 
> linux-kernel messages and the rest came from reading the source code.

Thanks -- this looks promising.  I'm not sure, but I think Daniel Jacobowitz
made a number of these additions to ptrace().  Perhaps he 
has some comments on the accuracy and completeness of the text.

Any comments Daniel?

Cheers,

Michael 


> PTRACE_GETSIGINFO
>    Retrieve  information  about  the  signal  that caused the stop.
>    Copies a siginfo_t from the child to location data in  the  par-
>    ent.
>
> PTRACE_SETSIGINFO
>    Set signal information.  Copies a siginfo_t from  location  data
>    in the parent to the child.
>
> PTRACE_SETOPTIONS
>    Sets  ptrace  options  from  data in the parent.  data is inter-
>    preted as a bitmask of options, which are specified by the  fol-
>    lowing (addr is ignored:)
>
>        PTRACE_O_TRACESYSGOOD
>           When  delivering  syscall  traps, set bit 7 in the signal
>           number (i.e. deliver (SIGTRAP | 0x80)  This makes it easy
>           for  the  tracer  to  tell  the difference between normal
>           traps and those caused by a syscall.
>
>        PTRACE_O_TRACEFORK
>           Stop the child at the next fork()  call  with  SIGTRAP  |
>           PTRACE_EVENT_FORK  <<  8  and automatically start tracing
>           the  newly  forked  process,  which  will  start  with  a
>           SIGSTOP.   The  pid  for the new process can be retrieved
>           with PTRACE_GETEVENTMSG.
>
>        PTRACE_O_TRACEVFORK
>           Stop the child at the next vfork() call  with  SIGTRAP  |
>           PTRACE_EVENT_VFORK  <<  8 and automatically start tracing
>           the the newly vforked process, which will  start  with  a
>           SIGSTOP.   The  pid  for the new process can be retrieved
>           with PTRACE_GETEVENTMSG.
>
>        PTRACE_O_TRACECLONE
>           Stop the child at the next clone() call  with  SIGTRAP  |
>           PTRACE_EVENT_CLONE  <<  8 and automatically start tracing
>           the  newly  cloned  process,  which  will  start  with  a
>           SIGSTOP.   The  pid  for the new process can be retrieved
>           with PTRACE_GETEVENTMSG.
>
>        PTRACE_O_TRACEEXEC
>           Stop the child at the next exec()  call  with  SIGTRAP  |
>           PTRACE_EVENT_EXEC << 8.
>
>        PTRACE_O_TRACEVFORKDONE
>           Stop the child at the completion of the next vfork() call
>           with SIGTRAP | PTRACE_EVENT_VFORK_DONE << 8.
>
>        PTRACE_O_TRACEEXIT
>           Stop the child at exit with SIGTRAP  |  PTRACE_EVENT_EXIT
>           <<  8.   The  child’s  exit  status can be retrieved with
>           PTRACE_GETEVENTMSG.  This stop will be done early  during
>           process  exit  whereas  the  normal  notification is done
>           after the process is done exiting.
>
> PTRACE_GETEVENTMSG
>    Retrieve a message (as an unsigned long) about the ptrace  event
>    that  just  happened  to  the  location data in the parent.  For
>    PTRACE_EVENT_EXIT  this  is  the   child’s   exit   code.  For
>    PTRACE_EVENT_FORK,   PTRACE_EVENT_VFORK  and  PTRACE_EVENT_CLONE
>    this is the pid of the new process.
>
> PTRACE_SYSEMU, PTRACE_SYSEMU_SINGLESTEP
>    For  PTRACE_SYSEMU,  continue  and  stop  on  entry  to the next
>    syscall, which will not  be  executed.   For  PTRACE_SYSEMU_SIN-
>    GLESTEP, so the same but also singlestep if not a syscall.

-- 
Michael Kerrisk
maintainer of Linux man pages Sections 2, 3, 4, 5, and 7 

Want to help with man page maintenance?  
Grab the latest tarball at
ftp://ftp.win.tue.nl/pub/linux-local/manpages/, 
read the HOWTOHELP file and grep the source 
files for 'FIXME'.
