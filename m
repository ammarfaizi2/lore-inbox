Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932485AbWACTyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbWACTyA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 14:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbWACTyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 14:54:00 -0500
Received: from styx.suse.cz ([82.119.242.94]:26339 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932485AbWACTx7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 14:53:59 -0500
Date: Tue, 3 Jan 2006 20:53:44 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Michael Hanselmann <linux-kernel@hansmi.ch>, linux-kernel@vger.kernel.org,
       linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 1/1] usb/input: Add missing keys to hid-debug.h
Message-ID: <20060103195344.GC6443@corona.home.nbox.cz>
References: <20060102233730.GA29826@hansmi.ch> <200601030142.32623.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601030142.32623.dtor_core@ameritech.net>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2006 at 01:42:31AM -0500, Dmitry Torokhov wrote:
> On Monday 02 January 2006 18:37, Michael Hanselmann wrote:
> > This patch adds the missing keys from input.h to hid-debug.h.
> > 
> > Signed-off-by: Michael Hanselmann <linux-kernel@hansmi.ch>
> 
> Thank you Michael, I will add it to my tree. I still ponder your other
> patch and whether we should employ something like hooks for HID.
 
We should split HID in two parts - transport and decoding. This would
help in many places:

	Bluetooth would be happy, because it uses the same HID protocol
	on top of a different transport layer (completely non-USB).

	Wacom and many other blacklisted devices would be happy, because
	they could use the USB HID transport - no blacklist would be
	needed.

	Would allow for /dev/usb/rawhid0 style devices, which would give
	access to raw HID reports without any parsing done.

	Would allow userspace drivers for broken UPS devices (like APC)
	without the need for special handling of their bugs in the kernel.

It seems to me it could be almost its own layer, like serio or gameport.
Windows has an API like that.

I don't have the time to do the split myself, but it shouldn't be too
hard.

It would not be the perfect solution for Apple keyboards, because the
patch is simplifies by doing the processing after parsing the reports,
but still, since it would allow for device-specific parsers, it'd be a
reasonable solution for devices that need more special handling than
just a simple quirk.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
