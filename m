Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751002AbVLTN0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbVLTN0p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 08:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbVLTN0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 08:26:45 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:34581 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750999AbVLTN0p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 08:26:45 -0500
Date: Tue, 20 Dec 2005 14:28:21 +0100
From: Jens Axboe <axboe@suse.de>
To: Ben Collins <ben.collins@ubuntu.com>
Cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       greg@kroah.com
Subject: Re: [RFC] Let non-root users eject their ipods?
Message-ID: <20051220132821.GH3734@suse.de>
References: <1135047119.8407.24.camel@leatherman> <20051220074652.GW3734@suse.de> <1135082490.16754.0.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135082490.16754.0.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20 2005, Ben Collins wrote:
> On Tue, 2005-12-20 at 08:46 +0100, Jens Axboe wrote:
> > On Mon, Dec 19 2005, john stultz wrote:
> > > All,
> > > 	I'm getting a little tired of my roommates not knowing how to safely
> > > eject their usb-flash disks from my system and I'd personally like it if
> > > I could avoid bringing up a root shell to eject my ipod. Sure, one could
> > > suid the eject command, but that seems just as bad as changing the
> > > permissions in the kernel (eject wouldn't be able to check if the user
> > > has read/write permissions on the device, allowing them to eject
> > > anything).
> > 
> > This just came up yesterday, eject isn't opening the device RDWR hence
> > you have a permission problem with a command requiring write
> > permissions. So just fix eject, there's no need to suid eject or run it
> > as root.
> 
> Yep, and here's the patch to do it:
> 
> http://bugzilla.ubuntu.com/attachment.cgi?id=5415
> 
> Still, this whole issue with ALLOW_MEDIUM_REMOVAL. Would be nice if
> CDROMEJECT just did the right thing.

I would tend to agree, but you are bypassing the checks that are in
there by doing so which isn't very nice. Then we might as well just mark
ALLOW_MEDIUM_REMOVAL as safe-for-read in the first place.

-- 
Jens Axboe

