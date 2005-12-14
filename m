Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbVLNGUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbVLNGUz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 01:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbVLNGUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 01:20:55 -0500
Received: from HELIOUS.MIT.EDU ([18.248.3.87]:52353 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S1750720AbVLNGUy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 01:20:54 -0500
Date: Wed, 14 Dec 2005 02:23:29 -0500
From: Adam Belay <ambx1@neo.rr.com>
To: Anil kumar <anils_r@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: driver_attach question
Message-ID: <20051214072329.GA4639@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Anil kumar <anils_r@yahoo.com>, linux-kernel@vger.kernel.org
References: <20051214020754.66330.qmail@web32409.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051214020754.66330.qmail@web32409.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2005 at 06:07:54PM -0800, Anil kumar wrote:
> Hi,
> 
> Should driver_attach( ) return an error value?
> 
> I have disabled a device in the system bios, The
> driver fails to report -ENODEV.
> This is for 2.6.11.1 kernel
> When I dig through the PCI subsystem and driver_attach
> code, I find that :
> 
> pci_register_driver is returing zero(no error) even
> when the device is not present in the system. 
> But when I check driver_attach( ), I get -ENODEV for
> driver_probe_device(). which is correct. But
> driver_attach( ) does not return this error value. 
> driver attach( ) is called in bus_add_driver( ) and
> bus_add_driver just returns error=0
> Hence I get error=0 in pci_register_driver.
> 
> Am I missing something in the flow?

The basic strategy is to leave the driver loaded so that
later, if the a device is hotplugged or the user adds a
dynamic id to an existing device, it will be available.
In other words, even if the registration of a driver does
not result in device detection, the operation can still
considered successful.

Does this answer your question?

Thanks,
Adam
