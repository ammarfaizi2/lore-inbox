Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263949AbTDYMrK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 08:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263957AbTDYMrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 08:47:10 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:3601 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263949AbTDYMrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 08:47:09 -0400
Date: Fri, 25 Apr 2003 14:59:18 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Andreas Dilger <adilger@clusterfs.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@digeo.com>, cat@zip.com.au, mbligh@aracnet.com,
       gigerstyle@gmx.ch, geert@linux-m68k.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fix SWSUSP & !SWAP
Message-ID: <20030425125918.GA25733@atrey.karlin.mff.cuni.cz>
References: <20030424022505.5b22eeed.akpm@digeo.com> <20030424093534.GB3084@elf.ucw.cz> <20030424024613.053fbdb9.akpm@digeo.com> <1051182797.2250.10.camel@laptop-linux> <20030424043637.71c3812e.akpm@digeo.com> <20030424142632.GB229@elf.ucw.cz> <20030424103734.O26054@schatzie.adilger.int> <20030424204805.GA379@elf.ucw.cz> <20030424154608.V26054@schatzie.adilger.int> <1051232975.1919.26.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1051232975.1919.26.camel@laptop-linux>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > On Apr 24, 2003  22:48 +0200, Pavel Machek wrote:
> > OK, then why all of the talk earlier saying that journal recovery will
> > corrupt a swapfile?  That was the reason journaling was brought into the
> > discussion in the first place:
> > 
> > 	"And now you have kernel which expects data still in journal (that was
> > 	 state before suspend), but reality on disk is quite different (journal
> > 	 was replayed). Data corruption." -- Pavel
> 
> I don't believe Pavel was saying the image would be corrupted. Rather,
> the rest of the disk contents are corrupted by replaying the journal and
> then resuming back to a memory state that has been made inconsistent
> with the disk state because of the journal replay.

Right.

> > If that is the case, then the only way to avoid this would be to call
> > sync_super_lockfs() on each filesystem before the suspend, which will
> > force the journal to be empty when it returns.  That API is supported
> > by all of the journaling filesystems, and is probably a good thing to
> > do anyways, as it will potentially free a lot of dirty data from RAM,
> > and also ensure that the on-disk data is consistent in case the resume
> > isn't handled gracefully.
> 
> Sounds like a good idea to me.

When I do sys_sync(), will it trigger that?
								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
