Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314027AbSDQClL>; Tue, 16 Apr 2002 22:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314030AbSDQClK>; Tue, 16 Apr 2002 22:41:10 -0400
Received: from eriador.apana.org.au ([203.14.152.116]:64267 "EHLO
	eriador.apana.org.au") by vger.kernel.org with ESMTP
	id <S314027AbSDQClK>; Tue, 16 Apr 2002 22:41:10 -0400
Date: Wed, 17 Apr 2002 12:40:58 +1000
To: linux-kernel@vger.kernel.org
Subject: Re: Why HZ on i386 is 100 ?
Message-ID: <20020417024058.GA24483@gondor.apana.org.au>
In-Reply-To: <20020416222156.GB20464@turbolinux.com> <E16xba3-0005tw-00@gondolin.me.apana.org.au> <20020416225631.GD20464@turbolinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2002 at 04:56:31PM -0600, Andreas Dilger wrote:
> 
> Er, because the 'tick' is a valid count of the actual time that the
> system has been running, while the "boot time" is totally meaningless.
> What if the system has no RTC, or the RTC is wrong until later in the
> boot sequence when it can be set by the user/ntpd?  What if you pass
> daylight savings time?  Does your uptime increase/decrease by an hour?

Tick is the number of timer interrupts that you've collected, which
may or may not be exactly 100Hz.  In fact, after 400 days of operation,
the deviation from true time is likely to be above 1 hour.

Anyway, you don't need the RTC since you can always fall back to the
system clock which is no worse than before.  However, if you do have
an accurate clock source then this is much better than using the tick.

If you use ntpd, then you can simply record the time on a server that
you trust, and use the tick reading at that point in time to deduce
the boot time.
-- 
Debian GNU/Linux 2.2 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
