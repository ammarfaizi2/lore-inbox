Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272487AbTGaOSL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 10:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273026AbTGaOSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 10:18:11 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:1544 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S272487AbTGaOSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 10:18:08 -0400
Date: Thu, 31 Jul 2003 16:18:07 +0200
From: Pavel Machek <pavel@suse.cz>
To: David Brownell <david-b@pacbell.net>
Cc: weissg@vienna.at, kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] OHCI problems with suspend/resume
Message-ID: <20030731141807.GC16463@atrey.karlin.mff.cuni.cz>
References: <20030723220805.GA278@elf.ucw.cz> <3F2673C4.9010302@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F2673C4.9010302@pacbell.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> 
> Here's a patch that makes things slightly better.  It's still
> not fully functional yet -- I forgot how many FIXMEs are in
> those PM code paths! -- and shouldn't be merged as-is, but it
> works slightly better:
> 
>  - Has a more informative diagnostic message (which HC died);
> 
>  - When HC dies, mark the whole tree as unavailable so that
>    new URB submissions using that HC will just fail;
> 
>  - Then hcd_panic() just disconnects all the devices, still
>    keeping the root hub around.
> 
>  - OHCI-specific (should be generic, hcd-pci.c):  don't
>    try resuming a halted controller.
> 
> Where "better" means that it seems functional after the
> first suspend/resume cycle, and re-enumerates the device
> that's connected ... but there's still strangeness.  And
> I can see how some of it would be generic.

For me it:

reports problem after first suspend, and ohci stops working

oopses in hcd_panic during second suspend (IIRC).
							Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
