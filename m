Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314829AbSENA3V>; Mon, 13 May 2002 20:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314835AbSENA3U>; Mon, 13 May 2002 20:29:20 -0400
Received: from panzer.kdm.org ([216.160.178.169]:23051 "EHLO panzer.kdm.org")
	by vger.kernel.org with ESMTP id <S314829AbSENA3T>;
	Mon, 13 May 2002 20:29:19 -0400
Date: Mon, 13 May 2002 18:27:52 -0600
From: "Kenneth D. Merry" <ken@kdm.org>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Re: atari partitioning problem?
Message-ID: <20020513182752.A1665@panzer.kdm.org>
In-Reply-To: <20020513172300.A995@panzer.kdm.org> <Pine.LNX.4.44.0205131922540.19498-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2002 at 19:25:17 -0500, Kai Germaschewski wrote:
> On Mon, 13 May 2002, Kenneth D. Merry wrote:
> 
> > [ Al Viro CCed, since from the changelog for 2.4.11, it looks like he may
> > have submitted the patch in question. ]
> > 
> > I was looking through the atari partitioning code (fs/partitions/atari.c)
> > in 2.4.18 (from what I can see in 2.4.19-pre8, it hasn't changed) and I
> > noticed something (starting at about line 144) that may be a problem:
> > 
> > 			for (; pi < &rs->icdpart[8] && minor < m_lim; minor++, p
> > i++) {
> > 				/* accept only GEM,BGM,RAW,LNX,SWP partitions */
> > 				if (!((pi->flg & 1) && OK_id(pi->id)))
> > 					continue;
> > 				part_fmt = 2;
> > 				add_gd_partition (hd, minor,
> > 						  be32_to_cpu(pi->st),
> > 						  be32_to_cpu(pi->siz));
> > 			}
> > 			printk(" >");
> > 
> > This code changed in 2.4.11, and was previously:
> > 
> >       for (; pi < &rs->icdpart[8] && minor < m_lim; minor++, pi++)
> >       { 
> >         /* accept only GEM,BGM,RAW,LNX,SWP partitions */
> >         if (pi->flg & 1 &&
> >             (memcmp (pi->id, "GEM", 3) == 0 ||
> >              memcmp (pi->id, "BGM", 3) == 0 ||
> >              memcmp (pi->id, "LNX", 3) == 0 ||
> >              memcmp (pi->id, "SWP", 3) == 0 ||
> >              memcmp (pi->id, "RAW", 3) == 0) )
> >         { 
> >           part_fmt = 2;
> >           add_gd_partition (hd, minor, be32_to_cpu(pi->st),
> >                             be32_to_cpu(pi->siz));
> >         }
> >       }
> >       printk(" >");
> > 
> > Note that the test was reversed, but not fully.  You want only active
> > partitions of the specified types to be added, but with the code as it is
> > now, only partitions that are active and *not* of the correct type will get
> > added.
> 
> No, the change is correct.
> 
> Note that the ! in the first snippet is in front of the whole expression, 
> and it's pretty obvious that the reversed test for (a && b) is !(a && b).
> 
> The latter is equivalent to (!a || !b), which seems to be what you're 
> thinking, but you didn't get it right and put !(a || !b) which is wrong.

Oops!  You're right, thanks for pointing that out. :)

Ken
-- 
Kenneth Merry
ken@kdm.org
