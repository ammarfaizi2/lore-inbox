Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268010AbUIPLuR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268010AbUIPLuR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 07:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267971AbUIPLsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 07:48:18 -0400
Received: from 147.32.220.203.comindico.com.au ([203.220.32.147]:26025 "EHLO
	relay01.mail-hub.kbs.net.au") by vger.kernel.org with ESMTP
	id S268028AbUIPLq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 07:46:26 -0400
Subject: Re: [PATCH] Suspend2 Merge: Driver model patches 0/2
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@digeo.com>, Patrick Mochel <mochel@digitalimplant.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040916113205.GF5467@elf.ucw.cz>
References: <1095332314.3855.157.camel@laptop.cunninghams>
	 <20040916111852.GC5467@elf.ucw.cz>
	 <1095334173.3324.200.camel@laptop.cunninghams>
	 <20040916113205.GF5467@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1095335274.4932.219.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 16 Sep 2004 21:47:55 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2004-09-16 at 21:32, Pavel Machek wrote:
> > Sorry. Perhaps I wasn't clear enough. I do suspend these devices. But I
> > do it later:
> > 
> > Suspend all other drivers.
> > Write pageset 2 (page cache).
> > Suspend used drivers.
> > Make atomic copy.
> > Resume used drivers.
> > Write pageset 1 (atomic copy)
> > Suspend used drivers.
> > Power down all.
> 
> What is problem with:
> 
> Write pageset 2
> Suspend all drivers (avoiding slow operations)
> Make atomic copy
> Resume all drivers (avoiding slow operations)
> Write pageset 1
> Suspend all drivers
> Power down all.

It's always interesting trying to remember your logic for doing
something after the fact :>. If I recall correctly, it goes like this:

Writing two pagesets forces me to account for memory usage much more
carefully. I need to ensure before I start to write the image that I
know exactly what the size is and have allocated enough memory to do the
write. If I get some driver coming along and grabbing memory for who
knows what (hotplug, anyone? :>), I may get stuck halfway through
writing the image with no memory to use. I also have to be paranoid
about how much memory is available because I save that too (some of it
may have become slab by the time I do the atomic copy).

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.

