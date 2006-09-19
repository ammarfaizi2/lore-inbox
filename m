Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbWISGuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWISGuk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 02:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbWISGuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 02:50:40 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:7821 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1750807AbWISGuj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 02:50:39 -0400
Message-ID: <450F8833.3050200@drzeus.cx>
Date: Tue, 19 Sep 2006 08:03:31 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Alex Dubov <oakad@yahoo.com>
CC: linux-kernel@vger.kernel.org, rmk+lkml@arm.linux.org.uk
Subject: Re: Support for TI FlashMedia (pci id 104c:8033, 104c:803b) flash
 card readers
References: <20060919032003.77685.qmail@web36702.mail.mud.yahoo.com>
In-Reply-To: <20060919032003.77685.qmail@web36702.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Dubov wrote:
> I was looking at the way to put my driver into the kernel and currently have three ways of doing
> it (all of them came up in the thread, already):
> 1.
> Put everything in drivers/misc
>
> 2.
> Put tifm_core, tifm_7xx1 and tifm_ms (in progress) in drivers/misc, tifm_sd in drivers/mmc
>
> 3.
> Put everything in drivers/mmc
>
> I'm favoring everything in drivers/mmc, especially if it can be renamed into drivers/flashcards or
> something. This way, all flash card drivers will be nicely localized. In this respect, I also
> wonder where the MemoryStick driver for Winbond card readers is supposed to go when it enters the
> kernel? (Winbond driver is written by people with access to the MemoryStick spec and I'm using it
> as reference for my own work, with great utility).
>
>   

I prefer 2, where only tifm_sd (and tifm_ms) show up in Kconfig. The
other modules will be "Select":ed via Kconfig.

1 can be a bit confusing for users as they expect a MMC/SD driver to be
in drivers/mmc, but it could be acceptable if it's considered more
important to keep all files in a common place.

3 is out as drivers/mmc isn't for "any flashcard technology". It is
intended to grow with SDIO drivers, so we do not want to clutter it up
with other systems.

Until your (and Winbond's) driver has a generic MemoryStick layer, then
the fact that you use MemoryStick is just an implementation detail. From
the kernel's point of view you're just some odd-ball block driver. When
we have a generic MS layer, we should probably move these to a "ms"
directory, possibly creating a common tree structure for mmc and ms.

Rgds
Pierre

