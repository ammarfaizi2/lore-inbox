Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129486AbRCHUU3>; Thu, 8 Mar 2001 15:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129517AbRCHUUS>; Thu, 8 Mar 2001 15:20:18 -0500
Received: from mta5.rcsntx.swbell.net ([151.164.30.29]:7413 "EHLO
	mta5.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id <S129486AbRCHUTj>; Thu, 8 Mar 2001 15:19:39 -0500
Date: Thu, 08 Mar 2001 14:01:03 -0600
From: Erik DeBill <edebill@swbell.net>
Subject: Re: Linux 2.4.2ac12 and ac13 breaks usb-visor
In-Reply-To: <20010307173640.A14818@kroah.com>; from greg@kroah.com on Wed,
 Mar 07, 2001 at 05:36:40PM -0800
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <20010308140103.A17993@austin.rr.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14aQA9-0001br-00@the-village.bc.nu>
 <20010307172056.A8647@austin.rr.com> <20010307173640.A14818@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2001 at 05:36:40PM -0800, Greg KH wrote:
> I'll try to run with everything compiled into the kernel later tonight.
> Does -ac14 with all of USB as modules, using usb-uhci work for you?

Hmm... I was compiling usb-uhci and uhci directly into the kernel,
then visor.o as a module.

In any case, I can't load any modules under ac14.  None.  I get
complaints about unmatched symbols.  Really fun when /home is on a fs
compiled as a module...

ac13 + crypto works with usb-uhci, usb-serial, and visor as modules.
No problems.

I've gone back and (re)tested with kernels 2.4.1, 2.4.2, ac[36],
ac1[01234].  I can only get a crash on ac12 and ac13.  2.4.2 is broken
after all, and everything after it.  2.4.2 and the ac kernels seem to
fail on 'pilot-xfer /dev/usb/tts/1 -m scsi.pdb' (to install a zTXT
into gutenpalm, doesn't matter what I'm sending), and things seem to
go slower and have more problems as the versions increase.  Then I can
crash the system under ac12 and 13.  This is using uhci compiled
directly into kernel, with usb-serial and visor as modules.

If uhci + visor is unsupported, might I suggest the following change
to Configure.help to warn people?

Erik


(agains 2.4.2-ac14)

--- Configure.help.orig	Thu Mar  8 13:24:31 2001
+++ Configure.help	Thu Mar  8 13:28:50 2001
@@ -10750,6 +10750,11 @@
   its USB docking station. See http://usbvisor.sourceforge.net for
   more information on using this driver.
 
+  If you say Y here, you MUST NOT use the UHCI Alternate Driver (JE).
+  Use the usb-uhci driver instead ("UHCI (Intel PIIX4, VIA, ...) support").
+  This driver is not stable in combination with the JE driver, and 
+  can cause system crashes.
+
   This code is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
   The module will be called visor.o. If you want to compile it as a

