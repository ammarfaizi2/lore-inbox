Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316289AbSFZCjW>; Tue, 25 Jun 2002 22:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316309AbSFZCjV>; Tue, 25 Jun 2002 22:39:21 -0400
Received: from mta05ps.bigpond.com ([144.135.25.137]:59087 "EHLO
	mta05ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S316289AbSFZCjU>; Tue, 25 Jun 2002 22:39:20 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Tom Rini <trini@kernel.crashing.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/RFC 2.4.19-rc1] Fix dependancies on keybdev.o
Date: Wed, 26 Jun 2002 12:36:24 +1000
User-Agent: KMail/1.4.5
References: <20020625160644.GP3489@opus.bloom.county>
In-Reply-To: <20020625160644.GP3489@opus.bloom.county>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200206261236.24247.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jun 2002 02:06, Tom Rini wrote:
> Right now drivers/input/keybdev.o depends on drivers/char/keyboard.o for
> handle_scancode, keyboard_tasklet and kbd_ledfunc.  However, compiling
> drivers/char/keyboard.o isn't quite straight forward, as we have:
> ifndef CONFIG_SUN_KEYBOARD
>   obj-$(CONFIG_VT) += keyboard.o $(KEYMAP) $(KEYBD)
> else
>   obj-$(CONFIG_PCI) += keyboard.o $(KEYMAP)
> endif
> in drivers/char/Makefile
>
> To attempt to work around this, I've come up with the following patch
> for drivers/input/Config.in.  Comments?
Here is a bit of arch/i386/config.in:
<extract>
# input before char - char/joystick depends on it. As does USB.
#
source drivers/input/Config.in
source drivers/char/Config.in
</extract>

So it will still crap out, because CONFIG_VT and CONFIG_SUN_KEYBOARD won't be 
set early enough.

Three possible options, none of them especially good:
1. Do various munging of config and make setup and try to cover this.
2. Move keyboard handling code to input subsystem
3. Do wholesale backport of input subsystem from 2.5

Brad
-- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
