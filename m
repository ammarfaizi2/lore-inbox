Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269762AbSISPgf>; Thu, 19 Sep 2002 11:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271304AbSISPgf>; Thu, 19 Sep 2002 11:36:35 -0400
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:60946 "EHLO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S269762AbSISPge> convert rfc822-to-8bit; Thu, 19 Sep 2002 11:36:34 -0400
x-mimeole: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Linux TPC-C performance aided by kernel features
Date: Thu, 19 Sep 2002 10:41:32 -0500
Message-ID: <45B36A38D959B44CB032DA427A6E106402D09E3F@cceexc18.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Linux TPC-C performance aided by kernel features
Thread-Index: AcJfxxvPId8vVu+wSCyOJHzylHXekgAJXE5g
From: "Bond, Andrew" <Andrew.Bond@hp.com>
To: "Matthew Kirkwood" <matthew@hairy.beasts.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 19 Sep 2002 15:41:33.0175 (UTC) FILETIME=[07C3A870:01C25FF3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't have exact numbers, but I believe the gains were in the 12-15% range going from 4 to 8GB.

Yes, I believe that there are situations where you could add more memory >4GB and lose performance.  When we went from 8GB to 16GB we lost 5% performance just because the memory was in the system.  We ran tests that used the same about of memory in both cases and performance went down when the system had 16GB.  

Seeing a slowdown adding memory >4GB is also very possible if you don't have a kernel/driver/controller that supports 64-bit DMA.  The bounce buffer activity can be very costly.  For instance, in the benchmark we just published we could not use 64-bit DMA so we spent about 40% of our time in the kernel when we should be spending only about 20%.

Andy

> -----Original Message-----
> From: Matthew Kirkwood [mailto:matthew@hairy.beasts.org]
> Sent: Thursday, September 19, 2002 6:27 AM
> To: Bond, Andrew
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Linux TPC-C performance aided by kernel features
> 
> 
> On Wed, 18 Sep 2002, Bond, Andrew wrote:
> 
> > 2. Large memory support (16GB) - The Oracle processes used 
> about 14GB
> > of shared memory which was allocated using shmfs and 
> managed through a
> > mapping window in the Oracle process space.  Databases always love
> > more memory, however in an IA-32 architecture the gains definitely
> > diminish once you get past 4GB because of overhead.  Our gains going
> > from 8GB to 16GB of memory in the system were in the 10% range.
> 
> What did the gains from 4 to 8GB look like?
> 
> Could going above 4GB be a performance loss on less busy systems?
> #
> Matthew.
> 
> 
