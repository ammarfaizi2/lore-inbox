Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129280AbQKAJwP>; Wed, 1 Nov 2000 04:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129355AbQKAJwF>; Wed, 1 Nov 2000 04:52:05 -0500
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:59880 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S129280AbQKAJvw>; Wed, 1 Nov 2000 04:51:52 -0500
Message-Id: <5.0.0.25.2.20001101094152.03caed30@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.0
Date: Wed, 01 Nov 2000 09:51:35 +0000
To: Andrea Arcangeli <andrea@suse.de>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: 2.2.18Pre Lan Performance Rocks!
Cc: "Jeff V. Merkey" <jmerkey@timpanogas.org>, Larry McVoy <lm@bitmover.com>,
        Paul Menage <pmenage@ensim.com>, Rik van Riel <riel@conectiva.com.br>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20001101023010.G13422@athlon.random>
In-Reply-To: <39FF49C8.475C2EA7@timpanogas.org>
 <E13qj56-0003h9-00@pmenage-dt.ensim.com>
 <39FF3D53.C46EB1A8@timpanogas.org>
 <20001031140534.A22819@work.bitmover.com>
 <39FF4488.83B6C1CE@timpanogas.org>
 <20001031142733.A23516@work.bitmover.com>
 <39FF49C8.475C2EA7@timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:30 01/11/2000, Andrea Arcangeli wrote:
> > Larry McVoy wrote:
> >> Are there processes with virtual memory?
>On Tue, Oct 31, 2000 at 03:38:00PM -0700, Jeff V. Merkey wrote:
> > Yes.
>
>If that stack switch is your context switch then you share the same VM for all
>tasks. I think the above answer "yes" just means you have pagetables so 
>you can
>swap, but you _must_ miss memory protection across different processes.  That
>also mean any program can corrupt the memory of all the other programs.  Even
>on the Palm that's a showstopper limitation (and on the Palm that's an 
>hardware
>limitation, not a software deficiency of PalmOS).
>
>That will never happen in linux, nor in windows, nor internally to kde2. It
>happens in uclinux to deal with hardware without MMU. And infact the agenda
>uses mips with memory protection even on a organizer with obvious advantages.
>
>Just think kde2 could have all the kde app sharing the same VM skipping 
>all the
>tlb flushes by simply using clone instead of fork. Guess why they aren't doing
>that? And even if they would do that, the first bug would _only_ destabilize
>kde, so kill it and restart and everything else will keep running fine (you
>don't even need to kill X). With your ring 0 linux _everything_ will 
>crash, not
>just kde.

No need for imagination. Reality shows it: In my experience Netware is very 
unstable as an OS. - We are running 5 Netware servers here in College (used 
to be 3.12 now are 4.11) and whenever we do any upgrades (e.g. new service 
pack) the servers start crashing every day or so until we find one by one 
all modules that are not SMP capable (I assume that this is the reason it 
is crashing?) and take them out / replace them with 3rd party equivalent 
modules. - Just to name some things: Novell FTP server, Xconsole and/or 
associated modules, "Apple desktop rebuilding thing" module... - All of 
those would cause the server to crash into the debugger when running SMP 
usually with a page fault. - Admittedly Netware is great at file & 
application serving so we use it but it gets nowhere near to the stability 
of Linux. The number of times Linux production systems in College have 
crashed can be counted on the fingers of my hand while I have lost count of 
the Novell crashes a long time ago.

IMHO stability is more important than anything else. - I prefer to run 20 
Linux servers which will result in no phonecalls at midnight calling me 
into College to reboot them compared to a Netware server which runs as fast 
as the 20 Linux servers but disturbs my out-of-working-hours time!

I agree that having ring 0 OS will improve performance, no doubt about 
that, but at what price?

Just my 2p.

Anton

>And on sane architectures like alpha you don't even need to flush the TLB
>during "real" context switching so all your worry to share the same VM for
>everything is almost irrelevant there since it happens all the time anyways
>(until you overflow the available ASN bits that takes a lots of forks to
>happen).
>
>So IMHO for you it's much saner to move all your performance critical code 
>into
>kernel space (that will be just stability-risky enough as khttpd and tux are).
>In 2.4.x that will avoid all the cr3 reloads and that will be enough as what
>you really care during fileserving are the copies that you must avoid.
>
>Andrea
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>Please read the FAQ at http://www.tux.org/lkml/

-- 
      "Education is what remains after one has forgotten everything he 
learned in school." - Albert Einstein
-- 
Anton Altaparmakov  Voice: +44-(0)1223-333541(lab) / +44-(0)7712-632205(mobile)
Christ's College    eMail: AntonA@bigfoot.com / aia21@cam.ac.uk
Cambridge CB2 3BU    ICQ: 8561279
United Kingdom       WWW: http://www-stu.christs.cam.ac.uk/~aia21/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
