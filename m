Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbTKBGGP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 01:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbTKBGGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 01:06:14 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:39173
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S261463AbTKBGGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 01:06:12 -0500
Date: Sat, 1 Nov 2003 22:05:31 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Ville Herva <vherva@niksula.hut.fi>
cc: Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org
Subject: Re: ide write cache issue? [Re: Something corrupts raid5 disks
 slightly during reboot]
In-Reply-To: <20031101210223.GM4640@niksula.cs.hut.fi>
Message-ID: <Pine.LNX.4.10.10311012201421.23682-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I added the flush code to flush a drive in several places but it got
pulled and munged.

The original model was to flush each time a device was closed, when any
partition mount point was released, and called by notifier.

In a minimal partition count of 1, you had at least two flush before
shutdown or reboot.

So it was not the code because I fixed it, but then again I am retiring
from formal maintainership.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Sat, 1 Nov 2003, Ville Herva wrote:

> On Sat, Nov 01, 2003 at 08:01:14PM +0100, you [Willy Tarreau] wrote:
> > On Sat, Nov 01, 2003 at 08:25:18PM +0200, Ville Herva wrote:
> >  
> > > Is there anything special in booting to DOS instead of different linux
> > > kernel, other than that it would rule out some strange kernel bug that is
> > > present in 2.2 and 2.4?
> > 
> > No, it was just to quicky confirm or deny the fact that it's the kernel
> > which causes the problem. It could have been a long standing bug in the IDE
> > or partition code, and which is present in several kernels. 
> 
> I vaguely recall some ide write cache flushing code was fixed some time ago,
> but I can't find it in the archives. Maybe I dreamed that up. But I still
> wonder why an otherwise idle drive would hold the data in write cache for so
> long (several minutes.)
> 
> > But as you say that it affects two different controllers, there's little
> > chance that it's caused by anything except linux itself. 
> 
> Unless the drive is buggy wrt. flushing its write cache. But I think it's
> a quite distant possibility.
> 
> > Then, the reboot on DOS will only tell you if the drives were corrupted at
> > startup or at shutdown.
> 
> Yep. I'll try to find the moment to boot the beast into something else than
> the current kernel / distro (it could in theory be something in userspace,
> though I cannot think what). 
> 
> > > BTW: the corruption happens on warm reboots (running reboot command), not
> > > just on power off / on.
> > 
> > OK, but the BIOS scans your disks even during warm reboots. 
> 
> True, I mainly made this note because I hadn't mentioned it before in the
> thread, and I thought it might have some relevance wrt. possible ide write
> caching problems. I didn't mean it as a response to the BIOS theory.
> 
> 
> -- v --
> 
> v@iki.fi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

