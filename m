Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264494AbTKNCOd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 21:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264499AbTKNCOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 21:14:33 -0500
Received: from web11503.mail.yahoo.com ([216.136.172.35]:42107 "HELO
	web11503.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264494AbTKNCOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 21:14:31 -0500
Message-ID: <20031114021430.12641.qmail@web11503.mail.yahoo.com>
Date: Thu, 13 Nov 2003 18:14:30 -0800 (PST)
From: gary ng <garyng2000@yahoo.com>
Subject: USB mouse driver depends on module loading sequence to function properly ?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a small USB to PS/2 converting device which has
one USB male to plug to the computer and the other end
has two PS/2 connector, one for keyboard, one for
mouse.

While it is recognized correctly by linux and all the
proper drivers loaded, the mouse just doesn't work but
the keyboard function normally(both plug to this
device). I use hotplug package to manage to
loading/unloading stuff.

After some digging, I found that in order for the
mouse to be properly initiated(and it would work), I
have to do the module loading in the following
sequence :

modprobe usbcore
modprobe hid
modprobe usb-uhci

but by default, I do it as(well, hotplug does) :

modprobe usbcore
modprobe usb-uhci

What is even stranger is that if I just plug an USB
mouse in the system, the later sequence works.

So it seems that for this particular device(which has
two USB HID devices on the same bus), the loading
sequence of hid(must be before everything else) is
important in order for the mouse port to work but for
simple USB mouse, it doesn't matter.

I am not sure if this should be classified as a bug
and if it should be reported here. My current work
around is to just load hid right after usbcore.

I am using 2.4.21 vanilla kernel. Please let me know
if there is other information needed or if I should
report to a different devloper group(say hotplug).

regards,

gary

__________________________________
Do you Yahoo!?
Protect your identity with Yahoo! Mail AddressGuard
http://antispam.yahoo.com/whatsnewfree
