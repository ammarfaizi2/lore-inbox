Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263612AbTJ0W2K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 17:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263618AbTJ0W2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 17:28:10 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:49156
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S263612AbTJ0W2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 17:28:05 -0500
Date: Mon, 27 Oct 2003 14:27:09 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: jw schultz <jw@pegasys.ws>
cc: linux-kernel@vger.kernel.org
Subject: Re: Blockbusting news, results end
In-Reply-To: <20031027205854.GF8540@pegasys.ws>
Message-ID: <Pine.LNX.4.10.10310271425000.14405-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


To date IDEMA has not released a formal spec for drive makers to switch to
4Kb sectors.  If they have, then when running in compatibility mode, a
heavy read-modify-write happens to goto the pseudo sector of 512b.

Linux can not handled new IDEMA calls currently.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Mon, 27 Oct 2003, jw schultz wrote:

> On Sun, Oct 26, 2003 at 08:25:26PM +0900, Norman Diamond wrote:
> > Pavel Machek replied to me:
> > 
> > > > The drive finally reallocated the block and there are no longer any
> > > > visible bad blocks.
> > >
> > > And what was the operation that made it realocate?
> > 
> > At first I wasn't sure.  I noticed that the drive was behaving differently
> > when I told dd to use bs=4096 instead of 512.  Until seeing Oleg Drokin's
> > message about ReiserFS, I thought that the drive itself was doing something
> > differently.  That didn't make much sense to me because the physical sectors
> > are much longer than 4096 and the pseudo-sectors are the conventional 512,
> > so why did 4096 cause different behaviour?  From Oleg Drokin's message, I
> > guess that the use of 4096 might make a difference in the sequence of
> > read-modify-write cycles involved in the logical write operation.
> 
> You bring up an interesting point.  If the physical sector
> is larger than the data being written how can the drive
> reallocate the sector without silently losing data?
> 
> To put it in the concrete, if the physical sector were 16K
> and we only do a 4K write and there is a unrecoverable read
> error on the physical sector as part of the
> read-modify-write sequence what is the drive to do?  The
> other 12K for which the drive has no data could be other
> files not related to the 4K being written or even filesystem
> meta-data.  Reallocation in that case would cause silent
> corruption.
> 
> Perhaps what finally allowed the reallocation was that the
> entire physical sector finally accumulated writes to all the
> logical sectors needed to be a complete physical sector
> write.
> 
> -- 
> ________________________________________________________________
> 	J.W. Schultz            Pegasystems Technologies
> 	email address:		jw@pegasys.ws
> 
> 		Remember Cernan and Schmitt
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

