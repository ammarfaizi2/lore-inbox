Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261485AbSJMKM4>; Sun, 13 Oct 2002 06:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261486AbSJMKM4>; Sun, 13 Oct 2002 06:12:56 -0400
Received: from mail.scram.de ([195.226.127.117]:5096 "EHLO mail.scram.de")
	by vger.kernel.org with ESMTP id <S261485AbSJMKM4>;
	Sun, 13 Oct 2002 06:12:56 -0400
Date: Sun, 13 Oct 2002 12:14:13 +0200 (CEST)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@gfrw1044.bocc.de
To: greg@kroah.com, Wilfried Soeker / Cleware GmbH <wsoeker@cleware.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Cleware Linux Info
In-Reply-To: <3DA92640.8030301@cleware.de>
Message-ID: <Pine.LNX.4.44.0210131149060.867-100000@gfrw1044.bocc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i assume you try to search for a particular HID device by its serial
number.

> 1. The struct hiddev_devinfo lacks the serial number. In the usb
> structure, the
> index of the string is available, but not the number itself.

I don't think it's the right way to scan through all devices and query for
the serial number (even if it were available). This would be a very
expensive operation on systems with devfs as modprobe would be called on
each try to open an unavailable device (I know some ALSA utils
occasionally do the same, but it's still a bad thing).

IMHO, the right way would be to scan /proc/bus/usb/devices for the device
with the desired serial number and then open the corresponding
hiddev device.

However, it looks like the information about the corresponding
hiddev device is not included in /proc/bus/usb/devices (at least on
2.4.19). Is there a way to get the device name without scanning through
all hiddev devices and scan for the USB dev num instead (would be as bad
as scanning for the serial number in the first place).

--jochen

