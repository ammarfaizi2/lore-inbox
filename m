Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030903AbWKUMAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030903AbWKUMAo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 07:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030907AbWKUMAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 07:00:44 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:28324 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030903AbWKUMAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 07:00:43 -0500
Date: Tue, 21 Nov 2006 12:06:14 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: avl@logic.at
Cc: linux-kernel@vger.kernel.org
Subject: Re: possible bug in ide-disk.c (2.6.18.2 but also older)
Message-ID: <20061121120614.06073ce8@localhost.localdomain>
In-Reply-To: <20061121115117.GU6851@gamma.logic.tuwien.ac.at>
References: <20061120145148.GQ6851@gamma.logic.tuwien.ac.at>
	<20061120152505.5d0ba6c5@localhost.localdomain>
	<20061120165601.GS6851@gamma.logic.tuwien.ac.at>
	<20061120172812.64837a0a@localhost.localdomain>
	<20061121115117.GU6851@gamma.logic.tuwien.ac.at>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> After reading it a second time, I'll see if I got it straight now:
> 
> .) the kernel always loads even-aligned pairs of sectors.
> .) for an odd-sectored disk, this results in the GPT plus the
>      following (non-existent) sector being accessed from disk.

Yes

> .) the old, unmaintained ide-driver generally does not handle
>      the odd-size case right, as it misinterprets the harddisks
>      error for the second sector (the one after the end) as a
>      general error causing dma to be turned off, after some retries.
>      It would also do that, if I later accessed the last sector
>      (e.g. dd if=/dev/hda ..., or by accessing a file that happens
>      to be stored there per filesystem, if at all possible),
>      not just during the initial GPT-check.

Only ever seen during the partition check

> .) If I remove the "addr++;", then the harddisk is actually
>      believed to be 1 sector smaller than it really is, which
>      means that it looks like an even-sized disk. This could mean
>      that an eventually existing GPT could be missed. What would
>      be the "worst-case" consequences?
> .) if ((old ide-driver) && (odd # of sectors)) youre_doomed_anyway(); ?

Not in any normal situation it appears, just the partition code seems to
trip it up.
