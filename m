Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291192AbSBLVTO>; Tue, 12 Feb 2002 16:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291193AbSBLVRT>; Tue, 12 Feb 2002 16:17:19 -0500
Received: from smtp2.vol.cz ([195.250.128.42]:31501 "EHLO smtp2.vol.cz")
	by vger.kernel.org with ESMTP id <S291192AbSBLVQg>;
	Tue, 12 Feb 2002 16:16:36 -0500
Date: Tue, 12 Feb 2002 12:39:54 +0000
From: Pavel Machek <pavel@suse.cz>
To: mulix <mulix@actcom.co.il>
Cc: Andreas Ferber <aferber@techfak.uni-bielefeld.de>,
        linux-kernel@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        SA products <super.aorta@ntlworld.com>, choo@actcom.co.il
Subject: Re: faking time
Message-ID: <20020212123954.A108@toy.ucw.cz>
In-Reply-To: <20020212093355.A29445@devcon.net> <Pine.LNX.4.33.0202121052160.25841-100000@alhambra.merseine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.33.0202121052160.25841-100000@alhambra.merseine.nu>; from mulix@actcom.co.il on Tue, Feb 12, 2002 at 10:56:17AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!
> > > Here's an LD_PRELOAD shared library that will do the trick... just
> > > export the environment variable FAKETIME with the time that you'd
> > > like, and then export the LD_PRELOAD environment variable to point
> > > that the faketime.so library, and then execute your program.  All
> > > programs that have these two environment variables set will have their
> > > time faked out accordingly.
> >
> > But note that this doesn't work with programs linked statically. If
> > you must fool one of those, ptrace() is the only way to do it without
> > some sort of kernel patch or module I think.

subterfugue.sf.net can do this. It has ready-to-use timeshift/timemultiply
module.

> it's in alpha stages right now, but it seems pretty stable so far (It
> Works For Me - i run it regularly on all of my machines). note that we
> currently support only logging system calls (a-la strace) and failing
> them with a user given parameter- rewriting system call parameters will
> require additional hackery, but not too much of it - on the order of one
> day of work. volunteers are welcome.

Why do you need kernel module at all?

BTW syscall rewriting is pretty hard (subterfugue solves that, but it definitely
took more than a day.

Imagine open('/foo/bar')

you rewrite it to open('/funny/bar')

then another thread comes and rewrites it back to '/foo/bar'.

Or imagine open(address in read-only memory).
								Pavel

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

