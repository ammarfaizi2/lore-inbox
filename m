Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263225AbVCDXn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263225AbVCDXn0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 18:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263398AbVCDXln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:41:43 -0500
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:17560 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S263202AbVCDVs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 16:48:59 -0500
Subject: Re: swsusp: allow resume from initramfs
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, mjg59@scrf.ucam.org, hare@suse.de,
       "Barry K. Nathan" <barryn@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050304214329.GD2385@elf.ucw.cz>
References: <20050304101631.GA1824@elf.ucw.cz>
	 <20050304030410.3bc5d4dc.akpm@osdl.org>
	 <20050304175038.GE9796@ip68-4-98-123.oc.oc.cox.net>
	 <1109971327.3772.280.camel@desktop.cunningham.myip.net.au>
	 <20050304214329.GD2385@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1109973035.3772.291.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sat, 05 Mar 2005 08:50:35 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sat, 2005-03-05 at 08:43, Pavel Machek wrote:
> > You guys are reinventing the wheel a lot at the moment and I'm in the
> > middle of doing it for x86_64 lowlevel code :> Can we see if we can work
> > a little more closely - perhaps we can get some shared code going that
> > will allow us to handle these issues without stepping on each others'
> > feet? In particular, shared code for
> > 
> > - initramfs and initrd support
> 
> Its actually done, and it was few strategically placed lines of code
> (like 20 lines). I do not think it can be meaningfully shared.

Mmm. But if we're both putting hooks in the same places...

> > - lowlevel suspend & resume
> 
> This makes very good sense to share. We have i386, x86-64 and ppc
> versions. They simply walk list of pbe's; that should be simple enough
> to be usable for suspend2, too....

The CPU save and restore, yes. But I use a different format for
recording the image metadata (I use bitmaps to record the locations of
pages). Perhaps I should hasten to mention the bitmaps are discontiguous
- single pages connected by a kmalloc'd list. The copyback itself will
need to stay distinct.

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://softwaresuspend.berlios.de


