Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbWB0N2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbWB0N2v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 08:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWB0N2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 08:28:50 -0500
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:44521 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1751091AbWB0N2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 08:28:50 -0500
Date: Mon, 27 Feb 2006 08:28:48 -0500
To: col-pepper@piments.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: o_sync in vfat driver
Message-ID: <20060227132848.GA27601@csclub.uwaterloo.ca>
References: <op.s5cj47sxj68xd1@mail.piments.com> <op.s5jpqvwhui3qek@mail.piments.com> <op.s5kxhyzgfx0war@mail.piments.com> <op.s5kx7xhfj68xd1@mail.piments.com> <op.s5kya3t0j68xd1@mail.piments.com> <op.s5ky2dbcj68xd1@mail.piments.com> <op.s5ky71nwj68xd1@mail.piments.com> <op.s5kzao2jj68xd1@mail.piments.com> <op.s5lq2hllj68xd1@mail.piments.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <op.s5lq2hllj68xd1@mail.piments.com>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2006 at 11:50:40PM +0100, col-pepper@piments.com wrote:
> Hi,
> 
> OMG what do I have to do to post here? 10th attempt.
> {part2}
> 
> Here is a non-exhaustive list of typical devices types requiring fat vfat
> support:
> 
> fd ide-hd scsi-hd usb-hd cdrom usb-hd usb-handheld (iPod, iRiver etc)
> usb-flash (usbsticks, cameras, some music devices.)
> 
> IIRC the sync mount option for vfat is ignored for file systems >2G, this
> effectively (and probably intentionally) excludes nearly all hd partitions
> and iPod type devices.

I think many people wish it was ignored on smaller devices too given
what it does to write performance.  And if your device is flash based
and is one of the ones that doesn't have proper wear leveling the card
won't last long with sync enabled (even with wear leveling rewriting the
fat that often as sync seems to do can't be good for the lifespan of the
flash).

I suspect either vfat should ignore sync all the time, or it should at
least warn about its use so distributions don't think enabling it on all
removeable media is a good idea in general.  Or perhaps the vfat driver
could be made to wait for a file to be closed or at least have some
timeout before updating the fat table again.  Not sure.

Len Sorensen
