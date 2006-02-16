Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbWBPQl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbWBPQl2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 11:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWBPQl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 11:41:28 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:28065
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932326AbWBPQl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 11:41:27 -0500
Date: Thu, 16 Feb 2006 08:41:08 -0800
From: Greg KH <greg@kroah.com>
To: Kaiwan N Billimoria <kaiwan@designergraphix.com>
Cc: philippe.seewer@bfh.ch, linux-kernel@vger.kernel.org
Subject: Re: Stuck creating sysfs hooks for a driver..
Message-ID: <20060216164108.GA12420@kroah.com>
References: <43F2DE34.60101@designergraphix.com> <20060215221301.GA25941@kroah.com> <43F46319.9090400@designergraphix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F46319.9090400@designergraphix.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2006 at 05:03:45PM +0530, Kaiwan N Billimoria wrote:
> One thing i'd like to point out though, Greg: the LM70 is an 
> SPI/Microwire based system and not i2c; so straight away, the i2c 
> interface by itself will not be used...; also, the specific board 
> (LM70CILD-3, which i've written the 2.4 driver for & am now porting to 
> 2.6), comes with a built-in parport interface..so that's what the driver 
> takes into account of course..

That's fine, you do not have to be a i2c driver to use the hwmon
interface.  There are other drivers in the drivers/hwmon/ directory
today that are not i2c drivers.  It is not a requirement at all.

> Also it's a relatively simple temperature sensor - it does not seem to 
> support hysteresis temperature, i/p voltages, etc. I'm saying all this 
> as the sysfs interface i envision is just a simple read-only hook: the 
> o/p value (after a little userspace massaging) is the temperature in 
> Celsius correct to 0.25 degrees. So it looks to me that this particular 
> driver necessitates a kind-of "custom" entry under /sys/class/hwmon with 
> it's own userspace support. Do I move ahead in this direction?

No.  Use the same names for your files as is described in the document.
If you can't provide all of the different files, that's fine, just
provide what you can.  The userspace tools will handle this properly.

This also keeps you from having to write custom userspace tools for
every individual program that wants to know this information.

thanks,

greg k-h
