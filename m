Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275758AbRJ2OFz>; Mon, 29 Oct 2001 09:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275743AbRJ2OFr>; Mon, 29 Oct 2001 09:05:47 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:38162 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S275301AbRJ2OFe>; Mon, 29 Oct 2001 09:05:34 -0500
Date: Mon, 29 Oct 2001 15:06:02 +0100
From: Jan Kara <jack@suse.cz>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: RFC - tree quotas for Linux (2.4.12, ext2)
Message-ID: <20011029150602.G11994@atrey.karlin.mff.cuni.cz>
In-Reply-To: <15310.25406.789271.793284@notabene.cse.unsw.edu.au> <20011024171658.B10075@atrey.karlin.mff.cuni.cz> <15319.12709.29314.342313@notabene.cse.unsw.edu.au> <20011025174815.C4644@atrey.karlin.mff.cuni.cz> <15320.59456.565780.111066@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15320.59456.565780.111066@notabene.cse.unsw.edu.au>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > So the only possibility that I see is that each time you read the inode
> > you check whether its TID is OK. But that means going through dirs everytime
> > you read some inode which doesn't look nice to me...
> > 
> 
> Have a look at the code and see where treequota_check is called.
> 
> It is called every time a "lookup" is done, whether the result is in
> the cache or not.  If the lookup found something, then you have a
> inode and it's parent right there in the cache.  treequota_check
> checks that the tid of the child matches that of the parent, and
> changes it if not.  So the overhead is very small for the common case
> where the tid is correct.
> 
> It just tests:
>    is inode NULL
>    are treequotas enabled for this inode
>    does the tid of the child match that of the parent (or the uid of
>            the child if parent.tid==0
  OK. I've seen the code and I agree it's not real problem.

> > > 
> > > It is, I think, the 'best' solution that is possible.
> >   I also don't see a better solution but I'm not sure this solution is good
> > enough to be implemented (to me it looks more like a hack than a regular
> > part of system...).
> 
> I accept that it does look like a bit of a hack.
> But I think it is simple, understandable, and predictable.
> And I think that (for me) the value of tree quotas is more than enough
> to offset that cost.
  I just don't like the idea that when you do lookup you can suddenly get
Disk quota exceeded... I'd concern this behaviour a bit nonintuitive. I agree
that if root makes lookup of every file after moving directories then this
doesn't happen but still I don't like the design :).

									Honza

--
Jan Kara <jack@suse.cz>
SuSE CR Labs
