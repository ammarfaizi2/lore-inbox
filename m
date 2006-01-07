Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932719AbWAGLz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932719AbWAGLz7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 06:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932720AbWAGLz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 06:55:59 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:61446 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932719AbWAGLz6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 06:55:58 -0500
Date: Sat, 7 Jan 2006 12:57:55 +0100
From: Jens Axboe <axboe@suse.de>
To: Sebastian <sebastian_ml@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Digital Audio Extraction with ATAPI drives far from perfect
Message-ID: <20060107115754.GX3389@suse.de>
References: <20060103222044.GA17682@section_eight.mops.rwth-aachen.de> <43BE24F7.6070901@triplehelix.org> <20060106232522.GA31621@section_eight.mops.rwth-aachen.de> <5bdc1c8b0601061530l3a8f4378o3b9cb96c187a6049@mail.gmail.com> <20060107103901.GA17833@section_eight.mops.rwth-aachen.de> <20060107105649.GT3389@suse.de> <20060107110004.GU3389@suse.de> <20060107115309.GA20748@section_eight.mops.rwth-aachen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060107115309.GA20748@section_eight.mops.rwth-aachen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07 2006, Sebastian wrote:
> On Sa, Jan 07, 2006 at 12:00:04 +0100, Jens Axboe wrote:
> > 
> > One more question - when using ide-scsi, does it use the SG_IO ioctl to
> > rip cdda, or does it use CDROMREADAUDIO like I'm assuming it does with
> > ide-cd? Is there a way to force SG_IO usage with a given device in
> > cdparanoia? If so, please try ide-cd with SG_IO usage instead.
> > 
> 
> There's one reference in cdparanoia to CDROMREADAUDIO, none at all to SG_IO:
> 
> interface/cooked_interface.c line 89:
> 
>   do {
>     if((err=ioctl(d->ioctl_fd, CDROMREADAUDIO, &arg))){
>       if(!d->error_retry)return(-7);
>       switch(errno){
>       ...
> 
> http://svn.xiph.org/trunk/cdparanoia/interface/cooked_interface.c

(please, don't drop me from the cc list!!)

it might be using the older sg interface, opening read/write to /dev/sgX
char devices directly. In which case you can't test it with ide-cd,
sadly.

-- 
Jens Axboe

