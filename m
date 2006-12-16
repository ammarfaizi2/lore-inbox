Return-Path: <linux-kernel-owner+w=401wt.eu-S1030912AbWLPMpP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030912AbWLPMpP (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 07:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030915AbWLPMpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 07:45:15 -0500
Received: from main.gmane.org ([80.91.229.2]:40108 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030912AbWLPMpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 07:45:13 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Wiebe Cazemier <halfgaar@gmx.net>
Subject: Software RAID1 (with non-identical discs) performance
Date: Sat, 16 Dec 2006 13:39:22 +0100
Message-ID: <em0pdq$r7o$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cc503261-a.eelde1.dr.home.nl
User-Agent: KNode/0.10.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm planning to put a software RAID1 array in my computer, but I have a few
technical questions. 

When using non-identical discs (not just size, but also geometry) to contruct
your array, you can never get the partitions of the underlying discs to be
equal in size because the size of a partition can only be N*cylindersize,
where cylindersize varies across discs; the array always assumes the size of
the smallest partition. When one of the discs fails, you need to replace it
and make a partition that is exactly equal in size to the array, but because
that usually is impossible, it mostly will be bigger. To cover for this, I
have always left a small bit of unpartioned space on my discs. This not only
provides me with headroom in making the partitions on discs with different
geometry, but it's also possible that brand B's 250 GB is a little smaller
than brand A's, and staying (well) below the 250 GB, makes sure any 250 GB
disc fits in the array.

My first question is, is this a necessary/convenient technique to ensure you
can replace discs over time, especially when you can't get the exact same
replacement disc?

My second question is about the performance impact of using non-identical discs
and partitions. I can't really find any info about this, but I've read someone
making the statement that it would slow things down.

My third question: write performance of RAID1 is usually lower than non-RAID,
because the data has to be sent over the bus twice. But, with for example an
NForce4 based mainboard using SATA, does that matter? I don't know if the SATA
ports are connected to the chipset by means of PCI express or hypertransport,
but both should be able to handle the double data transfer with room to spare.
So, as I understand it, as long as the kernel can perform both transfers
simultaniously, there should be no slow down, because when writing, there will
simply be two discs writing data simultaniously, at the same speed one drive
would. Is this correct?

Thanks in advance,

Wiebe Cazemier

