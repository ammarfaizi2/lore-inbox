Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130018AbRANLfj>; Sun, 14 Jan 2001 06:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131066AbRANLf3>; Sun, 14 Jan 2001 06:35:29 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:45074 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S130018AbRANLfO>; Sun, 14 Jan 2001 06:35:14 -0500
Date: 14 Jan 2001 12:16:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <7trueV0Xw-B@khms.westfalen.de>
In-Reply-To: <31714.979301892@ocs3.ocs-net>
Subject: Re: Where did vm_operations_struct->unmap in 2.4.0 go?
X-Mailer: CrossPoint v3.12d.kh5 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <3A5EF208.4013B5F7@innominate.de> <31714.979301892@ocs3.ocs-net>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kaos@ocs.com.au (Keith Owens)  wrote on 12.01.01 in <31714.979301892@ocs3.ocs-net>:

> On Fri, 12 Jan 2001 13:01:12 +0100,
> Daniel Phillips <phillips@innominate.de> wrote:
> >Keith Owens wrote:
> >> I want to completely remove this multi layered method for setting
> >> initialisation order and go back to basics.  I want the programmer to
> >> say "initialise E and F after G, H and I".  The kernel build system
> >> works out the directed graph of initialisation order then controls the
> >> execution of startup code to satisfy this graph.
> >
> >I don't doubt you will come up with a workable solution at build time.
> >However, working out a valid graph at execution time is trivial and
> >efficient, given a list of precedence relations of the kind you're
> >suggesting.  In fact you don't even have to work out the graph before
> >starting the initialization, it's also trivial to keep a count of
> >unsatisfied initialization conditions at the beginning of each
> >initialization sequence and block until the count goes to zero.  (In
> >essence, evaluate a priority sort on the fly.)
>
> It is safer to evaluate the graph at link time in case somebody
> mistakenly codes a dependency loop, that is an abort case.  Finding
> that you have a loop at load time and aborting the kernel is a little
> too drastic for my tastes.
>
> In any case it is academic.  Linus insists on link order being
> explicitly and completely specified by the programmer and he likes the
> link order being implied by Makefile order.  So there is no point in
> working on a better system.

I'm not so sure about that. I think it _should_ be possible to do both,  
and get better documentation at the same time.

How about this:

* Invent some method for modules to declare these dependencies. Maybe even
  in /** */ type comments, so it goes right into the documentation.

* Write a program to collect all dependencies, do a tsort on them
  (alerting the developer if a loop is found), determining a reasonable
  initialization order, and spitting out the relevant Makefiles or
  Makefile fragments to *create* that initialization order the Linus way.

Or in other words, don't do it at runtime, don't do it at compile time, do  
it at develop time. (Or patch time, perhaps.)

MfG Kai
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
