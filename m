Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161223AbWAMFhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161223AbWAMFhY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 00:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbWAMFhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 00:37:24 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:47372 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751505AbWAMFhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 00:37:23 -0500
Date: Fri, 13 Jan 2006 06:37:06 +0100
From: Willy Tarreau <willy@w.ods.org>
To: "Calin A. Culianu" <calin@ajvar.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SBC: Winsystems EPX-C3 Watchdog Timer?
Message-ID: <20060113053706.GL7142@w.ods.org>
References: <Pine.LNX.4.64.0601122044190.9231@rtlab.med.cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601122044190.9231@rtlab.med.cornell.edu>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 12, 2006 at 08:48:43PM -0500, Calin A. Culianu wrote:
> 
> Hi,
> 
> I wanted to see if a driver for the watchdog timer built into the 
> Winsystems EPX-C3 SBC board is something the linux kernel people are 
> interested in.  If so, how should I structure the driver if I were to 
> submit it?
> 
> The reason I ask is that this board's watchdog is pretty basic/primitive. 
> It is not a PCI device, it doesn't have any status registers per se and 
> is configured by jumpers on the board only.
> 
> Behavior of the watchdog (if configured):
> 
> Enable the watchdog:  Write a 1 to io address: 0x1EE
> Pet the watchdog before the timeout period (1.5s or 200s depending on 
> jumper config): Write any value to io address: 0x1EF
> Disable the watchdog: Write a 0 to io address: 0x1EE.
> 
> Pretty basic huh?  As such -- there is no way to tell in software if the 
> watchdog exists, if it is enabled, or how long the timeout is.  Since 
> this is so basic.. does it belong in the mainline kernel?  Or should it 
> best be done as a userspace program instead?

Most of a watchdog's intelligence should be in userspace. However,
it's interesting to put the basic watchdog driver in kernel so that
you have the choice to use any watchdog daemon which will ping
/dev/watchdog. So I think that basically, your driver should turn
any write to /dev/watchdog into a write to 0x1EF.

Now about your concern that there's no way to detect the presence
of the hardware, well, it's already a problem with most such hardware.
I think you don't have to worry about that. Just put a big config
warning, put a message at startup reminding that it will write to
0x1EE and 0x1EF, and that's all.

> Any guidance is appreciated..
> 
> -Calin

Willy

