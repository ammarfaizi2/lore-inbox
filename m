Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261632AbULOIVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbULOIVd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 03:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbULOIVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 03:21:33 -0500
Received: from mail.mellanox.co.il ([194.90.237.34]:9309 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S261632AbULOIV1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 03:21:27 -0500
Date: Wed, 15 Dec 2004 10:21:28 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, pavel@suse.cz, discuss@x86-64.org,
       gordon.jin@intel.com
Subject: Re: unregister_ioctl32_conversion and modules. ioctl32 revisited.
Message-ID: <20041215082128.GA11889@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20041215065650.GM27225@wotan.suse.de> <20041215074635.GC11501@mellanox.co.il> <20041215080020.GT27225@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041215080020.GT27225@wotan.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
Quoting r. Andi Kleen (ak@suse.de) "Re: unregister_ioctl32_conversion and modules. ioctl32 revisited.":
> > There were two additional motivations for my patch:
> > 1. Make it possible to avoid the BKL completely by writing
> >    an ioctl with proper internal locking.
> 
> Good point.  It is the first step towards BKL less native ioctls. So it's 
> certainly a good idea even for the non compat case.
> 
> > 2. As noted by  Juergen Kreileder, the compat hash does not work
> >    for ioctls that encode additional information in the command, like this:
> > 
> > #define EVIOCGBIT(ev,len)  _IOC(_IOC_READ, 'E', 0x20 + ev, len)
> > 
> > I post the patch (updated for 2.6.10-rc2, boots) that I built for
> > Juergen, below. If there's interest, let me know.
> 
> Patch looks good to me, except for some messed up white space
> that is probably easily fixed.

I did try so .. Where? :)

> > I'd like to add that my patch does not touch any in-kernel users,
> > that would have to be done separately, probably as a first step
> > simply taking the BKL inside ioctl_compat.
> 
> I doubt any of the compat wrappers need BKL, they never touch
> any global state and then just call sys_ioctl which takes the BKL
> only when needed.
> 
> Ok there is a slight possibility that out of tree code wrote
> compat wrappers that need BKL, but in that case they will just
> have to deal with the bugs. Removing register_ioctl32_conversion
> and some comments would take care of them anyways.

I mean out of tree code can just implement ioctl_compat by taking the BKL
if it needs it.

MST
