Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263800AbUBKBfW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 20:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263868AbUBKBfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 20:35:22 -0500
Received: from h24-82-88-106.vf.shawcable.net ([24.82.88.106]:43149 "HELO
	tinyvaio.nome.ca") by vger.kernel.org with SMTP id S263805AbUBKBfJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 20:35:09 -0500
Date: Tue, 10 Feb 2004 17:35:36 -0800
From: Mike Bell <kernel@mikebell.org>
To: Timothy Miller <miller@techsource.com>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: devfs vs udev, thoughts from a devfs user
Message-ID: <20040211013535.GB4915@tinyvaio.nome.ca>
References: <20040210113417.GD4421@tinyvaio.nome.ca> <20040210170157.GA27421@kroah.com> <20040210171337.GK4421@tinyvaio.nome.ca> <40291A73.7050503@nortelnetworks.com> <20040210192456.GB4814@tinyvaio.nome.ca> <40293BEB.9010606@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40293BEB.9010606@techsource.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 03:15:39PM -0500, Timothy Miller wrote:
> What's unpredictable about it?  udev can apply exactly the same rules 
> that devfs uses, thereby coming up with the same names.  In that limited 
> case, the advantage to udev is to move code out of the kernel.  Not only 
> does that shrink the kernel, but it moves policy that affects user space 
> into user space.

But you're still relying on sysfs. You're not shrinking the kernel,
you're moving the resource usage to a different filesystem which is new
and thus doesn't have people who feel strongly about how the files in it
should be named.


> If udev had a "devfs" mode where it used a ramdisk for device nodes, and 
> it produced exactly the same names as devfs, would you be happy with it?

No, as I already said, udev on a tmpfs would not be enough for me. Or at
least that's the opinion I have now, it seems pretty much everyone loves
udev, so it may well become The Way to do things on linux, at which
point I may not have a choice but to grow to love it. :)

> You have the further advantage, for the embedded people, that you can 
> eliminate udev, and create static device nodes, without having to modify 
> the kernel in any way.

But the old devfs argument was that devfs actually takes LESS flash than
a static /dev. Even the udev author says it was good for embedded
people.

> For the typical case, udev COULD produce the same device names as devfs, 
> completely addressing your "predictability" issue.  It would be 
> PERFECTLY predictable.

No, because I'm saying that udev's fundamental philosophy seems to be
"instead of", when it talks about giving the user more choice than
devfs, it's talking about the freedom to have different names INSTEAD OF
the ones everyone else has. It doesn't matter what layout those names
have, devfs-style or LFS-style or whatever, the point is that the
devfs-style "in addition to" userspace daemon means you've always got
predictable names for device files there as well.

I'm not saying that's a big win for devfs, or that it couldn't be done
in userspace. I'm asking why people keep talking about that as if it was
a win for udev? Why is that a good thing? Because that's the difference
between a devfsd and a udev, both can create whatever crazy naming
scheme you want, completely in user space. But the devfsd relies on the
paths to kernel-generated device files, while udev relies on the paths
to kernel-generated text files in a different tree.

> Can devfs do that?  If so, where does it keep its history?

With devfsd. In userspace, the same place as udev. 

> How does devfs save space?  Device node information has to be stores 
> SOMEWHERE.  Whether that's in filesystem nodes or in datastructures in 
> the kernel that are dynamically made to LOOK like device nodes, you 
> still need to take up memory.

But a filesystem that is able to support the creation of a file
up to ssize_t, loopback mounting, maximum "disc" space usage and other
accounting stuff (tmpfs) is presumably more space inefficient than one
that just has to support devices, symlinks and fifos, all of which have
tiny metadata and don't need associated "blocks" to store their data.

