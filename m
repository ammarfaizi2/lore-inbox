Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262221AbVERWNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbVERWNR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 18:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262414AbVERWNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 18:13:16 -0400
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:61209 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S262221AbVERWMN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 18:12:13 -0400
X-IronPort-AV: i="3.93,118,1115017200"; 
   d="scan'208"; a="266921824:sNHT31778908"
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Disk write cache (Was: Hyper-Threading Vulnerability)
Date: Thu, 19 May 2005 06:11:59 +0800
Message-ID: <26A66BC731DAB741837AF6B2E29C10171E55EB@xmb-hkg-413.apac.cisco.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Disk write cache (Was: Hyper-Threading Vulnerability)
Thread-Index: AcVbsFjpLqL9Y5eWS+2Zc9ha7F80dwAQewhA
From: "Lincoln Dale \(ltd\)" <ltd@cisco.com>
To: "John Stoffel" <john@stoffel.org>
Cc: "Eric D. Mudama" <edmudama@gmail.com>, "Robert Hancock" <hancockr@shaw.ca>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 18 May 2005 22:12:02.0816 (UTC) FILETIME=[9E702800:01C55BF6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: John Stoffel [mailto:john@stoffel.org] 
> Sent: Wednesday, 18 May 2005 11:49 PM
> To: Lincoln Dale (ltd)
> Cc: Eric D. Mudama; Robert Hancock; linux-kernel
> Subject: RE: Disk write cache (Was: Hyper-Threading Vulnerability)
> 
> >>>>> "Lincoln" == Lincoln Dale \(ltd\) <Lincoln> writes:
> 
> Lincoln> why don't drive vendors create firmware which reserved a 
> Lincoln> cache-sized (e.g. 2MB) hole of internal drive space 
> somewhere 
> Lincoln> for such an event, and a "cache flush caused by hard-reset"
> Lincoln> simply caused it to write the cache to a fixed (contiguous) 
> Lincoln> area of disk.
> 
> Well, if you're losing power in the next Xmilliseconds, do 
> you have the time to seek to the cache holding area and 
> settle down the head (since you could have done a seek from 
> the edge of the disk to the middle), start writing, etc? 

I believe its possible.
rationale:

 [1] ATX power specification, (google finds this for me at
http://www.formfactors.org/developer%5Cspecs%5CATX12V_1_3dg.pdf)
     section 3.2.11 (Voltage Hold-up time) states:

	The power supply should maintain output regulation per Section
3.2.1 despite a loss of input
	power at the low-end nominal range-115 VAC / 57 Hz or 230 VAC /
47 Hz-at maximum
	continuous output load as applicable for a minimum of 17 ms.

     the assumption here is that T6 in figure 5 does de-assert the
POWER_OK signal early in that "minimum of 17ms".
     the spec (unfortunately) only calls for >=1msec.

     once again, i see that there could be a market for a combination of
p/s & peripherals that could make use of it.
     lets say that we DO have 17msec.

 [2] Hard drive response times
     picking a 'standard' high-end hard drive (Maxtor Atlas 10K V scsi
disk):

	average seek + rotional latency is measured at 7.6msec.
	transfer rates at beginning of disk are 89.5MB/s at end of disk
are 53.9MB/s.
      (source
http://www.storagereview.com/articles/200411/200411028D300L0_2.html)

     allowing 8msec for seek time, and writing at the 'slow' side of the
disk, writing 2MB
     could take ~37msec (2 / 53.9).  allow 50% overhead here - and we
have 55msec.

     55 + 8 = 63 msec.

ok - 63msec doesn't fit into 17msec -
but as i say, a combination of p/s and/or larger caps (and/or more
innovative design by a case or p/s manufactuer which creates a dedicated
peripheral power bus)

> Seems better to have a cache sized flash ram instead where 
> you could just keep the data there in case of power loss.  
> 
> But that's expensive, and not something most people need...

indeed, and that is what MS have been targeting. (flash isn't that
expensive, but flash write times are..).



cheers,

lincoln.


> 
> John
> 
