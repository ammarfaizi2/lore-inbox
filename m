Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286161AbSAZSYc>; Sat, 26 Jan 2002 13:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286322AbSAZSYW>; Sat, 26 Jan 2002 13:24:22 -0500
Received: from nydalah028.sn.umu.se ([130.239.118.227]:2440 "EHLO
	x-files.giron.wox.org") by vger.kernel.org with ESMTP
	id <S286161AbSAZSYF>; Sat, 26 Jan 2002 13:24:05 -0500
Message-ID: <018801c1a696$c55e95a0$0201a8c0@HOMER>
From: "Martin Eriksson" <nitrax@giron.wox.org>
To: "Jamie Lokier" <lk@tantalophile.demon.co.uk>,
        "Jeff Garzik" <jgarzik@mandrakesoft.com>
Cc: "Linus Torvalds" <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <200201251550.g0PFoIPa002738@tigger.cs.uni-dortmund.de> <200201250802.32508.bodnar42@phalynx.dhs.org> <jeelkes8y5.fsf@sykes.suse.de> <a2sv2s$ge3$1@penguin.transmeta.com> <20020126034106.F5730@kushida.apsleyroad.org> <012d01c1a687$faa11120$0201a8c0@HOMER> <3C52DD96.183322F9@mandrakesoft.com> <20020126174800.D6724@kushida.apsleyroad.org>
Subject: Re: [ACPI] ACPI mentioned on lwn.net/kernel
Date: Sat, 26 Jan 2002 19:25:02 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
From: "Jamie Lokier" <lk@tantalophile.demon.co.uk>
To: "Jeff Garzik" <jgarzik@mandrakesoft.com>
Cc: "Martin Eriksson" <nitrax@giron.wox.org>; "Linus Torvalds"
<torvalds@transmeta.com>; <linux-kernel@vger.kernel.org>
Sent: Saturday, January 26, 2002 6:48 PM
Subject: Re: [ACPI] ACPI mentioned on lwn.net/kernel


> Jeff Garzik wrote:
> > > Hmm.. I tried to compile the kernel with -Os (gcc 2.96-98) and I just
got a
> > > ~1% smaller vmlinux and a ~3% smaller bzImage. Maybe the size
optimizations
> > > doesn't show on these files? Internal data structures that are much
bigger
> > > than "real" code?
> >
> > That doesn't tell us much unless you benchmark any speed
> > improvements/degradations noticed.  Hidden in that 1% may be more
> > favorable I-cache usage, better register usage... who knows.
> >
> > It would also be interesting to compile key files like kernel/sched.c or
> > mm/vmscan.c in assembly using O2 and Os, and compare the output with
> > diff -u.
>
> It'd be good to know why it's not achieving the quoted 30% space saving
> that other compilers manage for normal code, unless it's myth of course.
>

So I compiled sched.c to assembly (note that I have the rml preempt patch
there too), and the results are pretty strange:

Diff between -O2 and -Os:
http://giron.wox.org/sched.s.diff

As you can see, not much size optimizing are done from -O2.

The C file:
http://giron.wox.org/sched.c

Command line:
gcc -D__KERNEL__ -Wall -Wstrict-prototypes -Wno-trigraphs -OX \
    -fomit-frame-pointer -fno-strict-aliasing -fno-common -S sched.c

where -OX have been replaced by -O0 -O2 -O3 and -Os

The assembler files:
http://giron.wox.org/sched.s.o0
http://giron.wox.org/sched.s.o2
http://giron.wox.org/sched.s.o3
http://giron.wox.org/sched.s.os

The file created with -O0 (no optimization) is the biggest of all, even
bigger than -O3.
-O2 and -Os differ only about 1%

So either
a) -O2 does size optimization
b) -Os sucks at size optimization

_____________________________________________________
|  Martin Eriksson <nitrax@giron.wox.org>
|  MSc CSE student, department of Computing Science
|  Umeå University, Sweden


