Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317430AbSG1Xbd>; Sun, 28 Jul 2002 19:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317435AbSG1Xbd>; Sun, 28 Jul 2002 19:31:33 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:46377 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S317430AbSG1Xbc>;
	Sun, 28 Jul 2002 19:31:32 -0400
Date: Mon, 29 Jul 2002 01:34:51 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.5.28
Message-ID: <20020728233451.GA27114@win.tue.nl>
References: <1027553482.11881.5.camel@sonja.de.interearth.com> <Pine.LNX.4.44.0207241803410.4293-100000@home.transmeta.com> <20020727235726.GB26742@win.tue.nl> <200207282203.g6SM3KI15155@fachschaft.cup.uni-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207282203.g6SM3KI15155@fachschaft.cup.uni-muenchen.de>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2002 at 01:27:32PM +0200, Oliver Neukum wrote:
> Am Sonntag, 28. Juli 2002 01:57 schrieb Andries Brouwer:

> > IDE? 2.4.17 and 2.5.27+Jens are stable for me in ordinary use.
> > IRQ? Quite possible.
> > My third candidate is USB. Systems without USB are clearly more stable.

> could you be a bit more specific?
> Are you refering to a USB mass storage device, or USB in general?
> 
> Also which devices do you have connected to USB?
> Which HCD and which chipset? (VIA is known to be problematic)

"USB mass storage" in general.

hcd-pci.c: uhci-hcd @ 00:07.2, Intel Corp. 82371AB PIIX4 USB

I don't think you need to search in this kind of direction.
The usb-storage code is just not very solid. It works more or less,
but it is really easy to provoke an oops.

Since there has been so much mail this evening, let me provoke an oops
just to show. Steps:

1. compile vanilla 2.5.29 with all built-in (also usb), except for
usb-storage.

2a. boot it, do nothing, reboot - all is fine
2b. boot it, insmod usb-storage, rmmod usb-storage, reboot - all is fine
2c. boot it, connect four CF/SM card readers to a hub. Mount usbdevfs.
    Look at them with usbview. Now insmod usb-storage. This generates some
    kernel messages about the probing, then silence. Wait for two minutes.
    Nothing. Still no prompt showing the completion of the insmod.
    Remove the four Smart Media card readers from the hub. No reaction.
    Ctrl-Alt-Del initiates a reboot, but the reboot hangs.
    Wait for a while. Nothing. Touch the (non-USB) keyboard. Oops.

This was a funny oops, rather different from those I usually see.
The stack trace was:

put_queue < handle_scancode < handle_kbd_event < update_wall_time <
timer_bh < keyboard_interrupt < handle_IRQ_event < do_IRQ <
default_idle < default_idle < common_interrupt < default_idle <
default_idle < default_idle < cpu_idle < rest_init.

Andries

[that was all for today, I am afraid - have no time to do Linux work today]
