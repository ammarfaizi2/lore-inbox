Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315634AbSGNI3K>; Sun, 14 Jul 2002 04:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315690AbSGNI3J>; Sun, 14 Jul 2002 04:29:09 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:26430 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S315634AbSGNI3I>; Sun, 14 Jul 2002 04:29:08 -0400
To: Chiaki <ishikawa@yk.rim.or.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Q: boot time memory region recognition and clearing.
References: <3D303700.5030002@yk.rim.or.jp>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 14 Jul 2002 02:20:38 -0600
In-Reply-To: <3D303700.5030002@yk.rim.or.jp>
Message-ID: <m14rf2ra95.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chiaki <ishikawa@yk.rim.or.jp> writes:

> >> I have found that the particular motherboard (and memory sticks)
> >> that I use at home tends to generate bogus memory problem warning messages
> >> when I use ecc module.
> >> Motherboard is Gigabyte 7XIE4 that uses AMD751.
> >> (Yes, AMD has now provides AMD76x series chipset for
> >> newer CPUs.)
> >> I say "bogus" because I have tested the hardware
> >> many times using memtest86 and found that it doesn't
> >> detect any memory errors even
> >
> >memtest86 isnt (except on the very very latest versions) aware of ECC.
> >It sees the memory after the ECC rescues minor errors so if the RAM has
> >
> >errors but ECC just about saves you it will show up clean
> >
> Thank you for the info on the latest memtest86.
> I will check out.
> 
> It might as well be the case that memtest86 (previous versions)
> was not quite ECC-aware.
> 
> I was not clear on the type of error messages
> I received from ecc.o module.
> I got both SBE (single bit error detected and corrected)
> and MBE (multiple bits error detected,
> which presumably was not correctable!).
> 
> My point was that there is something amiss
> if memtest86 doesn't report errors due to
> underlying (hardware) ECC fix,
> but the why ecc.o module does.
> 
> In any case, I will run memtest86 (the latest version).
> Thank you again for the info.

Note.  The hardware ECC support in memtest86 3.0
is limited, so I would check to make certain your chipset
is supported..

> But any comment to my original post and other avenue
> to achieve similar result welcome.
> (Maybe  the high reliability computing people
> have a better idea short of replacement BIOS  or
> even have some prototype code working on this?
> Hmm. Come to think of it, maybe I can take
> the part of free BIOS and see if it will not
> enlarge setup.S too large, etc.. But thinking of
> various proprietary chipsets, I would hope that
> I can insert a short C routine somewhere in the
> boot chain, preferably on the kernel side, to
> accomplish my objective.)

Your objective is misguided.  Even with a bios that
is slightly buggy in initializing the ECC bits, what you want is 
scrubbing.  Then if the error disappears after 5 minutes of uptime 
you can ignore it.  And if it comes back you know you really have
something to worry about.  At least for single bit errors this should
fix the whole problem with something that is useful for other
purposes. 

Eric
