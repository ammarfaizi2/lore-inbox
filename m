Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281255AbRLVRjX>; Sat, 22 Dec 2001 12:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281648AbRLVRjN>; Sat, 22 Dec 2001 12:39:13 -0500
Received: from fe4.rdc-kc.rr.com ([24.94.163.51]:9998 "EHLO mail4.kc.rr.com")
	by vger.kernel.org with ESMTP id <S281255AbRLVRjA>;
	Sat, 22 Dec 2001 12:39:00 -0500
To: vic <zandy@cs.wisc.edu>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] ptrace on stopped processes (2.4)
In-Reply-To: <m3adwc9woz.fsf@localhost.localdomain>
From: Mike Coleman <mkc@mathdogs.com>
Date: 22 Dec 2001 11:38:43 -0600
In-Reply-To: <m3adwc9woz.fsf@localhost.localdomain>
Message-ID: <87g0632lzw.fsf@mathdogs.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vic <zandy@cs.wisc.edu> writes:
> The most significant bug is that gdb cannot attach to a stopped
> process.  Specifically, the wait that follows the PTRACE_ATTACH will
> block indefinitely.

Are you sure this is a bug in ptrace?  Maybe gdb and other such programs could
notice that a wait is inappropriate in this case and not do it.

(It looks to me like the wait actually does complete when the process is
continued.)

Also, is this something that used to work?  Or would this be a change in the
semantics of ptrace?


> Another bug is that it is not possible to use PTRACE_DETACH to leave a
> process stopped, because ptrace ignores SIGSTOPs sent by the tracing
> process.

Unless I'm missing something (frequently the case), there are two cases here:
(1) the tracer wants to leave the tracee stopped, and (2) the tracer wants the
process to continue running in as natural a way as possible, meaning without
sending it a SIGCONT (which can cause the SIGCONT signal handler to execute).
As things currently stand, we have behavior (2), and (1) is not possible.
With your change, we'd have behavior (1), and (2) would not be possible.

To me, (2) seems very important, so I wouldn't want to give it up.  Is there
some way we can get both?

> This patch is against 2.4.16 on x86.  I have tested gdb and strace.

Although SUBTERFUGUE isn't widely used, I'd be curious to know how it reacts
to this patch.  (If you're running Debian, there's a package.)

Mike

