Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273180AbRIJD3E>; Sun, 9 Sep 2001 23:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273181AbRIJD2y>; Sun, 9 Sep 2001 23:28:54 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:14859 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S273180AbRIJD2s>; Sun, 9 Sep 2001 23:28:48 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Chris Mason <mason@suse.com>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: linux-2.4.10-pre5
Date: Mon, 10 Sep 2001 05:36:07 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Andreas Dilger <adilger@turbolabs.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20010910001556Z16150-26183+680@humbolt.nl.linux.org> <20010910023312Z16066-26183+700@humbolt.nl.linux.org> <1381380000.1000090938@tiny>
In-Reply-To: <1381380000.1000090938@tiny>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010910032901Z16134-26183+710@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 10, 2001 05:02 am, Chris Mason wrote:
> On Monday, September 10, 2001 04:40:21 AM +0200 Daniel Phillips
> <phillips@bonn-fries.net> wrote:
> 
> >> How about subsequent calls for the same offset with the same blocksize
> >> need to return the same buffer head?
> > 
> > Are we picking nits?  Better add "the same dev" and "until the buffer
> > head is  freed" ;-)
> 
> ;-)  Really, wasn't trying for that.  If we just say later calls for the
> same offset, we get in trouble later on if we also want variable, very
> large blocksizes.

Well, I really wonder if buffers are the right transport medium for variable, 
large blocks, aka extents.  Personally, I think buffers will have disappeared 
or mutated unrecognizably by the time we get around to adding extents to ext2 
or its descendents.  Note that XFS already implements extents on Linux, by 
mapping them onto the pagecache I believe.

> If we relax the rules to allow multiple buffer heads for
> the same physical spot on disk, things get easier, and the FS is
> responsible for not doing something stupid with it.  
> 
> The data is still consistent either way, there are just multiple io handles.

Were you thinking of one mapping for all buffers on a given partition?  If 
so, how did you plan to handle different buffer sizes?  Were you planning to 
keep the existing buffer hash chain or use the page cache hash chain, as I 
did for ext2_getblk?

--
Daniel
