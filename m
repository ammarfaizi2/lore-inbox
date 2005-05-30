Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261525AbVE3GFC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261525AbVE3GFC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 02:05:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbVE3GFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 02:05:01 -0400
Received: from stark.xeocode.com ([216.58.44.227]:54989 "EHLO
	stark.xeocode.com") by vger.kernel.org with ESMTP id S261525AbVE3GEz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 02:04:55 -0400
To: Matthias Andree <matthias.andree@gmx.de>
Cc: Greg Stark <gsstark@mit.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux does not care for data integrity (was: Disk write cache)
References: <20050515152956.GA25143@havoc.gtf.org>
	<20050516.012740.93615022.okuyamak@dd.iij4u.or.jp>
	<42877C1B.2030008@pobox.com>
	<20050516110203.GA13387@merlin.emma.line.org>
	<1116241957.6274.36.camel@laptopd505.fenrus.org>
	<20050516112956.GC13387@merlin.emma.line.org>
	<1116252157.6274.41.camel@laptopd505.fenrus.org>
	<20050516144831.GA949@merlin.emma.line.org>
	<1116256005.21388.55.camel@localhost.localdomain>
	<87zmudycd1.fsf@stark.xeocode.com>
	<20050529211610.GA2105@merlin.emma.line.org>
In-Reply-To: <20050529211610.GA2105@merlin.emma.line.org>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 30 May 2005 02:04:46 -0400
Message-ID: <87is11xn9d.fsf@stark.xeocode.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@gmx.de> writes:

> On Sun, 29 May 2005, Greg Stark wrote:
> 
> > They meet this requirement just fine on SCSI drives (where write caching
> > generally ships disabled) and on any OS where fsync issues a cache flush. If
> 
> I don't know what facts "generally ships disabled" is based on, all of
> the more recent SCSI drives (non SCA type though) I acquired came with
> write cache enabled and some also with queue algorithm modifier set to 1.

People routinely post "Why does this cheap IDE drive outperform my shiny new
high end SCSI drive?" questions to the postgres mailing list. To which people
point out the IDE numbers they've presented are physically impossible for a
7200 RPM drive and the SCSI numbers agree appropriately with an average
rotational latency calculated from whatever speed their SCSI drives are.

> > Worse, if the disk flushes the data to disk out of order it's quite
> > likely the entire database will be corrupted on any simple power
> > outage. I'm not clear whether that's the case for any common drives.
> 
> It's a matter of enforcing write order. In how far such ordering
> constraints are propagated by file systems, VFS layer, down to the
> hardware, is the grand question.

Well guaranteeing write order will at least mean the database isn't complete
garbage after a power event.

It still means lost transactions, something that isn't going to be acceptable
for any real-life business where those transactions are actual dollars.

-- 
greg

