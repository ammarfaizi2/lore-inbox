Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261335AbTCaA1H>; Sun, 30 Mar 2003 19:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261338AbTCaA1H>; Sun, 30 Mar 2003 19:27:07 -0500
Received: from air-2.osdl.org ([65.172.181.6]:33734 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261335AbTCaA1G>;
	Sun, 30 Mar 2003 19:27:06 -0500
Message-ID: <32798.4.64.238.61.1049071088.squirrel@webmail.osdl.org>
Date: Sun, 30 Mar 2003 16:38:08 -0800 (PST)
Subject: Re: 2.5.59: Input subsystem initialised really late
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
Cc: <vojtech@suse.cz>
X-Mailer: SquirrelMail (version 1.2.11 [cvs])
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on 18-jan-2003 Russell King wrote:
It appears to be impossible to get a SysRQ-T dump out of a kernel which has
hung during (eg) the SCSI initialisation with 2.5.

Unlike previous 2.4 kernels, the keyboard is no longer initialised until
fairly late - after many of the other drivers have initialised.
Unfortunately, this means that it is quite difficult to debug these hangs
(we'll leave discussion about in-kernel debuggers for another time!)

Can we initialise the input subsystem earlier (eg, after pci bus
initialisation, before disks etc) so that we do have the ability to use the
SysRQ features?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
and Vojtech replied:
I think this should be possible, yes.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Any updates to this?  Any clues?

I have changed 5 module_inits to be run a little earlier in the initcall
sequence (the 5 being:  atkbd_init, kbd_init, serio_init, input_init,
and chr_dev_init).
However, this still isn't enough to allow keyboard input (like
ctrl-S, ctrl-Q, SysRq) during init messages as can be done with 2.4.20.

Thanks,
~Randy



