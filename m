Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbWAIKB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbWAIKB0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 05:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbWAIKB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 05:01:26 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:40751 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751217AbWAIKBZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 05:01:25 -0500
Date: Mon, 9 Jan 2006 11:03:22 +0100
From: Jens Axboe <axboe@suse.de>
To: Sebastian <sebastian_ml@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Digital Audio Extraction with ATAPI drives far from perfect
Message-ID: <20060109100322.GP3389@suse.de>
References: <20060107115449.GB20748@section_eight.mops.rwth-aachen.de> <20060107115947.GY3389@suse.de> <20060107140843.GA23699@section_eight.mops.rwth-aachen.de> <20060107142201.GC3389@suse.de> <20060107160622.GA25918@section_eight.mops.rwth-aachen.de> <43BFFE08.70808@wasp.net.au> <20060107180211.GA12209@section_eight.mops.rwth-aachen.de> <43C00C32.9050002@wasp.net.au> <20060109093025.GO3389@suse.de> <20060109094923.GA8373@section_eight.mops.rwth-aachen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060109094923.GA8373@section_eight.mops.rwth-aachen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09 2006, Sebastian wrote:
> On Mo, Jan 09, 2006 at 10:30:25 +0100, Jens Axboe wrote:
> > Sebastian, care to try one more thing? Patch your kernel with this
> > little patch and try ripping a known "faulty" track again _not_ using
> > SG_IO. See if that produces the same faulty results again, or if it
> > actually works.
> > 
> > diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
> > index 1539603..2e44d81 100644
> > --- a/drivers/cdrom/cdrom.c
> > +++ b/drivers/cdrom/cdrom.c
> > @@ -426,7 +426,7 @@ int register_cdrom(struct cdrom_device_i
> >  		cdi->exit = cdrom_mrw_exit;
> >  
> >  	if (cdi->disk)
> > -		cdi->cdda_method = CDDA_BPC_FULL;
> > +		cdi->cdda_method = CDDA_BPC_SINGLE;
> >  	else
> >  		cdi->cdda_method = CDDA_OLD;
> >  
> > 
> > -- 
> > Jens Axboe
> > 
> Hi Jens,
> 
> I applied your patch, recompiled the kernel, rebooted and recompiled
> cdparanoia without the Red Hat patches. Extracting the first track of my
> test cd the result was the same as without the kernel patch with ide-cd
> using the cooked interface (md5 e8319ccc20d053557578b9ca3eb368dd).
> 
> Sorry :)

Well it's actually a good thing, because then at least it's not a bug
with the multi-frame extraction. So my guess would still be at the error
correction possibilities that the application has, in which case
CDROMREADAUDIO is just an inferior interface for this sort of thing. It
also doesn't give the issuer a chance to look at potential error
reasons, since the extended status isn't available.

-- 
Jens Axboe

