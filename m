Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262811AbTFISZh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 14:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263918AbTFISZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 14:25:37 -0400
Received: from evil.netppl.fi ([195.242.209.201]:17873 "EHLO evil.netppl.fi")
	by vger.kernel.org with ESMTP id S262811AbTFISZg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 14:25:36 -0400
Date: Mon, 9 Jun 2003 21:39:06 +0300
From: Pekka Pietikainen <pp@netppl.fi>
To: Lionel Bouton <Lionel.Bouton@inet6.fr>
Cc: Jurgen Kramer <gtm.kramer@inter.nl.net>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Completely disable AT/PS2 keyboard support in 2.4?
Message-ID: <20030609183906.GA32734@netppl.fi>
References: <Pine.GSO.4.21.0306091529480.1347-100000@vervain.sonytel.be> <1055169922.4052.3.camel@paragon.slim> <3EE4A14C.3000109@inet6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <3EE4A14C.3000109@inet6.fr>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 09, 2003 at 05:01:32PM +0200, Lionel Bouton wrote:
> Jurgen Kramer wrote:
> On my config (Logitech wireless mouse and kb with USB receiver) :
> - 272 keycode happens on each left click,
> - 273 or 276 on each right click (actual button pressed dependant there 
> are 2 buttons recognised as the right one on my Optical Trackman),
> - 275 on each middle click,
> - 274 on each wheel click...

Same here... Here's a patch that fixed it (something similar was added
to 2.5 recently)

--- linux-2.4.20-20.1.2007.nptl/drivers/input/keybdev.c.orig	2003-05-31 14:23:10.000000000 +0300
+++ linux-2.4.20-20.1.2007.nptl/drivers/input/keybdev.c	2003-05-31 14:23:58.000000000 +0300
@@ -172,7 +172,8 @@
 	if (type != EV_KEY) return;
 
 	if (emulate_raw(code, down))
-		printk(KERN_WARNING "keyboard.c: can't emulate rawmode for keycode %d\n", code);
+		if(code < BTN_MISC)
+			printk(KERN_WARNING "keybdev.c: can't emulate rawmode for keycode %d\n", code);
 
 	tasklet_schedule(&keyboard_tasklet);
 }

-- 
Pekka Pietikainen




