Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263881AbRFHIDF>; Fri, 8 Jun 2001 04:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263917AbRFHICy>; Fri, 8 Jun 2001 04:02:54 -0400
Received: from leeor.math.technion.ac.il ([132.68.115.2]:42414 "EHLO
	leeor.math.technion.ac.il") by vger.kernel.org with ESMTP
	id <S263881AbRFHICo>; Fri, 8 Jun 2001 04:02:44 -0400
Date: Fri, 8 Jun 2001 11:02:37 +0300
From: "Nadav Har'El" <nyh@math.technion.ac.il>
To: Andrey Savochkin <saw@saw.sw.com.sg>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug in nonlocal-bind (transparent proxy)?
Message-ID: <20010608110237.A1911@leeor.math.technion.ac.il>
In-Reply-To: <20010607170825.A18760@leeor.math.technion.ac.il> <20010608014443.A28407@saw.sw.com.sg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010608014443.A28407@saw.sw.com.sg>; from saw@saw.sw.com.sg on Fri, Jun 08, 2001 at 01:44:43AM -0400
Hebrew-Date: 17 Sivan 5761
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2001, Andrey Savochkin wrote about "Re: Bug in nonlocal-bind (transparent proxy)?":
> On Thu, Jun 07, 2001 at 05:08:25PM +0300, Nadav Har'El wrote:
> Hi,
> > Bind()ing a non-local address worked fine in the 2.2 line of kernels if a
> > certain compile-time option was enabled (TRANSPARENT_PROXY, or something
> > like that). But it no longer seems to be working in the 2.4 kernels (I
> > tried this on 2.4.2 coming from the Redhat 7.1 distribution).
> 
> It's not a bug, it's willful.

I don't understand what is willful: why does the ip_nonlocal_bind sysctl
exist if it doesn't help? Getting bind() to work (which is what
ip_nonlocal_bind does) but later not being able to connect() this socket
isn't very useful...

> To make a custom kernel where you can use non-local addresses more freely,
> find source address checks in ip_route_output_slow() and get rid of all of
> them except considering
> 	MULTICAST(saddr) || BADCLASS(saddr) || ZERONET(saddr) ||
> 		saddr == htonl(INADDR_BROADCAST)
> as invalid.

Thanks for the idea - I'll try doing that, and see if it works.

Is there any special reason why, instead of that ip_nonlocal_bind that doesn't
work, we don't have instead a compile-time variable (obviously a run-time
sysctl or socket-specific option would be even better) which enables both
ip_nonlocal_bind and the hacks needed to get connect() to work?

-- 
Nadav Har'El                        |       Friday, Jun  8 2001, 17 Sivan 5761
nyh@math.technion.ac.il             |-----------------------------------------
Phone: +972-53-245868, ICQ 13349191 |A conscience does not prevent sin. It
http://nadav.harel.org.il           |only prevents you from enjoying it.
