Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262511AbTIENTP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 09:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262496AbTIENTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 09:19:15 -0400
Received: from chaos.analogic.com ([204.178.40.224]:60289 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262512AbTIENTN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 09:19:13 -0400
Date: Fri, 5 Sep 2003 09:20:09 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: John Bradford <john@grabjohn.com>
cc: clemens-dated-1063627487.e072@endorphin.org, joern@wohnheim.fh-wedel.de,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: nasm over gas?
In-Reply-To: <200309051225.h85CPOYr000323@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.4.53.0309050830430.11980@chaos>
References: <200309051225.h85CPOYr000323@81-2-122-30.bradfords.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Sep 2003, John Bradford wrote:

> > > Are there any buffer overflows or other security holes?
> > > How can you be sure about it?
> >
> > How can you be sure? Mathematical program verification applies quite badly
> > to assembler.
>
> The point is, if somebody does find a bug they will want to
> re-assemble with Gas after they've fixed it.
>
> > > If your code fails on any one of these questions, forget about it.  If
> > > it survives them, post your results and have someone else verify them.
> >
> > I'm sorry, your critique is too generel to be useful.
>
> It's not, all the time the argument is not against the assembler code,
> but rather against $assembler!=Gas.
>
> John.

All assemblers suck. However, they are exceeding useful. The
code ends up being exactly what you write. Usually one only
needs to learn one assembler per platform. It was a real shock
for me to have to learn GAS, it was "backwards", seemed to
think everything was a '68000, and basically sucked. However,
once I learned how to use it, it became a useful tool. In
a mini-'C' library I wrote for a project, the total sharable
runtime-library size is:

crt.so: ELF 32-bit LSB shared object, Intel 80386, version 1, stripped
-rwxr-xr-x   1 root     root        77896 Aug 20 2000 assembly/crt.so
-rw-r--r--   1 root     root         1448 Aug 20 2000 assembly/start.o

This includes most of the string stuff and the 'C' interface to
Linux.

The test of code that works in the 'real' world is called
regression-testing. Basically, you run the stuff. You execute
all "known" possible execution paths. If it works, it works.
If it doesn't, you fix it until it does. Seeding with faults
to see if your regression test picks it up, as is proposed
by a bunch of different testing methods, is absurd whether it's
written in assembly or C#. It doesn't matter what the
language is. You need to test procedures as "black-boxes" with
specified inputs and outputs. You also have to violate the
input specifications and show that an error, so created, doesn't
propagate. Such an error need not crash or kill the system, but
it must be detected so that invalid output doesn't occur.

Error-checkers like Lint, that use a specific langage such as 'C',
can provide the programmer with a false sense of security. You
end up with 'perfect' code with all the unwanted return-values
cast to "void", but the logic remains wrong and will fail once
the high-bit in an integer is set. So, in some sense, writing
procedures in assembly is "safer". You know what the code will
do before you run it. If you don't, stay away from assembly.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
            Note 96.31% of all statistics are fiction.


