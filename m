Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293605AbSBRDFq>; Sun, 17 Feb 2002 22:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293607AbSBRDFh>; Sun, 17 Feb 2002 22:05:37 -0500
Received: from duracef.shout.net ([204.253.184.12]:4101 "EHLO
	duracef.shout.net") by vger.kernel.org with ESMTP
	id <S293605AbSBRDFc>; Sun, 17 Feb 2002 22:05:32 -0500
Date: Sun, 17 Feb 2002 21:05:18 -0600
From: Michael Elizabeth Chastain <mec@shout.net>
Message-Id: <200202180305.g1I35IS04421@duracef.shout.net>
To: jgarzik@mandrakesoft.com
Subject: Re: [kbuild-devel] Re: Disgusted with kbuild developers
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik replies to me:
mec> I believe that CML1 is rococo and I welcome a replacement.  I think that
mec> leapfrog development is a good strategy here, just as it was for ALSA.
jg> I think this is a key mistake.  See Al's message "Of Bundling, Dao,
jg> ...".

I am reading lkml from an archive and I saw only the Friday night messages.
I have caught up now.

I agree with Al's strategy in "Of Bundling, Dao, and Cowardice".

Let me talk about the list-based makefiles.  Long before I submitted the
first list-based makefile to the kernel tree (drivers/sound/makefile),
I had a whole rewrite of every makefile.  These were the "Dancing Makefiles"
and several ideas came out of them: CONFIG_SMP and list-based makefiles
in particular.

I never thought I'd be able to get the Dancing Makefiles adopted.  I spent
a whole year just getting CONFIG_SMP merged!  So I came to view it as
a useful laboratory project to show what kinds of things were viable or not.

Then 2.1.XX developed a real problem with drivers/sound/Makefile.  The
"if-statement" based approach was not working.  The "if-statements"
changed on every patch level and new bugs came in for every patch level.

I said to myself "aha, list-based makefiles will solve this problem".
I wrote a new drivers/sound/Makefile.  Here is the important point:
I did not touch Rules.make *at all*.  I put some translation lines
into drivers/sound/Makefile so that it would just work.

Between 2.2 and 2.4, several people -- including Jeff Garzik -- converted
a lot more makefiles incremenetally to the new style.  This process got
about 80% done incrementally.

Eventually one of the old-style Makefiles developed a similar problem
with new tweaks in every patch level leading to a new batch of bug
reports.  Linus said something like "to hell with this" and summarily
removed support for the old-style.

So ... I leapfrogged in my own work area, but I put out incremental
patches that solved problems that other people wanted solved.

It was also a very painful process for me.  My patches got black-holed
numerous times.

jg> It's impossible to prove that Eric's CML2 rulebase reflects a current
jg> CML1 rulebase, primarily for this reason.

That's an important property and I haven't given enough weight to it.  :-(

It would be nice if:

  The new tool reads both CML1 and CML2.
  Deploy the new tool.
  People could convert directories to CML2 one at a time.

jg> Those are meta-properties.

Indeed, all my criteria are meta-properties.

jg> CML2's syntax is not reflective of the direction of being able to plop
jg> down "driver.c" and "driver.conf" and having the config/make system
jg> magically notice it.

This "driver.conf" idea did not exist when CML2 was invented.

So it looks like there is a market opportunity here: a tool that
reads CML1 files and also reads some kind of new driver.conf files,
which can be written in a fresh new language.

jg> Would you support the replacement of in-kernel
jg> configure/Menuconfig/xconfig with in-kernel mconfig?

I believe that mconfig is best distributed as a semi-independent package,
distributed in the way that modutils is distributed today.  I think that's
better than in-kernel.  Between the choice of in-kernel
configure/menuconfig/xconfig and in-kernel mconfig, I would go for
in-kernel mconfig.

jg> If we want to migrate to a point where all kernel configuration is
jg> maintained solely outside the kernel, I actually support that.  But as a
jg> SEPARATE migration step.  I do not want to drop all config tools from
jg> the kernel and tell people "use mconfig" in the same breath.

My vision of the migration path was that mconfig would be distributed
separately and co-exist with configure/menuconfig/xconfig.  When the
market share of mconfig becomes high enough( (say, 80% to 90%),
then drop support for configure/menuconfig/xconfig.

Michael Elizabeth Chastain
<mailto:mec@shout.net>
"love without fear"
