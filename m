Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263355AbTE3ICx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 04:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263365AbTE3ICx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 04:02:53 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:36626 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263355AbTE3ICw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 04:02:52 -0400
Date: Fri, 30 May 2003 09:16:06 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Dave Airlie <airlied@linux.ie>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IRQ_NONE definition in NCR5380 driver...
Message-ID: <20030530091606.A7813@flint.arm.linux.org.uk>
Mail-Followup-To: Dave Airlie <airlied@linux.ie>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.53.0305300024550.14345@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.53.0305300024550.14345@skynet>; from airlied@linux.ie on Fri, May 30, 2003 at 12:27:25AM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 30, 2003 at 12:27:25AM +0100, Dave Airlie wrote:
> Currently the NCR5380.h defines IRQ_NONE to be 255, is there any special
> reason for this? why not use UINT32_MAX-1?..
> 
> The VAX actually has got more than 255 interrupt handlers which we've
> mapped to IRQs, and it happens the external SCSI interface is at 255, so
> this makes it a bit sick...
> 
> I've redefined it in our tree to 65535 but I see no reason not to go to
> the above... any objections?

Only that ARM already has a NO_IRQ macro fairly well established for this
thing, which should probably be propagated to the other architectures.
Could we call it NO_IRQ instead?

I seem to remember that in the dim and distant past, several drivers
used to store IRQ numbers in byte-sized objects, so this would need to
be fixed before making NO_IRQ > 255.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

