Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161220AbWFVTuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161220AbWFVTuf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 15:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161226AbWFVTuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 15:50:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50667 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161220AbWFVTud (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 15:50:33 -0400
Date: Thu, 22 Jun 2006 12:50:23 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <gregkh@suse.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [GIT PATCH] USB patches for 2.6.17
In-Reply-To: <20060622183021.GA5857@kroah.com>
Message-ID: <Pine.LNX.4.64.0606221239100.5498@g5.osdl.org>
References: <20060621220656.GA10652@kroah.com> <Pine.LNX.4.64.0606211519550.5498@g5.osdl.org>
 <20060621225134.GA13618@kroah.com> <Pine.LNX.4.64.0606211814200.5498@g5.osdl.org>
 <20060622181826.GB22867@kroah.com> <20060622183021.GA5857@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 22 Jun 2006, Greg KH wrote:
> 
> I take that back.  I just used -M for the W1 patch series and I think it
> is very helpful as it shows only the lines that change in a rename,
> which can easily get lost in the noise of a longer patch.

Yes. The main reason to do rename detection is not that the patch shrinks 
(although it does), but simply because in many cases it makes the patch a 
hell of a lot more readable. It's often much more obvious what is actually 
going on, when you don't see it as a large "one file got deleted, another 
one added" thing.

> Very nice stuff, have I mentioned lately how much I love git?

It does seem to be working out, doesn't it?

I'm just constantly surprised by how people don't even seem to realize 
what it can do sometimes. Part of it is that development has been pretty 
active (and some of the things it can do simply weren't there three months 
ago), but part of it must be because people don't even expect it to be 
able to do something like that.

The "git log -p" thing is wonderful, but it's even more wonderful when you 
realize that you can ask it to just tell you what changed in a specific 
set of subdirectories. Or when you realize that you can actually have two 
branches, and ask it to show only the commits that are in one and not the 
other (even if the branches are _not_ subsets of each other).

For example, if you track my branch separately (not merging, and not 
rebasing - just doing something like "git fetch linus" to track where I 
am), you can always just do things like

	git log -p ..linus drivers/usb/

to see what _I_ have merged that might touch drivers/usb/, but that isn't 
in your branch because I ended up taking a patch from somebody else (for 
example, you might see some USB change that the MIPS merges brought in).

That kind of thing has, I believe, been the biggest success of the whole 
git model (the "track whole _trees_ rather than individual files").

I realize that some people are used to individual file tracking, and that 
the git model makes "git annotate individual_file.c" pretty inefficient, 
but at least for me, the whole sub-tree tracking is a _lot_ more 
important, and I don't think anybody else can do it as effortlessly and 
efficiently as git does.

The above kind of command line is just _so_ powerful. Maybe it's because 
I'm a top-level maintainer, but I basically _never_ care about a single 
file, but often care about one (or a few) subdirectory.

And Junio has done a stellar job at maintaining git. 

		Linus
