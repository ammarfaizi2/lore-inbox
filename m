Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313514AbSDHMP0>; Mon, 8 Apr 2002 08:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313524AbSDHMPZ>; Mon, 8 Apr 2002 08:15:25 -0400
Received: from 91dyn252.com21.casema.net ([62.234.22.252]:60624 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S313514AbSDHMPY>; Mon, 8 Apr 2002 08:15:24 -0400
Message-Id: <200204081215.OAA12031@cave.bitwizard.nl>
Subject: Re: faster boots?
In-Reply-To: <200204080048.g380mt514749@lmail.actcom.co.il> from Itai Nahshon
 at "Apr 8, 2002 03:48:42 am"
To: Itai Nahshon <nahshon@actcom.co.il>
Date: Mon, 8 Apr 2002 14:15:10 +0200 (MEST)
CC: Pavel Machek <pavel@suse.cz>, Benjamin LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Richard Gooch <rgooch@ras.ucalgary.ca>,
        Andrew Morton <akpm@zip.com.au>, joeja@mindspring.com,
        linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-notice1: This Email contains my Email address. This grants you the right
X-notice2: to communicate with me using this address, related to the subject
X-notice3: in this message. Unsollicitated mass-mailings are explictly 
X-notice4: forbidden here, and by Dutch law. 
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Itai Nahshon wrote:
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
> My suggestion was: there should _never_ be dirty blocks for disks that
> are not spinning. Flush all dirty buffers before spinning down, and spin-up
> on any operation that writes to the disk (and block that operation).
> 
> The opposite to that (which I do not like) processes create as many
> dirty buffers as they want and disk spins up only on sync() or when
> the system is starving for usable memory.
> 
> An aletrnate ides (more drastic) is that fle systems can mount internally
> read-only when a disk is spinned-down. Means - you cannot spin
> down when there is a file handle open for writing. Other than this there
> are advantages.

Actually, you can allow the spindown with open write-filehandles. You
have to remember to spin it up and remount r/w when activity happens.

I'd really like my systems to remount RO if ilde for long times. I
have a few systems that occasionally stop unexpectedly, and not having
to fsck the non-active filesystems would save a lot of time.

(I've decided I dislike reiser: It ate two of my sources, because I
crashed the machine before the sources hit the disk. But the metadata
had been updated to indicate that the overwritten source was in a
different spot on the disk than the old sources. Having to go back to
an older version is less bad than losing the source altogether. 

Yes, I could turn on data-loggin. Yes, I could type "sync" before
insmodding the new driver.)

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
