Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263754AbTDDPL1 (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 10:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263753AbTDDPKR (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 10:10:17 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:7115 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263749AbTDDPCc (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 10:02:32 -0500
Date: Fri, 4 Apr 2003 17:13:56 +0200
From: Jens Axboe <axboe@suse.de>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] only use 48-bit lba when necessary
Message-ID: <20030404151356.GA15124@suse.de>
References: <20030404122936.GB786@suse.de> <20030404144044.GA14371@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030404144044.GA14371@win.tue.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 04 2003, Andries Brouwer wrote:
> On Fri, Apr 04, 2003 at 02:29:36PM +0200, Jens Axboe wrote:
> 
> > 48-bit lba has a non-significant overhead (twice the outb's, 12 instead
> 
> s/non-// ?

Of course :)

> > of 6 per command), so it makes sense to use 28-bit lba commands whenever
> > we can.
> > 
> 
> > +	if (drive->addressing == 1 && block > 0xfffffff)
> > +		lba48 = 1;
> 
> Hmm. I wonder whether we should be more cautious, and ask for lba48
> as soon as some part of the interval is past this limit.
> (say, block+nsectors > 0xfffffff)
> 
> I don't know whether the standard spells out what happens
> at the boundary, but for example the LBA low/mid/high, DEV is required
> to contain the sector number at the place the error occurred,
> and that is possible only if one stays below the 28-byte sector limit.

That might not be a bad idea, just to be on the safe side. I'll do that.

-- 
Jens Axboe

