Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263362AbSLFQOk>; Fri, 6 Dec 2002 11:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263366AbSLFQOk>; Fri, 6 Dec 2002 11:14:40 -0500
Received: from h-64-105-35-8.SNVACAID.covad.net ([64.105.35.8]:49122 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S263362AbSLFQOj>; Fri, 6 Dec 2002 11:14:39 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 6 Dec 2002 08:19:25 -0800
Message-Id: <200212061619.IAA22144@baldur.yggdrasil.com>
To: davem@redhat.com
Subject: Re: [RFC] generic device DMA implementation
Cc: James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org,
       willy@debian.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-12-06, David S. Miller wrote:
>On Thu, 2002-12-05 at 23:41, Adam J. Richter wrote:
>> These change
>> will eliminate a difficulty in supporting devices on inconsistent-only
>> machines

>I think you are solving a non-problem, but if you want me to see your
>side of the story you need to give me specific examples of where
>pci_alloc_consistent() is "IMPOSSIBLE".

	I am not a parisc developer, but it is apparently the
case for certain parisc machines with "PCXS/T processors" or
the "T class" machines, as described by Mathew Wilcox:

http://lists.parisc-linux.org/pipermail/parisc-linux/2002-December/018535.html

	They currently need the contortions
that are implemented in linux-2.5.50/drivers/net/lasi_82596.c
and partially implemented in drivers/scsi/53c700.c to be
implemented in every driver that they want to use (i.e., what
these drivers try to do when pci_alloc_consistent fails).

	Under the API addition that we've been discussing, the
extra cache flushes and invalidations that these drivers need
would become macros that would be expand to nothing on the
other architectures, and the drivers would no longer have to
have "if (consistent_alloation_failed) ..." branches around them.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
