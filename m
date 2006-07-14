Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161211AbWGNDKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161211AbWGNDKb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 23:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161216AbWGNDKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 23:10:31 -0400
Received: from marcansoft.com ([80.68.93.119]:25864 "EHLO smtp.marcansoft.com")
	by vger.kernel.org with ESMTP id S1161211AbWGNDKb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 23:10:31 -0400
Message-ID: <44B70B21.7050109@marcansoft.com>
Date: Fri, 14 Jul 2006 05:10:25 +0200
From: "Hector Martin [LKML]" <hector+lkml@marcansoft.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060605)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: USB HID output events
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm building and writing the firmware for a homebrew USB HID device.
Currently it just behaves like a HID gamepad, with a set of buttons. The
device has four lights associated with four of the buttons, which by
default light up when the buttons are pressed. However, the host should
be able to set the device in an override mode and take control of the
lights independently.

I'll be writing the userland interface software too (it will really just
be a patch to a game), for linux. Does linux have a mechanism where a
userland process can send events to a USB HID device? I am quite new to
USB (this is my first project with it, although I managed to figure out
how to implement a HID device based on some device-side driver code I
found), and I'm not sure how I should go about implementing this, both
device-side and host-side. The host-side process must be able to run
non-root and still be able to access the lights.

There should be two modes: automatic lights, and overriden lights. This
can be implemented both in host-side and device-side (as controlled by a
user configuration on the device). Ideally, both would be: if the host
wishes to control the lights, and the user set the device to allow it,
then the device will listen to the host's information. Otherwise (if the
host is unwilling to control the lights at this time, or the device is
set by the user to ignore the host's information, or both), then the
device will revert to controlling the lights itself. This will allow for
the user to control the setting on the device without having to mess
around on the host software (which on its current implementation makes
making this configuration change annoying, as it requires a reset to the
main menu), and also allows the device to control the lights when the PC
doesn't want to do it.

I of course can set the device to do pretty much anything I want with
USB. I'd need to make it allow receiving USB HID events (it already
does, but currently ignores them). I'm not sure how I should implement
this in USB descriptor format, though, or how the data should be formatted.

Any help, pointers, or other information would be very appreciated.

Sincerely,
-- 
Hector Martin (hector@marcansoft.com)
Public Key: http://www.marcansoft.com/hector.asc

