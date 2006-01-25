Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750998AbWAYOUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbWAYOUX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 09:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWAYOUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 09:20:23 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:22554 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750998AbWAYOUV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 09:20:21 -0500
Date: Wed, 25 Jan 2006 15:21:55 +0100
From: Jens Axboe <axboe@suse.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: matthias.andree@gmx.de, jengelh@linux01.gwdg.de, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest) (was: Rationale for RLIMIT_MEMLOCK?)
Message-ID: <20060125142155.GW4212@suse.de>
References: <20060123165415.GA32178@merlin.emma.line.org> <1138035602.2977.54.camel@laptopd505.fenrus.org> <20060123180106.GA4879@merlin.emma.line.org> <1138039993.2977.62.camel@laptopd505.fenrus.org> <20060123185549.GA15985@merlin.emma.line.org> <43D530CC.nailC4Y11KE7A@burner> <1138048255.21481.15.camel@mindpipe> <20060123212119.GI1820@merlin.emma.line.org> <Pine.LNX.4.61.0601241823390.28682@yvahk01.tjqt.qr> <43D78585.nailD7855YVBX@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D78585.nailD7855YVBX@burner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25 2006, Joerg Schilling wrote:
> Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> 
> > >1. compile a list of their requirements,
> >
> > Have as few code duplicated (e.g. ATAPI and SCSI may share some - after 
> > all, ATAPI is (to me) some sort of SCSI tunneled in ATA.)
> 
> Thank you! This is a vote _pro_ a unified SCSI generic implementation for all
> types of devices. The current implementation unneccssarily duplicates a lot 
> of code.

The block layer SG_IO is just that, it's completely transport agnostic.
There's not a lot of duplicated code. In the future, perhaps sg will
disappear and be replaced by bsg which is just the full block layer
implementation of that (SG_IO can currently be considered a subset of
that support).

> > Make it, in accordance with the above, possible to have as few kernel 
> > modules loaded as possible and therefore reducing footprint - if I had not 
> > to load sd_mod for usb_storage fun, I would get an itch to load a 78564 
> > byte scsi_mod module just to be able to use ATAPI. (MINOR one, though.)
> 
> On Solaris, the SCSI glue code (between hostadaptor drivers and target drivers) is 
> really small:
> 
> /usr/ccs/bin/size /kernel/misc/scsi 
> 28482 + 27042 + 2036 = 57560
> 
> And if you check the amount of completely unneeded code Linux currently has 
> just to implement e.g. SG_IO in /dev/hd*, it could even _save_ space in the 
> kernel when converting to a clean SCSI based design.

Please point me at that huge amount of code. Hint: there is none.

Deja vu, anyone?

-- 
Jens Axboe

