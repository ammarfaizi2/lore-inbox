Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261961AbUCIOQW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 09:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261949AbUCIOQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 09:16:22 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:62424 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261524AbUCIOQU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 09:16:20 -0500
Date: Tue, 9 Mar 2004 15:16:17 +0100
From: Jens Axboe <axboe@suse.de>
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cdromaudio patch gives up too easily
Message-ID: <20040309141616.GN23525@suse.de>
References: <1078841242.995.24.camel@newt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1078841242.995.24.camel@newt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09 2004, Adrian Cox wrote:
> The patch for DMA based CD reading worked well for me until I tried to
> read the audio from a badly damaged CDR.  At this point the code dropped
> back to the old mechanism and stayed that way for further CDs.
> 
> The logs below show what happened, running 2.6.4-rc2 with just that
> patch:
> 
> cdrom: open failed.
> hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
> hdc: packet command error: error=0x30
> ATAPI device hdc:
>   Error: Medium error -- (Sense key=0x03)
>   (reserved error code) -- (asc=0x57, ascq=0x00)
>   The failed "Prevent/Allow Medium Removal" packet command was:
>   "1e 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "
> cdrom: open failed.
> hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
> hdc: packet command error: error=0x30
> ATAPI device hdc:
>   Error: Medium error -- (Sense key=0x03)
>   (reserved error code) -- (asc=0x57, ascq=0x00)
>   The failed "Prevent/Allow Medium Removal" packet command was:
>   "1e 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "
> cdrom: cdda rip sense 03/02/00
> cdrom: dropping to old style cdda

Ok, it's pretty harmful. I was just telling Andrew last week that I
wanted to add sense checking for whether we should fall back to pio or
not. Probably something as simple as checking for sense key 0x04 or 0x0b
and then skipping dma completely, all others keep going.

Thanks for testing, I'm pretty happy with the results you got. They are
just a bit too conservative, rather that than throwing up.

-- 
Jens Axboe

