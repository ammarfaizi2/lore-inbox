Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263142AbRFEDjr>; Mon, 4 Jun 2001 23:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263144AbRFEDjh>; Mon, 4 Jun 2001 23:39:37 -0400
Received: from fe1.rdc-kc.rr.com ([24.94.163.48]:54020 "EHLO mail1.kc.rr.com")
	by vger.kernel.org with ESMTP id <S263142AbRFEDjX>;
	Mon, 4 Jun 2001 23:39:23 -0400
To: Stanislav Malyshev <stas@zend.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: gdb/ptrace problem
In-Reply-To: <Pine.LNX.4.33.0105171443050.4567-100000@shire.zend.office>
From: Mike Coleman <mkc@mathdogs.com>
Date: 04 Jun 2001 22:39:21 -0500
In-Reply-To: <Pine.LNX.4.33.0105171443050.4567-100000@shire.zend.office>
Message-ID: <87ae3nlhna.fsf@mathdogs.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stanislav Malyshev <stas@zend.com> writes:
> Since installing 2.2.19, I have the following problem: each time I try to
> attach to a running program with gdb, the result is:
> 
> ptrace: Operation not permitted.
> 
> and attaching fails. No problem with 2.2.18. Have I missed something? Any
> advice on how this can be fixed?
> 
> gdb version:
> GNU gdb 5.0
> Copyright 2000 Free Software Foundation, Inc.

I did a cursory look throught the 18->19 patch and didn't see anything obvious
that could be causing this.  Are you talking about an i386 box?  Are you
running any other special patches on it?

You could try running gdb itself under strace.  Perhaps this will show some
info on exactly how this ptrace call is failing.

The EPERM would suggest that gdb doesn't have permission to attach.  You can't
attach to setuid/setgid processes unless you're root.  Otherwise, you can
generally attach to processes you're allowed to send signals to (unless
something has changed).  So you could try running gdb as root as see if you
can attach then.  Or, you could try doing a 'kill -STOP' on the process
instead of attaching to it.  Does it work?

Also, check for operator error.  :-)

--Mike

-- 
Mike Coleman, mkc@mathdogs.com
  http://www.mathdogs.com -- problem solving, expert software development
