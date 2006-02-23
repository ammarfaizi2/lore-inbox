Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750984AbWBWEja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbWBWEja (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 23:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751047AbWBWEja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 23:39:30 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:42710
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750984AbWBWEja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 23:39:30 -0500
Date: Wed, 22 Feb 2006 20:39:37 -0800
From: Greg KH <greg@kroah.com>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: what's a platform device?
Message-ID: <20060223043937.GA7204@kroah.com>
References: <Pine.LNX.4.44.0602221517370.21264-100000@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0602221517370.21264-100000@gate.crashing.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 03:47:40PM -0600, Kumar Gala wrote:
> Guys,
> 
> I was hoping to get your opinion on a question I had.  The question comes 
> down to what we think a "platform device" is.
> 
> The situation I have is an FPGA connected over PCI.  The FPGA implements
> various device functionality (serial ports, I2C controller, IR, etc.) as a
> single PCI device/function.  The FPGA breaks any notion of a true PCI
> device, it uses PCI as a device interconnect more than anything else.
> 
> In talking to Greg about this, he suggested I just create a new bus_type
> for this similar to what is being done for usb-serial.  As I started to
> think about what I wanted ended up being a platform_device plus a sysfs
> entry for the MMIO region.
> 
> So, it seems that a "platform device" is a pretty generic concept now.  Do 
> you guys thing its acceptable to use a platform device for my needs or 
> should I create some new bus_type?  Do we have a better definition of what 
> a platform device is or might be?

Well, your FPGA is a pci device, right?  It's only the devices that hang
off of it that you are concerned about.  I really think you should make
your own bus type, as it's not much work, and it would not disturb the
existing platform devices, which do not know about mmio regions like
PCI.

thanks,

greg k-h
