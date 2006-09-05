Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbWIENDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbWIENDi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 09:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbWIENDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 09:03:38 -0400
Received: from cs.columbia.edu ([128.59.16.20]:7334 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id S932179AbWIENDg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 09:03:36 -0400
Subject: Re: [PATCH 00/22][RFC] Unionfs: Stackable Namespace Unification
	Filesystem
From: Shaya Potter <spotter@cs.columbia.edu>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Pavel Machek <pavel@ucw.cz>, Josef Sipek <jsipek@cs.sunysb.edu>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org, viro@ftp.linux.org.uk
In-Reply-To: <Pine.LNX.4.61.0609050759360.17126@yvahk01.tjqt.qr>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu>
	 <20060903110507.GD4884@ucw.cz>
	 <1157376506.4398.15.camel@localhost.localdomain>
	 <20060904203346.GA6646@elf.ucw.cz>
	 <1157406184.4398.24.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0609050759360.17126@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Tue, 05 Sep 2006 09:02:39 -0400
Message-Id: <1157461359.23523.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, X-Seen-By filter2.cs.columbia.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-05 at 08:02 +0200, Jan Engelhardt wrote:
> >
> >I agree that unionfs shouldn't oops, it should handle that situation in
> >a more graceful manner, but once the "backing store" is modified
> >underneath it, all bets are off for either unionfs or ext2/3 behaving
> >"correctly" (where "correctly" doesn't just mean handle the error
> >gracefully).
> >
> >But are you also 100% sure that messing with the underlying backing
> >store wouldn't be considered an admin bug as opposed to an administrator
> >bug? I mean there's nothing that we can do to prevent an administrator
> >from FUBAR'ing their system by 
> >
> >dd if=/dev/random of=/dev/kmem.
> >
> >where does one draw the line?  I agree that stackable file systems make
> >this a more pressing issue, as the "backing store" can be visible within
> >the file system namespace as a regular file system that people are
> >generally accustomed to interacting with.
> 
> So here's an idea. When a branch is added, mount an empty space onto the
> branch. (From within the kernel, so it appears as a side-effect of mount(2))
> 
>   mount -t unionfs -o dirs=/a=rw:/b=ro none /union
> 
> should imply something like
> 
>   mount --bind /var/lib/empty /a
>   mount --bind /var/lib/empty /b
> 
> Or better, yet, make them read-only:
> 
>   mount --rbind -o ro /a /a
>   mount --rbind -o ro /b /b
> (hope this works as intended?)
> 
> So that no one can tinker with /a and /b while the union is mounted.

I thought about that, but that doesn't help you w/ the NFS as branch
case.

