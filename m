Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267893AbUIPWFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267893AbUIPWFL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 18:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267974AbUIPWFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 18:05:11 -0400
Received: from 147.32.220.203.comindico.com.au ([203.220.32.147]:26345 "EHLO
	relay01.mail-hub.kbs.net.au") by vger.kernel.org with ESMTP
	id S267893AbUIPWEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 18:04:49 -0400
Subject: Re: [PATCH] Suspend2 Merge: Driver model patches 0/2
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@digeo.com>, Patrick Mochel <mochel@digitalimplant.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040916121259.GA3125@elf.ucw.cz>
References: <1095332314.3855.157.camel@laptop.cunninghams>
	 <20040916111852.GC5467@elf.ucw.cz>
	 <1095334173.3324.200.camel@laptop.cunninghams>
	 <20040916113205.GF5467@elf.ucw.cz>
	 <1095335274.4932.219.camel@laptop.cunninghams>
	 <20040916121259.GA3125@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1095372377.5897.13.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 17 Sep 2004 08:06:18 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2004-09-16 at 22:13, Pavel Machek wrote:
> > It's always interesting trying to remember your logic for doing
> > something after the fact :>. If I recall correctly, it goes like this:
> > 
> > Writing two pagesets forces me to account for memory usage much more
> > carefully. I need to ensure before I start to write the image that I
> > know exactly what the size is and have allocated enough memory to do the
> > write. If I get some driver coming along and grabbing memory for who
> > knows what (hotplug, anyone? :>), I may get stuck halfway through
> > writing the image with no memory to use. I also have to be paranoid
> > about how much memory is available because I save that too (some of it
> > may have become slab by the time I do the atomic copy).
> 
> What prevents video driver or disk driver to grab some memory? Tree
> containing disk device can be pretty big [pci-usb-usb_hub-disk] and
> contain some hot-pluggable components.

I do allow some slack to account for this (and slab), but I'm also
relying upon the same assumption you use: that the hardware present at
resume is the same as at suspend, and that the driver model
suspend/resume support will properly and successfully hold off any
activity until resume time.

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.

