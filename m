Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263719AbTDDOsm (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 09:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263720AbTDDOnU (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 09:43:20 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:10500 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S263710AbTDDO3R (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 09:29:17 -0500
Date: Fri, 4 Apr 2003 16:40:44 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] only use 48-bit lba when necessary
Message-ID: <20030404144044.GA14371@win.tue.nl>
References: <20030404122936.GB786@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030404122936.GB786@suse.de>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 04, 2003 at 02:29:36PM +0200, Jens Axboe wrote:

> 48-bit lba has a non-significant overhead (twice the outb's, 12 instead

s/non-// ?

> of 6 per command), so it makes sense to use 28-bit lba commands whenever
> we can.
> 

> +	if (drive->addressing == 1 && block > 0xfffffff)
> +		lba48 = 1;

Hmm. I wonder whether we should be more cautious, and ask for lba48
as soon as some part of the interval is past this limit.
(say, block+nsectors > 0xfffffff)

I don't know whether the standard spells out what happens
at the boundary, but for example the LBA low/mid/high, DEV is required
to contain the sector number at the place the error occurred,
and that is possible only if one stays below the 28-byte sector limit.

Andries

