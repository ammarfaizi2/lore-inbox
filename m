Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284499AbRLFQLS>; Thu, 6 Dec 2001 11:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284630AbRLFQLI>; Thu, 6 Dec 2001 11:11:08 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:6591 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S284499AbRLFQKx>;
	Thu, 6 Dec 2001 11:10:53 -0500
Importance: Normal
Subject: Re: [Lse-tech] [RFC] [PATCH] Scalable Statistics Counters
To: kiran@linux.ibm.com
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF5920A1C3.B32C93AF-ON85256B1A.005706AC@raleigh.ibm.com>
From: "Niels Christiansen" <nchr@us.ibm.com>
Date: Thu, 6 Dec 2001 10:10:47 -0600
X-MIMETrack: Serialize by Router on D04NM104/04/M/IBM(Release 5.0.8 |June 18, 2001) at
 12/06/2001 11:10:47 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Kiran,

> Are you concerned with increase in memory used per counter Here? I
suppose
> that must not be that much of an issue for a 16 processor box....

Nope, I'm concerned that if this mechanism is to be used for all counters,
the improvement in cache coherence might be less significant to the point
where the additional overhead isn't worth it.

Arjab van de Ven voiced similar concerns but he also said:

> There's several things where per cpu data is useful; low frequency
> statistics is not one of them in my opinion.

...which may be true for 4-ways and even 8-ways but when you get to
32-ways and greater, you start seeing cache problems.  That was the
case on AIX and per-cpu counters was one of the changes that helped
get the spectacular scalability on Regatta.

Anyway, since we just had a long thread going on NUMA topology, maybe
it would be proper to investigate if there is a better way, such as
using the topology to decide where to put counters?  I think so, seeing
as it is that most Intel based 8-ways and above will have at least some
NUMA in them.

> Well, I wrote a simple kernel module which just increments a shared
global
> counter a million times per processor in parallel, and compared it with
> the statctr which would be incremented a million times per processor in
> parallel..

I suspected that.  Would it be possible to do the test on the real
counters?

Niels Christiansen
IBM LTC, Kernel Performance

