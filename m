Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131801AbRBESri>; Mon, 5 Feb 2001 13:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132138AbRBESr2>; Mon, 5 Feb 2001 13:47:28 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:11274 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S131801AbRBESrS>;
	Mon, 5 Feb 2001 13:47:18 -0500
Date: Mon, 5 Feb 2001 19:46:59 +0100
From: Jens Axboe <axboe@suse.de>
To: Oliver Feiler <kiza@lionking.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Very high system load writing data to SCSI DVD-RAM
Message-ID: <20010205194659.U5285@suse.de>
In-Reply-To: <20010205193216.A198@lionking.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010205193216.A198@lionking.org>; from kiza@lionking.org on Mon, Feb 05, 2001 at 07:32:16PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 05 2001, Oliver Feiler wrote:
> Hello,
> 
> 	I have the following problem with a DVD-RAM drive. The drive is a 
> Panasonic LF-D101 connected to a Tekram DC395U SCSI controller. Kernel is 
> 2.2.18 with the patch for the Tekram controller 
> (http://www.garloff.de/kurt/linux/dc395/). 
> 
> 	When I write huge amounts of data to a DVD-RAM the system load is 
> getting very high, like 10 or even above and the system temporarily freezes 
> for a short time every minute or so while writing data to the drive. The DVD 
> drive writes data with 1.35 MB/sec on the discs so there is not really much 

This is an old problem, and not related to the dvd-ram itself. If you
dirty lots of data and the target device is slow, kswapd/bdflush
will go crazy trying to free up memory. It should behave better on
2.4.1, where we impose a global limit on locked buffers. Try and run
a vmstat 1 while doing the copy, and send that along.

> data going over the SCSI controller. Reading data from DVD-RAMs is done with 
> 2.7 MB/s (2x) by the drive and does not cause any problems at all.

Reading is much easier to control.

> 	There is a 4x Teac burner connected to the SCSI controller as well. 
> Burning CDs does not raise the system load or cause any other problems.

Burning CDs is very different and does not put pressure on the mm.

-- 
Jens Axboe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
