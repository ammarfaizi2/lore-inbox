Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278551AbRJXPRE>; Wed, 24 Oct 2001 11:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278567AbRJXPQy>; Wed, 24 Oct 2001 11:16:54 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:56076 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S278556AbRJXPQi>; Wed, 24 Oct 2001 11:16:38 -0400
Date: Wed, 24 Oct 2001 17:16:58 +0200
From: Jan Kara <jack@suse.cz>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: RFC - tree quotas for Linux (2.4.12, ext2)
Message-ID: <20011024171658.B10075@atrey.karlin.mff.cuni.cz>
In-Reply-To: <15310.25406.789271.793284@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15310.25406.789271.793284@notabene.cse.unsw.edu.au>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

>  In my ongoing effort to provide centralised file storage that I can
>  be proud of, I have put together some code to implement tree quotas.
> 
>  The idea of a tree quota is that the block and inode usage of a file
>  is charged to the (owner of the root of the) tree rather than the
>  owner (or group owner) of the file.
>  This will (I hope) make life easier for me.  There are several
>  reasons that I have documented (see URL below) but a good one is that
>  they are transparent and predictable.  du -s $HOME should *always*
>  match your usage according to "quota".
> 
>  I have written a patch which is included below, but also is at
>     htttp://www.cse.unsw.edu.au/~neilb/patches/linux/
> 
>  which defines a third type of quotas for Linux, named "treequotas".
>  The patch supports these quotas for ext2 by borrowing (or is that
>  stealing) i_reserved2 from the on-disc inode to store the "tid",
>  which is the uid of the ultimate non-root parent of the file.
> 
>  There are obvious issues with hardlinks between trees with different
>  tree-ids, but they can be easily restricted to root who should know
>  better.
> 
>  The patch introduces the concept of a "Treeid" or "tid" which is
>  inherited from the parent, if not zero, or set from the uid
>  otherwise.
>  Thus if root creates a directory near the top of a filesystem and
>  chowns it to someone, all files created beneath that directory,
>  independant of ownership, get charged to the someone (for the purpose
>  of treequotaing).
  But how do you solve the following: mv <dir> <some_other_dir>
The parent changes. You need to go through all the subdirs of <dir> and change
the TID. This is really hard to get right and to avoid deadlocks
and races... At least it seems to me so.

									Honza
