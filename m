Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271528AbTGQSBk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 14:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271469AbTGQSBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 14:01:40 -0400
Received: from ore.jhcloos.com ([64.240.156.239]:517 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S271545AbTGQSBf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 14:01:35 -0400
To: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1-ac2 issues / Toshiba Laptop keyboard
References: <20030717141847.GF7864@charite.de>
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <20030717141847.GF7864@charite.de>
Date: 17 Jul 2003 14:15:08 -0400
Message-ID: <m38yqxf2ab.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Ralf" == Ralf Hildebrandt <Ralf.Hildebrandt@charite.de> writes:

Ralf> * and the most interesting issue is related to the keyboard of this
Ralf>   Toshiba laptop (Satellite Pro 6100):

Ralf>   The Kernel reports:

Ralf> atkbd.c: Unknown key (set 2, scancode 0xb2, on isa0060/serio0) pressed.
Ralf> atkbd.c: Unknown key (set 2, scancode 0xae, on isa0060/serio0) pressed.
Ralf> atkbd.c: Unknown key (set 2, scancode 0xb1, on isa0060/serio0) pressed.
Ralf> atkbd.c: Unknown key (set 2, scancode 0x97, on isa0060/serio0) pressed.
Ralf> atkbd.c: Unknown key (set 2, scancode 0xa2, on isa0060/serio0) pressed.
Ralf> atkbd.c: Unknown key (set 2, scancode 0x92, on isa0060/serio0) pressed.

I've been hacking through a similar issue on some Dell laptops.

You need to add entries to the atkbd_set2_keycode[] array in
drivers/input/keyboard/atkbd.h.  Look at the #defines in
inlucde/linux/input.h for stuff that matches the keys that
five the unknown key printk()s, and put those values in the
Nth entry of the array, where N is the scancode reported in
the printk().  

Eg, if the first key mentioned above were a VolumeUp key, you
would want to add the value 115 to the 0xb2'th entry in the
array.

Once you do that, you can run xev(1x) to see what X keycode they
get, look in xkb/keycodes/xfree86 for the symbol associated with
each keycode, and in xkb/symbols/* for something that associates
that xkb symbol with an X11 keysym.

-JimC

