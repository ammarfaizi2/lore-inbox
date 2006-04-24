Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750948AbWDXQFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbWDXQFq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 12:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbWDXQFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 12:05:46 -0400
Received: from tim.rpsys.net ([194.106.48.114]:15055 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1750812AbWDXQFp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 12:05:45 -0400
Subject: Re: [RFC] [PATCH] Make ACPI button driver an input device
From: Richard Purdie <rpurdie@rpsys.net>
To: dtor_core@ameritech.net
Cc: Matthew Garrett <mjg59@srcf.ucam.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@suse.cz>
In-Reply-To: <d120d5000604240745i71bd56b8n99b97130388d36f6@mail.gmail.com>
References: <20060419195356.GA24122@srcf.ucam.org>
	 <20060419200447.GA2459@isilmar.linta.de>
	 <20060419202421.GA24318@srcf.ucam.org>
	 <d120d5000604240745i71bd56b8n99b97130388d36f6@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 24 Apr 2006 17:05:30 +0100
Message-Id: <1145894731.7155.120.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-24 at 10:45 -0400, Dmitry Torokhov wrote:
> Yes, I still need to apply it.
> 
> Matthew, I would recommend not adding KEY_LID but using one of the
> switch codes (SW_0?) for the lid.
> 
> Richard, on your handhelds what switch would be most similar to
> notebook's lid? Should we alias one of the switches to SW_LID?

This gets tricky as the handhelds have two "lid" switches. Pictures of
how it can fold are at http://www.dynamism.com/sl-c3000/main.shtml . To
summarise, it can be in three positions:

* Screen folded facing the keys (shut like a laptop)
* Screen open above the keyboard (like an open laptop)
* Screen folded over the keys but with the screen visible (becomes a
tablet like handheld with no keyboard)

Shut is when both switches (SW_0 and SW_1) are pressed, open is when
neither are pressed and the "no keyboard" mode has only one switch
pressed.

The final switch (SW_2) is mapped to headphone detection.

If we are going to have a KEY_LID switch, we should probably decide now
whether the switch is pressed (1) when the lid is either open or shut
otherwise things are going to get confused.

I've often wondered whether the input system could/should be used to
pass more generic events. I know my handheld has lots of other switch
like events such as MMC/SD card insertion, CF card insertion, a battery
lock switch, AC power insertion switch and USB cable detection "switch".
Most of these are currently acted on by the kernel so userspace doesn't
need to see them but some like the USB cable detection would be useful.
It could then load the user's chosen USB gadget kernel module for
example. In that case its a user choice as there is no "right" gadget
module to autoload. I'm not sure if it would be right for these to go
via the input system and last time I looked, udev wasn't able to handle
generic events like this. 

In an ideal world, given the system nature of the events, perhaps they'd
be better suited to a more generalised or specialised piece of code
based on the input system. A more general events system would mean we
could have:

EVENT_LID_SHUT
EVENT_LID_OPEN
EVENT_LID_OPEN_NOKEYBOARD

or similar which would avoid the issues associated with a single SW_LID
switch. I suspect there are no easy answers though.

Whilst sort of on the subject (AC power switches and AC power events)
I'd like to see some standard way of exporting power/battery information
to userspace. Currently, the ARM handhelds use kernel emulation of an
APM bios and export the battery info as part of that. Making ARM emulate
ACPI interfaces doesn't appeal. The answer could be a battery sysfs
class and the above system events interface but I'm open to other
suggestions.

Cheers,

Richard

