Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130903AbRCVRVr>; Thu, 22 Mar 2001 12:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131279AbRCVRVi>; Thu, 22 Mar 2001 12:21:38 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:5297 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130903AbRCVRVc>;
	Thu, 22 Mar 2001 12:21:32 -0500
Date: Thu, 22 Mar 2001 12:20:48 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: lock_kernel() usage and sync_*() functions
In-Reply-To: <20010322154544.B11126@nightmaster.csn.tu-chemnitz.de>
Message-ID: <Pine.GSO.4.21.0103221207110.5619-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 22 Mar 2001, Ingo Oeser wrote:

> Could we remove the "magic" sync_flag from the exported interface?

Sure. But I seriously suspect that sync_dev() is wrong in 100% of cases.
So "flag" is eventually going to become "do we want to sync it or not?"
thing. However, I don't want to deal with that sort of analysis right now -
callers are in drivers/* and we are in even branch.
 
> Do sth. like renaming your invalidate_dev() to
> _invalidate_dev() and adding 3 defines:
> 
> #define invalidate_dev(dev) _invalidate_dev(dev,0)
> #define invalidate_dev_sync(dev) _invalidate_dev(dev,1)
> #define invalidate_dev_fsync(dev) _invalidate_dev(dev,2)
> 
> This would make it quite clear, what will be done.
> 
> AFAIR Linus dosn't like these magic numers either, right?

I also don't like them. I _don't_ believe that magic #defines are
any better, though. And I would rather localize the get_super() to
kernel proper preserving the current behaviour and left dealing
with the sync vs. fsync to 2.5. It's easy to grep and if my gut
feeling is correct your invalidate_dev_sync() is going to be a ballast.

Again, for 2.4 I would rather do a change that obviously doesn't
change behaviour of drivers, doesn't add functions without need
and is easy to review once drivers become a fair game again (== in 2.5).
Comments?
							Cheers,
								Al

