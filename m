Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272501AbRIKP7y>; Tue, 11 Sep 2001 11:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272507AbRIKP7o>; Tue, 11 Sep 2001 11:59:44 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:28164 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S272501AbRIKP7j>; Tue, 11 Sep 2001 11:59:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: linux-2.4.10-pre5
Date: Tue, 11 Sep 2001 18:07:03 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Rik van Riel <riel@conectiva.com.br>,
        Andreas Dilger <adilger@turbolabs.com>,
        Andrea Arcangeli <andrea@suse.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0109110843010.8078-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0109110843010.8078-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010911155953Z16272-1367+16@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 11, 2001 05:48 pm, Linus Torvalds wrote:
> On Tue, 11 Sep 2001, Daniel Phillips wrote:
> >
> > But see my post in this thread where I created a simple test to show that,
> > even when we pre-read *all* the inodes in a directory, there is no great
> > performance win.
> 
> Note that I suspect that because the inode tree _is_ fairly dense, you
> don't actually need to do much read-ahead in most cases. Simply because
> you automatically do read-ahead _always_: when somebody reads a 128-byte
> inode, you (whether you like it or not) always "read-ahead" the 31 inodes
> around it on a 4kB filesystem.
> 
> So we _already_ do read-ahead by a "factor of 31". Whether we can improve
> that or not by increasing it to 63 inodes, who knows?
> 
> I actually think that the "start read-ahead for inode blocks when you do
> readdir" might be a bigger win, because that would be a _new_ kind of
> read-ahead that we haven't done before, and might improve performance for
> things like "ls -l" in the cold-cache situation..

But wait, if our theories are correct then the disk is doing physical 
readahead anyway, and its a nice scsi disk with lots of cache, so *why does 
it take so long to read the metadata*?  It's about 11,000 files, that's 
1.3Meg of inodes and just a couple hundred K of directories.

There is clearly something nonoptimal about the hardware readahead and/or 
caching.

> (Although again, because the inode is relatively small to the IO cache
> size, it's probably fairly _hard_ to get a fully cold-cache inode case. So
> I'm not sure even that kind of read-ahead would actually make any
> difference at all).

--
Daniel
