Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbWGHLXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbWGHLXI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 07:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbWGHLXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 07:23:07 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:10415 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964796AbWGHLXG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 07:23:06 -0400
Date: Sat, 8 Jul 2006 13:22:45 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: suspend2-devel@lists.suspend2.net, Olivier Galibert <galibert@pobox.com>,
       grundig <grundig@teleline.es>, Avuton Olrich <avuton@gmail.com>,
       jan@rychter.com, linux-kernel@vger.kernel.org
Subject: Re: uswsusp history lesson [was Re: [Suspend2-devel] Re: swsusp / suspend2 reliability]
Message-ID: <20060708112245.GK1700@elf.ucw.cz>
References: <20060627133321.GB3019@elf.ucw.cz> <200607080933.12372.ncunningham@linuxmail.org> <20060708002826.GD1700@elf.ucw.cz> <200607081342.40686.ncunningham@linuxmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607081342.40686.ncunningham@linuxmail.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I really looked at suspend2 hard, year or so ago, when I was pretty
> > tired of the flamewars. At that point I decided it is way too big to
> > be acceptable to mainline, and got that crazy idea about uswsusp, that
> > surprisingly worked out at the end.
> >
> > uswsusp makes suspend2 obsolete, and suspend2 now looks
> > misdesigned. It puts too much stuff into the kernel, you know that
> > already.
> 
> No, I don't. From my point of view, uswsusp is misdesigned, but suspend2 
> isn't. Suspend2 keeps the stuff that ought to be done by the kernel in the 
> kernel. It doesn't shift data out to userspace, only to copy it straight back 
> to the kernel for I/O. It will keep working even if userspace crashes and 
> burns. 

Copying back and forth is not a problem (3GB/sec RAM bandwidth
vs. 50MB/sec disk bandwidth), and at least we do not have to add LZF
to kernel.

> > From your point of view, uswsusp is misdesigned, too. It is too damn
> > hard to install. There's no way it could survive as a standalone patch
> > -- the way suspend2 survives. Fortunately, from distro point of view,
> > being hard to install does not matter that much. Distros already have
> > their own initrds, etc. And in the long term, distros matter, and I'm
> > quite confident I can make 90% distributions ship uswsusp + its
> > userland; cleaner kernel code matters, too, and maybe you'll agree
> > that if you only look at the kernel parts, uswsusp looks nicer.
> 
> It looks simple, I agree. But that's only because it's doing the minimum 
> required.

Yes, and that's exactly how kernel design should work.

> > Now... switching to uswsusp kernel parts will make it slightly harder
> > to install in the short term (messing with initrd). OTOH there's at
> > least _chance_ to get to the point where suspend "just works" in
> > Linux, in the long term...
> >
> > (Of course, you can just ignore this and keep maintaining out-of-tree
> > suspend2. We'll also get to the point where it "just works"... it will
> > just take a little longer.)
> 
> With your current design, I don't see how you're ever going to get to the 
> level of functionality that Suspend2 has. I'm of course thinking of a full 
> image of memory (although Rafael's patch a while back looked hopeful there) 
> and support for other-than-just-one-swap-partition.

Rafael's code was nice hack, unfortunately noone was able to review
it, so it is on hold. (You'll have similar problems, BTW; that LRU
issues are really "interesting").

other-than-just-one-swap-partition is a weekend task for someone
motivated. (And not even dangerous to your data, given that we can do
checksums.) [Any volunteers? Given ammount of trafic in my inbox,
suspend is still interesting topic.]
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
