Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317498AbSFDNbd>; Tue, 4 Jun 2002 09:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317499AbSFDNbc>; Tue, 4 Jun 2002 09:31:32 -0400
Received: from 216-42-72-145.ppp.netsville.net ([216.42.72.145]:11404 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S317498AbSFDNbc>; Tue, 4 Jun 2002 09:31:32 -0400
Subject: Re: Caching files in nfsd was Re: [patch 12/16] fix race between
	writeback and unlink
From: Chris Mason <mason@suse.com>
To: Andi Kleen <ak@suse.de>
Cc: Neil Brown <neilb@cse.unsw.edu.au>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020604141649.A29334@wotan.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 04 Jun 2002 09:29:44 -0400
Message-Id: <1023197384.2920.97.camel@tiny>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-06-04 at 08:16, Andi Kleen wrote:
> > The only issue that I can see (except for simple coding) is that as
> > NFS cannot be precise about closing at the *right* time we would be
> > changing from closing too early (and so re-opening) to closing too
> > late.
> > Would this be an issue for any filesystem?  My feeling is not, but I'm
> > open to opinions....
> 
> The only potential issue I see is that forcing a flush when the file system
> fills up may be a good idea to drop preallocations (but then one would hope 
> that a fs with preallocation does this already automatically, so it hopefully 
> won't be needed in nfsd) 

reiserfs does, but I'm not sure about ext2.  reiserfs doesn't carry
preallocated blocks from one transaction to another.  So when the
transaction closes, we free preallocated blocks.

When the FS runs out of space, we stop the transaction to give everyone
a chance to free up what they can (not just preallocation), and then
start a new transaction.  So nfs closing too late won't hurt.

-chris

