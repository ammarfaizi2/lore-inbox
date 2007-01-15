Return-Path: <linux-kernel-owner+w=401wt.eu-S1751788AbXAOCxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbXAOCxS (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 21:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751789AbXAOCxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 21:53:18 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:10911 "EHLO virtualhost.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751788AbXAOCxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 21:53:17 -0500
Date: Mon, 15 Jan 2007 13:53:19 +1100
From: Jens Axboe <jens.axboe@oracle.com>
To: Robert Hancock <hancockr@shaw.ca>
Cc: Jeff Garzik <jeff@garzik.org>,
       =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
       linux-kernel@vger.kernel.org, htejun@gmail.com
Subject: Re: SATA exceptions with 2.6.20-rc5
Message-ID: <20070115025319.GC4516@kernel.dk>
References: <fa.hif5u4ZXua+b0mVNaWEcItWv9i0@ifi.uio.no> <45AAC039.1020808@shaw.ca> <45AAC95B.1020708@garzik.org> <45AAE635.8090308@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45AAE635.8090308@shaw.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 14 2007, Robert Hancock wrote:
> Jeff Garzik wrote:
> >>Looks like all of these errors are from a FLUSH CACHE command and the 
> >>drive is indicating that it is no longer busy, so presumably done. 
> >>That's not a DMA-mapped command, so it wouldn't go through the ADMA 
> >>machinery and I wouldn't have expected this to be handled any 
> >>differently from before. Curious..
> >
> >It's possible the flush-cache command takes longer than 30 seconds, if 
> >the cache is large, contents are discontiguous, etc.  It's a 
> >pathological case, but possible.
> >
> >Or maybe flush-cache doesn't get a 30 second timeout, and it should...? 
> > (thinking out loud)
> >
> >    Jeff
> 
> If the flush was still in progress I would expect Busy to still be set, 
> however..

I'd be surprised if the device would not obey the 7 second timeout rule
that seems to be set in stone and not allow more dirty in-drive cache
than it could flush out in approximately that time.

And BUSY should also be set for that case, as Robert indicates.

-- 
Jens Axboe

