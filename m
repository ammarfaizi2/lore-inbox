Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbVLCQ17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbVLCQ17 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 11:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbVLCQ17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 11:27:59 -0500
Received: from mail.gmx.de ([213.165.64.20]:5521 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932068AbVLCQ16 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 11:27:58 -0500
X-Authenticated: #428038
Date: Sat, 3 Dec 2005 17:27:55 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051203162755.GA31405@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20051203135608.GJ31395@stusta.de> <1133620598.22170.14.camel@laptopd505.fenrus.org> <20051203152339.GK31395@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051203152339.GK31395@stusta.de>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 03 Dec 2005, Adrian Bunk wrote:

> Things will change as time passes by, but then there's the possibility 
> to open the next branch and bring the older branch into a security-fixes 
> only mode.
> 
> > If the current model doesn't work as you claim it doesn't, then maybe
> > the model needs finetuning. Right now the biggest pain is the userland
> > ABI changes that need new packages; sometimes (often) for no real hard
> > reason. Maybe we should just stop doing those bits, they're not in any
> > fundamental way blocking general progress (sure there's some code bloat
> > due to it, but I guess we'll just have to live with that).
> 
> IOW, we should e.g. ensure that today's udev will still work flawlessly 
> with kernel 2.6.30 (sic)?

Exactly that, and kernel interfaces going away just to annoy binary
module providers also hurts third-party OSS modules, such as
Fujitsu-Siemens's ServerView agents.

I found myself chasing some genuine bugs in that code to please GCC 4
(which doesn't tolerate extern blah declarations before static blah
definitions), and some idiotic breakage when inter_module_get was
dropped somewhen between 2.6.8 (where the modules compiled just fine)
and 2.6.13 (where they didn't as functions had been removed).  And
there's no point arguing about deprecation warnings being around,
interfaces can be removed between 2.6 and 2.8 but not between
2.6.foo.bar and 2.6.foo.baz. Why not use

#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,8,0)

or similar to automatically disable such interfaces at the given
version?

> This could work, but it should be officially announced that e.g. a 
> userspace running kernel 2.6.15 must work flawlessly with _any_ future 
> 2.6 kernel.

Right. This effectively means to call the beast 2.8.0 if you feel you
must break the applications.

> For how many years do you think we will be able to ensure that this will 
> stay true?

Well, the current model, since it has been in effect, is just "let's
break the interfaces at will, but let's not hint anyone, so let's always
just bump the patchlevel no matter how intrusive the change is", and the
bandaid 2.6.M.N releases cannot cover the fact that the M -> M+1
transition causes breakage.

Effectively, 2.6.X behaves like a bleeding edge development ("everything
changes") kernel such as 2.3 or 2.5; it isn't stable because some code
monkeys claim it is. You cannot declare the can of pea soup in front of
you "open" either.

Linux is in fact light years away from being "stable", and while it was
relatively easy to move forward between 2.4.X releases and even 2.4.X
and some early 2.6.X release, moving between 2.6.X and 2.6.Y means
switching user-space, too, and chances are the new user-space doesn't
work with the old kernel.

--
Matthias Andree
