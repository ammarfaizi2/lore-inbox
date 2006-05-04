Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750961AbWEDNhd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbWEDNhd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 09:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbWEDNhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 09:37:33 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:15589 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750961AbWEDNhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 09:37:33 -0400
Subject: Re: cdrom: a dirty CD can freeze your system
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Herbert Rosmanith <kernel@wildsau.enemy.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200605041232.k44CWnFn004411@wildsau.enemy.org>
References: <200605041232.k44CWnFn004411@wildsau.enemy.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 04 May 2006 14:48:52 +0100
Message-Id: <1146750532.20677.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-05-04 at 14:32 +0200, Herbert Rosmanith wrote:
> I've been experimenting with damaged CDs this day. I observed that
> a dirty or (partly) unreadable CD will (1) block the process which is
> trying to read from the CD - it will be in state "D" - uninterruptible
> sleep and (2) sometimes(?) probably freeze your system such that even
> a manual reboot wont work (e.g., because it's not possible to log in, or
> keystrokes are no longer accepted) and a power-cycle is required.

This is a known problem with the old IDE layer. There are several
problems involved

1. The old IDE layer reset confuses some drives fatally
2. The DMA recovery tricks it does break the state machine of some
controllers and hang them for good
3. The error recovery and timer code races and can hang
4. The speed change paths used on DMA fail change down race everything

> please tell me a way to savely
> (1) reset the IDE interface, e.g via IDE-TASKFILE (or, for testing,
>     a sequence of outb() to the chip)
> (2) reset the CD-drive - sending a WIN_DEVICE_RESET (linux/hdreg.h line 196)
>     doesnt seem to be enough.

Please try the libata PATA patches instead of the old IDE layer.

Alan

