Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266302AbUBEUyZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 15:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266369AbUBEUyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 15:54:24 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:26541 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266302AbUBEUyW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 15:54:22 -0500
Date: Thu, 5 Feb 2004 21:54:21 +0100
From: Jens Axboe <axboe@suse.de>
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0, cdrom still showing directories after being erased
Message-ID: <20040205205421.GE11683@suse.de>
References: <20040205203336.GE10547@stud.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040205203336.GE10547@stud.uni-erlangen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 05 2004, Thomas Glanzmann wrote:
> Hi,
> 
> > now I got the error which I would expect after erasing the CD and trying
> > to mount it
> 
> > seems to me like some cache should have been invalidated, but was not
> 
> I hit at this problem while I was writing an IDE Atapi simulator for
> FAUmachine. The problem is that the kernel asks the CDROM if the 'disc
> has changed', which means that the disc was ejected and reinserted, and
> if this *isn't* the case the vfs or whatever assumes that the media
> hasn't changed and so the buffers will not be flushed. You can cirumvent
> this problem if you just eject and load the media back again.
> 
> And this isn't an issue of the cdrom (because my virtual cdrom on
> FAUmachine has no buffer) but an issue of the kernel caching.
> 
> The linux kernel atapi layer makes a TEST UNIT READY and if the media
> has changed the cdrom does return an ERR_STAT with a UNIT_ATTENTION
> which means that the medium has changed. IF that this the case the
> kernel flushes it's buffers.

So the drive ought to report media changed if it knowingly over wrote
the table of contents, for instance.

I still think this is to be expected when mucking in undefined teritory.
Reload the media, it's not hard... Sure you can get around this with
snooping if you really wanted to, but IMO it's wasted effort. Add -eject
to cdrecord command line of default config, how you want so solve it is
not my problem.

-- 
Jens Axboe

