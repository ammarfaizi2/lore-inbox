Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264257AbTLVAKu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 19:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264267AbTLVAKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 19:10:50 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:33929 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S264257AbTLVAKs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 19:10:48 -0500
Date: Mon, 22 Dec 2003 01:10:39 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Raul Miller <moth@magenta.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: user problem with usb duo mouse and keyboard
Message-ID: <20031222001039.GA16419@ucw.cz>
References: <20031221154331.Z28449@links.magenta.com> <20031221213950.GA14664@ucw.cz> <20031221170323.D28449@links.magenta.com> <20031221223443.GA15744@ucw.cz> <20031221175121.E28449@links.magenta.com> <20031221230042.GA15960@ucw.cz> <20031221182757.F28449@links.magenta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031221182757.F28449@links.magenta.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 21, 2003 at 06:27:57PM -0500, Raul Miller wrote:

> On Mon, Dec 22, 2003 at 12:00:42AM +0100, Vojtech Pavlik wrote:
> > hid-core.c includes hid.h, which in turn, if DEBUG is defined, includes
> > hid-debug.h. That last file defines some functions (hid_dump_input,
> > hid_dump_device), which are called by hid-core.c.
> ...
> > This is the problem! Don't ever use usbkbd and usbmouse. Use hid
> > instead.
> 
> Oh!
> 
> And, looking at the docs on those modules, I see nice big warnings that
> say something similar...
> 
> Looking further, these modules where build and installed by default
> when I installed my system (debian, with the 2.4.18-bf2.4 kernel), and
> I've been carrying forward that configuration on my hand-built kernels,
> and never realized I needed to get rid of those modules.
> 
> I see the hid-debug messages in syslog now, but the keyboard and mouse
> are working properly as well.  Do you want to pursue this any further?
> [If so, I can send you the messages.]

If they are working, then no.

> [It's perhaps of note that the extra keys on the keyboard are reported
> as scancode 0 by showkey (with other release scan codes) when plugged

This is normal. This is because the keycodes are above 128 and that's
all that you can fit into a single signed byte.

> in via usb and which have different keypress scan codss when plugged as
> a ps/2 keyboard.]

This is also normal and can be fixed via the setkeycodes utility. The
driver cannot be preconfigured for every PS/2 keyboard out there,
because their scancodes conflict. On USB the configuration is static,
because USB carries much more information about the keys.

> [[There's a slight chance that [to avoid confused messages from other
> people in my situation] a warning message from hid about usbkbd and
> usbmouse would be a good idea.]]

Maybe. But fortunately current distros get it right.

> Thank you very much.
> Sorry about the confusion,

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
