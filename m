Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318099AbSIFGpx>; Fri, 6 Sep 2002 02:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318143AbSIFGpx>; Fri, 6 Sep 2002 02:45:53 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:42485 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318099AbSIFGpt>;
	Fri, 6 Sep 2002 02:45:49 -0400
Date: Thu, 05 Sep 2002 23:48:42 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: "David S. Miller" <davem@redhat.com>, hadi@cyberus.ca
cc: tcw@tempest.prismnet.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       Nivedita Singhvi <niv@us.ibm.com>
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
Message-ID: <18563262.1031269721@[10.10.2.3]>
In-Reply-To: <20020905.204721.49430679.davem@redhat.com>
References: <20020905.204721.49430679.davem@redhat.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    I would think shoving the data down the NIC
>    and avoid the fragmentation shouldnt give you that much significant
>    CPU savings.
> 
> It's the DMA bandwidth saved, most of the specweb runs on x86 hardware
> is limited by the DMA throughput of the PCI host controller.  In
> particular some controllers are limited to smaller DMA bursts to
> work around hardware bugs.
> 
> Ie. the headers that don't need to go across the bus are the critical
> resource saved by TSO.

I'm not sure that's entirely true in this case - the Netfinity
8500R is slightly unusual in that it has 3 or 4 PCI buses, and
there's 4 - 8 gigabit ethernet cards in this beast spread around
different buses (Troy - are we still just using 4? ... and what's
the raw bandwidth of data we're pushing? ... it's not huge). 

I think we're CPU limited (there's no idle time on this machine), 
which is odd for an 8 CPU 900MHz P3 Xeon, but still, this is Apache,
not Tux. You mentioned CPU load as another advantage of TSO ... 
anything we've done to reduce CPU load enables us to run more and 
more connections (I think we started at about 260 or something, so 
2900 ain't too bad ;-)).

Just to throw another firework into the fire whilst people are 
awake, NAPI does not seem to scale to this sort of load, which
was disappointing, as we were hoping it would solve some of 
our interrupt load problems ... seems that half the machine goes
idle, the number of simultaneous connections drop way down, and
everything's blocked on ... something ... not sure what ;-)
Any guesses at why, or ways to debug this?

M.

PS. Anyone else running NAPI on SMP? (ideally at least 4-way?)
