Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751269AbVKNT67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbVKNT67 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 14:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbVKNT67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 14:58:59 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:62426 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751267AbVKNT66 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 14:58:58 -0500
Subject: Re: Calibration issues with USB disc present.
From: john stultz <johnstul@us.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: George Anzinger <george@mvista.com>, ganzinger@mvista.com,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20051114184940.GA876@kroah.com>
References: <43750EFD.3040106@mvista.com>
	 <1131746228.2542.11.camel@cog.beaverton.ibm.com>
	 <20051112050502.GC27700@kroah.com> <4376130D.1080500@mvista.com>
	 <20051112213332.GA16016@kroah.com> <4378DDC5.80103@mvista.com>
	 <20051114184940.GA876@kroah.com>
Content-Type: text/plain
Date: Mon, 14 Nov 2005 11:58:58 -0800
Message-Id: <1131998339.4668.16.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-14 at 10:49 -0800, Greg KH wrote:
> On Mon, Nov 14, 2005 at 10:56:05AM -0800, George Anzinger wrote:
> > Greg KH wrote:
> > >On Sat, Nov 12, 2005 at 08:06:37AM -0800, George Anzinger wrote:
> > >>Greg KH wrote:
> > >On these boxes, I'd just recommend disabling USB legacy support
> > >completly, if possible.  And then complain loudly to the vendor to fix
> > >their BIOS.
> > 
> > But if one is booting from that device...
> 
> Booting from a USB device?  I can see this happening when installing a
> distro, and you boot from the USB cdrom, but not for "normal"
> operations.
> 
> Oh well, publicly mock the manufacturer for doing horrible things in
> their BIOS and then no one will buy the boxes, and we will not have
> problems :)

I suspect the right fix is in-between. We should try to push hardware
makers away from using SMIs recklessly, but we should also do our best
to work around those that don't. The same problems crop up w/
virtualization where time-based calibration may be interrupted.

George, again, there has been some SMI resistant delay calibration code
added recently. You mentioned this problem was seen on 2.4 kernel, so
you could verify that the new code in 2.6.14 works and if so, try
backporting it.

If not we need to see what else we can do about improving delay
calibration (its a similar tick-based problem to what I'm addressing
with the timeofday rework) or reducing the use of delay by using
something else.

thanks
-john


