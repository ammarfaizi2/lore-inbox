Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbVADN6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbVADN6J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 08:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbVADN6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 08:58:09 -0500
Received: from styx.suse.cz ([82.119.242.94]:6609 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261631AbVADN6B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 08:58:01 -0500
Date: Tue, 4 Jan 2005 14:58:59 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [bk patches] Long delayed input update
Message-ID: <20050104135859.GA9167@ucw.cz>
References: <20041227142821.GA5309@ucw.cz> <200412271419.46143.dtor_core@ameritech.net> <20050103131848.GH26949@ucw.cz> <Pine.LNX.4.58.0501032148210.2294@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501032148210.2294@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2005 at 09:54:33PM -0800, Linus Torvalds wrote:

> I pulled and immediately unpulled again.
> 
> Vojtech, stuff like this is unacceptable:
> 
> 	PS/2 driver library (SERIO_LIBPS2) [N/m/y/?] (NEW) ?
> 
> 	Say Y here if you are using a driver for device connected
> 	to a PS/2 port, such as PS/2 mouse or standard AT keyboard.
> 
> Stop messing with peoples minds. The default config should contain
> keyboard and mouse support, and unless the user asks for "Embedded" or the
> year 2010 comes along and you can't find computers with non-USB keyboards
> anyway, that's how it's going to remain.

What machine this was on? Kernel config won't allow you to unselect that
option if AT Keyboard is selected, and that's always selected when
CONFIG_PC is.

> We had this _idiocy_ early in 2.5.x, and it caused untold silly problems. 
> We fixed it. We're not going to re-do that mistake.
> Please re-do your BK tree without this

I tested it then, and now again. And I can't get the prompt you're
getting.

	$ bk clone linus test
	$ cd test
	$ bk -r get
	$ make defconfig
	$ bk pull ../input
	$ make oldconfig

doesn't ask ANY questions.

I can imagine that option being asked about on a Mac, but there it might
make sense, or at least cause no harm if you enable it, even if it's
not needed.

> Also, considering that every
> _single_ time we've messed with the legacy keyboard/mouse controller there
> have been compatibility problems, I want to know what the advantages are.  

The changes to the keyboard/mouse controller code (i8042.c) are added
powermanagement callbacks, which are very much needed, and added ACPI
probing, which, although not strictly needed, is a less intrusive way of
detecting whether a kbd/mouse controller is present.

Regarding libps2, that doesn't touch the controller code itself, only
the mouse and keyboard drivers. It's a refactoring of the code,
eliminating a bunch of duplicate code which had a tendency of diverging
and that was causing problems. It shouldn't change any functionality per
se.

> Does the work actually _fix_ anything,

The refactoring itself didn't fix any problems, and it wasn't intended
to, but it uncovered some bugs that when fixed, made real problems go
away, like the ACK timeouts in RESET_BAT code path.

> and has it in any way been tested on the millions of different
> versions of kbd controller clones out there?

Does a few months in Andrew's tree count?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
