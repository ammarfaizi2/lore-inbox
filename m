Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261686AbVEPPDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbVEPPDH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 11:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVEPPDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 11:03:05 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:40864 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261686AbVEPPAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 11:00:01 -0400
Date: Mon, 16 May 2005 16:59:54 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Mark Lord <lkml@rtr.ca>
Cc: Matthias Andree <matthias.andree@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: Linux does not care for data integrity
Message-ID: <20050516145954.GB949@merlin.emma.line.org>
Mail-Followup-To: Mark Lord <lkml@rtr.ca>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0505151657230.19181@artax.karlin.mff.cuni.cz> <200505151121.36243.gene.heskett@verizon.net> <20050515152956.GA25143@havoc.gtf.org> <20050516.012740.93615022.okuyamak@dd.iij4u.or.jp> <42877C1B.2030008@pobox.com> <20050516110203.GA13387@merlin.emma.line.org> <4288A4CA.7000009@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4288A4CA.7000009@rtr.ca>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 May 2005, Mark Lord wrote:

> Most of us want longer lifespan and 2X the performance from our hardware,
> and use UPSs to guarantee continuous power & survivability.

Which is a different story and doesn't protect from dying power supply
units.  I have replaced several PSUs that died "in mid-flight" and that
were not overloaded. UPS isn't going to help in that case. Of course you
can use a redundant PSU, redundant UPS - but that's easily more than a
battery-backed up cache on a decent RAID controller - since drive
failure will also toast file systems.

> Others want to live more dangerously on the power supply end,
> but still be safe on the filesystem end -- no guarantees there,
> even with "hdparm -W0" to disable the on-drive cache.

As long as one can rely on the kernel scheduling writes in the proper
order, no problem that I'd see. ext3 has apparently been doing this for
a long time in the default options, and I have yet to see ext3
corruption (except for massive hardware failure such as b0rked non-ECC
RAM or a harddisk that crashed its heads).

> Pulling power from a writing drive is ALWAYS a bad idea,
> and can permanently corrupt the track/cylinder that was being
> written.  This will toast a filesystem regardless of how careful
> or proper the write flushes were done.

Most drive manufacturers make more extensive guarantees about what gets
NOT damaged when a write is interrupted by power loss, and are careful
to turn the write current off pretty soon on power loss. None of the OEM
manuals I looked at advised that data that was already on disk would be
damaged beyond the block that was being written.

-- 
Matthias Andree
