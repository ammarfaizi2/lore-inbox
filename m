Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129379AbQKMJUb>; Mon, 13 Nov 2000 04:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129410AbQKMJUW>; Mon, 13 Nov 2000 04:20:22 -0500
Received: from zirkon.biophys.uni-duesseldorf.de ([134.99.176.3]:53262 "EHLO
	zirkon.biophys.uni-duesseldorf.de") by vger.kernel.org with ESMTP
	id <S129379AbQKMJUG>; Mon, 13 Nov 2000 04:20:06 -0500
Date: Mon, 13 Nov 2000 10:19:42 +0100 (CET)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Karim Yaghmour <karym@opersys.com>
cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        Eric Reischer <emr@engr.de.psu.edu>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.linuxppc.org, debian-powerpc@lists.debian.org
Subject: Re: Issue compiling 2.4test10
In-Reply-To: <3A0FB18A.534F2F21@opersys.com>
Message-ID: <Pine.LNX.4.10.10011131013380.5201-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Would this patch help?
> > 
> > --- drivers/input/keybdev.c.org Thu Nov  2 10:13:39 2000
> > +++ drivers/input/keybdev.c     Thu Nov  2 10:19:43 2000
> > @@ -36,7 +36,7 @@
> >  #include <linux/module.h>
> >  #include <linux/kbd_kern.h>
> > 
> > -#if defined(CONFIG_X86) || defined(CONFIG_IA64) || defined(__alpha__) || defined(__mips__)
> > +#if defined(CONFIG_X86) || defined(CONFIG_IA64) || defined(__alpha__) || defined(__mips__) || defined(CONFIG_MAC_HID)
> > 
> 
> I've tried this on my PowerBook and it doesn't work. The keymap is broken and
> pressing anything on the keyboard will output something completely different.
> This is fixed if the "defined(CONFIG_MAC_HID)" gets move the "#elif" part of
> the "#if" mentionned above.

Fine, my patch made it compile, yours even makes it work. Please post a
diff or send it to Paul Mackerras. 
 
> That said, 2 and 3 button emulation is broken for (at least) the PowerBook on test-10.
> I've tried the 
> echo "1" > /proc/sys/dev/mac_hid/mouse_button_emulation
> and there's no effect. Anyone know what this is about?

Works for me, you just need to use PC keycodes instead of ADB keycodes if
you want to remap the keys. The default emulation codes are for fn-opt and
fn-cmd. 

	Michael

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
