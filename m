Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277751AbRJRPnr>; Thu, 18 Oct 2001 11:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277774AbRJRPnh>; Thu, 18 Oct 2001 11:43:37 -0400
Received: from mail.science.uva.nl ([146.50.4.51]:5033 "EHLO
	mail.science.uva.nl") by vger.kernel.org with ESMTP
	id <S277756AbRJRPnY>; Thu, 18 Oct 2001 11:43:24 -0400
X-Organisation: Faculty of Science, University of Amsterdam, The Netherlands
X-URL: http://www.science.uva.nl/
Date: Thu, 18 Oct 2001 17:42:44 +0200 (CEST)
From: Kamil Iskra <kamil@science.uva.nl>
To: Andreas Dilger <adilger@turbolabs.com>
cc: Steve Kieu <haiquy@yahoo.com>, kernel <linux-kernel@vger.kernel.org>
Subject: Re: Poor floppy performance in kernel 2.4.10
In-Reply-To: <20011018092837.C1144@turbolinux.com>
Message-ID: <Pine.LNX.4.33.0110181734270.7583-100000@krakow.science.uva.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2001, Andreas Dilger wrote:

> > The behaviour is as if no caching was done,
> > there is a slowdown by a factor of two.
> I think this is a result of the "blockdev in pagecache" change added in
> 2.4.10.  One of the byproducts of this change is that if a block device
> is closed (no other openers) then all of the pages from this device are
> dropped from the cache.  In the case of a floppy drive, this is very
> important, as you don't want to be cacheing data from one floppy after
> you have inserted a new floppy.
>
> In contrast, if you mounted the floppy instead of using mtools, it would
> probably have good performance for small files as well.

That's very interesting.  It would explain why it takes 2 seconds _every_
time you invoke "mdir", whereas before the invocations after the first one
were more or less instantenous.  And indeed, as you say, mounting a floppy
does result in a good performance.

However, it does not explain why the first invocation is two times slower
(it's 1 sec with kernel 2.4.9 and 2 secs with 2.4.10, the effect is even
more visible for mcopy of a small file, like 30KB).  I strace'd mdir and
it's opening /dev/fd0 just once, at the beginning, and closing it at the
end.

Regards,

-- 
Kamil Iskra                 http://www.science.uva.nl/~kamil/
Section Computational Science, Faculty of Science, Universiteit van Amsterdam
kamil@science.uva.nl  tel. +31 20 525 75 35  fax. +31 20 525 74 90
Kruislaan 403  room F.202  1098 SJ Amsterdam  The Netherlands

