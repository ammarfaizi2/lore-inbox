Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265998AbTB0S2k>; Thu, 27 Feb 2003 13:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266010AbTB0S2k>; Thu, 27 Feb 2003 13:28:40 -0500
Received: from smtp1.clear.net.nz ([203.97.33.27]:56292 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP
	id <S265998AbTB0S2j>; Thu, 27 Feb 2003 13:28:39 -0500
Date: Fri, 28 Feb 2003 07:42:05 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: SWSUSP Discontiguous pagedirs
In-reply-to: <20030227132024.GB27084@atrey.karlin.mff.cuni.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1046371311.2308.30.camel@laptop-linux.cunninghams>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1045784829.3821.10.camel@laptop-linux.cunninghams>
 <20030223223757.GA120@elf.ucw.cz>
 <1046136752.1784.15.camel@laptop-linux.cunninghams>
 <20030227132024.GB27084@atrey.karlin.mff.cuni.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-28 at 02:20, Pavel Machek wrote:
> Hi!
> 
> > SPAM: Content analysis details:   (6.30 hits, 5 required)
> > SPAM: SUBJ_HAS_SPACES    (2.6 points)  Subject contains lots of white space
> Spam assassin clearly does not like you :-(.

I'll make my subject lines shorter :>

> > Well, I might ask how many people you know with 4GB of swap and 4GB of
> > RAM they want to suspend to disk :> Don't forget we still aren't
> > handling himem anyway (at least not last time I checked). As y
> 
> Well, on x86-64 it should be able to suspend 8GB machine just fine --
> being 64bit means you don't have to deal with himem. Plus it would
> only be 2GB limit on x86-64.

I was thinking about this before I got up. If the code was a hybrid of
what we have now and my changes, there wouldn't need to be such a limit.
If I am thinking straight, the number of pages to be copied back using
suspend_asm.S will always be within this currently limit, because no
highmem pages will be needed during the suspend process, so they can all
be put in the second pageset. The only issue then is storage of the data
for those pageset 2 pages. We could just add another layer of
indirection(!), but that would result in quite inefficient memory usage
in the pagedir struct beyond the end of pageset 1. Still, the
alternative is more complicated code, and if you have that much memory
anyway... I'll put some more thought into this.

> 
> > If you still doubt the usefulness, perhaps you might try loading up 2.4,
> > first with beta 16 applied and then with beta 18. In both cases, compare
> > performance after loading up a bunch of applications and doing a suspend
> > to disk cycle. Depending of course on what the applications are, beta 16
> > will be sluggish to respond (since it has to access disk a lot) whereas
> > beta 18 will be much more responsive - as if you'd never suspended. To
> > think in marketing terms for a moment, which would you rather have a
> > reviewer comparing Linux and Windows see?
> 
> As I'm used to machine pushed to swap, I can tolerate it quite
> easily. shell/emacs/mutt is what I use, anyway...

Mmm, but not all of us do. I'm using Evolution, Win4Lin...

> 
> I don't know. I'd let Linus decide. I don't like hard limit on ammount
> of mem, through.
> 
> Is it possible to use some userspace app to page it back it?

All things are possible, but not everything is beneficial :> (Bible).
Actually, I'm not sure it's possible in this case. We can't restart
processes when most of their memory space, along with all of the page
cache and swap cache is still on disk and they think it's in RAM.

Regards,

Nigel

