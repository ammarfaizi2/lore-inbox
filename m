Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263589AbSKRR0Z>; Mon, 18 Nov 2002 12:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263837AbSKRR0Y>; Mon, 18 Nov 2002 12:26:24 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:42253 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S263589AbSKRR0U>; Mon, 18 Nov 2002 12:26:20 -0500
Date: Mon, 18 Nov 2002 12:24:29 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
cc: Sam Ravnborg <sam@ravnborg.org>, Nicolas Pitre <nico@cam.org>,
       Andreas Steinmetz <ast@domdv.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: make distclean and make dep??
In-Reply-To: <Pine.LNX.4.44.0211181034100.24137-100000@chaos.physics.uiowa.edu>
Message-ID: <Pine.LNX.3.96.1021118120325.26196A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2002, Kai Germaschewski wrote:

> On Sun, 17 Nov 2002, Bill Davidsen wrote:
> 
> > On Fri, 15 Nov 2002, Sam Ravnborg wrote:
> > 
> > > Here is first try:
> > > - clean now deletes all generated files except .config + .config.old
> > > - mrproper in addition to clean only deleted .config + .config.old
> > > - distclean in addition ot mrproper deletes backupfiles as usual.
> > 
> > Just what I wanted. If you can be happy doing this it now provides all
> > three useful behaviours in a clear manner.
> 
> But when do you need the "clean + rm .config*" behavior? I don't see that 
> to be such a common case.
> 
> That's why I think two targets are enough, "clean" to remove the files
> generated during the build and "distclean" to remove all other extra stuff
> to. And just keep mrproper to be an alias for distclean, since that's what
> "mrproper" traditionally was (AFAIK, Linus used it that way).

Let me note how I use the three levels of cleaning, and perhaps that will
clarify why I find them desirable.

1 - make clean
  When I apply a patch or make a config change, being paranoid I always
end the testing with a clean make and install.

2 - make mrproper
  When something works on the test machine, I will want to build it in
several other configurations to be tested on "non-critical production"
machines. These are machines actually used in normal work, although they
might be someone's personal work machine, a syslog server, a backup
{whatever} server, or similar. Test machines can afford to lose their
files, 2nd test could lose files but run kernels which have no lost files
or been reported to do so. A failure during hours when someone is
available to push the reset button is acceptable. I really don't want to
part with my original files or build logs at this point.

3 - make distclean
  When I'm about to create a whole "as built" kernel source to keep at
each site running that kernel, this is the one which should be absolutely
clean.

  The way I use it item 2 is the easiest to do by hand, but since people
have been using it *in just that way* up to 2.5.45 or so, why change?
Historically many other packages have used distclean as the cleanest
target, many Linux packages have it, and it's a defacto standard.

  Again, why change something which has been around for years and has had
no problems, complaints, or maintenence. All three are useful and have
been around for a long time, and might be in test scripts for all I
know.

  Sam seems to have agreed that this is useful, unless there's a good
reason not to leave these as historically they have been and as he has
proposed to return them, that should end it. If you have seen some problem
caused by this do describe.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

