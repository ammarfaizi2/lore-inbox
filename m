Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261739AbTCGRD7>; Fri, 7 Mar 2003 12:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261750AbTCGRD7>; Fri, 7 Mar 2003 12:03:59 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:36592 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S261739AbTCGRDv>;
	Fri, 7 Mar 2003 12:03:51 -0500
Date: Fri, 7 Mar 2003 18:14:09 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Olivier Galibert <galibert@pobox.com>
cc: Pavel Machek <pavel@suse.cz>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: BitBucket: GPL-ed KitBeeper clone
In-Reply-To: <20030307165413.GA78966@dspnet.fr.eu.org>
Message-ID: <Pine.GSO.4.21.0303071808520.13981-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Mar 2003, Olivier Galibert wrote:
> Now if the development went that way:
> 
> 1.7  -> 1.7.1.1 (branching, i.e. copy)
>  v         v
>  v      1.7.1.2
> 1.8        v
>  v   -> 1.7.1.3 (merge)
> 1.9        v
>  v         v
> 1.10       v
>  v   -> 1.7.1.4 (merge)
>  v         v
>  v      1.7.1.5
>  v         v
> 1.11 <-         (merge)
> 
> Pretty much standard, a developper created a new branch, made some
> changes in it, synced with mainline, synced with mailine again a
> little later, made some new changes and finally folded the branch back
> in the mainline.  Let's admit the developper changes don't conflict by
> themselves with the mainline changes.
> 
> CVS, for all the merges, is going to pick 1.7 as the reference.  The
> first time, for 1.7.1.3, it's going to work correctly.  It will fuse
> the 1.7->1.8 patch with the 1.7.1.1->1.7.1.2 patch and apply the
> result to 1.7 to get 1.7.1.3.  The two patches have no reason to
> overlap.  1.7.1.2->1.7.1.3 will essentially be identical to 1.7->1.8,
> and 1.8->1.7.1.3 will essentially be identical to 1.7.1.2->1.7.1.3.
                                                    ^^^^^^^^^^^^^^^^
1.7.1.1->1.7.1.2, I assume?

> As soon as the next merge, i.e 1.7.1.4, it breaks.  CVS is going to
> try to fuse the 1.7->1.10 patch with the 1.7->1.7.1.3 patch.  But
> 1.7->1.10 = 1.7->1.8+1.8->1.10 and 1.7->1.7.1.3 ~= 1.7->1.7.1.2+1.7->1.8.
> So they have components in common, hance they _will_ conflict.
> 
> If CVS had taken the latest common ancestor by keeping in the
> repository the existence of the 1.8->1.7.1.3 link, it would have taken
> the 1.8 version as the reference.  The patches to fuse would have been
> 1.8->1.10 and 1.8->1.7.1.3, which have no reason to conflict.
> 
> Same for the next merge, the optimal merge point is in that case 1.10,
> and it ends up being a null merge, i.e. 1.11 is a copy of 1.7.1.5.
> 
> You can see the final structure is a DAG, with each node having a max
> of 2 ancestors.  And that's what PRCS and bk are working with,
> fundamentally.

Aha, so that's why my `mergetree' script (which basically is some directory
recursion around plain RCS merge, with additional support for hardlinking
identical files) works better than CVS, when I merge e.g. linux-2.5.64 and
linux-m68k-2.5.63 into linux-m68k-2.5.64. It always uses the latest common
ancestor (linux-2.5.63)...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

