Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312735AbSDGXdB>; Sun, 7 Apr 2002 19:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312803AbSDGXdA>; Sun, 7 Apr 2002 19:33:00 -0400
Received: from pD903C98D.dip.t-dialin.net ([217.3.201.141]:57060 "EHLO
	no-maam.dyndns.org") by vger.kernel.org with ESMTP
	id <S312735AbSDGXdA>; Sun, 7 Apr 2002 19:33:00 -0400
Date: Mon, 8 Apr 2002 01:31:22 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: Two fixes for 2.4.19-pre5-ac3
Message-ID: <20020407233122.GA9883@no-maam.dyndns.org>
In-Reply-To: <Pine.LNX.4.44.0204071240360.15439-100000@atx.fast.net> <E16uGg1-0006Ln-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: erik.tews@gmx.net (Erik Tews)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 07, 2002 at 06:42:05PM +0100, Alan Cox wrote:
> > And, unless this is reversed the OpenAFS kernel module won't load (it 
> > needs sys_call_table.):
> 
> Correct. There was agreement a very long time ago that code should not patch
> the syscall table (for one its not safe). AFS probably needs fixing so the
> AFS syscall hook is exported portably and nicely in the syscall code.

I am really not an expert on kernel-programming but I remember that
there was a security-hole in the ptrace-code with which one a local user
could gain root access. And there was a little kernel-modul with a
wrapper-function for the ptrace-syscall that made traces only possible
if the user who was calling this syscall was root. So if I understand
right if we don't export the syscall-table it is impossible to write
such syscall-wrapper-functions and it requires to recompile the kernel
and reboot the machiene to fix such an security-hole.

So wouldn't it be better to export the syscall-table and just write into
the documentation that it is not a good idea to manipulate syscalls or
write a compiler-makro that gives out a warning when such a module is
beeing compiled.
