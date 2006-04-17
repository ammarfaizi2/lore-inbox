Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbWDQVW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbWDQVW2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 17:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWDQVW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 17:22:28 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:13476 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751267AbWDQVW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 17:22:28 -0400
Subject: Re: [RFC] Watchdog device class
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rudolf Marek <r.marek@sh.cvut.cz>
Cc: wim@iguana.be, linux-kernel@vger.kernel.org
In-Reply-To: <4443EED9.30603@sh.cvut.cz>
References: <4443EED9.30603@sh.cvut.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 17 Apr 2006 22:31:35 +0100
Message-Id: <1145309500.14497.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-04-17 at 21:39 +0200, Rudolf Marek wrote:
> The char device of watchdog class is compatible with existing watchdog API,
> so no need to change the user applications. There is just one exception
> and this is temperature handling. I belive it should be implemented not
> via IOCTL but using the HWMON class. (100% compatibility can be restored
> with the ioctl class op)

Then it should be kept.

The watchdog API simply pre-dates the sysfs world, it goes back to the
1.0-1.2 era and has remained very consistent since that time.

If you expose it in sysfs somewhere (which I think is a good idea) then
the units should probably also be fixed in the sysfs case to be metric
(ie Kelvin or Centigrade float values) [or scaled int]

> 	int (*set_timeout)(struct device *, int sec);

Pass the usual time structures instead. Seconds is a field so it is free
but it means all the signed/unsigned stuff and any future subsecond
watchdogs for embedded environments don't break stuff.

> 	int (*notify_reboot)(struct notifier_block *this, unsigned long code,
> 	        void *unused);

Can this not use the power management callbacks from the device model
instead

> 	/* this may be removed in the future */
>	struct watchdog_info legacy_info;

This wants breaking out into sysfs, but again the ioctls are expected
and standardised for years now.



People have talked about sorting out a watchdog helper library for years
so this is overdue, and doing it with the class model in mind is even
better.

Alan

