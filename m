Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271924AbTGYHh1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 03:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271943AbTGYHh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 03:37:26 -0400
Received: from imap.gmx.net ([213.165.64.20]:1695 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S271924AbTGYHhZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 03:37:25 -0400
Date: Fri, 25 Jul 2003 09:52:22 +0200
From: Dominik Brugger <ml.dominik83@gmx.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: OHCI problems with suspend/resume
Message-Id: <20030725095222.21a2632e.ml.dominik83@gmx.net>
In-Reply-To: <20030724224600.GB430@elf.ucw.cz>
References: <20030723220805.GA278@elf.ucw.cz>
	<20030724143731.5fe40b4e.ml.dominik83@gmx.net>
	<20030724224600.GB430@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.0claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning,

> Do not unload modules before suspend, they should handle that just
> fine.

If I keep them loaded during suspend:

[...]
Suspending devices
uhci-hcd 0000:00:11.2: suspend to state 3
drivers/usb/host/uhci-hcd.c: dc00: suspend_hc
 hwsleep-0257 [10] acpi_enter_sleep_state: Entering sleep state [S3]
Enabling SEP on CPU 0
Back to C!
Devices Resumed
uhci-hcd 0000:00:11.2: resume
[...]
drivers/usb/host/uhci-hcd.c: dc00: wakeup_hc

Mouse doesn't work, unplug:

hub 1-0:0: port 1, status 300, change 3, 1.5 Mb/s
usb 1-1: USB disconnect, address 2
drivers/usb/core/usb.c: nuking urbs assigned to 1-1
usb 1-1: unregistering interfaces
drivers/usb/core/usb.c: nuking urbs assigned to 1-1
usb 1-1: hcd_unlink_urb df7be640 fail -22
usb 1-1: hcd_unlink_urb df7be540 fail -22
drivers/usb/core/usb.c: usb_hotplug
usb 1-1: unregistering device
drivers/usb/core/usb.c: usb_hotplug
hub 1-0:0: port 1 enable change, status 300
drivers/usb/host/uhci-hcd.c: dc00: suspend_hc

replug:

hub 1-0:0: port 1, status 301, change 3, 1.5 Mb/s
hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
hub 1-0:0: new USB device on port 1, assigned address 3
drivers/usb/core/message.c: usb_control/bulk_msg: timeout

Further attempts to un/re-plug the device show no response.

(Same with Canon Powershot instead of Logitech USB Mouse)

> With uhci on toshiba satelite I can do both S3 and S4, and USB
> survives that (at least it is able to power devices and detects
> plugs/unplugs).

In my case it is an Epox 8kha+ board, the problem should not be hardware specific since Suspend To RAM works under WinXP.

I will try S4 lateron.

-Dominik Brugger
