Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262926AbVCDQfG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262926AbVCDQfG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 11:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263017AbVCDQfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 11:35:06 -0500
Received: from mail-gw0.york.ac.uk ([144.32.128.245]:39419 "EHLO
	mail-gw0.york.ac.uk") by vger.kernel.org with ESMTP id S262926AbVCDQdP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 11:33:15 -0500
Subject: Re: Re: RivaFB and GeForce FX
From: Alan Jenkins <aj504@student.cs.york.ac.uk>
To: ods15 <ods5926@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <f470889705030315142ff753a3@mail.gmail.com>
References: <200503040112.21111.ods15@ods15.dyndns.org>
	 <f470889705030315142ff753a3@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 04 Mar 2005 16:32:15 +0000
Message-Id: <1109953935.6819.59.camel@host-172-19-5-120.sns.york.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
X-York-MailScanner: Found to be clean
X-York-MailScanner-From: aj504@student.cs.york.ac.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Query: register vpllB


I have a question about your patch: you added chip->vpllB and
chip->vpllB2 (presumably taken from the X driver).  Do you know their
purpose, and did you find them to be necessary or useful?


Possible patch to add supported cards


I discovered that since your patch, some changes have been made to
support GeForce FX chips (which are classified as NV_ARCH_30), but the
only one recognised by the driver is the GeForce FX GO 5200 (the name
may be slightly mangled).  I can get the driver to work on my card just
by adding it to the list of supported cards (altering
drivers/video/riva/fbdev.c and include/linux/pci_ids.h of 2.6.11).

The driver comments suggest that NV_ARCH_30 is applicable to the 5200,
5600, 5700, 5800 and 5900.  As far as I can tell the actual code would
apply this classifaction to all GeForce FX cards, including the GeForce
FX Go series, and also the Quadro FX series.

My opinion is that theres no point in having the code there but not
letting people try it.  I'd like to add every single card which would be
classified under NV_ARCH_30, taking them from the X driver
(hw/XFree86/drivers/nv/nv_driver.c), with a configuration warning that
rivafb has not really been tested on these cards.  If nobody has any
objections I'll send a patch.


Additional information


I do see a cursor related problem, but I don't think its the same one
you describe.  On the framebuffer console, sometimes when the cursor
moves the character at the new cursor position will be displayed at the
old position for a very short period of time.

EDID/DDC fails (it works with my monitor under X), and acceleration has
been disabled.  

There are problems with some screen modes, particularly on 800x600-90
and 1024x768-43-lace.  The screen wraps, so that about an 8th of the
left hand side appears on the right hand side instead, and there is
additional corruption (there seem to be pixels in the wrong places, but
colours are not affected).

My computer locked up during a console switch (X to console) with linux
rivafb, X framebuffer and X nv running.

Some rivafb debug output during boot:

rivafb: nVidia device/chipset 10DE0322
rivafb: Detected CRTC controller 0 being used
rivafb: RIVA MTRR set to ON
riva_get_EDID START
riva_get_EDID_i2c START
riva_get_EDID_i2c END
rivafb: could not retrieve EDID from DDC/I2C
riva_get_EDID END
riva_update_default_var START
riva_update_default_var END
riva_set_fbinfo START
rivafb: disabling acceleration
riva_set_fbinfo END
rivafb_check_var START
rivafb_do_maximize START
rivafb: setting virtual Y resolution to 209715
rivafb_do_maximize END
rivafb_check_var END
rivafb: PCI nVidia NV32 framebuffer ver 0.9.5b (128MB @ 0xC0000000)
rivafb_probe END
rivafb_open START
riva_save_state START
riva_save_state END
rivafb_open END
rivafb_release START
riva_load_state START
riva_load_state END
rivafb_release END


