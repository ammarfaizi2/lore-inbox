Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313515AbSDHA57>; Sun, 7 Apr 2002 20:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313524AbSDHA56>; Sun, 7 Apr 2002 20:57:58 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:45214 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S313515AbSDHA56>; Sun, 7 Apr 2002 20:57:58 -0400
Date: Sun, 7 Apr 2002 18:57:37 -0600
Message-Id: <200204080057.g380vbO00868@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: nahshon@actcom.co.il
Cc: Pavel Machek <pavel@suse.cz>, Benjamin LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@zip.com.au>,
        joeja@mindspring.com, linux-kernel@vger.kernel.org
Subject: Re: faster boots?
In-Reply-To: <200204080048.g380mt514749@lmail.actcom.co.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Itai Nahshon writes:
> On Sunday 07 April 2002 17:42 pm, Pavel Machek wrote:
> > Hi!
> >
> > > I'm curios, how much work can you accomplish on your laptop
> > > without any disk access (but you still need to save files - keeping
> > > them in buffers until it's time to actually write them).
> >
> > Debugging session (emacs/gcc/gdb) for half an hour with disks stopped is
> > easy to accomplish.
> > 								Pavel
> 
> My suggestion was: there should _never_ be dirty blocks for disks
> that are not spinning. Flush all dirty buffers before spinning down,

This is fine, and I wish the block I/O layer was smarter and could
handle spin/idle management itself, rather than telling the drive to
spin down after inactivity. That way, when the bio layer sees
inactivity, it can tell the drive to go to sleep, but first it can
flush any remaining buffers.

> and spin-up on any operation that writes to the disk (and block that
> operation).

Absolutely not! I don't want my writes to spin up the drive.

> The opposite to that (which I do not like) processes create as many
> dirty buffers as they want and disk spins up only on sync() or when
> the system is starving for usable memory.

Maybe you don't like that, but many of us with laptops prefer that
behaviour. And for many reasons, it is definately the correct
behaviour.

> An aletrnate ides (more drastic) is that fle systems can mount
> internally read-only when a disk is spinned-down. Means - you cannot
> spin down when there is a file handle open for writing. Other than
> this there are advantages.

Undesirable behaviour.

> I don't see how any of these will stop you from doing emacs/gcc/gdb
> with the disk stopped, as long as you are not trying to write to the
> disk or read from files that are not cached.

But I *want* to write while the drive is spun down. And leave it spun
down until the system is RAM starved (or some threshold is reached).

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
