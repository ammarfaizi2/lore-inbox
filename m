Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132838AbRDPCPi>; Sun, 15 Apr 2001 22:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132837AbRDPCP3>; Sun, 15 Apr 2001 22:15:29 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:19464 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S132830AbRDPCPO>;
	Sun, 15 Apr 2001 22:15:14 -0400
Message-ID: <3ADA5BE4.367741CA@candelatech.com>
Date: Sun, 15 Apr 2001 19:41:40 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: george anzinger <george@mvista.com>
CC: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
        linux-kernel@vger.kernel.org,
        high-res-timers-discourse@lists.sourceforge.net
Subject: Re: No 100 HZ timer!
In-Reply-To: <200104131205.f3DC5KV11393@sleipnir.valparaiso.cl> <3AD77540.42BF138E@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger wrote:
> 
> Horst von Brand wrote:
> >
> > Ben Greear <greearb@candelatech.com> said:
> >
> > [...]
> >
> > > Wouldn't a heap be a good data structure for a list of timers?  Insertion
> > > is log(n) and finding the one with the least time is O(1), ie pop off the
> > > front....  It can be implemented in an array which should help cache
> > > coherency and all those other things they talked about in school :)
> >
> > Insertion and deleting the first are both O(log N). Plus the array is fixed
> > size (bad idea) and the jumping around in the array thrashes the caches.

Jumping around an array can't be much worse than jumping around
a linked list, can it?

It does not have to be fixed length, though it wouldn't be log(n) to
grow the array, it can still be done...and once you reach maximal
size, you won't be growing it any more...

I had forgotten about the log(n) to delete, though log(n) is
still pretty good.  As others have suggested, it might be good
to have a linked list for very-soon-to-expire timers.  However,
they would have to be few enough that your linear insert was
not worse than a log(n) instert and a log(n) delete...

> > --
> And your solution is?


> 
> George

-- 
Ben Greear (greearb@candelatech.com)  http://www.candelatech.com
Author of ScryMUD:  scry.wanfear.com 4444        (Released under GPL)
http://scry.wanfear.com               http://scry.wanfear.com/~greear
