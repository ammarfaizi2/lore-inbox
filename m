Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311176AbSCLNIJ>; Tue, 12 Mar 2002 08:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311177AbSCLNHu>; Tue, 12 Mar 2002 08:07:50 -0500
Received: from pc-62-31-92-140-az.blueyonder.co.uk ([62.31.92.140]:177 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S311176AbSCLNHo>; Tue, 12 Mar 2002 08:07:44 -0500
Date: Tue, 12 Mar 2002 13:06:35 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: OBATA Noboru <noboru@ylug.org>
Cc: greearb@candelatech.com, linux-kernel@vger.kernel.org
Subject: Re: a faster way to gettimeofday?
Message-ID: <20020312130635.C4281@kushida.apsleyroad.org>
In-Reply-To: <3C859007.50102@candelatech.com> <20020311.174702.74741981.obatan@rpi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020311.174702.74741981.obatan@rpi.edu>; from noboru@ylug.org on Mon, Mar 11, 2002 at 05:47:02PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OBATA Noboru wrote:
> I'm running verification program for 18 hours, but the userland
> gettimeofday still synchronizes with the actual system call.
> 
>   :
>   :
>   sys: 1015885532.519445              <- system call
>   usr: 1015885532.519444 (-0.000001)  <- userland (difference in seconds)
>   sys: 1015885533.029344
>   usr: 1015885533.029344 (+0.000000)
>   sys: 1015885533.539446
>   usr: 1015885533.539445 (-0.000001)
>   :
>   :
> 
> Yes, it is just for fun...  Enjoy!

I was just thinking that I'd expect to see more drift, as in labs it is
really quite difficult to keep _different_ computers synchronised.
Thermal and/or power variation causes the clock frequencies to change,
just a little but enough that <1ppm over 18 hours would be improbable.
I've seen graphs in which night and day, even in an environmentally
regulated lab, show up.

But then I realised that the CPU clock and the PIT chip (which provides
the 100HZ tick) are sometimes derived from the same clock source anyway,
so the drift would be as good as the calibration.  And if they weren't,
they might will be physically close and so tend to drift together.

If you run NTP (synchronisation with atomic clock standards over the
network), you get really good real world clock times.  It continually
adjust gettimeofday() but not the rdtsc clock.  That may highlight any
drift due to thermal effects in the PC.

I would guess you're not running NTP?

cheers,
-- Jamie
