Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbVHNVo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbVHNVo4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 17:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbVHNVo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 17:44:56 -0400
Received: from ns9.hostinglmi.net ([213.194.149.146]:60631 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S932303AbVHNVoz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 17:44:55 -0400
Date: Sun, 14 Aug 2005 23:48:02 +0200
From: DervishD <lkml@dervishd.net>
To: Willy Tarreau <willy@w.ods.org>
Cc: Pete Zaitcev <zaitcev@redhat.com>, Bodo Eggert <7eggert@gmx.de>,
       harvested.in.lkml@7eggert.dyndns.org, vonbrand@inf.utfsm.cl,
       linux-kernel@vger.kernel.org
Subject: Re: Problem with usb-storage and /dev/sd?
Message-ID: <20050814214802.GB81@DervishD>
Mail-Followup-To: Willy Tarreau <willy@w.ods.org>,
	Pete Zaitcev <zaitcev@redhat.com>, Bodo Eggert <7eggert@gmx.de>,
	harvested.in.lkml@7eggert.dyndns.org, vonbrand@inf.utfsm.cl,
	linux-kernel@vger.kernel.org
References: <4pzyn-10f-33@gated-at.bofh.it> <4AubX-4w6-9@gated-at.bofh.it> <E1E3X6P-0000cN-BB@be1.lrz> <20050812103832.28ff17a0.zaitcev@redhat.com> <Pine.LNX.4.58.0508131149070.2192@be1.lrz> <20050813202046.50c41405.zaitcev@redhat.com> <20050814073257.GA62@DervishD> <20050814084847.GD20363@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050814084847.GD20363@alpha.home.local>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Willy :)

 * Willy Tarreau <willy@w.ods.org> dixit:
> >     That's not possible. sd_mod will assign different devices for
> > different USB gadgets, and that's my problem in the first case!. If I
> > plug my USB-whatever, it gets assigned /dev/sda1 (for the first
> > partition, I mean). If I unplug it and, after that, I plug any other
> > USB device, it gets assigned /dev/sdb1, etc. Don't know if the
> > culprit is usb-storage or sd_mod :? The problem is that I cannot know
> > about which device was assigned (at least in 2.4.x) so I can modify
> > fstab or even mount it.
> I've been suffering from the same problem for a long time until I found
> a patch from Erik Andersen which automatically unregisters the sd device
> once you unplug the USB device. It has changed my life :-)

    Thanks! Unfortunately, it solves only half of my problem. If I
plug *two* USB storage devices, the second will fail (well, it won't
be assigned the correct device). The perfect solution is to always
use the same dev entry for the same USB device, but I need sysfs for
that (AFAIK), just like udev does.
 
> Here it is for 2.4. I even wonder why we would not put this into mainline,
> since having orphan devices brings nothing but confusion.

    Don't know :????

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
http://www.pleyades.net & http://www.gotesdelluna.net
It's my PC and I'll cry if I want to...
