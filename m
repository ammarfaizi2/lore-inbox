Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbWELRX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbWELRX5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 13:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWELRX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 13:23:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36568 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751105AbWELRX4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 13:23:56 -0400
Date: Fri, 12 May 2006 10:23:53 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: John Kelly <jak@isp2dial.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: + deprecate-smbfs-in-favour-of-cifs.patch added to -mm tree
In-Reply-To: <200605121710.k4CHA6Hv005194@isp2dial.com>
Message-ID: <Pine.LNX.4.64.0605121015520.3866@g5.osdl.org>
References: <200605110717.k4B7HuVW006999@shell0.pdx.osdl.net>
 <20060511175143.GH25646@redhat.com> <Pine.LNX.4.61.0605121243460.9918@yvahk01.tjqt.qr>
 <200605121619.k4CGJCtR004972@isp2dial.com> <Pine.LNX.4.58.0605121222070.5579@gandalf.stny.rr.com>
 <200605121630.k4CGUuiU005025@isp2dial.com> <Pine.LNX.4.64.0605120949060.3866@g5.osdl.org>
 <200605121710.k4CHA6Hv005194@isp2dial.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 May 2006, John Kelly wrote:
> 
> I just think forward progress would be easier without dragging around
> some of the old baggage in the kernel.

I think that is generally true, but we've actually been pretty successful 
in having a modular enough source tree that most of the time, old code 
simply is old - and doesn't much affect new code.

That is especially true in filesystems. We've had a few fairly painful 
times (the page cache changes in 2.3.x and the switch to the dentry cache 
in 2.1.x(?)), but on the whole we've had a pretty stable VFS interface 
that hasn't needed _that_ much work for individual filesystems.

We've had much bigger problems with drivers, although there the main 
reason for the problems is just that if some interface changes even very 
trivially, there's just so _many_ drivers that they tend to be harder to 
fix up (and they tend to do things that you can't "think about" because 
it's very much due to bugs or specific issues with some random piece of 
hardware that most developers don't even have access to).

Also, while it can be easier in _one_sense_ to move forwards if you drop 
the old stuff, it often ends up making it harder in another sense: it can 
mean, for example, that people or distributions need to do more work to 
update, which in turn can mean that you have a much harder time getting 
the change tested.

Which then in turn can mean that you actually lose more developer time 
than you gained from the code simplification..

So it's not always a very clear-cut thing. For the _users_ (and those are 
who matter most), backwards compatibility is almost always absolutely the 
biggest priority, and everything else comes second.

		Linus
