Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129243AbRBVBn0>; Wed, 21 Feb 2001 20:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130579AbRBVBnP>; Wed, 21 Feb 2001 20:43:15 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:38930 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129243AbRBVBnG>; Wed, 21 Feb 2001 20:43:06 -0500
Message-ID: <3A946E9F.F1D20C46@transmeta.com>
Date: Wed, 21 Feb 2001 17:42:55 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Daniel Phillips <phillips@innominate.de>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] Near-constant time directory index for Ext2
In-Reply-To: <20010221220835.A8781@atrey.karlin.mff.cuni.cz> <XFMail.20010221132959.davidel@xmailserver.org> <20010221223238.A17903@atrey.karlin.mff.cuni.cz> <971ejs$139$1@cesium.transmeta.com> <20010221233204.A26671@atrey.karlin.mff.cuni.cz> <3A94435D.59A4D729@transmeta.com> <20010221235008.A27924@atrey.karlin.mff.cuni.cz> <3A94470C.2E54EB58@transmeta.com> <20010222000755.A29061@atrey.karlin.mff.cuni.cz> <3A944C05.FC2B623A@transmeta.com> <3A945081.E6EB78F4@innominate.de> <3A9453E9.4457668C@transmeta.com> <3A9469D8.DB4679DB@innominate.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> "H. Peter Anvin" wrote:
> >
> > Daniel Phillips wrote:
> > >
> > > Have you looked at the structure and algorithms I'm using?  I would not
> > > call this a hash table, nor is it a btree.  It's a 'hash-keyed
> > > uniform-depth tree'.  It never needs to be rehashed (though it might be
> > > worthwhile compacting it at some point).  It also never needs to be
> > > rebalanced - it's only two levels deep for up to 50 million files.
> >
> > I'm curious how you do that.  It seems each level would have to be 64K
> > large in order to do that, with a minimum disk space consumption of 128K
> > for a directory.  That seems extremely painful *except* in the case of
> > hysterically large directories, which tend to be the exception even on
> > filesystems where they occur.
> 
> Easy, with average dirent reclen of 16 bytes each directory leaf block
> can holds up to 256 entries.  Each index block indexes 512 directory
> blocks and the root indexes 511 index blocks.  Assuming the leaves are
> on average 75% full this gives:
> 
>         (4096 / 16) * 512 * 511 * .75 = 50,233,344
> 

That's a three-level tree, not a two-level tree.

> I practice I'm getting a little more than 90,000 entries indexed by a
> *single* index block (the root) so I'm not just making this up.
> 
> > I think I'd rather take the extra complexity and rebalancing cost of a
> > B-tree.
> 
> Do you still think so?

I think so.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
