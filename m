Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317283AbSHAWgT>; Thu, 1 Aug 2002 18:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317287AbSHAWgT>; Thu, 1 Aug 2002 18:36:19 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:6129 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S317283AbSHAWgS>;
	Thu, 1 Aug 2002 18:36:18 -0400
Date: Thu, 1 Aug 2002 18:39:37 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: martin@dalecki.de
cc: Petr Vandrovec <vandrove@vc.cvut.cz>, linux-kernel@vger.kernel.org,
       mingo@elte.hu
Subject: Re: IDE from current bk tree, UDMA and two channels...
In-Reply-To: <3D49B29D.1090702@evision.ag>
Message-ID: <Pine.GSO.4.21.0208011836490.12627-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 2 Aug 2002, Marcin Dalecki wrote:

> > I'd like to apologize to Ingo, his changes were completely innocent.
> > Problem was triggered by Al's 'block device size cleanups' (currently
> > cset 1.403.160.5 on bkbits).
> > 
> > Before this change, my system was using 4KB block size when reading
> > from /dev/hdc1, because of blk_size[][] (which is in 1kB units) of this 
> > partition was multiple of 2, and so i_size % 4096 was 0.  But after
> > Al's change partition size is read from gendisk, and not from blk_size,
> > and gendisk partition size is in 512 bytes units: and, as you can
> > probably guess, now my partition had i_size % 4096 == 512, and so only
> > 512 byte block size was choosen. And with 512 bytes block size my
> > harddisk refuses to cooperate.

Uh-oh...

Let me see if I got it straight:

a) your disk doesn't work with half-Kb requests
b) you have a partition with odd number of sectors
c) hardsect_size is set to half-Kb
d) old code worked since it rounded size to multiple of kilobyte.

Correct?

