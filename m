Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129124AbRBFUUC>; Tue, 6 Feb 2001 15:20:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129219AbRBFUTv>; Tue, 6 Feb 2001 15:19:51 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:1451 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129124AbRBFUTo>; Tue, 6 Feb 2001 15:19:44 -0500
Date: Tue, 6 Feb 2001 15:16:44 -0500 (EST)
From: Ben LaHaise <bcrl@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        <kiobuf-io-devel@lists.sourceforge.net>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <Pine.LNX.4.30.0102062045350.8926-100000@elte.hu>
Message-ID: <Pine.LNX.4.30.0102061450590.15204-100000@today.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Feb 2001, Ingo Molnar wrote:

>
> On Tue, 6 Feb 2001, Ben LaHaise wrote:
>
> > > > You mentioned non-spindle base io devices in your last message.  Take
> > > > something like a big RAM disk. Now compare kiobuf base io to buffer
> > > > head based io. Tell me which one is going to perform better.
> > >
> > > roughly equal performance when using 4K bhs. And a hell of a lot more
> > > complex and volatile code in the kiobuf case.
> >
> > I'm willing to benchmark you on this.
>
> sure. Could you specify the actual workload, and desired test-setups?

Sure.  General parameters will be as follows (since I think we both have
access to these machines):

	- 4xXeon, 4GB memory, 3GB to be used for the ramdisk (enough for a
	  base install plus data files.
	- data to/from the ram block device must be copied within the ram
	  block driver.
	- the filesystem used must be ext2.  optimisations to ext2 for
	  tweaks to the interface are permitted & encouraged.

The main item I'm interested in is read (page cache cold)/synchronous
write performance for blocks from 256 bytes to 16MB in powers of two, much
like what I've done in testing the aio patches that shows where
improvement in latency is needed.  Including a few other items on disk
like the timings of find/make -s dep/bonnie/dbench is probably to show
changes in throughput.  Sound fair?

		-ben

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
