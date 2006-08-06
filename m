Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932447AbWHFKPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbWHFKPT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 06:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932533AbWHFKPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 06:15:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3771 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932447AbWHFKPS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 06:15:18 -0400
Date: Sun, 6 Aug 2006 03:15:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matthias Dahl <mlkernel@mortal-soul.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sluggish system responsiveness under higher IO load
Message-Id: <20060806031512.57585f5d.akpm@osdl.org>
In-Reply-To: <200608061200.37701.mlkernel@mortal-soul.de>
References: <200608061200.37701.mlkernel@mortal-soul.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Aug 2006 12:00:37 +0200
Matthias Dahl <mlkernel@mortal-soul.de> wrote:

> Since I bought my current system, I have experienced sluggish system 
> responsiveness when the IO load increases to a certain point.
> 
> For example: when I emerge (gentoo system) new kernel sources, during the 
> untar process of the archive, Xorg gets sluggish, meaning you can sometimes 
> see the entire desktop or windows repainting or the mouse pointer jumps 
> around. From time to time, depending on the IO load, even typing in the 
> console doesn't respond right away.
> 
> I opened a thread in the gentoo support forum for amd64 which brought some 
> details to light: it doesn't seem to be a nforce4 or amd64 related problem, 
> because other people on newer intel based systems run into exactly the same 
> problems. It looks like a general sata issue. Here a link to the thread:
> 
>    http://forums.gentoo.org/viewtopic-t-482731.html

I'd suggest that you generate a kernel profile while the sluggishness is
happening.

Boot with "profile=1" on the kernel boot command line.  Then run:

readprofile -r
do-sluggish-thing
readprofile -n -v -m /boot/System.map | sort -n -k 3 | tail -40


Or, better-but-more-complex: oprofile.
