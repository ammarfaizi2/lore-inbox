Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317552AbSGORp3>; Mon, 15 Jul 2002 13:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317559AbSGORp2>; Mon, 15 Jul 2002 13:45:28 -0400
Received: from noc.easyspace.net ([62.254.202.67]:10003 "EHLO
	noc.easyspace.net") by vger.kernel.org with ESMTP
	id <S317552AbSGORp2>; Mon, 15 Jul 2002 13:45:28 -0400
Date: Mon, 15 Jul 2002 18:48:05 +0100
From: Sam Vilain <sam@vilain.net>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: dax@gurulabs.com, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
In-Reply-To: <20020715160357.GD442@clusterfs.com>
References: <1026490866.5316.41.camel@thud>
	<1026679245.15054.9.camel@thud>
	<E17U1BD-0000m0-00@hofmann>
	<1026736251.13885.108.camel@irongate.swansea.linux.org.uk>
	<E17U4YE-0000TL-00@hofmann>
	<20020715160357.GD442@clusterfs.com>
X-Mailer: Sylpheed version 0.7.8claws (GTK+ 1.2.10; i386-debian-linux-gnu)
X-Face: NErb*2NY4\th?$s.!!]_9le_WtWE'b4;dk<5ot)OW2hErS|tE6~D3errlO^fVil?{qe4Lp_m\&Ja!;>%JqlMPd27X|;b!GH'O.,NhF*)e\ln4W}kFL5c`5t'9,(~Bm_&on,0Ze"D>rFJ$Y[U""nR<Y2D<b]&|H_C<eGu?ncl.w'<
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E17U9x9-0001Dc-00@hofmann>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger <adilger@clusterfs.com> wrote:

> Amusingly, there IS directory hashing available for ext2 and ext3, and
> it is just as fast as reiserfs hashed directories.  See:
>    http://people.nl.linux.org/~phillips/htree/paper/htree.html

You learn something new every day.  So, with that in mind - what has reiserfs got that ext2 doesn't?

  - tail merging, giving much more efficient space usage for lots of small
    files.
  - B*Tree allocation offering ``a 1/3rd reduction in internal
    fragmentation in return for slightly more complicated insertions and
    deletion algorithms'' (from the htree paper).
  - online resizing in the main kernel (ext2 needs a patch -
    http://ext2resize.sourceforge.net/).
  - Resizing does not require the use of `ext2prepare' run on the
    filesystem while unmounted to resize over arbitrary boundaries.
  - directory hashing in the main kernel

On the flipside, ext2 over reiserfs:

  - support for attributes without a patch or 2.4.19-pre4+ kernel
  - support for filesystem quotas without a patch
  - there is a `dump' command (but it's useless, because it hangs when you
    run it on mounted filesystems - come on, who REALLY unmounts their
    filesystems for a nightly dump?  You need a 3 way mirror to do it
    while guaranteeing filesystem availability...)

I'd be very interested in seeing postmark results without the hierarchical directory structure (which an unpatched postfix doesn't support), with about 5000 mailboxes with and without the htree patch (or with the htree patch but without that directory indexed, if that is possible).
--
   Sam Vilain, sam@vilain.net     WWW: http://sam.vilain.net/
    7D74 2A09 B2D3 C30F F78E      GPG: http://sam.vilain.net/sam.asc
    278A A425 30A9 05B5 2F13

  Try to be the best of what you are, even if what you are is no good.
ASHLEIGH BRILLIANT
