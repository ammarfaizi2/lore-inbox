Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263013AbVALCNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263013AbVALCNy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 21:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263008AbVALCNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 21:13:53 -0500
Received: from orb.pobox.com ([207.8.226.5]:30153 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S263005AbVALCMz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 21:12:55 -0500
Date: Tue, 11 Jan 2005 18:12:46 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: "Barry K. Nathan" <barryn@pobox.com>, Linus Torvalds <torvalds@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Lukasz Trabinski <lukasz@wsisiz.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make uselib configurable (was Re: uselib()  & 2.6.X?)
Message-ID: <20050112021246.GE4325@ip68-4-98-123.oc.oc.cox.net>
References: <Pine.LNX.4.58LT.0501071648160.30645@oceanic.wsisiz.edu.pl> <20050107170712.GK29176@logos.cnet> <1105136446.7628.11.camel@localhost.localdomain> <Pine.LNX.4.58.0501071609540.2386@ppc970.osdl.org> <20050107221255.GA8749@logos.cnet> <Pine.LNX.4.58.0501081042040.2386@ppc970.osdl.org> <20050111225127.GD4378@ip68-4-98-123.oc.oc.cox.net> <20050111235907.GG2760@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050111235907.GG2760@pclin040.win.tue.nl>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2005 at 12:59:07AM +0100, Andries Brouwer wrote:
> > +config SYS_USELIB
> > +	bool "sys_uselib syscall support (needed for old binaries)"
> > +	---help---
> > +	  Many old binaries (e.g. dynamically linked a.out binaries, and
> > +	  ELF binaries that are dynamically linked against libc5), require
> > +	  the sys_uselib syscall. However, on the typical Linux system, this
> > +	  code is just old cruft that no longer serves a purpose.
> > +
> > +	  If you are unsure, say "N" if you care more about security and
> > +	  trimming bloat, or say "Y" if you care more about compatibility
> > +	  with old software. (If you will answer "Y" or "M" to BINFMT_AOUT,
> > +	  below, you probably should answer "Y" here.)
> 
> s/sys_uselib/uselib/
> The system call is uselib().

Ok.

> Hmm - old cruft.. Why insult your users?
> I do not have source for Maple. And my xmaple binary works just fine.
> But it is a libc4 binary.

Err... I didn't see it as "insulting [my] users". That was not at all
what I intended. I'll have to rework that...

> You mean "on the typical recently installed Linux system,
> with nothing but the usual Linux utilities".

No, more like, "on the typical Linux system installed since 2000,
running additional 3rd-party software from no earlier than 2001", or
something vaguely like that.

> People always claim that Linux is good in preserving binary compatibility.
> Don't know how true that was, but introducing such config options doesnt
> help.

Binary compatibility is good to have, but it isn't everything in life.
*Optionally* breaking compatibility with certain types of old binaries
doesn't seem so bad to me. People who want binary compatibility can have
it, and people who don't need it can choose to not install the old code
on their systems.

> Let me also mutter about something else.
> In principle configuration options are evil. Nobody wants fifty thousand
> configuration options. But I see them multiply like ioctls.
> There should be a significant gain in having a config option.
> 
> Maybe some argue that there is a gain in security here. Perhaps.
> Or a gain in memory. It is negligible.
> I see mostly a loss.

It's probably the case that on millions (and growing) of Linux systems
out there, the one and only possible use of this syscall is as a
security threat. On these systems, with no need for libc4/5 binaries
(and no installed versions of these libraries anyway), there is **NO**
other redeeming use for this syscall.

If removal of this syscall isn't a config option, then the alternatives
are out-of-tree patches, forking 2.7 over this issue alone, or settling
for the status quo. A 3rd-party patch would increase vendor kernel
divergence again (which is also evil), and starting 2.7 just for this
would be overkill. And I'm not the only person who is not satisfied
with the current situation.

> There are more ancient system calls, like old_stat and oldolduname.
> Do we want separate options for each system call that is obsoleted?

A config option for each one would be a bit much, I'll agree. However,
I think having a single config option for the whole bunch would be a
good idea. At the time that I wrote this patch, I was thinking that the
rest of the old syscalls would be a second config option, but now that I
think about it, it makes more sense for it to just be one config option,
not two.

FWIW, my current patch does uselib() alone, because I figured that would
be less controversial than trying to do all of the old syscalls now.
Maybe I'll rethink that decision though.

Thank you for your feedback. It's quite helpful, and I greatly
appreciate it.

-Barry K. Nathan <barryn@pobox.com>
