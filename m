Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268040AbUH3NlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268040AbUH3NlW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 09:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268039AbUH3NlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 09:41:22 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:16065 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S268040AbUH3NlJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 09:41:09 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 30 Aug 2004 15:32:05 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Luca Risolia <luca.risolia@studio.unibo.it>,
       Kernel List <linux-kernel@vger.kernel.org>,
       video4linux list <video4linux-list@redhat.com>
Subject: Re: [PATCH 2.6.9-rc1-mm1] Disable colour conversion in the CPiA Video Camera driver
Message-ID: <20040830133205.GC1727@bytesex>
References: <20040830013201.7d153288.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040830013201.7d153288.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Given that colour conversion is not allowed in kernel space, this patch
> disables it in the CPiA driver. The routines implementing the conversions
> can be removed at all by the maintainers of the driver; however, this
> patch is a good starting point and makes someone happy.

Yes, colorspace conversion shouldn't be done by the kernel but by the
applications.  I don't like the idea to just disable them through:

First: there should be a reasonable warning time for the current users.
Some printk message telling them they are using a depricated feature.
Maybe even a insmod option to enable/disable it, with the default being
software conversion disabled.

Second: IMHO it would be a very good idea to port the driver to the v4l2
API before ripping the in-kernel colorspace conversion support.  v4l2
provides a sane API to get a list of supported color formats, whereas
with v4l1 it is dirty trial-and-error + guesswork for the applications.

While thinking about it: due to the v4l1 trial-and-error mess a printk
likely generates alot of false positives, so a insmod option
(+rate-limited printk) is likely the better way to figure how much
userspace software breaks.  Maybe it isn't that much as other drivers
don't offer in-kernel conversion in the first place, so apps already
have to deal with that ...

  Gerd

-- 
return -ENOSIG;
