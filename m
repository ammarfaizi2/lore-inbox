Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262489AbTFZUph (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 16:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262456AbTFZUph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 16:45:37 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:52695 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S262490AbTFZUoD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 16:44:03 -0400
Date: Thu, 26 Jun 2003 22:58:11 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, orinoco-devel@lists.sf.net, jt@hpl.hp.com
Subject: orinoco_usb Request For Comments
Message-ID: <20030626205811.GA25783@ranty.pantax.net>
Reply-To: ranty@debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello,

 As many of you already know, I have been working on a variant of the
 standard orinoco driver to support ORiNOCO USB devices.

 I now believe that it is stable enough for the kernel, and I would like
 to get it integrated in the official kernel tree.

 At first I tried convincing David to accept the changes in the standard
 orinoco driver but he was (rightfully) skeptic. Then Jean Tourrilhes
 opened my eyes, the changes touch carefully crafted locking semantics
 and could give trouble (although it has been working well for quite a
 while), and suggested adding it as an independent (alternative) driver.
 
 It has happened before with rtl8139/8139too and others, while the new
 driver probes it's merits stability conscious people can still use the
 standard driver.

 I know that there are some issues, this is what I plan to do:
 	- Beautify the source
		- Function renaming for consistency
		- Moving code around for structure
	- Remove reg_name()/rid_name()?
	- Cleanup bridge_or_reg/bridge_read_reg/bridge_write_reg to the
	  minimum possible.
	  	- Implement my own orinoco_interrupt using
		  __orinoco_ev_* directly.
	- Add '-exp' to all module names and offer them as an
	  alternative in Kconfig.
	  	- I have renamed a couple of functions so they don't get
		  mixed with the standard orinoco modules.

 Please comment, how much of that or what else needs to be done to get
 it in the kernel?

 Also suggestions on better ways to do the USB vs. PCMCIA abstraction
 would be welcomed, although IMHO that could be polished later.

 Oh, and since I am at it, I wouldn't mind cleaning kcompat.h for
 inclusion in 2.4 kernels to make driver porting easier. I have also
 been working in porting lirc so I could put it all together (the
 kcompat.h stuff) for 2.4 inclusion.

 The code can be downloaded from 

	http://alioth.debian.org/download.php/223/orinoco-usb-0.2.1.tar.bz2

 Or if you want to look at independent files:

	http://orinoco-usb.alioth.debian.org/orinoco-usb-0.2.1/

 And for the record, the web page for the project is:

 	http://orinoco-usb.alioth.debian.org/

 BTW, for comparison purposes, it was last merged with standard
 orinoco-0.13e.

 Have a nice day

 	Manuel

 PS: Sorry for the long message.
-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.
