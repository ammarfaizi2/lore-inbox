Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267361AbRGPNQC>; Mon, 16 Jul 2001 09:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267355AbRGPNPw>; Mon, 16 Jul 2001 09:15:52 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:30478 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S267351AbRGPNPj>; Mon, 16 Jul 2001 09:15:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Chris Wedgwood <cw@f00f.org>, "Justin T. Gibbs" <gibbs@scsiguy.com>
Subject: Re: [PATCH] 64 bit scsi read/write
Date: Mon, 16 Jul 2001 15:19:39 +0200
X-Mailer: KMail [version 1.2]
Cc: "Jonathan Lundell <jlundell@pobox.com> Alan Cox" <alan@lxorguk.ukuu.org.uk>,
        Andrew Morton <andrewm@uow.edu.au>,
        Andreas Dilger <adilger@turbolinux.com>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Ben LaHaise <bcrl@redhat.com>,
        Ragnar Kjxrstad <kernel@ragnark.vestdata.no>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mike@bigstorage.com, kevin@bigstorage.com, linux-lvm@sistina.com
In-Reply-To: <200107151747.f6FHlAU60256@aslan.scsiguy.com> <20010716205633.G11938@weta.f00f.org>
In-Reply-To: <20010716205633.G11938@weta.f00f.org>
MIME-Version: 1.0
Message-Id: <01071615193905.06482@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 July 2001 10:56, Chris Wedgwood wrote:
> On Sun, Jul 15, 2001 at 11:47:10AM -0600, Justin T. Gibbs wrote:
>
>     Simply disabling the write cache does not guarantee the order of
>     writes.  For one, with tagged I/O and the use of the SIMPLE_Q tag
>     qualifier, commands may be completed in any order.  If you want
>     some semblance of order, either disable the write cache or use
> the FUA bit in all writes, and use the ORDERED tag qualifier.  Even
> when using these options, it is not clear that the drive cannot
> reorder writes "slightly" to make track writes more efficient (e.g.
> two separate commands to write sequential sectors on the same track
> may be written in reverse order).
>
> ORDERED sounds like the trick...  I assume this is some kind of
> write-barrier? If so, then I assume it has some kind of strict
> temporal ordering, even between command issues to the drive.
>
> If so, that would be idea if we can have the fs communicate this all
> the way down to the device layer, making it work for soft-raid and
> LVM be a little harder perhaps.

There was general agreement amongst filesystem developers at San Jose
that we need some kind of internal interface at the filesystem level
for this, independent of the type of underlying block device - IDE,
SCSI or "other".  That's as far as it got.

--
Daniel
