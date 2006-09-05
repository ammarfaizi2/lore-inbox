Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965173AbWIEGKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965173AbWIEGKY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 02:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965170AbWIEGKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 02:10:24 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:60373 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S965167AbWIEGKX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 02:10:23 -0400
Date: Tue, 5 Sep 2006 08:02:50 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Shaya Potter <spotter@cs.columbia.edu>
cc: Pavel Machek <pavel@ucw.cz>, Josef Sipek <jsipek@cs.sunysb.edu>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org, viro@ftp.linux.org.uk
Subject: Re: [PATCH 00/22][RFC] Unionfs: Stackable Namespace Unification
 Filesystem
In-Reply-To: <1157406184.4398.24.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0609050759360.17126@yvahk01.tjqt.qr>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu>  <20060903110507.GD4884@ucw.cz>
  <1157376506.4398.15.camel@localhost.localdomain>  <20060904203346.GA6646@elf.ucw.cz>
 <1157406184.4398.24.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>I agree that unionfs shouldn't oops, it should handle that situation in
>a more graceful manner, but once the "backing store" is modified
>underneath it, all bets are off for either unionfs or ext2/3 behaving
>"correctly" (where "correctly" doesn't just mean handle the error
>gracefully).
>
>But are you also 100% sure that messing with the underlying backing
>store wouldn't be considered an admin bug as opposed to an administrator
>bug? I mean there's nothing that we can do to prevent an administrator
>from FUBAR'ing their system by 
>
>dd if=/dev/random of=/dev/kmem.
>
>where does one draw the line?  I agree that stackable file systems make
>this a more pressing issue, as the "backing store" can be visible within
>the file system namespace as a regular file system that people are
>generally accustomed to interacting with.

So here's an idea. When a branch is added, mount an empty space onto the
branch. (From within the kernel, so it appears as a side-effect of mount(2))

  mount -t unionfs -o dirs=/a=rw:/b=ro none /union

should imply something like

  mount --bind /var/lib/empty /a
  mount --bind /var/lib/empty /b

Or better, yet, make them read-only:

  mount --rbind -o ro /a /a
  mount --rbind -o ro /b /b
(hope this works as intended?)

So that no one can tinker with /a and /b while the union is mounted.


Jan Engelhardt
-- 
