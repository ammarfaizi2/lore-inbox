Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312799AbSDSSP2>; Fri, 19 Apr 2002 14:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312834AbSDSSP1>; Fri, 19 Apr 2002 14:15:27 -0400
Received: from waste.org ([209.173.204.2]:62670 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S312799AbSDSSP0>;
	Fri, 19 Apr 2002 14:15:26 -0400
Date: Fri, 19 Apr 2002 13:15:13 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Andrew Morton <akpm@zip.com.au>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Peloquin <peloquin@us.ibm.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Bio pool & scsi scatter gather pool usage
In-Reply-To: <3CBF5B67.E488A8E5@zip.com.au>
Message-ID: <Pine.LNX.4.44.0204191305560.8537-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Apr 2002, Andrew Morton wrote:

> Alan Cox wrote:
> >
> > > Perhaps, but calls are expensive. Repeated calls down stacked block
> > > devices will add up. In only the most unusually cases will there
> >
> > You don't need to repeatedly query. At bind time you can compute the
> > limit for any device heirarchy and be done with it.
> >
>
> S'pose so.  The ideal request size is variable, based
> on the alignment.  So for exampe if the start block is
> halfway into a stripe, the ideal BIO size is half a stripe.
>
> But that's a pretty simple table to generate once-off,
> as you say.

Perhaps we can return request size _and_ stripe alignment at bind time.
Then we can do the right thing for RAID/LVM/etc in a pretty
straightforward manner.  LVMs of RAIDs can return an GCD(LVM stripe, RAID
stripe) and non-striped devices can return 0 to indicate no restrictions.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

