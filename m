Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262331AbTEIHkT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 03:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbTEIHkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 03:40:19 -0400
Received: from siaab2ab.compuserve.com ([149.174.40.130]:5215 "EHLO
	siaab2ab.compuserve.com") by vger.kernel.org with ESMTP
	id S262331AbTEIHkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 03:40:17 -0400
Date: Fri, 9 May 2003 03:50:30 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Problem: strace -ff fails on 2.4.21-rc1
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200305090352_MC3-1-3815-126D@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser wrote:

>> # strace -q -o minicom.trc -tt -ff minicom
>> upeek: ptrace(PTRACE_PEEKUSER, ... ): Operation not permitted
>> detach: ptrace(PTRACE_CONT, ...): Operation not permitted
>> Device /dev/ttyS1 lock failed: No child processes.
>> # uname -a
>> Linux d2 2.4.21-rc1 #1 SMP Wed May 7 06:05:31 EDT 2003 i686 unknown
>
> Is minicom a SUID binary, like on my machine? E.g. does 
>
>   ls -la $(which minicom) 
>
> show
>
> -rwxr-sr-x   1 root     uucp       130664 Feb 21  1998 /usr/bin/minicom
>
> ?
>
> SUID binaries cannot be ptrace()d under Linux for security reasons.


  No, it's not suid.  Rather than do that I changed the permissions
on /dev/ttyS1 so my normal userid could open it.

  And the strace works -- until minicom forks and then the trace fails
to attach to the child.  Both root and a normal userid fail with the
above messages; it works on 2.5.68.

  (BTW does minicom work for you on 2.5?  It fails with the "No child
processes" message on 2.5.6x here but works on 2.4 when it's not being
traced.  Just the very act of running it under strace on 2.4 makes it
fail the same way it does on 2.5 here.  And stracing it on 2.5.66 made
it start working again!  Something very strange is going on...)
