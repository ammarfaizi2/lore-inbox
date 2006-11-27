Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758548AbWK0UBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758548AbWK0UBm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 15:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758547AbWK0UBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 15:01:42 -0500
Received: from outbound-cpk.frontbridge.com ([207.46.163.16]:16944 "EHLO
	outbound1-cpk-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1758548AbWK0UBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 15:01:41 -0500
X-BigFish: VP
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
Date: Mon, 27 Nov 2006 13:04:21 -0700
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: "Alan" <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org, info-linux@ldcmail.amd.com
Subject: Re: char: Add MFGPT driver for the CS5535/CS5536
Message-ID: <20061127200421.GB4495@cosmic.amd.com>
References: <20061122205736.GA588@cosmic.amd.com>
 <LYRIS-4270-95737-2006.11.22-15.19.56--jordan.crouse#amd.com@whitestar.amd.com>
MIME-Version: 1.0
In-Reply-To: <LYRIS-4270-95737-2006.11.22-15.19.56--jordan.crouse#amd.com@whitestar.amd.com>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 27 Nov 2006 19:58:22.0916 (UTC)
 FILETIME=[64B50840:01C7125E]
X-WSS-ID: 69759CD41WC1545491-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/06 22:17 +0000, Alan wrote:
> > The attached driver provides a low-level interface to the block, and 
> > allows for other kernel drivers to use the timers. 
> 
> Three comments
> 
> 2.	There is an RTC timer interface - could you use that interface
> for some of this so its compatible and consistent ?

Do you mean, use the RTC interface itself (i.e. - turn the mfgpt driver
into an RTC driver), or just emulate parts of the RTC interface in the
MFGPT driver.   I would be fine with the second option - the first doesn't
really fit, since the only functionality the RTC and the MFGPT share is
the periodic interrupt feature (which is sub-optimal on RTC anyway).

If the "timer interrupt" feature feels tacked on, thats because it is.
The best use for the MFGPT block is to drive a duty cycle on the
output pin suitable for LEDs and such.  Most Geode customers would use 
it for that purpose.  Running a close second on the usefulness scale is
the watchdog timer - its always nice to have that sort of functionality 
available at the hardware level (and its a double bonus that the watchdog
can be set up to continue running while in suspend).

The interrupt/NMI functionality was added to the hardware for the BIOS to 
use, and we added it to the kernel driver for a sense of completeness.
I personally can't fathom anybody using the timers, and I would gladly 
remove them if nobody else can come up with a realistic usage model.

> 3.	Ditto for a watchdog use - although that would be a separate
> driver using the kernel hooks anyway.

That was the plan - I do have a watchdog driver that I had when I first
wrote the MFGPT driver for a now defunct project.  I should dust it off
and add it in.

Thanks,
Jordan

-- 
Jordan Crouse
Senior Linux Engineer
Advanced Micro Devices, Inc.
<www.amd.com/embeddedprocessors>


