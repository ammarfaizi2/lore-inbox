Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265923AbUFOUaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265923AbUFOUaW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 16:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265931AbUFOUaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 16:30:22 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:35717 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S265923AbUFOUaJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 16:30:09 -0400
Date: Tue, 15 Jun 2004 22:30:53 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Karel =?iso-8859-1?Q?Kulhav=FD?= <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_USB_HID vs. CONFIG_USB_HIDINPUT
Message-ID: <20040615203053.GA2568@ucw.cz>
References: <20040615140705.B6153@beton.cybernet.src> <20040615160502.GA11059@ucw.cz> <20040615171451.A6843@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040615171451.A6843@beton.cybernet.src>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 05:14:51PM +0000, Karel Kulhavý wrote:
> On Tue, Jun 15, 2004 at 06:05:02PM +0200, Vojtech Pavlik wrote:
> > On Tue, Jun 15, 2004 at 02:07:05PM +0000, Karel Kulhavý wrote:
> > > Hello
> > > 
> > > When I enable CONFIG_USB_HID and not enable CONFIG_USB_HIDINPUT in 2.4.25, will
> > > I get something different from when I don't enable neither of them?
> > > 
> > > The <Help> says basically the same about both: that they control
> > > "keyboards, mice, joysticks, graphics tablets, or any other HID based devices"
> > > (CONFIG_USB_HID)
> > > "keyboard, mouse or joystick or any other HID input device"
> > > (CONFIG_USB_HIDINPUT)
> > > 
> > > I assume
> > > 1) it doesn't matter if "keyboard" or "keyboards" is in the <Help>
> > > 2) graphics tablets are assumed to be "any other HID input devices".
> > 
> > In that case you get the HID driver, but you won't get the Input
> > binding, so the devices will be detected, but won't be accessible by the
> > common means (keyboard through console, mouse via /dev/input/mice,
> > etc.). They still will be accessible via HIDDEV, if you enable that.
> > 
> > Enabling HID without either HIDINPUT or HIDDEV is pointless.
> 
> So they are 4 meaningful combinations:
> 0)nothing
> 1)HIDDEV
> 2)HIDINPUT
> 3)HIDINPUT+HIDDEV
> 
> There are 3 tickboxes with 5 possible combinations.  I suggest reducing this
> count to 2 tickboxes with 4 naturally resulting combinations. I think it will
> be less confusing for a user.

Actually - not. CONFIG_USB_HID enables or disables the hid.o module, and
has three states - Y, N, M. The HIDINPUT/HIDDEV are just options for
that module, enabling/disabling some of its functionality, having only Y
and N states.

So it's quite straightforward. And there are 7 useful combinations,
out of 9 possible.

And in your suggested case, you would either have to make
HIDDEV/HIDINPUT tristate, resulting in illegal combinations of Y+M, or
you wouldn't be able to express that the driver should be built as a
module.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
