Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319422AbSIFXoL>; Fri, 6 Sep 2002 19:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319424AbSIFXoL>; Fri, 6 Sep 2002 19:44:11 -0400
Received: from tempest.prismnet.com ([209.198.128.6]:60940 "EHLO
	tempest.prismnet.com") by vger.kernel.org with ESMTP
	id <S319422AbSIFXoK>; Fri, 6 Sep 2002 19:44:10 -0400
From: Troy Wilson <tcw@tempest.prismnet.com>
Message-Id: <200209062348.g86NmdId016825@tempest.prismnet.com>
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
In-Reply-To: <18563262.1031269721@[10.10.2.3]> "from Martin J. Bligh at Sep 5,
 2002 11:48:42 pm"
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Date: Fri, 6 Sep 2002 18:48:39 -0500 (CDT)
CC: "David S. Miller" <davem@redhat.com>, hadi@cyberus.ca,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       Nivedita Singhvi <niv@us.ibm.com>
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It's the DMA bandwidth saved, most of the specweb runs on x86 hardware
> > is limited by the DMA throughput of the PCI host controller.  In
> > particular some controllers are limited to smaller DMA bursts to
> > work around hardware bugs.
> 
> I'm not sure that's entirely true in this case - the Netfinity
> 8500R is slightly unusual in that it has 3 or 4 PCI buses, and
> there's 4 - 8 gigabit ethernet cards in this beast spread around
> different buses (Troy - are we still just using 4? 


  My machine is not exactly an 8500r.  It's an Intel pre-release
engineering sample (8-way 900MHz PIII) box that is similar to an 
8500r... there are some differences when going across the choerency 
filter (the bus that ties the two 4-way "halves" of the machine 
together).  Bill Hartner has a test program that illustrates the 
differences-- but more on that later.

  I've got 4 PCI busses, two 33 MHz, and two 66MHz, all 64-bit.
I'm configured as follows:

  PCI Bus 0     eth1 ---  3 clients
   33 MHz       eth2 ---  Not in use


  PCI Bus 1     eth3 ---  2 clients
   33 MHz       eth4 ---  Not in use


  PCI Bus 3     eth5 ---  6 clients
   66 MHz       eth6 ---  Not in use


  PCI Bus 4     eth7 ---  6 clients
   66 MHz       eth8 ---  Not in use


> ... and what's
> the raw bandwidth of data we're pushing? ... it's not huge). 

  2900 simultaneous connections, each at ~320 kbps translates to
928000 kbps, which is slightly less than the full bandwidth of a 
single e1000.  We're spreading that over 4 adapters, and 4 busses.

- Troy


