Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263713AbUDYX1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263713AbUDYX1i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 19:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263715AbUDYX1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 19:27:38 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:65296 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263713AbUDYX1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 19:27:36 -0400
Date: Mon, 26 Apr 2004 00:27:33 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Kenn Humborg <kenn@linux.ie>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Platform device matching
Message-ID: <20040426002733.A26138@flint.arm.linux.org.uk>
Mail-Followup-To: Kenn Humborg <kenn@linux.ie>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20040425220511.GA20808@excalibur.research.wombat.ie> <20040426000050.F13748@flint.arm.linux.org.uk> <20040425231709.GA29153@excalibur.research.wombat.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040425231709.GA29153@excalibur.research.wombat.ie>; from kenn@linux.ie on Mon, Apr 26, 2004 at 12:17:09AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2004 at 12:17:09AM +0100, Kenn Humborg wrote:
> On Mon, Apr 26, 2004 at 12:00:50AM +0100, Russell King wrote:
> > On Sun, Apr 25, 2004 at 11:05:11PM +0100, Kenn Humborg wrote:
> > > I'm looking at the code for binding platform devices with drivers.  
> > > However, platform_match() doesn't seem to agree with its kerneldoc
> > > comment:
> > 
> > The code is correct as stands.  The documentation is behind times.  All
> > platform devices are "<name><instance-number>" so it's correct that the
> > "floppy" driver matches "floppy0" and "floppy1" etc.
> 
> Forgive me if I am being dense, but I still don't see how that works.  

Sorry, I should've explained a little more.

pdev->name is the platform device name, which is just the <name> part.
pdev->dev.bus_id is the device model name, which is <name><instance-number>,
and the devices are known by this name.

Rather than going to the trouble of parsing <name> from the device model
name which would be inherently buggy, we reference it directly from the
platform_device structure.

So, this comment needs updating:

 *      So, extract the <name> from the device, and compare it against
 *      the name of the driver. Return whether they match or not.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
