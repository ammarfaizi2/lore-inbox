Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbVKWQtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbVKWQtK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 11:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbVKWQtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 11:49:10 -0500
Received: from styx.suse.cz ([82.119.242.94]:40900 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932071AbVKWQtI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 11:49:08 -0500
Date: Wed, 23 Nov 2005 17:49:07 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Marc Koschewski <marc@osknowledge.org>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>, rmk+lkml@arm.linux.org.uk
Subject: Re: Christmas list for the kernel
Message-ID: <20051123164907.GA2981@ucw.cz>
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com> <20051122204918.GA5299@kroah.com> <9e4733910511221313t4a1e3c67wc7b08160937eb5c5@mail.gmail.com> <20051123121726.GA7328@ucw.cz> <9e4733910511230643j64922738p709fecd6c86b4a95@mail.gmail.com> <20051123150349.GA15449@flint.arm.linux.org.uk> <9e4733910511230712y2b394851rc17fa71c6f9c6ecf@mail.gmail.com> <20051123155650.GB6970@stiffy.osknowledge.org> <20051123160520.GH15449@flint.arm.linux.org.uk> <9e4733910511230837v1519d3b3t28176b1fd6017ffc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910511230837v1519d3b3t28176b1fd6017ffc@mail.gmail.com>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 11:37:23AM -0500, Jon Smirl wrote:

> Before everyone gets excited, I realize that all of this has
> historical implications. But that doesn't mean we can't discuss
> possible future alternative solutions.
> 
> Thinking about this for a while it seems to me that the problem is
> that the various apps (init, syslog) etc should not have a tty name as
> part of their command line parameters. Instead these apps could use
> ptys instead. Ptys would solve all of the race problems too.
> 
> Is there any good reason (other than history) for using a device node
> name (tty0, etc) instead of some other naming scheme if names are
> needed at all?
> 
> If init, syslog, etc can be converted to ptys, do we need ttys? Xterms
> use ptys I don't notice that they aren't connect to a fix tty name.
> The virtual consoles would still be 0,1,2 but do they have to be
> hooked to tty0, 1, 2 instead of a pty?
 
The basic difference between a pty and tty is that a pty connects to a
program (that created it by opening the ptmx node, for example xterm or
ssh) on the other end, while a tty connects to the kernel doing all the
character drawing in the framebuffer.

You can't easily use one instead of the other, they're very different
beasts.

Of course, a way to use a pty would be to have the console
implementation in userspace.

The fact that no program is on the other end of a tty is also the reason
why they cannot be created dynamically like ptys, there is noone to open
a "ttmx" to create the ttys.

Hence, the device nodes are pre-created by the kernel, while the real
devices are only created on open.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
