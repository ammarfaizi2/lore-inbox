Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132500AbREEN5d>; Sat, 5 May 2001 09:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132527AbREEN5O>; Sat, 5 May 2001 09:57:14 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:4357 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S132500AbREEN5H>; Sat, 5 May 2001 09:57:07 -0400
Date: Sat, 5 May 2001 17:55:47 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Richard Henderson <rth@twiddle.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.4 alpha semaphores optimization
Message-ID: <20010505175547.A2302@jurassic.park.msu.ru>
In-Reply-To: <20010503194747.A552@jurassic.park.msu.ru> <20010504141240.A11122@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010504141240.A11122@twiddle.net>; from rth@twiddle.net on Fri, May 04, 2001 at 02:12:40PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2001 at 02:12:40PM -0700, Richard Henderson wrote:
> >  - removed some mb's for non-SMP
> 
> This isn't correct.  Either you need atomic updates or you don't.
> If you don't, then you shouldn't be using ll/sc at all.

I don't think so. On a single CPU system we need atomic updates
to protect modifying of critical variables from interrupts, and
ll/sc sequences guarantee exactly that. But on UP system we don't
need memory barriers of any kind (I mean system memory space accesses,
not IO, of course), as we don't care about read/write ordering at all.

> If you do
> (perhaps to coordinate with devices) then the barriers are required.

For IO space access mb's are required, but ll/sc are of no use, AFAIK.

However, if I understand correctly, the r/w semaphores can't be used from
interrupt context, so in this case I'd agree -- this stuff could be made
completely non-atomic for UP.
 
> >  - removed non-inline up()/down_xx() when semaphore/waitqueue debugging
> >    isn't enabled.
> 
> They should still be exported for module compatibility.

If you mean some external modules, then ok. The modules built from the
main tree shouldn't have any problems...

Ivan.
