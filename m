Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261351AbSJHWEo>; Tue, 8 Oct 2002 18:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261321AbSJHWEn>; Tue, 8 Oct 2002 18:04:43 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14341 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261320AbSJHWEk>; Tue, 8 Oct 2002 18:04:40 -0400
Date: Tue, 8 Oct 2002 15:12:03 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Patrick Mochel <mochel@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       <andre@linux-ide.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] embedded struct device Re: [patch] IDE driver model update
In-Reply-To: <Pine.GSO.4.21.0210081735370.5897-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.44.0210081510550.1226-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 8 Oct 2002, Alexander Viro wrote:
> That would be nice, if it worked that way.  As it is we have
> 
> driver allocates foo
> driver grabs a reference to foo->dev
> ....
> somebody else grabs/drops temporary references to foo->dev
> ....
> driver call put_device(&foo->dev)
> driver frees structures refered from foo.
> driver frees foo.
> 
> _IF_ the last two steps were done by ->release(), your arguments would
> work.  Actually they are done by driver right after the put_device() call.

Right. But that's a driver bug, and it's because this whole thing is 
fairly new.

There aren't that many things that actually play with these things (mainly 
the PCI and the USB layer, and individual drivers shouldn't care, it's 
just the bus layer that does all of this), so we should be able to fix the 
cases cleanly.

		Linus

