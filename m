Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266064AbTBTRFM>; Thu, 20 Feb 2003 12:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266091AbTBTRFM>; Thu, 20 Feb 2003 12:05:12 -0500
Received: from mx2.elte.hu ([157.181.151.9]:19875 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S266064AbTBTRFL>;
	Thu, 20 Feb 2003 12:05:11 -0500
Date: Thu, 20 Feb 2003 18:14:38 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Alex Larsson <alexl@redhat.com>,
       <procps-list@redhat.com>, Alexander Viro <viro@math.psu.edu>
Subject: Re: [patch] procfs/procps threading performance speedup, 2.5.62
In-Reply-To: <Pine.LNX.4.44.0302200902260.2493-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0302201810160.32017-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Feb 2003, Linus Torvalds wrote:

> > the main problem with threads in /proc is that there's a big slowdown when
> > using lots of threads.
> 
> Well, part of the problem (I think) is that you added all the threads to
> the same main directory.
> 
> Putting a "." in front of the name doesn't fix the /proc level directory
> scalability issues, it only means that you can avoid some of the user-
> level scalability ones.
> 
> So to offset that bad design, you then add other cruft, like the lookup
> cursor and the "." marker. Which is not a bad idea in itself, but I
> claim that if you'd made the directory structure saner you wouldn't have
> needed it in the first place.

with the dot-marker it's not scaling badly at all - you can see the
numbers in the mail, all of the command variants (even a simple 'ps')  
still reads the _full_ /proc directory. (just they dont go further than
that, because the readdir() output is enough to filter stuff.)

> It would just be _so_ much nicer if the threads would show up as
> subdirectories ie /proc/<tgid>/<tid>/xxx. More scalable, more readable,
> and just generally more sane.

Al says that this cannot be done sanely, and is fraught with security
problems. I'd vote for it if it were possible. Al?

but, if you worry about the scalability of large /proc directories - it's
not bad at all.

	Ingo

