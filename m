Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319111AbSIKPQT>; Wed, 11 Sep 2002 11:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319113AbSIKPQT>; Wed, 11 Sep 2002 11:16:19 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:58181 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S319111AbSIKPQR>; Wed, 11 Sep 2002 11:16:17 -0400
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: "David S. Miller" <davem@redhat.com>, hadi@cyberus.ca,
       tcw@tempest.prismnet.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, Nivedita Singhvi <niv@us.ibm.com>
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
References: <m1hegwoppm.fsf@frodo.biederman.org>
	<477096648.1031728254@[10.10.2.3]>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 11 Sep 2002 09:06:36 -0600
In-Reply-To: <477096648.1031728254@[10.10.2.3]>
Message-ID: <m1d6rko9ab.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> writes:

> >> > Ie. the headers that don't need to go across the bus are the critical
> >> > resource saved by TSO.
> >> 
> >> I'm not sure that's entirely true in this case - the Netfinity
> >> 8500R is slightly unusual in that it has 3 or 4 PCI buses, and
> >> there's 4 - 8 gigabit ethernet cards in this beast spread around
> >> different buses (Troy - are we still just using 4? ... and what's
> >> the raw bandwidth of data we're pushing? ... it's not huge). 
> >> 
> >> I think we're CPU limited (there's no idle time on this machine), 
> >> which is odd for an 8 CPU 900MHz P3 Xeon,
> > 
> > Quite possibly.  The P3 has roughly an 800MB/s FSB bandwidth, that must
> > be used for both I/O and memory accesses.  So just driving a gige card at
> > wire speed takes a considerable portion of the cpus capacity.  
> > 
> > On analyzing this kind of thing I usually find it quite helpful to
> > compute what the hardware can theoretically to get a feel where the
> > bottlenecks should be.
> 
> We can push about 420MB/s of IO out of this thing (out of that 
> theoretical 800Mb/s). 

Sounds about average for a P3.  I have pushed the full 800MiB/s out of
a P3 processor to memory but it was a very optimized loop.  Is
that 420MB/sec of IO on this test?
 
> Specweb is only pushing about 120MB/s of
> total data through it, so it's not bus limited in this case.

Note quite.  But you suck at least 240MB/s of your memory bandwidth with
DMA from disk, and then DMA to the nic.  Unless there is a highly
cached component.  So I doubt you can effectively use more than 1 gige
card, maybe 2.  And you have 8?

> Of course, I should have given you that data to start with, 
> but ... ;-)
>
> PS. This thing actually has 3 system buses, 1 for each of the two
> sets of 4 CPUs, and 1 for all the PCI buses, and the three buses
> are joined by an interconnect in the middle. But all the IO goes
> through 1 of those buses, so for the purposes of this discussion,
> it makes no difference whatsoever ;-)

Wow the hardware designers really believed in over-subscription.
If the busses are just running 64bit/33Mhz you are oversubscribed.
And at 64bit/66Mhz the pci busses can easily swamp the system 
533*4 ~= 2128MB/s. 

What kind of memory bandwidth does the system have, and on which
bus are the memory controllers?  I'm just curious  

Eric
