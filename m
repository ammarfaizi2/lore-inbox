Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261889AbVACVP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbVACVP1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 16:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261886AbVACVOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 16:14:19 -0500
Received: from brown.brainfood.com ([146.82.138.61]:16350 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S261889AbVACVHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 16:07:54 -0500
Date: Mon, 3 Jan 2005 15:07:42 -0600 (CST)
From: Adam Heath <doogie@brainfood.com>
X-X-Sender: adam@gradall.private.brainfood.com
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "xen-devel@lists.sf.net" <xen-devel@lists.sf.net>
Subject: Re: [Xen-devel] Re: [XEN] using shmfs for swapspace
In-Reply-To: <20050103205318.GD6631@lkcl.net>
Message-ID: <Pine.LNX.4.58.0501031506080.21792@gradall.private.brainfood.com>
References: <20050102162652.GA12268@lkcl.net> <20050103183133.GA19081@samarkand.rivenstone.net>
 <20050103205318.GD6631@lkcl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jan 2005, Luke Kenneth Casson Leighton wrote:

> On Mon, Jan 03, 2005 at 01:31:34PM -0500, Joseph Fannin wrote:
> > On Sun, Jan 02, 2005 at 04:26:52PM +0000, Luke Kenneth Casson Leighton wrote:
> > [...]
> > > this is presumed to be infinitely better than forcing the swapspace to
> > > be always on disk, especially with the guests only being allocated
> > > 32mbyte of physical RAM.
> >
> >     I'd be interested in knowing how a tmpfs that's gone far into swap
> > performs compared to a more normal on-disk fs.  I don't know if anyone
> > has ever looked into it.  Is it comparable, or is tmpfs's ability to
> > swap more a last-resort escape hatch?
> >
> >     This is the part where I would add something valuable to this
> > conversation, if I were going to do that. (But no.)
>
>  :)
>
>  okay.
>
>  some kind person from ibm pointed out that of course if you use a
>  file-based swap file (in xen terminology,
>  disk=['file:/xen/guest1-swapfile,/dev/sda2,rw'] which means "publish
>  guest1-swapfile on the DOM0 VM as /dev/sda2 hard drive on the
>  guest1 VM) then you of course end up using the linux filesystem cache
>  on DOM0 which is of course RAM-based.
>
>  so this tends to suggest a strategy where you allocate as
>  much memory as you can afford to the DOM0 VM, and as little
>  as you can afford to the guests, and make the guest swap
>  files bigger to compensate.

But the guest kernels need real ram to run programs in.

The problem with dom0 doing the caching, is that dom0 has no idea about the
usage pattern for the swap.  It's just a plain file to dom0.  Only each guest
kernel knows how to combine swap reads/writes correctly.
