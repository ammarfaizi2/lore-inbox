Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262226AbUDTRM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262226AbUDTRM5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 13:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263028AbUDTRM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 13:12:57 -0400
Received: from relay2.paracel.com ([192.187.140.37]:27791 "EHLO
	relay2.paracel.com") by vger.kernel.org with ESMTP id S262226AbUDTRMy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 13:12:54 -0400
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: PROBLEM: Second processor not responding in 2.4.21 and later
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Date: Tue, 20 Apr 2004 09:29:42 -0700
Message-ID: <9D8C1A43309BAD4A9B46071DAF911D9E80B569@exch01.paracel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PROBLEM: Second processor not responding in 2.4.21 and later
Thread-Index: AcQj52NPk2LgOxA5RiWR4PkwekOUMgDDPMxQ
From: "Marc Rieffel" <marc@paracel.com>
To: "Denis Vlasenko" <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like things changed dramatically from 2.4.20-pre4 to 2.4.20-pre5.  Can you help me figure out which of the changes was responsible?

Thanks.

Kernel			Fail	Pass	Fail%

2.4.18-27.7.xsmp		0	3314	0.0000
2.4.18			5	4206	0.0012
2.4.19			12	25786	0.0005
2.4.20-pre4			2	586	0.0034
2.4.20-pre5			2	49	0.0392
2.4.20-pre6			12	745	0.0159
2.4.20			55	3128	0.0173
2.4.20-20.7smp		483	15427	0.0304
2.4.21-4.0.1.ELsmp	155	7278	0.0209

> -----Original Message-----
> From: Denis Vlasenko [mailto:vda@port.imtp.ilyichevsk.odessa.ua]
> Sent: Friday, April 16, 2004 12:17 PM
> To: Marc Rieffel
> Subject: Re: PROBLEM: Second processor not responding in 2.4.21 and
> later
> 
> 
> On Friday 16 April 2004 18:45, Marc Rieffel wrote:
> > [1.] One line summary of the problem:
> >
> > The kernel sometimes fails to initialize the second 
> processor in 2.4.21 and
> > later kernels.
> >
> > [2.] Full description of the problem/report:
> >
> > I have an 18-node cluster running Rocks 3.1.0, which is 
> based on RHEL 2.1
> > and uses the 2.4.21-4.0.1.ELsmp kernel.  Each node has dual 
> Intel Xeon
> > processors on Intel motherboards.  I have configured each 
> node to reboot
> > continuously.  Sometimes the nodes fail to initialize the 
> second processor,
> > printing messages like this,
> >
> > Apr 15 04:14:43 compute-0-14 kernel: Booting processor 1/6 eip 2000
> > Apr 15 04:14:43 compute-0-14 kernel: Not responding.
> > Apr 15 04:14:43 compute-0-14 kernel: Error: only one 
> processor found.
> >
> > Once up, the system behaves as normal, but with only one 
> processor instead
> > of two.
> >
> > I have rebooted these systems thousands of times over two 
> days.  Most (15)
> > of my nodes have Intel SE7501CW2 motherboards with dual 2.4 GHz Xeon
> > processors.  These nodes exhibit this failure about 2% of 
> the time, but
> > with a wide variation.  Some nodes get it as often as 10% 
> of the time, and
> > others as infrequently as 0.3% of the time, but every node with this
> > motherboard and this kernel has done it at least twice.
> >
> > One of my nodes has an Intel SE7501CW2 motherboard with 
> dual 2.8 GHz Xeon
> > processors and a different chassis and power supply.  This 
> has about the
> > same failure rate as the 2.4 GHz CW2 nodes.
> >
> > Two of my nodes have Intel SE7501BR2 motherboards with dual 
> 2.4 GHz Xeon
> > processors.  Neither of these motherboards has ever shown 
> this problem.
> >
> > I have a separate 8-node cluster running Rocks 2.3.2, which 
> is based on
> > RedHat 7.3 and uses the 2.4.18-27.7.xsmp kernel.  This has 
> nodes that are
> > identical to the 15 nodes in the first cluster -- Intel SE7501CW2
> > motherboards with dual 2.4 GHz Xeons.  None of the nodes in this
> > configuration has ever failed to initialize a processor.
> >
> > I ran one of these nodes with a custom-build 2.4.25 kernel, and it
> > exhibited about the same failure rate as the CW2's running 2.4.21.
> 
> Looks like you have a nice pile of CPU power :)
> >
> > This evidence seems to suggest that a bug was introduced in 
> the linux
> > kernel sometime between 2.4.18 and 2.4.21, and that this 
> bug only exhibits
> > itself infrequently and only on the CW2 motherboard (not the BR2).
> 
> You can do bianry search between .18 and .21, then between -preN's.
> --
> vda
> 
> 
