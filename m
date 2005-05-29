Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbVE2VDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbVE2VDI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 17:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbVE2VDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 17:03:08 -0400
Received: from stark.xeocode.com ([216.58.44.227]:15823 "EHLO
	stark.xeocode.com") by vger.kernel.org with ESMTP id S261439AbVE2VDC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 17:03:02 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matthias Andree <matthias.andree@gmx.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux does not care for data integrity (was: Disk write cache)
References: <Pine.LNX.4.58.0505151657230.19181@artax.karlin.mff.cuni.cz>
	<200505151121.36243.gene.heskett@verizon.net>
	<20050515152956.GA25143@havoc.gtf.org>
	<20050516.012740.93615022.okuyamak@dd.iij4u.or.jp>
	<42877C1B.2030008@pobox.com>
	<20050516110203.GA13387@merlin.emma.line.org>
	<1116241957.6274.36.camel@laptopd505.fenrus.org>
	<20050516112956.GC13387@merlin.emma.line.org>
	<1116252157.6274.41.camel@laptopd505.fenrus.org>
	<20050516144831.GA949@merlin.emma.line.org>
	<1116256005.21388.55.camel@localhost.localdomain>
In-Reply-To: <1116256005.21388.55.camel@localhost.localdomain>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 29 May 2005 17:02:34 -0400
Message-ID: <87zmudycd1.fsf@stark.xeocode.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> I think you need to get real if you want that degree of integrity with a
> PC
> 
> Your typical PC setup means your precious data
...

All of your listed cases are low probability events. You're quit right that
low probability errors will always be present -- you could have just listed
cosmic rays and been finished. They're by far the most common such source of
errors.

But that doesn't mean we should just throw up our hands and say there's no way
to make computers work right, let's go home.

Making computer systems that don't randomly trash file systems in the case of
power outages isn't a hard problem. It's been solved for decades. That's *why*
fsync exists.

Oracle, Sybase, Postgres, other databases have hard requirements. They
guarantee that when they acknowledge a transaction commit the data has been
written to non-volatile media and will be recoverable even in the face of a
routine power loss.

They meet this requirement just fine on SCSI drives (where write caching
generally ships disabled) and on any OS where fsync issues a cache flush. If
the OS doesn't successfully flush the data to disk on fsync then it's quite
likely that any routine power outage will mean transactions are lost. That's
just ridiculous.

Worse, if the disk flushes the data to disk out of order it's quite likely the
entire database will be corrupted on any simple power outage. I'm not clear
whether that's the case for any common drives.

-- 
greg

