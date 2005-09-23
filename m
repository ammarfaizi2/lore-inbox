Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750893AbVIWLlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbVIWLlX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 07:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750897AbVIWLlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 07:41:23 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:27037 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750892AbVIWLlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 07:41:23 -0400
Subject: Re: Libata for parallel ATA controllers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mark Lord <lkml@rtr.ca>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4333674D.3070502@rtr.ca>
References: <1127408726.18840.126.camel@localhost.localdomain>
	 <4333674D.3070502@rtr.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 23 Sep 2005 13:07:56 +0100
Message-Id: <1127477276.5561.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-09-22 at 22:24 -0400, Mark Lord wrote:
> built-in error-handling or recovery mechanisms yet.  If a drive
> gets into a "reset me to recover" state, then libata just might
> require a reboot to recover, whereas the IDE subsystem will usually
> try a reset operation at some point.

Or crash.

> Not a problem with modern, mostly bug-free hardware (eg. most SATA),
> but this could be an issue for some PATA interfaces.

The basic error handling in the libata code seems to work as well when I
tested it, if not better because the old PATA code hangs the box on SMP
or pre-empt if you get a DMA timeout and cable changedown due to locking
flaws and also issues an immediate idle in error recovery which seems to
crash some drives for good.

What doesn't work at all is failed cable detect - the speed change down
support simply isn't in libata yet and that turns a downspeed change for
poor cables or cable misdetect into a hang.


