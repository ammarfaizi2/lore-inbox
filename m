Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262290AbULOIA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262290AbULOIA1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 03:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262303AbULOIA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 03:00:27 -0500
Received: from mail.suse.de ([195.135.220.2]:52878 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262290AbULOIAV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 03:00:21 -0500
Date: Wed, 15 Dec 2004 09:00:20 +0100
From: Andi Kleen <ak@suse.de>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, pavel@suse.cz,
       discuss@x86-64.org, gordon.jin@intel.com
Subject: Re: unregister_ioctl32_conversion and modules. ioctl32 revisited.
Message-ID: <20041215080020.GT27225@wotan.suse.de>
References: <20041215065650.GM27225@wotan.suse.de> <20041215074635.GC11501@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041215074635.GC11501@mellanox.co.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There were two additional motivations for my patch:
> 1. Make it possible to avoid the BKL completely by writing
>    an ioctl with proper internal locking.

Good point.  It is the first step towards BKL less native ioctls. So it's 
certainly a good idea even for the non compat case.

> 2. As noted by  Juergen Kreileder, the compat hash does not work
>    for ioctls that encode additional information in the command, like this:
> 
> #define EVIOCGBIT(ev,len)  _IOC(_IOC_READ, 'E', 0x20 + ev, len)
> 
> I post the patch (updated for 2.6.10-rc2, boots) that I built for
> Juergen, below. If there's interest, let me know.

Patch looks good to me, except for some messed up white space
that is probably easily fixed.

> I'd like to add that my patch does not touch any in-kernel users,
> that would have to be done separately, probably as a first step
> simply taking the BKL inside ioctl_compat.

I doubt any of the compat wrappers need BKL, they never touch
any global state and then just call sys_ioctl which takes the BKL
only when needed.

Ok there is a slight possibility that out of tree code wrote
compat wrappers that need BKL, but in that case they will just
have to deal with the bugs. Removing register_ioctl32_conversion
and some comments would take care of them anyways.

-Andi
