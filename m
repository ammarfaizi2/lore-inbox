Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264971AbSKETDc>; Tue, 5 Nov 2002 14:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264990AbSKETDc>; Tue, 5 Nov 2002 14:03:32 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:39662 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S264971AbSKETD3>; Tue, 5 Nov 2002 14:03:29 -0500
From: Andreas Dilger <adilger@clusterfs.com>
Date: Tue, 5 Nov 2002 12:07:41 -0700
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: bert hubert <ahu@ds9a.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tytso@mit.edu
Subject: Re: naive but spectacular ext3 HTREE+Orlov benchmark
Message-ID: <20021105190741.GC588@clusterfs.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	bert hubert <ahu@ds9a.nl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	tytso@mit.edu
References: <20021105151702.GA5894@outpost.ds9a.nl> <1036512604.4827.93.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036512604.4827.93.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 05, 2002  16:10 +0000, Alan Cox wrote:
> On Tue, 2002-11-05 at 15:17, bert hubert wrote:
> > Congratulations everybody, this is a major result! You can in fact *hear*
> > the difference. With the Orlov allocator, seeks are much more higher pitched
> > as if they are generally over shorter distances - which they probably are.
> 
> How does the Orlov allocator do if you continually randomly use and
> reuse the file space for a long period of time - the current allocator
> is pretty stable, does Orlov behave the same or degenerate ?

AKPM did some simulated testing of this and it wasn't too bad, but there
is of course a tradeoff.  If you pack your files more closely to improve
short term performance, you can cause additional fragmentation in the
future, if some of those files are randomly deleted.

However, I don't think the orlov allocator is "FAT-like" and just fills up
everything sequentially.

What would be an interesting test, let's say, would be lcloning the very
base 2.4.0 BK repository, and then applying all of the changesets in
sequence (or the equivalent with tarballs and patches), and timing
"make" between each run (if there was a way to flush the page cache for
that filesystem it would be very helpful).  This will easily simulate
a long-life directory tree in a very reproducable and quantitative way.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

