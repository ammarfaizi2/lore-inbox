Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261722AbREOX4c>; Tue, 15 May 2001 19:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261718AbREOX4M>; Tue, 15 May 2001 19:56:12 -0400
Received: from mailproxy.de.uu.net ([192.76.144.34]:23714 "EHLO
	mailproxy.de.uu.net") by vger.kernel.org with ESMTP
	id <S261716AbREOX4A>; Tue, 15 May 2001 19:56:00 -0400
Content-Type: text/plain; charset=US-ASCII
From: Tim Jansen <tim@tjansen.de>
To: David Brownell <david-b@pacbell.net>
Subject: Re: LANANA: To Pending Device Number Registrants
Date: Wed, 16 May 2001 01:56:23 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <047801c0dd95$231331e0$6800000a@brownell.org>
In-Reply-To: <047801c0dd95$231331e0$6800000a@brownell.org>
Cc: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <01051601562302.01000@cookie>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 May 2001 01:16, David Brownell wrote:
>Only if it's augmented by additional device IDs, such as the
>"what 's the physical connection for this interface" sort of
>primitive that's been mentioned.
>[...]
> I suppose that for network interface names, some convention for
> interface ioctls would suffice to solve that "identify" step.  PCI
> devices would return the slot_name, USB devices need something
> like a patch I posted to linux-usb-devel a few months back.

At this point of the discussion I would like to point to the Device Registry 
patch (http://www.tjansen.de/devreg) that already solves these problems and 
offers stable device ids for the identification of devices and finding their 
/dev nodes.

The devreg device id has four components: the bus identifier, the location of 
the device (for pci bus number and slot number, for usb the bus number and a 
list of port numbers), a model (product and device id) and, if available, a 
serial number. 
With the matching algorithm from the libdevreg library you can correctly 
identifiy after a hotplug action or reboot
- each device that has a serial numberas most of the better USB devices do, 
even if it location has changed
- a device without a serial number whose location has not changed

If you have a device without serial number and you changed its location the 
device id can be used for a guess that is correct as long as you dont have 
two devices of the same kind (same product and vendor ids). 

bye...
