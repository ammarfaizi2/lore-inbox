Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279201AbRKMVMP>; Tue, 13 Nov 2001 16:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279170AbRKMVMF>; Tue, 13 Nov 2001 16:12:05 -0500
Received: from ns.suse.de ([213.95.15.193]:60431 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S279156AbRKMVL4>;
	Tue, 13 Nov 2001 16:11:56 -0500
Date: Tue, 13 Nov 2001 22:11:53 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Brian Ristuccia <bristucc@sw.starentnetworks.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: elvtune fails with DAC960 and devfs on 2.4.14
In-Reply-To: <20011113145315.T22467@osiris.978.org>
Message-ID: <Pine.LNX.4.30.0111132206431.6089-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2001, Brian Ristuccia wrote:

> I can't seem to adjust the elevator parameters for this block device, but
> can't:
> # elvtune /dev/rd/disc0/disc
> ioctl get: Invalid argument

DAC960.c doesn't know about BLKELVSET / BLKELVGET, and control is
only passed down to the generic ioctl in the case of BLKBSZSET,
and doesn't have a default: entry in the switch statement of
DAC960_IOCTL()

I've not seen one of these devices, so I'm not sure if this makes
sense or not, but passing on requests to the lower level should
be a simple..

	default:
		return( blk_ioctl(Inode->i_rdev, Request, Argument));

Addition.

There may be other reasons this driver doesn't provide the
elevator ioctls though.

regards,

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

