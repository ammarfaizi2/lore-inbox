Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129747AbRACSFX>; Wed, 3 Jan 2001 13:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129183AbRACSFO>; Wed, 3 Jan 2001 13:05:14 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:30480 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129267AbRACSFD>;
	Wed, 3 Jan 2001 13:05:03 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Date: Wed, 3 Jan 2001 18:27:05 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Oops in prune_dcache (2.4.0-prerelease)
CC: Dan Aloni <karrde@callisto.yi.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>, viro@math.psu.edu
X-mailer: Pegasus Mail v3.40
Message-ID: <11894872650B@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  3 Jan 01 at 13:08, Udo A. Steinberg wrote:
> Alexander Viro wrote:
> >
> > In principle, it might be that d_find_alias() is broken. I don't see where
> > it could happen, but then I'm half-asleep right now...  While we are at it,
> > do you have
> 
> >         * autofs
> 
> Yes.
> 
> >         * knfsd
> >         * ncpfs
> 
> No, neither of these two.

I saw oopses in prune_dcache() during umount() of ncpfs circa 6 months
ago. As I was never able to reproduce problem, and it just stopped from
happenning as unexpected as it appeared, I never reported that. And
~2 times I got endless loop in d_prune_aliases() where it somewhat
happened that d_alias list looked like

1 -> 2 -> 3 -> 4 -> 2 -> 3 -> 4 ... (maybe after pruning d_count = 0
                                    entries...)

so it never stopped :-( But it really happened long long ago, I think
that sometime June-September 2000, and couple of logic changed since
then in both ncpfs and vfs.
                                    Best regards,
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
