Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265684AbSJXVp5>; Thu, 24 Oct 2002 17:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265685AbSJXVp5>; Thu, 24 Oct 2002 17:45:57 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:24738 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S265684AbSJXVpy> convert rfc822-to-8bit; Thu, 24 Oct 2002 17:45:54 -0400
Content-Type: text/plain; charset=US-ASCII
From: Erich Focht <efocht@ess.nec.de>
To: Michael Hohnbaum <hohnbaum@us.ibm.com>, landley@trommello.org
Subject: Re: Crunch time -- the musical.  (2.5 merge candidate list 1.5)
Date: Thu, 24 Oct 2002 23:51:56 +0200
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <200210231626.12903.landley@trommello.org> <200210240750.09751.landley@trommello.org> <1035486061.9367.1078.camel@dyn9-47-17-164.beaverton.ibm.com>
In-Reply-To: <1035486061.9367.1078.camel@dyn9-47-17-164.beaverton.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210242351.56719.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob and Michael,

I need to correct some inexactities and, of course, advertise my aproach
:-)

On Thursday 24 October 2002 21:01, Michael Hohnbaum wrote:
> > > > 26) NUMA aware scheduler extenstions (Erich Focht, Michael Hohnbaum)
> > > >
> > > > Home page:
> > > > http://home.arcor.de/efocht/sched/
> > > >
> > > > Patch:
> > > > http://home.arcor.de/efocht/sched/Nod20_numa_sched-2.5.31.patch

These are old. I posted the newer patches (splitted up in order to clearly
separate the functionality additions) to LKML:

http://marc.theaimsgroup.com/?l=linux-kernel&m=103459387719030&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=103459387519026&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=103459441119407&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=103459441319411&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=103459441419416&w=2
They should work for any NUMA platform by just adding a call to
build_pools() in smp_cpus_done(). They work for non-NUMA platforms
the same way as the O(1) scheduler (though the code looks different).
A test overview is in: http://lwn.net/Articles/12546/
This suggests that taking only patches 01+02 already gives you a VERY
good NUMA scheduler. They deliver the infrastructure for later
developments (patches 03+05) which we can further research and tune or
give only to special customers.

> The 2.5 status list has not been updated to reflect this separate
> effort, and I believe incorrectly lists this entry as "ready".  There
> really are now two NUMA scheduler projects:
>
> * Simple NUMA scheduler (Michael Hohnbaum)  - ready for inclusion
> * Node affine NUMA scheduler (Erich Focht)  - Alpha (Beta?)
This is not correct. We have the node affine scheduler in production
since 6 months on top of 2.4. kernels and are happy with it. It is a lot
more than alpha or beta, it already makes customers happy.

The situation is really funny: Everybody seems to agree that the design
ideas in my NUMA aproach are sane and exactly what we want to have on
a NUMA platform in the end. But instead of concentrating on tuning the
parameters for the many different NUMA platforms and reshaping this
aproach to make it acceptable, IBM concentrates on a very much stripped
down aproach. I understand that this project has been started to make
the inclusion of some NUMA scheduler easier. But in the end, the simple
NUMA scheduler will have to develop to a much more complex thing and in
some form or another replicate the design ideas of my node affine
scheduler. On machines with poor NUMA ratio like NUMAQ the simple NUMA
change helps. For machines with good NUMA ratio like NEC Azusa, NEC TX7
you need a little bit more. AMD Hammer-SMP and ppc64 are certainly in
the same class as the Azusa/TX7. And as soon as Hammer SMP systems will
be around, the pressure for a full featured NUMA scheduler will be much
higher.

A NUMA scheduler extension of the 2.6 kernel fits very well with the
development effort done for better scalability and enterprise level
fitnes of Linux. Check http://lwn.net/Articles/12546/ to see that it
makes a difference to have more than O(1) on NUMA machines! I'd
definitely prefer the inclusion of my 01+02 patches (I'd have to
maintain less code to keep the customers happy), on the other side:
including Michael's patch would be better than not adding NUMA
scheduler support at all.

Best regards,
Erich


