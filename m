Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130250AbQKNSzv>; Tue, 14 Nov 2000 13:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130767AbQKNSzm>; Tue, 14 Nov 2000 13:55:42 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:60169 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S130250AbQKNSzX>; Tue, 14 Nov 2000 13:55:23 -0500
Date: Tue, 14 Nov 2000 19:25:22 +0100
From: Jan Kara <jack@atrey.karlin.mff.cuni.cz>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Used space in bytes
Message-ID: <20001114192522.A18870@atrey.karlin.mff.cuni.cz>
In-Reply-To: <CD940355CE7@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <CD940355CE7@vcnet.vc.cvut.cz>; from VANDROVE@vc.cvut.cz on Tue, Nov 14, 2000 at 06:55:13PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On 14 Nov 00 at 18:39, Jan Kara wrote:
> >   Hello.
> > 
> > > On  9 Nov 00 at 19:18, Jan Kara wrote:
> > > > used (I tried to contact Ulrich Drepper <drepper@redhat.com> who should
> > > > be right person to ask about such things (at least I was said so) but go
> > > > no answer...). Does anybody have any better solution?
> > > >   I know about two others - really ugly ones:
> > > >    1) fs specific ioctl()
> > > >    2) compute needed number of bytes from st_size and st_blocks, which is
> > > >       currently possible but won't be in future
> > > 
> > > If I may, please do not add it into stat/stat64 structure. On Netware, 
> > > computing really used space can take eons because of it has to read 
> > > allocation tables to memory to find size. It is usually about 500% 
> > > slower than retrieving all other file informations.
> >   And how do you fill in st_blocks field?
> 
> Currently as st_size / st_blksize. If I'll want to report real used size,
> so that quotas could be built on the top of Netware space restrictions,
> Netware is willing to return size in its allocation blocks after holes 
> and compression takes place, but while computation time is afforable for 
> open(), it is not for stat()ing thousands of entries in directories.
  Hmm.. But that's problem as 'quotacheck' uses stat to get space used by
file... So it won't work on Netware anyway.

							Honza

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
