Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285709AbSAZRdb>; Sat, 26 Jan 2002 12:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285720AbSAZRdV>; Sat, 26 Jan 2002 12:33:21 -0500
Received: from pD9E103E5.dip.t-dialin.net ([217.225.3.229]:11648 "EHLO fefe.de")
	by vger.kernel.org with ESMTP id <S285709AbSAZRdK>;
	Sat, 26 Jan 2002 12:33:10 -0500
Date: Sat, 26 Jan 2002 18:33:03 +0100
From: Felix von Leitner <usenet-20020126@fefe.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [ACPI] ACPI mentioned on lwn.net/kernel
Message-ID: <20020126173303.GC11344@fefe.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <200201251550.g0PFoIPa002738@tigger.cs.uni-dortmund.de> <200201250802.32508.bodnar42@phalynx.dhs.org> <jeelkes8y5.fsf@sykes.suse.de> <a2sv2s$ge3$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2sv2s$ge3$1@penguin.transmeta.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus spake Linus Torvalds (torvalds@transmeta.com):
> >These are all startup costs that are lost in the noise the longer the
> >program runs.
> That's a load of bull.

Agreed.  I like to plug my diet libc slides at this point which (I hope)
make a point about this with network programming as an example.  See
http://www.fefe.de/dietlibc/talk.pdf for details.

> Startup costs tend to _dominate_ most applications, except for
> benchmarks, scientific loads and games/multimedia.

> Not surprisingly, those three categories are also the ones where lots of
> optimizer tuning is regularly done. But it's a _small_ subset of the
> general application load.

Exactly.  However, due to these optimizations the trend goes to large
long-running monster applications like Mozilla or GNOME and KDE.  KDE
does not ask me whether I want to run those 20 processes all the time.
It just starts them.  And new processes are forked off a long running
process because the start-up cost has become so large.

> Note that not only do startup costs often dominate the rest, they are
> psychologically very important.

That is not just psychological.  Most developers would do good to visit
a close university or school and see what kind of machines they use
there.  Ever tried installing Debian on a Sparc SLC?  It took a little
over 24 hours.  Compiling a kernel takes over 12 hours on that box IIRC.
But that's not the point.  This hardware was very much usable a few
years ago.  Today it's practically futile to use it.  You are waiting
more than you are working.  On my desktop Athlon, 1.3 million CPU cycles
static start-up cost for running a dynamically linked glibc program may
not look like much.  But my statically linked ls does an ls -rtl of a
directory with 10 files in less time.

> It's sad that gcc relegates "optimize for size" to a second-class
> citizen.  Instead of having a "-Os" (that optimizes for size and doesn't
> work together with other optimizations), it would be better to have a
> "-Olargecode", which explicitly enables "don't care about code size" for
> those (few) applications where it makes sense.

What do you mean with "does not work together with other optimizations"?
I use -Os all the time.  Actually, -Os often produces faster code than
-O2 or -O3!  What other optimizations do you mean?  I don't need much
other optimizer options besides -fomit-frame-pointer and -march=athlon
if you link PIC code and use an Athlon.

And since -funroll-loops and -finline-functions are enabled explicitly
(or the latter with -O3 and larger by people who don't know what they
are doing), I think gcc already does what you want it to do ;)

Felix
