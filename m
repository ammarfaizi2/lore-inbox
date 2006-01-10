Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbWAJIiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbWAJIiM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 03:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbWAJIiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 03:38:12 -0500
Received: from styx.suse.cz ([82.119.242.94]:54711 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932093AbWAJIiL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 03:38:11 -0500
Date: Tue, 10 Jan 2006 08:43:36 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: dtor_core@ameritech.net,
       Martin Bretschneider <mailing-lists-mmv@bretschneidernet.de>,
       linux-kernel@vger.kernel.org, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       linux-usb-devel@lists.sourceforge.net, Greg KH <gregkh@suse.de>,
       Leonid <nouser@lpetrov.net>
Subject: Re: PROBLEM: PS/2 keyboard does not work with 2.6.15
Message-ID: <20060110074336.GA7462@suse.cz>
References: <d120d5000601090850k42cc1c1ft6ab4e197119cacd@mail.gmail.com> <Pine.LNX.4.44L0.0601091215070.7432-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0601091215070.7432-100000@iolanthe.rowland.org>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 12:23:04PM -0500, Alan Stern wrote:
> On Mon, 9 Jan 2006, Dmitry Torokhov wrote:
> 
> > > It would be nice to know which part of the usb-handoff code causes the
> > > problem.
> > 
> > Well, it's not handoff code causing problems per se, it's just that it
> > does not look like it performs handoff. If it did then disabling USB
> > legacy emulation in BIOS would have no effect, right?
> 
> On the other hand, if the BIOS worked correctly then the ps/2 port would
> have no problems regardless of whether USB legacy emulation was on or off.  
> Given that the keyboard works during bootup, I see only two possibilities:
> 
> 	The USB handoff code somehow causes the BIOS to mess up the
> 	state of the 8042;
> 
> 	The 8042 driver interacts badly with the firmware when USB
> 	legacy emulation is on, and the USB handoff code doesn't
> 	successfully turn off legacy emulation.

It's usually that the BIOS does an incomplete emulation of the i8042
chip, while still getting in the way to the real i8042. Usually GRUB and
DOS don't care about sending any commands to the i8042, and so they
work. The Linux i8042.c driver needs to use them to enable the PS/2
mouse port and do other probing, and if the commans are not working, it
just bails out.

The question of course is why the handoff code doesn't work on that
platform.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
