Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317887AbSHLLwZ>; Mon, 12 Aug 2002 07:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317888AbSHLLwZ>; Mon, 12 Aug 2002 07:52:25 -0400
Received: from B5220.pppool.de ([213.7.82.32]:45229 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S317887AbSHLLwY>; Mon, 12 Aug 2002 07:52:24 -0400
Subject: Re: mmapping large files hits swap in 2.4?
From: Daniel Egger <degger@fhm.edu>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D577BC3.5BD0DE4@aitel.hist.no>
References: <Pine.LNX.4.33.0208101437380.838-100000@coffee.psychology.mcmaster.ca>
	<1029018000.2539.7.camel@sonja.de.interearth.com> 
	<3D577BC3.5BD0DE4@aitel.hist.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 12 Aug 2002 13:41:56 +0200
Message-Id: <1029152517.27391.20.camel@sonja.de.interearth.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mon, 2002-08-12 um 11.11 schrieb Helge Hafting:
 
> In short - memory used to cache your big mmapped file don't merely 
> compete with memory used for caching other parts of that file.
> It competes with all other swappable (or discardable) memory
> in the system, and some of that might go to the swap device.

That's what I though.

> Maybe you only need a little of that big file at a time - but
> the VM system cannot know that.  It simply looks at _all_
> memory, considers "what is recently used, and what is _not_"
> and goes on to swap/writeback the latter parts.

Actually I need 95% and the file will grow on demand so it's pretty
hefty in use; I really need to invent some hack to avoid touching
the memory as much as we do now without any need.

> You have enough RAM, but was all of it _free_ according to free?
> Lots of it will usually be in use as cache, so something must be
> evicted.  Cache are freed sometimes, swapping happens at
> other times.

Interestingly the behaviour seems to be quite different on PPC vs.
i386. On my PPC machine with 256 MB RAM I have constant use swap and
all of the "free" memory is used as cache. On a i386 maschine with
512MB RAM the kernel never touched a single byte of swap and around
150MB are always free. Both machines always have a load > 1 and are
used for big compile jobs like gcc, OpenOffice and alike.
 
-- 
Servus,
       Daniel

