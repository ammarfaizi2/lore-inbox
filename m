Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279228AbRKDWW4>; Sun, 4 Nov 2001 17:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279274AbRKDWWg>; Sun, 4 Nov 2001 17:22:36 -0500
Received: from alfik.ms.mff.cuni.cz ([195.113.19.71]:45316 "EHLO
	alfik.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S279228AbRKDWWV>; Sun, 4 Nov 2001 17:22:21 -0500
Date: Sun, 4 Nov 2001 23:34:16 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@zip.com.au>
Cc: Neil Brown <neilb@cse.unsw.edu.au>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.14-pre6
Message-ID: <20011104233416.D1875@elf.ucw.cz>
In-Reply-To: <Pine.LNX.4.33.0110310809200.32460-100000@penguin.transmeta.com> <15329.8658.642254.284398@notabene.cse.unsw.edu.au> <3BE1B6CD.7DA43A6C@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BE1B6CD.7DA43A6C@zip.com.au>
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > What I would like is that as soon as a buffer was marked "dirty", it
> > would get passed down to the driver (or at least to the
> > block-device-layer) with something like
> >     submit_bh(WRITEA, bh);
> > i.e. a write ahead. (or is it write-behind...)
> > The device handler (the elevator algorithm for normal disks, other
> > code for other devices) could keep them ordered in whatever way it
> > chooses, and feed them into the queues at some appropriate time.
> 
> Sounds sensible to me.
> 
> In many ways, it's similar to the current scheme when it's used
> with an enormous request queue - all writeable blocks in the
> system are candidates for request merging.  But your proposal
> is a whole lot smarter.
> 
> In particular, the current kupdate scheme of writing the
> dirty block list out in six chunks, five seconds apart
> does potentially miss out on a very large number of merging
> opportunities.  Your proposal would fix that.
> 
> Another potential microoptimisation would be to write out
> clean blocks if that helps merging.  So if we see a write
> for blocks 1,2,3,5,6,7 and block 4 is known to be in memory,
> then write it out too.  I suspect this would be a win for
> ATA but a loss for SCSI.  Not sure.

Please don't do this, it is bug.

If user did not ask writing somewhere, DO NOT WRITE THERE! If power
fails in the middle of the sector... Or if that is flashcard.... Just
don't do this.
								Pavel
-- 
STOP THE WAR! Someone killed innocent Americans. That does not give
U.S. right to kill people in Afganistan.


