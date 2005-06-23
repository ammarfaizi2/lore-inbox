Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262029AbVFWEJB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbVFWEJB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 00:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbVFWEJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 00:09:01 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:9942 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S262029AbVFWEI6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 00:08:58 -0400
X-ORBL: [69.107.32.110]
From: David Brownell <david-b@pacbell.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PATCH] Remove devfs from 2.6.12-git
Date: Wed, 22 Jun 2005 21:08:50 -0700
User-Agent: KMail/1.7.1
Cc: kernel@mikebell.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506222108.50905.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoth Mike Bell:
> 
> > Also, no disto uses devfs only (gentoo is close, but offers users udev
> > and a static /dev also.)
> 
> It breaks a lot of my embedded setups which have read-only storage only
> and thus need /dev on devfs or tmpfs.

I'd agree that embedded setups are the ones that have been slowest to
switch over, for various reasons.  One of them is that many LKML folk
ignore embedded systems issues; "just PC class or better".  Another
has been that the basic hotplug scripts never worked well with "ash",
and who's going to want to ship "bash" and friends?  :)

Those problems seem resolved with 2.6.12 and current modutils and udev.
Leaving basically an "upgrade your userspace" requirement.


> and thus need /dev on devfs or tmpfs. With early-userspace-udev-on-tmpfs
> being - in my experience - still unready.

Hmm, could you explain why you think udev-on-ramfs/tmpfs/... is still
unready?  And what it's "unready" for?  It can work fine without
needing to hack early userspace and initramfs, by the way.  :)  

I recently submitted patches to make buildroot support it.  They're
mostly merged [1] but adding a simple patch fixes up the remaining
glitches.  OpenEmbedded has supported it for a while too.

In short, I think udev-on-ramfs is simple enough to set up on 2.6.12
based embedded configs, and with "modprobe -q $MODALIAS" phasing in,
it seems to me [2] that hotplug-with-udev [3] can do most of what
folk have used devfs to achieve.  I've quilted buildroot so that it
works that way by default for me; it's turnkey, with no problems.

Of course, 2.6.13 will be better with cardmgr finally gone.  :)

- Dave

[1] http://bugs.busybox.net/view.php?id=290
[2] http://marc.theaimsgroup.com/?l=linux-hotplug-devel&m=111903617808816&w=2
[3] http://marc.theaimsgroup.com/?l=linux-hotplug-devel&m=111903647518255&w=2

