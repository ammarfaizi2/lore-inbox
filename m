Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263665AbUDYW6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263665AbUDYW6u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 18:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263671AbUDYW6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 18:58:50 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:45072 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263665AbUDYW6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 18:58:48 -0400
Date: Sun, 25 Apr 2004 23:58:44 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Marcel Holtmann <marcel@holtmann.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>
Subject: Re: [OOPS/HACK] atmel_cs and the latest changes in sysfs/symlink.c
Message-ID: <20040425235844.E13748@flint.arm.linux.org.uk>
Mail-Followup-To: Dmitry Torokhov <dtor_core@ameritech.net>,
	Marcel Holtmann <marcel@holtmann.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Simon Kelley <simon@thekelleys.org.uk>
References: <200404230142.46792.dtor_core@ameritech.net> <1082751264.4294.1.camel@pegasus> <20040423213916.D2896@flint.arm.linux.org.uk> <200404251653.55385.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200404251653.55385.dtor_core@ameritech.net>; from dtor_core@ameritech.net on Sun, Apr 25, 2004 at 04:53:53PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 25, 2004 at 04:53:53PM -0500, Dmitry Torokhov wrote:
> On Friday 23 April 2004 03:39 pm, Russell King wrote:
> > On Fri, Apr 23, 2004 at 10:14:24PM +0200, Marcel Holtmann wrote:
> > > should we apply the pcmcia_get_sys_device() patch from Dmitry for now to
> > > fix the current drivers that need a device for loading the firmware?
> > 
> > I don't think so - it obtains the struct device for the bridge itself
> > which has nothing to do with the card inserted in the slot.
> > 
> 
> Yes, my bad... I wonder if something like the patch below could be useful
> for now (although it created only one device entry even if card has multiple
> functions so we really need another device for every function):

This breaks modular builds - pcmcia_bus_type is in ds.c which is a
separate module.

Look, Dominik has done a fair amount of work in this area.  There is
a set of patches which need to be worked through and merged in a
controlled manner to get to the point where we can have a struct
device for PCMCIA cards.  We'll get there eventually.  Please don't
try to bypass this process - it won't work, and it'll only cause
unnecessary merge problems with the existing patch sets.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
