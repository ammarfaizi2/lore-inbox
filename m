Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261642AbULOI3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261642AbULOI3W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 03:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbULOI3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 03:29:22 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:167 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261642AbULOI3S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 03:29:18 -0500
Date: Wed, 15 Dec 2004 09:29:17 +0100
From: Andi Kleen <ak@suse.de>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, pavel@suse.cz,
       discuss@x86-64.org, gordon.jin@intel.com
Subject: Re: unregister_ioctl32_conversion and modules. ioctl32 revisited.
Message-ID: <20041215082917.GW27225@wotan.suse.de>
References: <20041215065650.GM27225@wotan.suse.de> <20041215074635.GC11501@mellanox.co.il> <20041215080020.GT27225@wotan.suse.de> <20041215082128.GA11889@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041215082128.GA11889@mellanox.co.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2004 at 10:21:28AM +0200, Michael S. Tsirkin wrote:
> > > 2. As noted by  Juergen Kreileder, the compat hash does not work
> > >    for ioctls that encode additional information in the command, like this:
> > > 
> > > #define EVIOCGBIT(ev,len)  _IOC(_IOC_READ, 'E', 0x20 + ev, len)
> > > 
> > > I post the patch (updated for 2.6.10-rc2, boots) that I built for
> > > Juergen, below. If there's interest, let me know.
> > 
> > Patch looks good to me, except for some messed up white space
> > that is probably easily fixed.
> 
> I did try so .. Where? :)

Most of it actually. But perhaps your mailer just messed up the patch?

Anyways, if there are no negative comments I would recommend you
submit your patch (preferably in a non messed up form) to akpm@osdl.org
for inclusion into -mm*. The other parts of the proposal (converting
the existing users and deprecating register_ioctl32_conversion) could be 
attacked then.

There is also some related work that could be done easily then,
e.g. the network stack ioctls currently drop the BKL as first thing.
With ioctl_native that could be probably done better. There may 
be other such low hanging fruit areas too.

-Andi
