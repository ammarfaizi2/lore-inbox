Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263806AbUDZMdC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbUDZMdC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 08:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263801AbUDZMdC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 08:33:02 -0400
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:36495 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264535AbUDZMcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 08:32:48 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [OOPS/HACK] atmel_cs and the latest changes in sysfs/symlink.c
Date: Mon, 26 Apr 2004 07:32:46 -0500
User-Agent: KMail/1.6.1
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>
References: <200404230142.46792.dtor_core@ameritech.net> <20040425235844.E13748@flint.arm.linux.org.uk> <1082975742.28880.120.camel@pegasus>
In-Reply-To: <1082975742.28880.120.camel@pegasus>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200404260732.46315.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 April 2004 05:35 am, Marcel Holtmann wrote:
> Hi Russell,
> 
> > Look, Dominik has done a fair amount of work in this area.  There is
> > a set of patches which need to be worked through and merged in a
> > controlled manner to get to the point where we can have a struct
> > device for PCMCIA cards.  We'll get there eventually.  Please don't
> > try to bypass this process - it won't work, and it'll only cause
> > unnecessary merge problems with the existing patch sets.
> 
> right now we have two broken drivers. They are only broken, because we
> need a device for loading the firmware. If the PCMCIA driver model
> integrations is not yet ready, we should find a way to make the firmware
> loading possible without having a device. We don't need the device for
> any other task. Actually I don't know how to achieve it, but I think if
> we give a NULL pointer to the request_firmware() call the firmware_class
> should create a dummy device.
>
Hi Marcel,

This is wrong... What if you have several devices that are needed firmware?
You are not only loading a specific firmware but do it for a specific device.
You may also want to do something else with it...

I think until pcmcia either provides or allows to create devices on pcmcia
bus you can just fixup the name breakage like I did for atmel driver and
leave it be. The device is not registered and not used in any way except to
provide "unique" name for fimrware loader, at list in atmel_cs that is the
case.

-- 
Dmitry
