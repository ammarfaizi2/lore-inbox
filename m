Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262701AbUBZGzR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 01:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbUBZGzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 01:55:17 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:58343 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262701AbUBZGzJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 01:55:09 -0500
Date: Thu, 26 Feb 2004 07:55:05 +0100
From: Jens Axboe <axboe@suse.de>
To: Byron Stanoszek <gandalf@winds.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to force cdrom driver to redetect media after cdrecord?
Message-ID: <20040226065505.GB32080@suse.de>
References: <Pine.LNX.4.58.0402251611590.6015@winds.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402251611590.6015@winds.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25 2004, Byron Stanoszek wrote:
> > > I originally thought so, but maybe I was wrong. Jens posted a patch
> > > to invalidate kernel buffers on an umount - if the problem persists
> > > with that patch, I still believe it is a hardware fault.
> >
> > Perhaps another program has the device open still? In that case, we
> > don't invalidate the toc cache.
> >
> > --
> > Jens Axboe
> 
> Jens,
> I ran into something similar today. I'd like to use cdrecord to write
> to a CD and then immediately turn around and read from it for
> verification purposes...
> 
> ...Except that I only get 2048 bytes from a 'cat /dev/scd0' until I
> take the CD out and put it back in.
> 
> Is there a known way for a userland application to make an ioctl to
> the cdrom device in a 2.4/2.6 kernel to tell it the media changed
> without forcing a tray open & close?
> 
> I intend to execute a program with this ioctl (if there is such a
> thing) after the cdrecord and before the 'cat'.

That should already work in 2.6 current, when the last program closes
the drive the toc is invalidated. For 2.4 you are probably out of luck,
use something like eject to open/close the tray.

-- 
Jens Axboe

