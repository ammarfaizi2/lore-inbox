Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265232AbUFHPt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265232AbUFHPt7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 11:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265229AbUFHPt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 11:49:58 -0400
Received: from winds.org ([68.75.195.9]:58277 "EHLO winds.org")
	by vger.kernel.org with ESMTP id S265232AbUFHPt4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 11:49:56 -0400
Date: Tue, 8 Jun 2004 11:49:51 -0400 (EDT)
From: Byron Stanoszek <gandalf@winds.org>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Behavior of serial usb driver when unplugged
Message-ID: <Pine.LNX.4.60.0406081137030.9168@winds.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm currently using Linux (2.6.7-rc3) in an embedded system with a 8-port
Sealevel SeaLink 2802 USB device. This is a 8-port RS-232/422 device that
allocates /dev/ttyUSB0 through /dev/ttyUSB7 when plugged in.

If I have a process talking to one of the ports, e.g. 'cat < /dev/ttyUSB0', and
I unplug the USB hub, all ports except ttyUSB0 unregister properly.

Without killing the 'cat' process, plugging the hub back in will make it
allocate /dev/ttyUSB1 through /dev/ttyUSB8, thereby offsetting each USB port#
by 1.

When killing the 'cat' process at this point, the kernel reports:

drivers/usb/serial/ftdi_sio.c: error from flowcontrol urb
drivers/usb/serial/ftdi_sio.c: Error from DTR LOW urb
drivers/usb/serial/ftdi_sio.c: Error from RTS LOW urb

and then unregisters /dev/ttyUSB0.


Is there a way to allow "hotplug" of a USB device to reuse /dev/ttyUSB0
regardless if an application still has that particular tty open?

If not, is there a way I could make the serial subsystem can send an EIO errno
or some other notification when the serial device is disconnected?

Thanks for your help,
  -Byron

--
Byron Stanoszek                         Ph: (330) 644-3059
Systems Programmer                      Fax: (330) 644-8110
Commercial Timesharing Inc.             Email: byron@comtime.com
