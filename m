Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbRAXHER>; Wed, 24 Jan 2001 02:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129431AbRAXHEH>; Wed, 24 Jan 2001 02:04:07 -0500
Received: from Cantor.suse.de ([194.112.123.193]:34824 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129401AbRAXHDw>;
	Wed, 24 Jan 2001 02:03:52 -0500
Mail-Copies-To: never
To: John Kacur <jkacur@home.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sigcontext on Linux-ppc in user space
In-Reply-To: <3A6E282E.89053126@home.com>
From: Andreas Jaeger <aj@suse.de>
Date: 24 Jan 2001 08:02:23 +0100
In-Reply-To: <3A6E282E.89053126@home.com> (John Kacur's message of "Tue, 23 Jan 2001 19:56:14 -0500")
Message-ID: <u8puhdmo00.fsf@gromit.rhein-neckar.de>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Kacur <jkacur@home.com> writes:

> Does anyone know how to get at the struct sigcontext in a signal handler
> on Linux for powerpc? sigaction of course lets you create a signal
> handler as a function with the prototype void(*)(int, siginfo_t *, void
> *)
> where the last argument, a pointer to void, is the sigcontext. I believe
> that the last argument is NOT defined by POSIX and so is implementation
> dependent.
> 
> On Intel it seems sufficient to use #include <asm/sigcontext.h>
> to get the definition of struct sigcontext, and then get the values
> you'd like out of the signal handler. But on Linux for powerpc, the same
> thing doesn't work. Does anyone know what the trick is here to
> accomplish this?

You should never include kernel headers in user space.

If you have a glibc 2.1 (or newer) based system, just include
<signal.h> which will include <bits/sigcontext.h> with the struct
(this works on all architectures).

Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
