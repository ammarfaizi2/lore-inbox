Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270994AbTGPR7g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 13:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271017AbTGPR7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 13:59:34 -0400
Received: from gate.crashing.org ([63.228.1.57]:42186 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S270994AbTGPR5v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 13:57:51 -0400
Date: Wed, 16 Jul 2003 13:10:26 -0500 (CDT)
From: <ajoshi@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] radeonfb 0.1.9 against 2.4.21pre2 (fwd)
In-Reply-To: <1058365086.515.89.camel@gaston>
Message-ID: <Pine.LNX.4.10.10307161258230.21751-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Many of these have already been addressed in 0.1.9, though I added the
usage of the native clock, assertion for it, the dvi blanking, and the
nolcd passthrough.  For things like the updated PM code, a patch would be
helpful.


ani



On 16 Jul 2003, Benjamin Herrenschmidt wrote:

> On Wed, 2003-07-16 at 15:05, Marcelo Tosatti wrote:
> > Ani,
> > 
> > I'm sending your patch to lkml CC benh.
> > 
> > All changes should be reviewed publically.
> 
> hrm... ok, here are my complaints against 0.1.9:
> 
>  - rinfo->name shall not be a pointer to an entry stored in a
> __devinitdata array, or get_fix() would possibly access freed
> memory
> 
>  - you didn't take my code for obtaining the DFP info from the
> BIOS. The current code works only with some flat panels (laptops
> mostly in my understanding). Also, I defaulted to syncs active
> high when using the "old" code, that fixed some laptops and is
> what XFree does
> 
>  - On LCDs you should use the LCD native pixel clock when using
> the RMX engine, not the mode specified one. Without this, scaled
> mode in XFree won't work properly among others on a lot of panels
> 
>  - The workaround when setting PLL registers helped some laptop
> users (not writing them when they don't change)
> 
>  - I added some sanity checking to the clocks we obtain from
> the BIOS pll block, especially since we now have relaxed algorithm
> to find the BIOS, that makes sense
> 
>  - If you fail to retreive BIOS infos, rinfo->clock can be 0 and
> you divide by 0 when setting the mode
> 
>  - After much discussions with some other hackers, I decided to
> keep the pitch to match exactly xres when accel is not enabled for
> various old apps that can't deal with a line lenght beeing different,
> you didn't take that code, so 0.1.9 won't work with those apps.
> 
>  - I added some code that helps blanking on some DVI panels in
> radeonfb_blank
> 
>  - When force_nolcd is set, I want to still call getmoninfo,
> not break (in radeonfb_pci_register())
> 
>  - There are more cases in radeonfb_switch where you want to
> reprogram the mode. Typically, accel flag changes, 15/16 bits
> changes, etc... Also, I worked around some XFree bugs by
> always re-initing the engine. It's not perfect yet, hopefully
> X will be fixed sooner or later, though I had no time to
> investigate that much yet.
> 
>  - I don't like the "workaround" disabling dynamic clocks in
> XFree, the code ATI gave me for M6, M7 and M9 on Apple HW enabled
> dynamic clocks, so I suspect those work properly, and I want the
> power saving. I suppose we shall discuss that with ATI to find out
> a better workaround
> 
>  - The "PM" code isn't up to date (cleanups & small fixes I did)
> 
>  - Not important, but inconsistent use of tab/space (you basically
> replace all tabs by spaces in code you touched) can be painful ;)
> 
> 
> I may have missed one or two though... 
> 
> Ben.
> 

