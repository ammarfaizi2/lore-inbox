Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267978AbUIPLbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267978AbUIPLbr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 07:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267971AbUIPL3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 07:29:22 -0400
Received: from 147.32.220.203.comindico.com.au ([203.220.32.147]:41869 "EHLO
	relay01.mail-hub.kbs.net.au") by vger.kernel.org with ESMTP
	id S267957AbUIPL2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 07:28:04 -0400
Subject: Re: [PATCH] Suspend2 Merge: Driver model patches 0/2
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@digeo.com>, Patrick Mochel <mochel@digitalimplant.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040916111852.GC5467@elf.ucw.cz>
References: <1095332314.3855.157.camel@laptop.cunninghams>
	 <20040916111852.GC5467@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1095334173.3324.200.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 16 Sep 2004 21:29:34 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2004-09-16 at 21:18, Pavel Machek wrote:
> Hi!
> 
> > Here are two patches for the driver model, which have been in use in
> > suspend2 for around a month.
> > 
> > The first provides support for keeping part of the device tree alive
> > while suspending the remainder. This is accomplished by abstracting the
> > dpm_active, dpm_off and dpm_irq lists into a new struct partial device
> 
> I believe this is wrong approach.
> 
> For atomic snapshot to work, all devices need to be stopped. If your
> video card does DMA, it needs to be stopped. So all drivers need to
> know, you can not just exclude part of tree.

Sorry. Perhaps I wasn't clear enough. I do suspend these devices. But I
do it later:

Suspend all other drivers.
Write pageset 2 (page cache).
Suspend used drivers.
Make atomic copy.
Resume used drivers.
Write pageset 1 (atomic copy)
Suspend used drivers.
Power down all.

And vice versa at resume time.

> Now, you probably do not want disks to spin down and you want your
> screen unblanked (as an optimalization/speedup). Patch for keeping
> disk up is allready in -mm. Patch for keeping radeonfb up looks like
> this, and is pending, too.

Mm. Don't forget i8xx and the gazillion other drivers there :>. I see
this is using the SYSTEM_SNAPSHOT value. Do those changes look like
being merged to Linus soon?

Regards,

Nigel

-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.

