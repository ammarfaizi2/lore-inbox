Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261473AbVALVvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbVALVvV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 16:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbVALVs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 16:48:56 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:21778 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261411AbVALVnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 16:43:55 -0500
Date: Wed, 12 Jan 2005 21:43:45 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ian Molton <spyro@f2s.com>
Subject: Re: MMC Driver RFC
Message-ID: <20050112214345.D17131@flint.arm.linux.org.uk>
Mail-Followup-To: Richard Purdie <rpurdie@rpsys.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Ian Molton <spyro@f2s.com>
References: <021901c4f8eb$1e9cc4d0$0f01a8c0@max>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <021901c4f8eb$1e9cc4d0$0f01a8c0@max>; from rpurdie@rpsys.net on Wed, Jan 12, 2005 at 09:10:12PM -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2005 at 09:10:12PM -0000, Richard Purdie wrote:
> 1. Card Detection Interrupts
> 
> The MMC code completely misses card removals on my test hardware as when the 
> interrupt triggers electrical contact is still fully functional.
> 
> The PXA code calls mmc_detect_change() whenever an interrupt is detected. 
> The MMC core then does a schedule_work(&host->detect). The problem is that 
> when the interrupt is generated, the card may not be 100% inserted or 100% 
> removed. Given the mechanical nature of insertions and removals, electrical 
> contact is possible for a while after removal has been started (and a while 
> before insertion is complete).

If your socket works like that, you need to handle that by using a timer
yourself.  It normally only affects removal rather than insertion.

> 2. Card Initialisation Problems
> 
> One of my cards works fine. The other works when I enable debug and doesn't 
> when I don't. I suspect the delay while it does a printk gives something 
> time to happen that doesn't normally when running at full speed!

Different cards behave differently.  I suspect you have yet another
quirky card.

> I suspect this is related to the 1ms wait that was added to mmc_setup() as 
> per comments. Is there any documentation which tells us exactly what timings 
> we should be aiming for here? Has anyone else has problems like this?

There isn't any 1ms wait in mmc_setup().

> 3. SD Support
> 
> Ian Molton seems to have added SD support to handhelds.org's kernel. I'm 
> still trying to contact him to discuss this but the following patch enables 
> SD cards to work for me:
> http://www.rpsys.net/openzaurus/2.6.11-rc1/mmc_sd-r1.patch

People are nervous about SD support - the SD forum has been traditionally
rather closed, and there is the perception that a SD card driver may not
go down well.  I have even heard rumours of patent issues/IP issues in
this area, and I don't wish to get stung.

However, that said, the situation has improved recently - we've gone from
no documentation to limited documentation.  However, this documentation
still isn't sufficient to do the job - eg, the SD formats for the CID
and CSD registers remain completely undocumented.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
