Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273799AbRIXFTQ>; Mon, 24 Sep 2001 01:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273801AbRIXFTH>; Mon, 24 Sep 2001 01:19:07 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:43533 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S273799AbRIXFSz>; Mon, 24 Sep 2001 01:18:55 -0400
Message-ID: <3BAEC254.2A29B495@zip.com.au>
Date: Sun, 23 Sep 2001 22:19:16 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Aaron Lehmann <aaronl@vitelus.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.10 + ext3
In-Reply-To: <Pine.LNX.4.33.0109231142060.1078-100000@penguin.transmeta.com> <1001280620.3540.33.camel@gromit.house> <9om4ed$1hv$1@penguin.transmeta.com>, <9om4ed$1hv$1@penguin.transmeta.com> <20010923193008.A13982@vitelus.com> <3BAEAC52.677C064C@zip.com.au>,
		<3BAEAC52.677C064C@zip.com.au> <20010923214507.A15014@vitelus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aaron Lehmann wrote:
> 
> ...
> I simply was hoping for insted of:
> 
>  <*> EXT2 fs
>  <*> EXT3 fs
> 
> (which is required today for most ext3-using people who want to do ext2
> mounts)
> 
> ... there could be:
> 
>  <*> EXT2 fs
>  <*>   EXT3 journalling extensions
> 
> AFAIK this would eliminate a lot of duplicate kernel code for ext3
> users.
> 

mm..  The filesystems could be pretty much identical on the reading
path, but they're quite dissimilar on the writing path. So the
reading-stuff code could be commoned up.

I don't think it'd buy much, though.  They are different filesystems
and the fact that ext3 borrows a lot of ext2 code is a useful
consequence of it having the same on-disk format.

And the main reason for having the same on-disk format is not, IMO, to
ease migration between the two filesystems.  That's just a once-off
activity.  The main reason for preserving compatibility is so that ext3
can leverage e2fsprogs, and the wealth of knowledge and understanding
of ext2 performance and behaviour.

The ext2-compatibility seems to be a bit of a political albatross
for ext3, really - people appear to be of the opinion that the
ext3 design was somehow compromised by the compatibility requirement.
This isn't so - ext3 is a block-level journalled filesystem.  It
could have been based on minixfs, UFS, sysvfs, etc.  Or it could
have been something altogether new.  But I can't think of any benefit
in changing the on-disk format from its current ext2ness.

-
