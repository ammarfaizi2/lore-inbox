Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965245AbVKBVNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965245AbVKBVNw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 16:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965246AbVKBVNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 16:13:52 -0500
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:53665 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S965245AbVKBVNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 16:13:51 -0500
Date: Wed, 2 Nov 2005 16:13:50 -0500
To: tcrix@att.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: No sharing IRQ broken board problem
Message-ID: <20051102211350.GD9488@csclub.uwaterloo.ca>
References: <110220052106.23704.43692A6C000AA6AE00005C98215876675598079D0C9B@att.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <110220052106.23704.43692A6C000AA6AE00005C98215876675598079D0C9B@att.net>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2005 at 09:06:53PM +0000, tcrix@att.net wrote:
> I have a pci board in development that works but..
> it can not share the interrupt line.  
> 
> Has someone hacked through the problem of reserving one of the inta, intb, .. 's for a single device?  I would love to see how you did so I could continue on with my driver while I wait for the !@$#!@ hardware guys to fix the board. 

As far as I understand the PCI specs, your device is currently NOT a PCI
device.

Support for shared IRQs on PCI is as far as I can tell not optional.
Short of designing your own mainboard there is no way to prevent the
interrupt lines from being joined.  One one board I use there are 6 PCI
devices, with 3 on INT-A and 3 on INT-B (The SBC doesn't have INT-C and
INT-D).  On my desktop machine, INT A is the same on slot 1 and 5, 2,
and 6 and onyl 3 and 4 have INT-A to themselves.  Of course this doesn't
prevent the bios from assigning the same IRQ to INT-A on multiple sets
as well.  I have run a PPro some years ago with a single IRQ shared
among all the PCI devices in the system.  Neither linux nor windows had
a problem with that and neither did any of the many PCI devices.

I think you are stuck waiting for the hardware guys to give you a PCI
device that is really a PCI device.  If you are lucky you can find one
slot in your machine that doesn't share INT-A with any other PCI device,
although on most modern machines there are so many PCI devices that it
is imposible to find one that isn't shared.

Len Sorensen
