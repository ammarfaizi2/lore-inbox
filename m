Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286456AbRL0SRj>; Thu, 27 Dec 2001 13:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286415AbRL0SQC>; Thu, 27 Dec 2001 13:16:02 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:62456 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S286456AbRL0SO6>;
	Thu, 27 Dec 2001 13:14:58 -0500
Date: Thu, 27 Dec 2001 11:14:15 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
        Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        Alexander Viro <viro@math.psu.edu>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [Ext2-devel] [RFC] [PATCH] Clean up fs.h union for ext2
Message-ID: <20011227111415.D12868@lynx.no>
Mail-Followup-To: Daniel Phillips <phillips@bonn-fries.net>,
	linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
	Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Alexander Viro <viro@math.psu.edu>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <E16JR71-0000cU-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <E16JR71-0000cU-00@starship.berlin>; from phillips@bonn-fries.net on Thu, Dec 27, 2001 at 04:21:42AM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 27, 2001  04:21 +0100, Daniel Phillips wrote:
> The strategy is to abstract all references to the struct inode union through 
> an inline function:
> 
> 	static inline struct ext2_inode_info *ext2_i (struct inode *inode)
> 	{
> 		return &(inode->u.ext2_inode_info);
> 	}
> 
> There is some grist here for the mills of language lawyers here.  Note the 
> compilation warning:
> 
>    ialloc.c:336: warning: passing arg 1 of `ext2_i' discards qualifiers from 
>    pointer target type

Why not just declare ext2_i like the following?  It _should_ work:

static inline struct ext2_inode_info *ext2_i(const struct inode *inode)
{
	return &(inode->u.ext2_inode_info);
}


Minor nit: this is already done for the ext3 code, but it looks like:

#define EXT3_I	(&((inode)->u.ext3_i))

We already have the EXT3_SB, so I thought I would be consistent with it:

#define EXT3_SB	(&((sb)->u.ext3_sb))

Do people like the inline version better?  Either way, I would like to make
the ext2 and ext3 codes more similar, rather than less.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

