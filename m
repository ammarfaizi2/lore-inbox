Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286263AbRL2Vaj>; Sat, 29 Dec 2001 16:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285568AbRL2Vaa>; Sat, 29 Dec 2001 16:30:30 -0500
Received: from waste.org ([209.173.204.2]:16340 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S286263AbRL2Va2>;
	Sat, 29 Dec 2001 16:30:28 -0500
Date: Sat, 29 Dec 2001 15:30:16 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Andreas Dilger <adilger@turbolabs.com>
cc: Daniel Phillips <phillips@bonn-fries.net>, <linux-kernel@vger.kernel.org>,
        <ext2-devel@lists.sourceforge.net>
Subject: Re: [Ext2-devel] [RFC] [PATCH] Clean up fs.h union for ext2
In-Reply-To: <20011229140105.A12868@lynx.no>
Message-ID: <Pine.LNX.4.43.0112291516530.18183-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Dec 2001, Andreas Dilger wrote:

> > The ext3 macros are rather revolting, simply because they assume the
> > variable name. A parameterized macro might be the best compromise:
> >
> > #define EXT2_I(i) (&(i->u.ext2_inode_info))
>
> My mistake, the Ext3 macros _do_ take an inode/sb parameter.  It's not that
> I'm a huge fan of macros over inline functions, it's just that I would like
> to have a consensus about how it should be done so that it is consistent
> between ext2 and ext3.

The inline route is the way to go. The const guarantee on *inode doesn't
get propagated down to the objects it points to by the compiler anyway so
when the unions go away being const-correct gains us nothing.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

