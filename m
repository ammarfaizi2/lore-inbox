Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266498AbUIANTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266498AbUIANTI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 09:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266508AbUIANTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 09:19:08 -0400
Received: from the-village.bc.nu ([81.2.110.252]:10123 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266498AbUIANS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 09:18:59 -0400
Subject: Re: MMC block major dev
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4134D5EF.9080903@drzeus.cx>
References: <4134CDF0.7070600@drzeus.cx>
	 <20040831201556.B11053@flint.arm.linux.org.uk> <4134D5EF.9080903@drzeus.cx>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094040990.2399.56.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 01 Sep 2004 13:16:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-08-31 at 20:47, Pierre Ossman wrote:
> >Registering with the block layer with a major number of zero means
> >"find me a free major number and assign that to me."  This is nothing
> >new.  If devfs can't cope with that, devfs is buggy.  Use udev instead.

Registering with an ID of 0 is bad because you've no idea what existing
device node you may reallocate and thus what permissions may be present
for access unless you sweep all of storage.

> Ok. Please excuse my ignorance =)
> My point was that I do not use a dynamic system for /dev so it would be 
> nice to have a static major number. Since MMC now is a part of Linus' 
> kernel maybe it's time for a permanent allocation?

Agreed. It also needs reigstering with LANANA to avoid /dev namespace
collisions irrespective of the device numbering and to ensure the
namespace is common across all vendors regardless of their dev
management tools. Without LANANA we'll get 

#if UDEV_REDHAT
#elif UDEV_SUSE
#elif DEVFS_SUSE
#elif GENTOO
#endif

type stuff in programs .. 8(

Send the proposed /dev naming for the device and details in the same
format as Documentation/devices.txt to device@lanana.org, and Torben
will either disagree with you or assign name and possibly numbers.

Alan

