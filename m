Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135186AbRDRNsU>; Wed, 18 Apr 2001 09:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135184AbRDRNsK>; Wed, 18 Apr 2001 09:48:10 -0400
Received: from [203.117.131.2] ([203.117.131.2]:8442 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S135180AbRDRNsF>; Wed, 18 Apr 2001 09:48:05 -0400
From: "Michael Clark" <michael@metaparadigm.com>
To: "Matti Aarnio" <matti.aarnio@zmailer.org>, <linux-kernel@vger.kernel.org>
Cc: "Jesse Pollard" <pollard@tomcat.admin.navo.hpc.mil>,
        "Leif Sawyer" <lsawyer@gci.com>,
        <Ian.Stirling@tomcat.admin.navo.hpc.mil>, <root@mauve.demon.co.uk>,
        "Manfred Bartz" <md-linux-kernel@logi.cc>, <n.brownlee@auckland.ac.nz>,
        "David Findlay" <david_j_findlay@yahoo.com.au>
Subject: RE: IP Acounting Idea for 2.5
Date: Wed, 18 Apr 2001 21:49:51 +0800
Message-ID: <HBEEKENFCJOPCENEDAGHKEPOCBAA.michael@metaparadigm.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
In-Reply-To: <20010417223747.M805@mea-ext.zmailer.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I repeat myself, fighting is apparently so pleasant that
> you are stuck on
> fighting over dead-end technology:
>
>   I seriously suggest that for the primary (subject given) topic
>   you are SERIOUSLY OFF TARGET.  Look around, counting hits on
>   some fw rules is waste of time!  (And mightly inaccurate!)

I agree. We could all stop re-inventing the wheel and use a
RFC2724/RFC2722/RFC2720 compliant traffic meter such as NeTraMet -
which has already solved most of the mentioned problems - has a
flexible rule language for matching flows and managing counters -
support for multiple protocols; not just IP - a distributed
architecture - SNMP accessable meter and remote Manager and Controller
(NeMaC) which can concurrently read from multiiple meters (including
NetFlow meters).

>   You absolutely don't want to do any sort of counting
> aggeration policy
>   control within kernel ( = FW rules ).   You want to
> collect accounting
>   per flow, and send those data records to offline analysis.

Yes, the IP accounting effort could do well by creating a fastpath for
feeding packet headers (can't say I know how optimal libpcap is
currently on Linux) to a userspace meter (like NeTraMet) letting it
deal with all of the policy.

I remember the DOS version of NeTraMet performed much better than the
Linux version (some years ago) due to custom ethernet drivers (for
some cards) that only generate interupts when a ring buffer is full of
packet headers - maybe the same sort of infrastructure (some of the
Linux GigE drivers also avoid the interupt per packet performance hit)
could be added to Linux and integrated with libpcap and leave the rest
up to a userspace meter application.

I'm sure Neville (traffic metering god - Hi Neville) would be pleased
to have optimized support for NeTraMet in the Linux kernel.

>   No more fighting of when to clear counters, and when not.
>
>   Having used (with own custom analyzers) cisco netflow, I can say
>   that any sort of "count hits on access-list elements" things are
>   from stone-age:

NetFlow really sucks alot doesn't - I remeber having bad aliasing
problems (trying to generate 5min averages) due to its minumum flow
export interval of 1 minute. Is this still the case?

Michael Clark.

