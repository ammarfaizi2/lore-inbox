Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280293AbRKNH53>; Wed, 14 Nov 2001 02:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280306AbRKNH5T>; Wed, 14 Nov 2001 02:57:19 -0500
Received: from 28.ppp1-3.hob.worldonline.dk ([212.54.85.28]:16516 "EHLO
	milhouse.home.kernel.dk") by vger.kernel.org with ESMTP
	id <S280293AbRKNH5B>; Wed, 14 Nov 2001 02:57:01 -0500
Date: Wed, 14 Nov 2001 08:56:42 +0100
From: Jens Axboe <axboe@suse.de>
To: Dave Jones <davej@suse.de>
Cc: Brian Ristuccia <bristucc@sw.starentnetworks.com>,
        linux-kernel@vger.kernel.org
Subject: Re: elvtune fails with DAC960 and devfs on 2.4.14
Message-ID: <20011114085642.G17933@suse.de>
In-Reply-To: <20011113145315.T22467@osiris.978.org> <Pine.LNX.4.30.0111132206431.6089-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0111132206431.6089-100000@Appserv.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13 2001, Dave Jones wrote:
> On Tue, 13 Nov 2001, Brian Ristuccia wrote:
> 
> > I can't seem to adjust the elevator parameters for this block device, but
> > can't:
> > # elvtune /dev/rd/disc0/disc
> > ioctl get: Invalid argument
> 
> DAC960.c doesn't know about BLKELVSET / BLKELVGET, and control is
> only passed down to the generic ioctl in the case of BLKBSZSET,
> and doesn't have a default: entry in the switch statement of
> DAC960_IOCTL()
> 
> I've not seen one of these devices, so I'm not sure if this makes
> sense or not, but passing on requests to the lower level should
> be a simple..
> 
> 	default:
> 		return( blk_ioctl(Inode->i_rdev, Request, Argument));
> 
> Addition.

Or just add it to the BLKBSZGET etc string that pass it on to blk_ioctl
anyways.

> There may be other reasons this driver doesn't provide the
> elevator ioctls though.

None, it was simply never added.

-- 
Jens Axboe

