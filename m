Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269590AbRHABIy>; Tue, 31 Jul 2001 21:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269587AbRHABIf>; Tue, 31 Jul 2001 21:08:35 -0400
Received: from gear.torque.net ([204.138.244.1]:33032 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S269586AbRHABId>;
	Tue, 31 Jul 2001 21:08:33 -0400
Message-ID: <3B6755E7.B63FA6D5@torque.net>
Date: Tue, 31 Jul 2001 21:05:43 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [RFT] Support for ~2144 SCSI discs
In-Reply-To: <200107310030.f6V0UeJ13558@mobilix.ras.ucalgary.ca>
		<rgooch@ras.ucalgary.ca>
		<10107310041.ZM233282@classic.engr.sgi.com>
		<200107311225.f6VCPj003249@mobilix.ras.ucalgary.ca>
		<20010731125926.B10914@us.ibm.com> <200108010048.f710miA05150@mobilix.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Richard Gooch wrote:
> 
> Mike Anderson writes:
> > In previous experiments trying to connect up to 512 devices we
> > switched to vmalloc because the static nature of sd.c's allocation
> > exceeds 128k which I assumed was the max for kmalloc YMMV.
> 
> Yes, I figure on switching to vmalloc() and putting in an
> in_interrupt() test in sd_init() to make sure the vmalloc() is safe.
> 
> Eric: do you happen to know why there are these GFP_ATOMIC flags?
> To my knowledge, nothing calls sd_init() outside of process context.

Richard,
I've seen GFP_KERNEL take 10 minutes in lk 2.4.6 . The 
mm gets tweaked pretty often so it is difficult to know 
exactly how it will react when memory is tight. A time 
bound would be useful on GFP_KERNEL.

<opinion> It is best to find out quickly there is 
not enough memory and have some alternate strategy 
to cope with that problem. GFP_KERNEL in its current 
form should be taken out and shot. </opinion>

Doug Gilbert
