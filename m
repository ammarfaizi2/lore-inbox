Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265646AbUA0TdS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 14:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265657AbUA0Tc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 14:32:56 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9223 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265648AbUA0Tcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 14:32:39 -0500
Date: Tue, 27 Jan 2004 19:32:28 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Alan Stern <stern@rowland.harvard.edu>,
       Greg KH <greg@kroah.com>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: PATCH: (as177)  Add class_device_unregister_wait() and platform_device_unregister_wait() to the driver model core
Message-ID: <20040127193227.A30224@flint.arm.linux.org.uk>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Alan Stern <stern@rowland.harvard.edu>, Greg KH <greg@kroah.com>,
	Kernel development list <linux-kernel@vger.kernel.org>,
	Patrick Mochel <mochel@digitalimplant.org>
References: <Pine.LNX.4.44L0.0401251224530.947-100000@ida.rowland.org> <Pine.LNX.4.58.0401251054340.18932@home.osdl.org> <Pine.LNX.4.58.0401261435160.7855@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0401261435160.7855@serv>; from zippel@linux-m68k.org on Mon, Jan 26, 2004 at 05:22:41PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 26, 2004 at 05:22:41PM +0100, Roman Zippel wrote:
> For example pci drivers currently do something like:
> 
> int init()
> {
> 	if (pci_register_driver(drv) < 0)
> 		pci_unregister_driver(drv);
> }
> 
> void exit()
> {
> 	pci_unregister_driver(drv);
> }

I'd like to take this opportunity to mention that the above is buggy
as written.  If pci_register_driver() fails, the device_driver structure
is not registered, and therefore pci_unregister_driver() may cause
Bad Things(tm) to happen.

(and yes, pci_module_init() is buggy as it currently stands, and I
believe GregKH has a patch in his queue from the stability freeze
from yours truely to fix it.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
