Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161107AbWBTSVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161107AbWBTSVe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 13:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161111AbWBTSVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 13:21:34 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:48900 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1161108AbWBTSVd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 13:21:33 -0500
Message-ID: <43FA0867.5060001@cfl.rr.com>
Date: Mon, 20 Feb 2006 13:20:23 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Olivier Galibert <galibert@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: Flames over -- Re: Which is simpler?
References: <200602131116.41964.david-b@pacbell.net> <200602181251.09865.david-b@pacbell.net> <43F80ACC.20704@cfl.rr.com> <200602192150.05567.david-b@pacbell.net> <43F9E95A.6080103@cfl.rr.com> <20060220165153.GA33155@dspnet.fr.eu.org>
In-Reply-To: <20060220165153.GA33155@dspnet.fr.eu.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Feb 2006 18:23:31.0859 (UTC) FILETIME=[C0E8A630:01C6364A]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14279.000
X-TM-AS-Result: No--1.250000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olivier Galibert wrote:
> USB has this additional problem that devices lose their addresses when
> the power is removed (it's very agressively hotplug).  So you can have
> the devices moving around under your feet between poweroff and poweron
> just because the devices happened to have enumerated in a different
> order at boot time.
> 

Isn't that address abstracted out by the usb layer?  i.e. there is no 
relationship between the device number and the usb bus address, so 
there's no reason the usb layer can't update it's internal data 
structures to point the old device to the new bus address.  Also if the 
USB host controller wants to, can't it assign any address it likes to 
each device on the bus?  It doesn't HAVE to assign them in sequence as 
the devices are enumerated does it?

I'm not all that familiar with USB, but I'd imagine it is somewhat like 
I2C/SMBUS: each device has a descriptor block that contains information 
about itself.  This is going to be unique for any given device.  The 
host controller begins by querying the broadcast address, and all 
unconfigured devices respond.  At some point a bit in their descriptor 
blocks will differ, and there will be a collision, at which point, the 
device trying to transmit a high bit will yield and let the others 
continue.  Eventually only one device will be left having sent its 
entire descriptor block to the host, and the host can then assign a 
unique address to that device.  The host repeats this until all devices 
have been assigned an address.

Because of this, given the same hardware on the bus, the same 
enumeration will happen every time, and the host can assign whatever 
address it wants to each device should it choose to do so rather than 
just assign them in ascending order.  If the host wanted to, it could 
power down the bus, and when it powers back up, it could assign the same 
addresses that they had before to the devices as they are enumerated, 
and new devices would get unused addresses.


