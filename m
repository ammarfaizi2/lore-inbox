Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313557AbSDHMiK>; Mon, 8 Apr 2002 08:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313588AbSDHMiJ>; Mon, 8 Apr 2002 08:38:09 -0400
Received: from 91dyn252.com21.casema.net ([62.234.22.252]:40145 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S313557AbSDHMiG>; Mon, 8 Apr 2002 08:38:06 -0400
Message-Id: <200204081238.OAA12083@cave.bitwizard.nl>
Subject: Re: faster boots?
In-Reply-To: <3CB14ECD.43E97BD8@aitel.hist.no> from Helge Hafting at "Apr 8,
 2002 10:03:25 am"
To: Helge Hafting <helgehaf@aitel.hist.no>
Date: Mon, 8 Apr 2002 14:38:04 +0200 (MEST)
CC: nahshon@actcom.co.il, linux-kernel@vger.kernel.org
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

Helge Hafting wrote:
> Itai Nahshon wrote:
> > 
> > On Sunday 07 April 2002 17:42 pm, Pavel Machek wrote:
> > > Hi!
> > >
> > > > I'm curios, how much work can you accomplish on your laptop
> > > > without any disk access (but you still need to save files - keeping
> > > > them in buffers until it's time to actually write them).
> > >
> > > Debugging session (emacs/gcc/gdb) for half an hour with disks stopped is
> > > easy to accomplish.
> > >                                                               Pavel
> > 
> > My suggestion was: there should _never_ be dirty blocks for disks that
> > are not spinning. 
> 
> Why not?  Are you afraid that the spun-down disk won't
> start the next time it is needed?

I think he is. The problem is: then it's almost always "too late"
anyway: What are you going to do with a system that suddenly doesn't
have a disk anymore? 

Suppose you enforce that, and first try to spin up the disk before
allowing teh write to continue. Suppose that the spin up fails: 

	vi: EIO writing source.c

Now to recover from this situation you may want to writ the source to 
a floppy then. So in another VC you type:

	mount /dev/fd0 /mnt/floppy
	IO error reading "mount". 

Remember the main disk couldn't be spun up....

This is almost no worse than the write going into the buffer cache,
and the appliction not knowing something went wrong...

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
