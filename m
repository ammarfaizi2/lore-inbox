Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267088AbRGOWKw>; Sun, 15 Jul 2001 18:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267101AbRGOWKn>; Sun, 15 Jul 2001 18:10:43 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:22029 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S267088AbRGOWKc>; Sun, 15 Jul 2001 18:10:32 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "Ken Hirsch" <kenhirsch@myself.com>, "Chris Wedgwood" <cw@f00f.org>,
        "John Alvord" <jalvo@mbay.net>
Subject: Re: [PATCH] 64 bit scsi read/write
Date: Mon, 16 Jul 2001 00:14:21 +0200
X-Mailer: KMail [version 1.2]
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
        "Andrew Morton" <andrewm@uow.edu.au>,
        "Andreas Dilger" <adilger@turbolinux.com>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        "Ben LaHaise" <bcrl@redhat.com>,
        "Ragnar Kjxrstad" <kernel@ragnark.vestdata.no>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mike@bigstorage.com>, <kevin@bigstorage.com>, <linux-lvm@sistina.com>
In-Reply-To: <Pine.LNX.4.20.0107142304010.17541-100000@otter.mbay.net> <20010715180752.B7993@weta.f00f.org> <005501c10d30$54e0e260$7c853dd0@hppav>
In-Reply-To: <005501c10d30$54e0e260$7c853dd0@hppav>
MIME-Version: 1.0
Message-Id: <01071600142101.06482@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 15 July 2001 15:16, Ken Hirsch wrote:
> Chris Wedgwood <cw@f00f.org> wrote:
> > On Sat, Jul 14, 2001 at 11:05:36PM -0700, John Alvord wrote:
> > >
> > >     In the IBM solution to this (1977-78, VM/CMS) the critical data
> > > was written at the begining and the end of the block. If the two
> > > data items didn't match then the block was rejected.
> >
> > Neat.
> >
> > Simple and effective.  Presumably you can also checksum the block,
> > and check that.
>
> The first technique is not sufficient with modern disk controllers,
> which may reorder sector writes within a block.  A checksum,
> especially a robust CRC32, is sufficient, but rather expensive.

As somebody else pointed out, not if you don't have to compute it on
every block, as with journalling or atomic commit.

> Mohan has a clever technique that is computationally trivial and only
> uses one bit per sector:
> http://www.almaden.ibm.com/u/mohan/ICDE95.pdf
>
> Unfortunately, it's also patented:
> http://www.delphion.com/details?pn=US05418940__

Fortunately, it's clunky and unappealing compared to the simple 
checksum method, applied only to those blocks that define consistency
points.  I don't think this is patented.  I'd be disturbed if it was,
since it's obvious.

> Perhaps IBM will clarify their position with respect to free software
> and patents in the upcoming conference.

Wouldn't that be nice.  Imagine, IBM comes out and says, we admit it,
patents are a net burden on everybody, even us - from now on, we use
them only against those who use them against us, and we'll put that
in writing.  Right.

--
Daniel
