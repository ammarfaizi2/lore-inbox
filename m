Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317842AbSFSKho>; Wed, 19 Jun 2002 06:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317844AbSFSKhn>; Wed, 19 Jun 2002 06:37:43 -0400
Received: from pc-62-31-66-56-ed.blueyonder.co.uk ([62.31.66.56]:31360 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S317842AbSFSKhl>; Wed, 19 Jun 2002 06:37:41 -0400
Date: Wed, 19 Jun 2002 11:37:34 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, DervishD <raul@pleyades.net>,
       Linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net
Subject: Re: Shrinking ext3 directories
Message-ID: <20020619113734.D2658@redhat.com>
References: <20020618225005.A7897@redhat.com> <Pine.GSO.4.21.0206181812220.13571-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.21.0206181812220.13571-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Tue, Jun 18, 2002 at 06:18:49PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 18, 2002 at 06:18:49PM -0400, Alexander Viro wrote:
 
> IOW, making sure that empty blocks in the end of directory get freed
> is a matter of 10-20 lines.  If you want such patch - just tell, it's
> half an hour of work...

It's certainly easier at the tail, but with htree we may have
genuinely enormous directories and being able to hole-punch arbitrary
coalesced blocks could be a huge win.  Also, doing the coalescing
block by block is likely to be far easier for ext3 than truncating
the directory arbitrarily back in one go.  

Chopping a large directory at once brings back the truncate()
nightmare of having to make an unbounded disk operation seem atomic,
even if it has to get split over multiple transactions.  Incremental
coalescing should allow us to know in advance how many disk blocks we
might end up touching for the operation, so we can guarantee to do it
in one transaction.

Cheers,
 Stephen

