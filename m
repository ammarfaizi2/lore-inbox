Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291752AbSBHTWY>; Fri, 8 Feb 2002 14:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291753AbSBHTWO>; Fri, 8 Feb 2002 14:22:14 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:58346 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S291752AbSBHTWD>;
	Fri, 8 Feb 2002 14:22:03 -0500
Date: Fri, 8 Feb 2002 14:21:58 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andrew Morton <akpm@zip.com.au>, Martin Wirth <Martin.Wirth@dlr.de>,
        Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org,
        mingo@elte.hu, haveblue@us.ibm.com
Subject: Re: [RFC] New locking primitive for 2.5
In-Reply-To: <Pine.LNX.4.31.0202081110190.12981-100000@cesium.transmeta.com>
Message-ID: <Pine.GSO.4.21.0202081416410.28514-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Feb 2002, Linus Torvalds wrote:

> ... so just make it a spinlock instead.
> 
> The semaphore is overkill, as the only thing we're really protecting is
> one 64-bit access against other updates.

I'm not sure that we really need a separate spinlock here.  BKL might
be just fine, provided that we remove it from real hogs.  And we can
do it now.

Had anyone actually seen lseek() vs. lseek() contention prior to the
switch to ->i_sem-based variant?  If the mix looked like
	infrequently called BKL hog + many lseeks()
almost all contention cases would have lseek() spinning while
a hog holds BKL.  And real problem here is a hog...

