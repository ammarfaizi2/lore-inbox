Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261793AbSJNAZv>; Sun, 13 Oct 2002 20:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261792AbSJNAZu>; Sun, 13 Oct 2002 20:25:50 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:37495 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S261793AbSJNAZt>; Sun, 13 Oct 2002 20:25:49 -0400
To: Andries Brouwer <aebr@win.tue.nl>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: Patch: linux-2.5.42/kernel/sys.c - warm reboot should not suspend devices
References: <200210131924.MAA00308@baldur.yggdrasil.com>
	<20021013225222.GA23518@win.tue.nl>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 13 Oct 2002 18:30:19 -0600
In-Reply-To: <20021013225222.GA23518@win.tue.nl>
Message-ID: <m1it05lv50.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer <aebr@win.tue.nl> writes:

> On Sun, Oct 13, 2002 at 12:24:26PM -0700, Adam J. Richter wrote:
> 
> > 	linux-2.5.42 had an annoying new behavior.  When I would
> > try to do a warm reboot, it would spin down the hard drives, which
> > just made the reboot take longer and gave the impression that a
> > halt or poweroff was in progress.
> 
> Yes. In my case worse than annoying:
> The drives spin down, but have not yet completed spindown when
> the machine is started again. LILO fails (prints a single 's'
> where I would have expected "uncompressing kernel" and dies).
> Pressing reset results in a strange garbled BIOS screen, and a hang.
> After a power cycle all is well again.
> 
> So, my hardware is very unhappy with the new 2.5.42 behaviour.

>From ChangeLog-2.5.42

<mochel@osdl.org>
        IDE: Add generic remove() method for drives; remove reboot notifier.
          
        The remove() method is generic for all drives, and set in ide_driver_t::gen_driver.
        The call simply forwards the call to ide_driver_t::standby(). 
        
        This obviates the need for IDE reboot notifier. The core iterates over all present
        devices in device_shutdown() and unregisters each one. 

<mochel@osdl.org>
        IDE: make ide_drive_remove() call driver's ->cleanup().
        
        This was accidentally dropped before, but re-added now to completely mimic
        behavior of the reboot notifier IDE used to have. 

And if you look at the changes you will notice ->suspend used to be called
only on a halt, but now it is also called on a reboot.

Eric



