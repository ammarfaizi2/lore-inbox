Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265985AbUFOWBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265985AbUFOWBX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 18:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265986AbUFOWBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 18:01:23 -0400
Received: from gw0.infiniconsys.com ([65.219.193.226]:41947 "EHLO
	mail.infiniconsys.com") by vger.kernel.org with ESMTP
	id S265985AbUFOWBU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 18:01:20 -0400
From: "Fab Tillier" <ftillier@infiniconsys.com>
To: "'Arthur Perry'" <kernel@linuxfarms.com>, <linux-kernel@vger.kernel.org>
Subject: RE: PCI bandwidth measurement methods
Date: Tue, 15 Jun 2004 14:58:24 -0700
Message-ID: <002201c45323$e2664350$655aa8c0@infiniconsys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
In-Reply-To: <Pine.LNX.4.58.0406151429200.30923@tiamat.perryconsulting.net>
Importance: Normal
X-OriginalArrivalTime: 15 Jun 2004 22:01:19.0823 (UTC) FILETIME=[49F975F0:01C45324]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Arthur Perry [mailto:kernel@linuxfarms.com]
> Sent: Tuesday, June 15, 2004 1:56 PM
> 
> Hello,
> 
> I have a question about methods of measuring PCI-X bandwidth.
> I was wondering if anybody has any ideas.
> What I am looking for is an "industry standard" method, if one exists.
> At this point, such software does not exist in SPEC.
> Different HBA cards such as Myricom and Mellanox (Myrinet and Infiniband
> hosts) have utilitites to test your PCI bandwidth..
> But what do you do when they come up with completely different numbers?

There are many variables that will determine peak bandwidth for an I/O
adapter.  The size of the I/O request as well as the number of I/O requests
outstanding affect bandwidth.  The PCI commands used by the adapters to
transfer the memory (burst length, etc) will change the amount of overhead
for the different devices too.

Unless mistaken, Myrinet PCI-X adapters operate at 2.5Gb full duplex per
port, while the Mellanox 4x InfiniBand HCA operates at 10Gb full duplex per
port.  From the HW characteristics, you should be able to get 4x the
bandwidth out of the IB HCA (assuming linear scale-up and comparable HW
operation), so that might explain your bandwidth discrepancy between the
different HW.

Lastly, a PCI analyzer can be useful in seeing exactly what commands are
used and how large a burst the different HW adapters are capable of, but
that moves you out of pure SW benchmarking.

> 
> What I need is an unbiased, objective PCI-X bandwidth test.
> It's all about performance in Linux actually... So I can't say "completely
> objective"..

You don't need a single test.  What you need is to control what each test
does.  Same size I/O, same number of outstanding requests, etc.  If you have
that, you should be able to compare.

> 
> I can write software that will do this, possibly by performing PCI
> writes to scratch memory area on several different HBAs..

PCI writes to HBA attached memory may not use the same PCI commands as I/O
DMA, and thus might lead to totally different results.

> Or maybe adding a counter into the Linux PCI device driver to verify the
> bandwidth claims that Mellanox and Myricom's tools report.
> But before I re-invent the wheel, I was wondering if anybody knew of
> anything that is already out there.

Things like MPI benchmarks should do the trick, since only the underlying HW
provider changes.  I'm assuming you can get MPI on top of Myrinet.

> If I were to write something, a whole software validation process would
> have to be performed on top of the actual work.
> If anybody knows of something that already exists and has been in use, it
> would be ideal.

Give MPI benchmarks a try.

Good luck,

- Fab


