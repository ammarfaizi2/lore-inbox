Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261818AbVBINZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261818AbVBINZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 08:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261819AbVBINZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 08:25:27 -0500
Received: from [195.23.16.24] ([195.23.16.24]:20692 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261818AbVBINZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 08:25:16 -0500
Message-ID: <420A0ECF.3090406@grupopie.com>
Date: Wed, 09 Feb 2005 13:23:27 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Linux-Input <linux-input@atrey.karlin.mff.cuni.cz>,
       Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [RFC/RFT] [patch] Elo serial touchscreen driver
References: <20050208164227.GA9790@ucw.cz>
In-Reply-To: <20050208164227.GA9790@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> Hi!
> 
> I've written a driver for probably the most common touchscreen type -
> the serial Elo touchscreen.

If we are serious about getting support for serial touchscreens into the 
kernel, I can certainly give a hand there.

I work for a company that develops software for restaurants, and we have 
a Linux port of our main application running in actual restaurants with 
a custom made Linux distribution for about 2 years now.

We had to support a number of touchscreens, and we do it in the 
application itself, reading the serial port and processing the data.

If this could go into the kernel, then our application needed only to 
read the input device, and handle events, no matter what touch screen 
was there. That would be a great improvement :)

> The driver should handle all generations of serial Elos, as it handles
> Elo 10-byte, 6-byte, 4-byte and 3-byte protocols.

> I do not have any touchscreen, so I can't test the driver myself.

I have one that uses the 10 byte protocol (I've never seen one ELOtouch 
that used one of the other protocols). I can give you some feedback as 
soon as I have some time to test it.

> So if you have the time, please comment on the code of the patch,
> and if you have an Elo, please try the driver with it.
> 
> [...]
> +		case 9:
> +			if (elo->csum) {
> +				input_regs(dev, regs);
> +				input_report_abs(dev, ABS_X, (elo->data[4] << 8) | elo->data[3]);
> +				input_report_abs(dev, ABS_Y, (elo->data[6] << 8) | elo->data[5]);
> +				input_report_abs(dev, ABS_PRESSURE, (elo->data[8] << 8) | elo->data[7]);
> +				input_report_key(dev, BTN_TOUCH, elo->data[8] || elo->data[7]);

This one is weird. In my code I have this:

 >            button = ((buf[2] & 0x03) != 0);

So maybe, ELO touchscreens that don't have pressure sense output, only 
send "touch down / up" information on the 2 LSB's of the third byte(?)

Anyway, inputattach should have a command line option to set the 
baudrate manually, as some of these touchscreens have configurable 
baudrates, and some POS manufacturers set them to non-default values.

Also, I've already seen touchscreens where the POS manufacturer got the 
pin-out wrong (or something like that) so the touch reports the X 
coordinate where the Y should be, and vice-versa. I really don't know 
where this should be handled (driver, input layer, application?), but it 
must be handled somewhere for the applications to work.

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
