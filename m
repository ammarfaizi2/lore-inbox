Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285552AbRL2VMQ>; Sat, 29 Dec 2001 16:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285568AbRL2VMH>; Sat, 29 Dec 2001 16:12:07 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:11024 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S285572AbRL2VL4>; Sat, 29 Dec 2001 16:11:56 -0500
Message-ID: <3C2E30DA.AEBC0C57@zip.com.au>
Date: Sat, 29 Dec 2001 13:08:42 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Oliver Xymoron <oxymoron@waste.org>
CC: Andreas Dilger <adilger@turbolinux.com>, linux-kernel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] [RFC] [PATCH] Clean up fs.h union for ext2
In-Reply-To: <20011227111415.D12868@lynx.no> <Pine.LNX.4.43.0112290957050.18183-100000@waste.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron wrote:
> 
> > Minor nit: this is already done for the ext3 code, but it looks like:
> >
> > #define EXT3_I        (&((inode)->u.ext3_i))
> >
> > We already have the EXT3_SB, so I thought I would be consistent with it:
> >
> > #define EXT3_SB       (&((sb)->u.ext3_sb))
> >
> > Do people like the inline version better?  Either way, I would like to make
> > the ext2 and ext3 codes more similar, rather than less.
> 
> The ext3 macros are rather revolting, simply because they assume the
> variable name. A parameterized macro might be the best compromise:
> 
> #define EXT2_I(i) (&(i->u.ext2_inode_info))
> 

They _would_ be revolting, except Andreas mistyped :)  We have:

#define EXT3_SB(sb)     (&((sb)->u.ext3_sb))
#define EXT3_I(inode)   (&((inode)->u.ext3_i))

(A number of the mm macros accidentally only work correctly if their
argument is called "page".  Dunno if this is stil the case though).

-
