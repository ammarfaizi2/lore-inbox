Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311509AbSCNFXR>; Thu, 14 Mar 2002 00:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311519AbSCNFXH>; Thu, 14 Mar 2002 00:23:07 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:53514
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S311509AbSCNFW4>; Thu, 14 Mar 2002 00:22:56 -0500
Date: Wed, 13 Mar 2002 21:21:28 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.5.6: ide driver broken in PIO mode
In-Reply-To: <E16lHNF-0007eO-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10203132108100.21396-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2002, Alan Cox wrote:

> > b) The block layer needs to be extended so the driver can walk
> >    all the request's segments prior to signalling completion
> >    against any of them.
> 
> This would be good - batching blocks by peeking down the queue is good
> for raid cards which tend to want stripe sized chunks
> 

Thank you Alan for the kind words.

Would you agree having the ablity to mark various BIOS' in process but not
retrun them back to the upper layers until the device driver can be
positive of a successful transfer?

The suggestion I put forward over many nights with the brillant Suparna,
was to create an in process marker on the a BIO handed to the driver.
She had enough guts to try out the idea but there still was a piece
missing.  We determined the needed part is an second path the do the
update delays and another function to clear any hold on the BIO for
release back to the top layers.

This has been my request from the beginning of BIO but not in the exact
words.  BIO does not address the granularity of the the hardware segment.
It does address all DMA transfers, but then again there are no partial
completions for the most part.  DMA speed is vastly quicker than PIO and
it is not possible to do partial updates in any sane way.

So what I am gathering from Alan is other hardware would benefit from this
feature/requirement.  Maybe now something will move forward.

Cheers,

Andre

