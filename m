Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266316AbUAGTul (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 14:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266318AbUAGTuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 14:50:40 -0500
Received: from mail.kroah.org ([65.200.24.183]:60811 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266316AbUAGTuh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 14:50:37 -0500
Date: Wed, 7 Jan 2004 11:50:33 -0800
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: removable media revalidation - udev vs. devfs or static /dev
Message-ID: <20040107195032.GB823@kroah.com>
References: <200401012333.04930.arvidjaar@mail.ru> <20040103055847.GC5306@kroah.com> <Pine.LNX.4.58.0401071036560.12602@home.osdl.org> <20040107185656.GB31827@kroah.com> <Pine.LNX.4.58.0401071123490.12602@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401071123490.12602@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 11:31:55AM -0800, Linus Torvalds wrote:
> On Wed, 7 Jan 2004, Greg KH wrote:
> > > But udev should probably also create all the sub-nodes if it doesn't 
> > > already.
> > 
> > It doesn't, as I thought we could rely on the kernel partition support.
> 
> Indeed, we _can_ rely on the kernel partition support, but the subnodes 
> are needed to get at those partitions.
> 
> Obviously, a "repartitioning hotplug event" can create the subnodes, but 
> that will fail exactly because it wouldn't allow the user to just access 
> the nodes.

It sounds like just having the device node around will not cause the
rescan if you access it.  I don't have any such devices here to test
this out or not.  If true, having udev create all nodes will not help
out much :(

> > Hm, that would work, but what about a user program that just polls on
> > the device, as the rest of this thread discusses?
> 
> I hate those "background CPU users". Have you looked at "ps" output after 
> something like kscd has run, and does a CD check every second? It's 
> _expensive_. It goes all the way down to the hardware, sends a request 
> to the device.

Oh I know, it's one of the first things I disable when setting up a box :)

> Doing it every five minutes wouldn't be an issue, but doing it every five 
> minutes would be absolutely _horrible_ from a user perspective standpoint. 
> If you insert a smartmedia card in your cardreader, you expect to be able 
> to access it pretty much immediately when you start typing. So a second or 
> two of delay is fine, but even just five or ten seconds are already bad.
> 
> So the choice is:
>  - probe every removable device once a second
>  - pre-populate the device nodes, and when the user presses the icon that 
>    says "mount", it will just do so. Immediately. No delay at all.

Based on the previous info, I think we are stuck with probing :(

> NOTE! We do have an alternative: if we were to just make block device 
> nodes support "readdir" and "lookup", you could just do
> 
> 	open("/dev/sda/1" ...)
> 
> and it magically works right. I've wanted to do this for a long time, but 
> every time I suggest allowing it, people scream.

Hm, that would be nice.  I don't remember seeing it being proposed
before, what are the main complaints people have with this?

thanks,

greg k-h
