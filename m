Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262494AbTIUSeM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 14:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262501AbTIUSeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 14:34:12 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:965 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S262494AbTIUSeK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 14:34:10 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Process in D state (was Re: 2.6.0-test5-mm2)
Date: Sun, 21 Sep 2003 14:30:50 -0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030914234843.20cea5b3.akpm@osdl.org> <200309201534.36362.rob@landley.net> <20030920144902.47c2c7c4.akpm@osdl.org>
In-Reply-To: <20030920144902.47c2c7c4.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309211430.51367.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 September 2003 17:49, Andrew Morton wrote:
> Rob Landley <rob@landley.net> wrote:
> > But, twice in a row now I've made this happen:
> >
> >   1391 pts/1    S      0:00 /bin/bash
> >   1419 pts/1    S      0:00 /bin/sh ./build.sh
> >   1423 pts/1    S      0:00 /bin/bash
> >  /home/landley/pending/newfirmware/make-stat
> >   1447 pts/1    D      0:04 tar xvjf
> >  /home/landley/pending/newfirmware/base/linux
> >   1448 pts/1    S      0:37 bzip2 -d
> >
> >  All I have to do is run my script, it tries to extract the kernel
> > tarball, and tar hangs in D state.
> >
> >  How do I debug this?  (Is there some way to get the output of Ctrl-ScrLk
> > to go to the log instead of just the console?  My system isn't currently
> > hung, it's just got a process that is.  This process being hung prevents
> > my partitions from being unmounted on shutdown, which is annoying.)
>
> sysrq-T followed by `dmesg -s 1000000 > foo' should capture it.

I'll give it a try...

Okay, I reproduced the hang.  Now...  It's beeping at me?

It helps to have magic sysrq selected in menuconfig.  I'll get back to this...

> >  Other miscelanous bugs: cut and paste only works some of the time (it
> > pastes blanks other times, dunno if this was -test5 or -mm2; it worked
> > fine in -test4).
>
> vgacon? fbcon? X11?

X11.  At first I thought it was only between certain apps, but now I thin it's 
just plain intermittent.  Smells like a race or uninitialized variable or 
something.  (For all I know, the bug could be in kde, although I'm using 
RH9's binaries.  I've seen it cutting and pasting between kmail, konsole, and 
konqueror.  Sorry, can't reproduce this one at will...

> >  The key repeat problem is still there, although still highly
> > intermittent.
>
> I think Andries says that some keyboards just forget to send up codes.
> We'll probably need some kernel boot parameter to support these, using the
> keyboard's silly native autorepeat.

I'd rather not have any autorepeat at all than have it go intermittently nuts 
on me...

> >  The boot hung enabling swap space once.  I don't know why.  (Init was
> > already running and everything...)
>
> Probably the O_DIRECT locking bug: I had `rpmv' getting stuck on boot for a
> while.  mm3 fixed that.

I'll upgrade after I get you your sysrq-t.

Rob
