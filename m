Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262040AbUKVK4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbUKVK4N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 05:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262067AbUKVKxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 05:53:52 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:10119 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262063AbUKVKwa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 05:52:30 -0500
Date: Mon, 22 Nov 2004 11:51:58 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan Chandler <alan@chandlerfamily.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide-cd problem
Message-ID: <20041122105157.GB10463@suse.de>
References: <200411201842.15091.alan@chandlerfamily.org.uk> <200411211025.11629.alan@chandlerfamily.org.uk> <200411211613.54713.alan@chandlerfamily.org.uk> <200411220752.28264.alan@chandlerfamily.org.uk> <20041122080122.GM26240@suse.de> <E1CWBSN-0003mF-4s@home.chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CWBSN-0003mF-4s@home.chandlerfamily.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22 2004, Alan Chandler wrote:
> Jens Axboe writes: 
> 
> >On Mon, Nov 22 2004, Alan Chandler wrote:
> >>On Sunday 21 November 2004 16:13, Alan Chandler wrote:
> >>...
> >>>
> >>> This seems to be some combination of frequently occuring timing problem,
> >>> and the difference treatment in cdrom_newpc_intr to cdrom_pc_intr 
> >>
> >>I put a ndelay(400) at the head of cdrom_newpc_intr and the problem of
> >>DRQ being set when there was no data to transfer disappeared.  It
> >>appears that my hardware is too slow. 
> >>
> >>I have been reading the ATA/ATAPI - 6 spec, and it implies that the
> >>state of DRQ line need one pio cycle before being correct and that you
> >>should read the alternative status register to achieve this.  I tried
> >>a simple 
> >>
> >>HWIF(drive)->INB( IDE_ALTSTATUS_REG); 
> >>
> >>But that made no difference.
> >
> >ALTSTATUS read should be fine as well, but the implicit delay is
> >probably better. 
> >
> 
> I don't know why, but the ALTSTATUS read did NOT work when I tried it 
> yesterday (am currently at work using web mail to access my mail - can't do 
> more until this evening).  Its possible I put it in the wrong place (ie 
> after the cdrom_decode_status call, but I don't think so. 
> 
> The ndelay(400) did work. 
> 
> >Is this enough to fix it? For ->drq_interrupt we already should have
> >an adequate delay, Alan fixed this one recently. 
> >
> 
> Yes, I had included this patch quite early in my process of tracking
> the problem down (when I corrected it like you have (add the drive
> parameter to the OUTBSYNC macro like you have, you also need to
> declare an unsigned long flags at the head of the routine that was
> also not in that patch).  Indeed it was this that was the inspiration
> for the 400 nanosecs in my change.  I have no idea what the right
> number should be 

400ns is the correctl value. Your writing is a little unclear to me -
did it work or not, with that change alone?

-- 
Jens Axboe

