Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314052AbSERWNY>; Sat, 18 May 2002 18:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314056AbSERWNX>; Sat, 18 May 2002 18:13:23 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:2055 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S314052AbSERWNV>;
	Sat, 18 May 2002 18:13:21 -0400
Date: Sun, 19 May 2002 00:14:34 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Drivers.conf and kbuild-2.5 [Was: kbuild 2.5 is ready ...]
Message-ID: <20020519001434.A4153@mars.ravnborg.org>
In-Reply-To: <Pine.LNX.4.44.0205172157540.4117-100000@xanadu.home> <15163.1021688371@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 18, 2002 at 12:19:31PM +1000, Keith Owens wrote:
> 
>  "Before I send you the kbuild 2.5 patch, how do you want to handle it?".
>  
> I am seeking Linus opinion on the next step, not sending the patch yet.

Hi Keith & others

Dunno if you have seen it already, but Linus gave some inputs in:
http://marc.theaimsgroup.com/?l=linux-kernel&m=102170343732408&w=2

As usual he likes the small steps, and I have seen your replies on this
before.

I have browsed a little in the last version I have used of kbuild-2.5.
The core part which I assume is the full engine of kbuild-2.5, touches
42 files. Most if not all of these are new files, and not modifications.
This part I agree cannot be splitted up furhter.

The common part touches a few existing files related to "make dep"
functionality [split-include, mkdep etc.]
Would it make sense to submit them separately to get them understood
and accepted?
The rest is a big bunch of new Makefile.in files, translated versions
of the existing Makefile's.

The architecture specific part contains a mixture of stuff, but only
touches/creates 17 files. Some of this is due to the new install method
introduced.
Would it make sense to submit that part separately, as it may be used with
kbuild-2.4 as well as I see it?

What actually triggered this mail was the old drivers.conf idea.
One way to sell kbuild-2.5 could be to introduce functionality that
was seen as an improvement for the kernel-hackers, and not persons like me.
Does it make sense to introduce limited support for the drivers.conf idea
in kbuild-2.5 already now?
The first step could be to support it in kbuild, next step could be to support
it in for example "make config" or even better mconfig from Michael Chastain.

Here it would make sense to take a gradually approach, and only convert a
single directory as proof of concept. The first version would naturally not
help text and config.in rules as "make config" does not support it.

Allowing this distributed approach getting rid of the centrally located
information could be the incentive required to convince Linus and at the
same time bring Linux one step further in the process of avoiding
centrally located information.


I also considered the possibility to let the two makefile syntaxes co-exist
to avoid creating ~270 new Makefile.in files, but I could not see this as
feasible. The new syntax add a great deal of info that cannot be obtained
by the old format.
IMHO it would also be plain stupid to put a lot of effort in
supporting the old makefile syntax, when the files are already converted.


PS. I'm one of those people that are hit by the errors in the current system.
I forget to run make dep, I fiddle with .config manually without running
make oldconfig etc. etc.
I am aware that people knowing what they are doing are much less hit by the
funnies in the current kbuild system.

	Sam

> 
> --
> 
> Those that can, do.  Those that can't, troll on linux-kernel.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
