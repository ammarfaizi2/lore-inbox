Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263975AbTI2RoO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 13:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263980AbTI2Rnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 13:43:50 -0400
Received: from web40902.mail.yahoo.com ([66.218.78.199]:22546 "HELO
	web40902.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263979AbTI2Rn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 13:43:26 -0400
Message-ID: <20030929174324.86819.qmail@web40902.mail.yahoo.com>
Date: Mon, 29 Sep 2003 10:43:24 -0700 (PDT)
From: Bradley Chapman <kakadu_croc@yahoo.com>
Subject: Re: [BUG] Defunct event/0 processes under 2.6.0-test6-mm1
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030929094136.0b4bb026.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mr. Morton,

--- Andrew Morton <akpm@osdl.org> wrote:
> Bradley Chapman <kakadu_croc@yahoo.com> wrote:
> >
> > I am experiencing defunct event/0 kernel daemons under 2.6.0-test6-mm1
> >  with synaptics_drv 0.11.7, Dmitry Torokhov's gpm-1.20 with synaptics
> >  support, and XFree86 4.3.0-10. Moving the touchpad in either X or with
> >  gpm causes defunct event/0 processes to be created. 
> 
> Defunct is odd.  Have you run `dmesg' to see if the kernel oopsed?
> 
> You could try reverting synaptics-reconnect.patch, and then serio-reconnect.patch
> from
> 
>
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test6/2.6.0-test6-mm1/broken-out

I reverted these two patches and rebooted. No such luck; I noticed that immediately
after starting gpm and X and moving my Logitech MX700 mouse to start the Konsole,
I had many events/0 processes that were defunct. No Oopses at all. Here is the
relevant part of dmesg:

drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
Synaptics Touchpad, model: 1
 Firmware: 5.9
 Sensor: 28
 new absolute packet format
 Touchpad has extended capability bits
 -> four buttons
 -> multifinger detection
 -> palm detection
mousedev: attached device SynPS/2 Synaptics TouchPad at input/mouse0 <----- *
input: SynPS/2 Synaptics TouchPad on isa0060/serio4
serio: i8042 AUX3 port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
...
hub 1-0:1.0: new USB device on port 1, assigned address 2
mousedev: attached device Logitech USB Receiver at input/mouse1 <---------- *
input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:1d.0-1

If you want the rest of the USB parts, I can send that too.

Brad

[*] - This is a patch I added to mousedev.c at the end of mousedev_connect() -
when the input core connects a new device to mousedev, this message prints the
devnode it made it available on. It's just a debugging patch.


=====
Brad Chapman

Permanent e-mail: kakadu_croc@yahoo.com

__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com
