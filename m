Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268260AbUHFTmB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268260AbUHFTmB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 15:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268257AbUHFTkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 15:40:19 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:32267 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S268258AbUHFTiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 15:38:55 -0400
Date: Fri, 6 Aug 2004 20:38:49 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Hamie <hamish@travellingkiwi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide-cs using 100% CPU
Message-ID: <20040806203849.I13948@flint.arm.linux.org.uk>
Mail-Followup-To: Hamie <hamish@travellingkiwi.com>,
	linux-kernel@vger.kernel.org
References: <40FA4328.4060304@travellingkiwi.com> <20040806202747.H13948@flint.arm.linux.org.uk> <4113DD20.1010808@travellingkiwi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4113DD20.1010808@travellingkiwi.com>; from hamish@travellingkiwi.com on Fri, Aug 06, 2004 at 08:33:52PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2004 at 08:33:52PM +0100, Hamie wrote:
> Russell King wrote:
> 
> >On Sun, Jul 18, 2004 at 10:30:16AM +0100, Hamie wrote:
> >  
> >
> >>Anyone know why this happens? Something busy waiting? (BUt that should 
> >>show as system cpu right?) or something taking out really long locks?
> >>    
> >>
> >
> >It'll be because IDE is using PIO to access the CF card, which could
> >have long access times (so reading a block of sectors could take some
> >time _and_ use CPU.)  Obviously, PIO requires the use of the CPU, so
> >the CPU can't be handed off to some other task while this is occuring.
> >
> >  
> >
> Well... I did consider that. And not to disbelieve you, since you know 
> the kernel way better than I do, But decided I was being silly that a 
> 1.6GHz Pentium-M processor should use 100% CPU moving a couple of 
> MB/second across a CF interface...
> 
> Is 100% CPU not excessive? IIRC my PIII-750 used to use less CPU doing 
> the same job as quick, or even slightly faster...
> 
> And should it not use system CPU rather than user CPU?

Actually, if its being accounted for as waitIO, then we should be
running some other task...  However, I've just realised that we
don't appear to specifically account IO waits in the kernel, so
I'm not sure how userspace comes up with this magic number.

Sorry for the noise...

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
