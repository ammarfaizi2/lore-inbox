Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318135AbSGaMpB>; Wed, 31 Jul 2002 08:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318188AbSGaMpB>; Wed, 31 Jul 2002 08:45:01 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:32731 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S318135AbSGaMo7>;
	Wed, 31 Jul 2002 08:44:59 -0400
Date: Wed, 31 Jul 2002 22:47:15 +1000
From: Anton Blanchard <anton@samba.org>
To: Daniel Barlow <dan@telent.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4, arch-dependent floating point exception and trap handling
Message-ID: <20020731124714.GB21246@krispykreme>
References: <873cu1nz4e.fsf@noetbook.telent.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873cu1nz4e.fsf@noetbook.telent.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> I'm seeing discrepancies between the way that floating point
> exceptions are handled on different architectures.  Briefly, I have a
> program that uses the glibc function feenableexcept() to enable SIGFPE
> on divide-by-zero errors, then installs a SIGFPE handler that uses
> sigsetjmp/siglongjmp, then divides 1.0 by 0.0 twice.
> 
> What I expect to happen is for my signal handler to be called twice.
> What actually happens varies:

...

> my signal handler is called the first time, and then the second
> attempt gets "inf".  I've run this under gdb as well; the second SIGFPE is 
> not received by the process

The x86 like behaviour happens on ppc64 too:

exceptions enabled: 0
exceptions enabled: 4000000
hello
in handler
abort
a/b=inf
terminating

There is a reason for this. A signal handler might want to do floating
point so exceptions are disabled upon entering a signal handler.

Now the question that needs to be answered is whether sigsetjmp should
save the floating point exception register. I asked our resident
standards expert Chris Yeoh and the answer is no.

So the x86, ppc32 and ppc64 behaviour looks correct.

Anton
