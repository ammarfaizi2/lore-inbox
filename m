Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030213AbWHHRwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030213AbWHHRwe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 13:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030212AbWHHRwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 13:52:34 -0400
Received: from brick.kernel.dk ([62.242.22.158]:56095 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1030209AbWHHRwd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 13:52:33 -0400
Date: Tue, 8 Aug 2006 19:53:43 +0200
From: Jens Axboe <axboe@suse.de>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Jason Lunz <lunz@gehennom.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       andre@linux-ide.org, pavel@suse.cz, linux-pm@osdl.org,
       linux-ide@vger.kernel.org
Subject: Re: swsusp regression [Was: 2.6.18-rc3-mm2]
Message-ID: <20060808175343.GX31726@suse.de>
References: <20060806030809.2cfb0b1e.akpm@osdl.org> <200608081316.00749.rjw@sisk.pl> <20060808111925.GO4025@suse.de> <200608081550.36054.rjw@sisk.pl> <20060808140601.GU31726@suse.de> <44D8BE88.4080809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44D8BE88.4080809@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08 2006, Jiri Slaby wrote:
> Jens Axboe wrote:
> >On Tue, Aug 08 2006, Rafael J. Wysocki wrote:
> >>On Tuesday 08 August 2006 13:19, Jens Axboe wrote:
> >>>On Tue, Aug 08 2006, Rafael J. Wysocki wrote:
> >>>>On Tuesday 08 August 2006 13:07, Jens Axboe wrote:
> >>>>>On Tue, Aug 08 2006, Jens Axboe wrote:
> >>>>>>>Indeed, that looks broken now. That must be what is screwing it up. 
> >>>>>>>With
> >>>>>>the former patch applied, did cdrom detection still look funny to you?
> >>>>Hm, I'm not sure what you mean ...
> >>>-hdc: ATAPI 63X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
> >>>+hdc: ATAPI CD-ROM drive, 0kB Cache, UDMA(33)
> >>Ah, that.
> >>
> >>>But perhaps that wasn't you?
> >>No, that wasn't me. :-)
> 
> It was me and it's OK.
> 
> >>>>>>I'll concoct a fix for that breakage.
> >>>>>Something like this.
> >>>>Looks good, I'll give it a try.
> >>>Thanks!
> >>It fixes this particular issue for me, but your first patch (appended)
> >>is also needed to prevent the box from hanging later during the resume
> >>(when it tries to save the image).
> >
> >Yes certainly, that's a separate bug, sorry if I didn't make that clear.
> >Both fixes are in the block repo now, so next -mm should work fine
> >again.
> 
> And even this is OK.

Good.

> I'm just curious, what
> @@ -387,3 +398,5 @@
>  EXT3 FS on md0, internal journal
>  EXT3-fs: mounted filesystem with ordered data mode.
>  Adding 506036k swap on /dev/hda3.  Priority:-1 extents:1 across:506036k
> +JBD: barrier-based sync failed on hda2 - disabling barriers
> +JBD: barrier-based sync failed on md0 - disabling barriers

I think that -mm also added barriers on by default for ext3, so I don't
think it's anything to worry about.

-- 
Jens Axboe

