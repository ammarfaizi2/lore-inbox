Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbVIBPDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbVIBPDj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 11:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750703AbVIBPDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 11:03:39 -0400
Received: from fmr18.intel.com ([134.134.136.17]:61077 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750702AbVIBPDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 11:03:38 -0400
From: Mark Gross <mgross@linux.intel.com>
Organization: Intel
To: Pavel Machek <pavel@suse.cz>
Subject: Re: Telecom Clock driver for MPCBL0010 ATCA compute blade.
Date: Fri, 2 Sep 2005 08:01:40 -0700
User-Agent: KMail/1.7.1
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
References: <200508301159.34053.mgross@linux.intel.com> <20050831191155.GH703@openzaurus.ucw.cz>
In-Reply-To: <20050831191155.GH703@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200509020801.40699.mgross@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 31 August 2005 12:11, Pavel Machek wrote:
> Hi!
> 
> > The following is a driver I would like to see included in the base kernel.
> > 
> > It allows OS controll of a device that synchronizes signaling hardware 
across a ATCA chassis.
> > 
> > The telecom clock hardware doesn't interact much with the operating 
system, and is controlled 
> > via registers in the FPGA on the hardware.  It is hardware that is unique 
to this computer.
> 
> Now... it is probably not feasible, but: why does it need special interface 
to userland?
> Could not it simply act as yet another timesource, and be controlled via 
get/settimeofday?
> 

The telcom clock is a special circuit, line card PLL, that provids a mechanism 
for synchronization of hardware across the backplane of a chassis of multiple 
computers with similar specail curcits.  In this case the synchronization 
signals get routed to multiple places, typically to pins on expansion slots 
for hardware that knows what to do with this signal.  (SONET, G.813, stratum 
3...) and similar signaling applications found in telcom sites can use this 
type of thing.

The actual device is hidden behind the FPGA on the motherboar, and is 
connected to the FPGA via I2C.  This driver only talks to the FPGA registers.

I suppose it could be configured to have the FPGA fire an interrupt ever ytime 
some count of clocks come in off the back plane.  The hardware really wasn't 
designed to do this and I would worry that as the interrupt source is really 
the FPGA getting I2C / traffic from the actual telcom clock hardware that 
there would be some latencies and funny business that would make it less than 
good for hard core applications.

I really don't know but, it might be possible to make it "short of work" as a 
time source to the OS.   I'm not going to bother trying. ;)

--mgross

>     Pavel

-- 
--mgross
BTW: This may or may not be the opinion of my employer, more likely not.  
