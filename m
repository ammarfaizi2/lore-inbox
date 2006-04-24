Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750962AbWDXQ0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbWDXQ0q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 12:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbWDXQ0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 12:26:46 -0400
Received: from nz-out-0102.google.com ([64.233.162.201]:4108 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750837AbWDXQ0p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 12:26:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n7mFOlLMXoe/W4jLlAObf7HZgW16nNRGtayskrL/CIxBJL5knwRsm8MowPlLdVcrwWgHAgup5rUbvGZ2FyFXdysKqzGN9mwGglFjCCqwMGs8rZlXGN5IdyPIVBh+HsmiuNRNKodT/ctWYLzcNQrlTi4zgOVZtW9DgCBa2rdzyjY=
Message-ID: <d120d5000604240926u51fc06d6gbf4f23832064e0ad@mail.gmail.com>
Date: Mon, 24 Apr 2006 12:26:44 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Richard Purdie" <rpurdie@rpsys.net>
Subject: Re: [RFC] [PATCH] Make ACPI button driver an input device
Cc: "Matthew Garrett" <mjg59@srcf.ucam.org>,
       "Dominik Brodowski" <linux@dominikbrodowski.net>,
       linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Pavel Machek" <pavel@suse.cz>
In-Reply-To: <1145894731.7155.120.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060419195356.GA24122@srcf.ucam.org>
	 <20060419200447.GA2459@isilmar.linta.de>
	 <20060419202421.GA24318@srcf.ucam.org>
	 <d120d5000604240745i71bd56b8n99b97130388d36f6@mail.gmail.com>
	 <1145894731.7155.120.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/06, Richard Purdie <rpurdie@rpsys.net> wrote:
> On Mon, 2006-04-24 at 10:45 -0400, Dmitry Torokhov wrote:
> > Yes, I still need to apply it.
> >
> > Matthew, I would recommend not adding KEY_LID but using one of the
> > switch codes (SW_0?) for the lid.
> >
> > Richard, on your handhelds what switch would be most similar to
> > notebook's lid? Should we alias one of the switches to SW_LID?
>
> This gets tricky as the handhelds have two "lid" switches. Pictures of
> how it can fold are at http://www.dynamism.com/sl-c3000/main.shtml . To
> summarise, it can be in three positions:
>
> * Screen folded facing the keys (shut like a laptop)
> * Screen open above the keyboard (like an open laptop)
> * Screen folded over the keys but with the screen visible (becomes a
> tablet like handheld with no keyboard)
>
> Shut is when both switches (SW_0 and SW_1) are pressed, open is when
> neither are pressed and the "no keyboard" mode has only one switch
> pressed.
>

Ugh... I wonder if we could change SW_0 to report "comletely
shut"/"open" and SW_1 to report orientation. Then we could alias SW_0
<-> SW_LID, SW_1 <-> SW_TABLET_MODE.

> The final switch (SW_2) is mapped to headphone detection.
>

We need to start naming switches so drivers will use same constants
for similar switches.

> If we are going to have a KEY_LID switch, we should probably decide now
> whether the switch is pressed (1) when the lid is either open or shut
> otherwise things are going to get confused.
>

SW_LID please.

> I've often wondered whether the input system could/should be used to
> pass more generic events. I know my handheld has lots of other switch
> like events such as MMC/SD card insertion, CF card insertion, a battery
> lock switch, AC power insertion switch and USB cable detection "switch".
> Most of these are currently acted on by the kernel so userspace doesn't
> need to see them but some like the USB cable detection would be useful.
> It could then load the user's chosen USB gadget kernel module for
> example. In that case its a user choice as there is no "right" gadget
> module to autoload. I'm not sure if it would be right for these to go
> via the input system and last time I looked, udev wasn't able to handle
> generic events like this.
>

I don't think these belong to input system.

> In an ideal world, given the system nature of the events, perhaps they'd
> be better suited to a more generalised or specialised piece of code
> based on the input system. A more general events system would mean we
> could have:
>
> EVENT_LID_SHUT
> EVENT_LID_OPEN
> EVENT_LID_OPEN_NOKEYBOARD
>
> or similar which would avoid the issues associated with a single SW_LID
> switch. I suspect there are no easy answers though.

Bring dbus into the kernel ;) No, I think kernel should not have
"cover everythingunder the sun" interface but rather set of
specialized ones.

>
> Whilst sort of on the subject (AC power switches and AC power events)
> I'd like to see some standard way of exporting power/battery information
> to userspace. Currently, the ARM handhelds use kernel emulation of an
> APM bios and export the battery info as part of that. Making ARM emulate
> ACPI interfaces doesn't appeal. The answer could be a battery sysfs
> class and the above system events interface but I'm open to other
> suggestions.
>

Having generic battery interface would be nice.

--
Dmitry
