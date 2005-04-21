Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbVDUSTm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbVDUSTm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 14:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbVDUSTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 14:19:42 -0400
Received: from open.hands.com ([195.224.53.39]:10648 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S261602AbVDUSTd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 14:19:33 -0400
Date: Thu, 21 Apr 2005 19:28:45 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: linux-kernel@vger.kernel.org,
       Linux ARM Kernel list 
	<linux-arm-kernel@lists.arm.linux.org.uk>
Subject: [2.6.11.7 / CLPS711x/SkyMinder] module integration issue: keyboard driver _still_ not working after port from 2.4.27
Message-ID: <20050421182845.GA16160@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

after some thought, i decided on friday to port all of the 2.4.27
code over to 2.6.11.7.

bearing in mind that reading from /dev/input/evdev0 worked fine
on 2.4.27 - and now also works fine under 2.6.11.7 - the exact
same problem occurs on 2.6.11.7 as occurred under 2.4.27 -
hanging of the linux kernel whilst providing absolutely zero
crash/debugging information responses whatsoever.

this device does _not_ have and cannot have a standard PC keyboard
attached to it.

in order to be able to debug what is going on, i have enabled 
a dummy/virtual serial console, all is well so far.

in order to test the screen, i have written, enabled, tested,
confirmed as reasonably working, a framebuffer driver (which
i would like to make the console framebuffer - eventually -
when the serial console is disabled and no longer needed -
so i am enabling Framebuffer Console support AS WELL as serial
console support)

now i load the keyboard event module... splat - absolutely no response:
complete lock-up.


okay, let's try that again.

reboot.

install the keyboard event module.

install evdev module.

run a program (multilog) which is a bit like tail -f except it outputs
to a logging file rather than to stdout on /dev/input/evdev0 and press a
few buttons.

do a hexdump -C on the output from multilog - GREAT!

oh...keeyyy...


so, individually, the components work fine.

put them together, and something goes badly wrong.


has _anyone_ else tried running two console drivers at the
same time?

should it be expected to work?

any assistance / guidance greatly appreciated.

l.

----- Forwarded message from Luke Kenneth Casson Leighton <lkcl@lkcl.net> -----

From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: linux-kernel@vger.kernel.org
Subject: [2.4.27 arm skyminder] writing new keyboard handler - help!

hi, please respond cc to me because i am not on the lkml.

for a new arm linux embedded device called a skyminder, i'm responsible
for getting all the drivers working.  ha ha.

the success of this device presents the linux community with
an opportunity to own a linux-based mobile phone (even if it's
not a very small phone - 8cm x 10cm x 1cm) - and it has a GPS
module in it, as well.

i'm endeavouring to adapt various bits of code to create a
keyboard driver.  they've adopted 2.4.27 and are too far down
the line to move to 2.6 - yet.

i particularly want to avoid - if i can - compiling this keyboard
driver under development into the kernel (even though it's the primary
keyboard) because downloading 600k over a serial link into flash ram
isn't a) funny b) a good idea c) slows development time down.

with that in mind, so far, i have:

- cut/paste pc_keyb.c just like everyone else has (in celps_keyb.c,
  c711x_keyb.c, dummy_keyb.c etc.) to create k_translate,
  k_unexpected_up, k_setkeycode and k_getkeycode routines.

- cut/paste usbkbd.c and adapted it to successfully call
  input_report_key on a key press and key release.

then, on installation of module input, keybdev and sky_buttons,
i happily get debug messages indicating key presses (keycode 31
indicating 's') ... but no actual key events appear down my serial
console.

so, my question is: does anyone know off the top of their heads what i
may have missed out that causes the keybdev event handler to _not_
actually stuff keys out?

am i... like... missing something really obvious, given that
the console has been set to "serial"?

where should i look to, to find the keys being outputted, if they're
going anywhere?

help, help, gloop.

cheers,

l.




-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

----- End forwarded message -----

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--
