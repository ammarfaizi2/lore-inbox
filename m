Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbVALCbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbVALCbH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 21:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbVALCbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 21:31:07 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:41992 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261352AbVALCa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 21:30:56 -0500
Date: Wed, 12 Jan 2005 03:30:47 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Andries Brouwer <aebr@win.tue.nl>, Linus Torvalds <torvalds@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Lukasz Trabinski <lukasz@wsisiz.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make uselib configurable (was Re: uselib()  & 2.6.X?)
Message-ID: <20050112023047.GI29578@stusta.de>
References: <Pine.LNX.4.58LT.0501071648160.30645@oceanic.wsisiz.edu.pl> <20050107170712.GK29176@logos.cnet> <1105136446.7628.11.camel@localhost.localdomain> <Pine.LNX.4.58.0501071609540.2386@ppc970.osdl.org> <20050107221255.GA8749@logos.cnet> <Pine.LNX.4.58.0501081042040.2386@ppc970.osdl.org> <20050111225127.GD4378@ip68-4-98-123.oc.oc.cox.net> <20050111235907.GG2760@pclin040.win.tue.nl> <20050112021246.GE4325@ip68-4-98-123.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050112021246.GE4325@ip68-4-98-123.oc.oc.cox.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 06:12:46PM -0800, Barry K. Nathan wrote:
>...
> > People always claim that Linux is good in preserving binary compatibility.
> > Don't know how true that was, but introducing such config options doesnt
> > help.
> 
> Binary compatibility is good to have, but it isn't everything in life.
> *Optionally* breaking compatibility with certain types of old binaries
> doesn't seem so bad to me. People who want binary compatibility can have
> it, and people who don't need it can choose to not install the old code
> on their systems.
> 
> > Let me also mutter about something else.
> > In principle configuration options are evil. Nobody wants fifty thousand
> > configuration options. But I see them multiply like ioctls.
> > There should be a significant gain in having a config option.
> > 
> > Maybe some argue that there is a gain in security here. Perhaps.
> > Or a gain in memory. It is negligible.
> > I see mostly a loss.
> 
> It's probably the case that on millions (and growing) of Linux systems
> out there, the one and only possible use of this syscall is as a
> security threat. On these systems, with no need for libc4/5 binaries
> (and no installed versions of these libraries anyway), there is **NO**
> other redeeming use for this syscall.
> 
> If removal of this syscall isn't a config option, then the alternatives
> are out-of-tree patches, forking 2.7 over this issue alone, or settling
> for the status quo. A 3rd-party patch would increase vendor kernel
> divergence again (which is also evil), and starting 2.7 just for this
> would be overkill. And I'm not the only person who is not satisfied
> with the current situation.

uselib() is only one of the zillion places in the Linux kernel where 
security vulnerabilities can occur. OK, now one was found there, but
is this enough for changing the status quo if the zillion other places
with possible vulnerabilities are still present and will stay?
If a vendor chooses to diverge from the ftp.kernel.org kernel in this
point, I don't see why this should cause any "evil" problems.

> > There are more ancient system calls, like old_stat and oldolduname.
> > Do we want separate options for each system call that is obsoleted?
>
> A config option for each one would be a bit much, I'll agree. However,
> I think having a single config option for the whole bunch would be a
> good idea. At the time that I wrote this patch, I was thinking that the
> rest of the old syscalls would be a second config option, but now that I
> think about it, it makes more sense for it to just be one config option,
> not two.
> 
> FWIW, my current patch does uselib() alone, because I figured that would
> be less controversial than trying to do all of the old syscalls now.
> Maybe I'll rethink that decision though.
>...

A patch for one config option for all pre-libc6 system calls might be 
interesting if it allows to disable a serious amount of system calls and 
is well-tested to not break any libc6, libc5 or libc4 binaries.

> -Barry K. Nathan <barryn@pobox.com>

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

