Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261616AbSKCD7f>; Sat, 2 Nov 2002 22:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261614AbSKCD6t>; Sat, 2 Nov 2002 22:58:49 -0500
Received: from packet.digeo.com ([12.110.80.53]:30146 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261613AbSKCD6I>;
	Sat, 2 Nov 2002 22:58:08 -0500
Message-ID: <3DC4A050.EF65975@digeo.com>
Date: Sat, 02 Nov 2002 20:04:32 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.45 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Akira Tsukamoto <at541@columbia.edu>
CC: linux-kernel@vger.kernel.org, Hirokazu Takahashi <taka@valinux.co.jp>
Subject: Re: [PATCH] 2/2 2.5.45 cleanup & add original copy_ro/from_user
References: <3DC415DA.29D22E92@digeo.com> <20021102210737.3794.AT541@columbia.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Nov 2002 04:04:33.0219 (UTC) FILETIME=[1DB78930:01C282EE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Akira Tsukamoto wrote:
> 
> > - smaller is faster
> 
> It could be said more efficient but faster?

Yes, faster.  From a whole-system point of view, which is after
all what we care about.

Cache misses are terribly expensive.

> The code or binary size directly connected to this issue?
> 

Sure.  Large cache footprints in the kernel require more cache
reloads by the kernel and cause more cache reloads on return
to userspace.  Thrashing.

> From my patch, about the speed:
> for PIII/4 CPU -> no change. using the same 2.5.45 copy.
> for old i386 -> more optimal.
> for Athlon -> 2.5.45 does not use unrolled copy for it either.

OK.  Please integrate you patch into the current kernel's usercopy.c.

> I am away for a while but I grew up in Japan and just wanted to save
> some rooms for a embedded system like below.
> http://linux.ascii24.com/linux/news/today/2000/05/22/imageview/images461056.jpg.html
> The phisical size(not kernel) is about 5cm*5cm.
> Is your copy function suitable in this case?

Well it won't hurt, but it looks like yours improves on it.

The thing which requires some thought is "should the decision
be made at compile time or runtime".  For Athlon vs Intel
and i386 vs others, it should be performed at compile time.
