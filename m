Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbTLBNPx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 08:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbTLBNPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 08:15:53 -0500
Received: from mailgate3.globalintranet.net ([194.206.181.244]:52630 "EHLO
	relais-int15.globalintranet.net") by vger.kernel.org with ESMTP
	id S262076AbTLBNPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 08:15:48 -0500
X-Lotus-FromDomain: MGE-UPS
From: arnaud.quette@mgeups.com
To: Greg KH <greg@kroah.com>, Paul Stewart <stewart@wetlogic.net>,
       Vojtech Pavlik <vojtech@suse.cz>
cc: linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net,
       opensource@mgeups.com, "Charles Lepple" <clepple@ghz.cc>
Message-ID: <C1256DF0.0048D122.00@gin123.ftgin.com>
Date: Tue, 2 Dec 2003 14:18:25 +0100
Subject: USB/HID UPS issue (was Re: USB scanner issue)
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi folks,

I take the opportunity of the previous discussion (USB
scanner obsolescence) to relaunch the one about hidddev.


On Mon, Dec 01, 2003 at 11:21:58AM -0800, Greg KH wrote:
> ...
> Can't you use xsane without the scanner kernel driver?  I thought the
> latest versions used libusb/usbfs to talk directly to the hardware.
> Because of this, the USB scanner driver is marked to be removed from the
> kernel sometime in the near future.

I'm thinking about doing the same with hiddev
as I'm facing new problems each times we solve
one! Currently, MGE devices won't work fine with
latest kernels (2.4 and 2.6). I've identified that
config/report descriptors are queried another time
at the end of HID enumeration, but the device doesn't
have time to answer (about 1,5 sec, instead of the
standard "5 sec" timeout). I've not found the cause
after digging, so I've directly gone to the next
step.

So I've setup the libHID project [1] to allow this
HID support, only used by UPSs at the moment (I've
seen passing some comments about USB radio and
other gadgets). But others complex HID devices are
welcomed.

My last problem is that I can't succeed in deactivating
hiddev at runtime (I've tryed various form of
"alias hiddev off" in modules.conf without success).
This still cause nasty side effect to the device.

So my question is: If we have userland HID support
through libHID (in the same way as libusb), is hiddev
still needed? I obviously don't talk about hid (core),
joy/keyb/mouse which are still needed...

Your feedback about all of that is welcomed.

Arnaud

[1] http://savannah.nongnu.org/projects/libhid
http://www.ghz.cc/~clepple/libHID/doc/html/index.html


