Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262205AbVBVEql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262205AbVBVEql (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 23:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262207AbVBVEqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 23:46:40 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:25871 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262205AbVBVEqF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 23:46:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=JD0GidhUzHxHzviWhcL7ST/8CgtrPKGea5tmSJpZC5EUisyscJiL7QeodAXAaWxcuhQy8mGwxCXUu54xIuOOzYgk2NwihKqgeI72T4LDRMtww+ojxMKVixNcAS61VUGqcDNQdebTb8El8s578L2a9O8nHQ/G7VCuYgbdXSeuNyU=
Message-ID: <21d7e99705022120462cb9494c@mail.gmail.com>
Date: Tue, 22 Feb 2005 15:46:03 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: James Simmons <jsimmons@www.infradead.org>
Subject: Re: [Linux-fbdev-devel] Resource management.
Cc: Jon Smirl <jonsmirl@gmail.com>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       adaplas@pol.net, dri-devel@lists.sourceforge.net,
       xorg@lists.freedesktop.org, Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.56.0502220319330.20949@pentafluge.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.56.0502211908520.14500@pentafluge.infradead.org>
	 <200502220653.01286.adaplas@hotpop.com>
	 <Pine.LNX.4.56.0502212313160.18148@pentafluge.infradead.org>
	 <9e473391050221170111610521@mail.gmail.com>
	 <Pine.LNX.4.56.0502220319330.20949@pentafluge.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 1. Lots of work that would take lots of time. To my knowledge all fbdev
>    developers work in there spare free time. No one does this for a
>    living.

So do most of the drm developers, I know I do and Jon Smirl does, and
Eric Anholt does and I think us three have been the largest
contributers apart from new driver submissions...

> 2. Sharing of headers. The dri headers are isolated in the drm directory.
>    I totally understand why :-) It makes merging easier for them. The
>    disadvantage is no one in the fbdev can use them easily :-(

I plan to move them in 2.6.12 maybe .. it might be 2.6.13 by the time
I get around to it, just some minor issues.. Arjan asked me for this
ages ago as well...
 
> 3. DRM has way to much functionality for most embedded devices. I have
>    talked to embedded guys before and they want a simple api to work with.
>    By default DRM builds in everything. A simple api mean alot to those
>    guys. Plus the extra built in code bloat takes up to much space which
>    is precious on embedded devices. If a devices doesn't support dma then
>    the dma code doesn't need to be built in.

Well crap on that, the old DRM didn't build everything in people
complained aw this code is too messy, build everything in, now you
want to revert? damn you all!!! :-), I understand I'm just saying we
can't have it both ways.. and too be honest I'm an embedded person and
I just want it to work, with a Linux kernel you rarely get to an every
byte counts embedded env, of if you are you aren't using the stock
Linus kernel....

> 
> 4. Which comes to the next point. The code is not modular enough. Take
>    drm_bufs.c. Everything is a ioctl function. This has a few disadvantages.
>    One is the fbdev layer couldn't just link into it so fbcon could use
>    it. The second is it's not easy to take advantage of things like sysfs.
>    If you could untangle the code somewhat it would make life so much
>    easier. That would include making life easier for OS ports.

the reason we can't take advantage of sysfs or anything like it is
that we can't bind to the PCI device as we break things.. this is the
root of a lot of our problems...

> 
> 5. The license issue. The DRI code is GPL and additional rights. What is that?
Nope the drm code is BSD... there should be no GPL anywhere near it...
it is GPL in the kernel as of course it is imported into a GPL work..
but the code is available for BSD uses....

Jon's last plan - was like to have a radeon basic module, with fb and
drm personalities and in fact any number of personalities..taking
radeon as example:
base module : hotplug, reset, monitor probing, memory management, CP
programming and locking.
fb: adds accelerated fb functions using CP locking.
drm: adds drm functionality on top of base module, drm ioctl interfaces etc..

I've looked at Alans ideas on a vga_class driver and have decided they
are unworkable due to the massive initial changes they involve in
*every* fb/drm driver in the kernel, I cannot undertake a work of that
magnitude without fb people being involved and the chances of breaking
a lot of stuff.. maybe a 2.7 thing but I don't think we'll ever have a
2.7 for this stuff...

What I do think though is that ideas of a the vga class driver could
be made into a helper module that the base graphics driver uses to do
some standard things, like reset and stuff..

I'm hoping to get a better handle on these ideas and write something
up.. but they are mostly Jons ideas better presented :-)

Dave.
