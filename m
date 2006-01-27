Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422678AbWA0XWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422678AbWA0XWT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 18:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422679AbWA0XWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 18:22:19 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:35283 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1422678AbWA0XWS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 18:22:18 -0500
Date: Sat, 28 Jan 2006 00:22:07 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Luca <kronos@kronoz.cjb.net>, mjg59@srcf.ucam.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Suspend to RAM: help with whitelist wanted
Message-ID: <20060127232207.GB1617@elf.ucw.cz>
References: <20060126213611.GA1668@elf.ucw.cz> <20060127170406.GA6164@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060127170406.GA6164@dreamland.darkstar.lan>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > On www.sf.net/projects/suspend , there's s2ram.c program for
> > suspending machines. It contains whitelist of known machines, along
> > with methods to get their video working (similar to
> > Doc*/power/video.txt). Unfortunately, video.txt does not allow me to
> > fill in whitelist automatically, so I need your help.
> > 
> > I do not yet have solution for machines that need vbetool; fortunately
> > my machines do not need that :-), and it is pretty complex (includes
> > x86 emulator).
> 
> What about adding something like:
> 
> void s2ram_restore(void) {
>         if (needed)
>                 fork_and_exec(vbetool);
> }
> 
> machine_table could set a global flag or something. It would be
> possibile to us an array to carry the informations about what need to be
> done on restore, i.e. something like:

I can imagine fork_and_exec... Disadvantages are:

* if disk driver is toast, user does not see anything

* vbetool can be missing from the system, or wrong version, or
something like that.

Other solution is to just integrate vbetool into s2ram. Advantages
are:

* s2ram is nicely integrated.

Disadvantages are:

* code duplication.

If vbetool's primary purpose is to fix video after suspend/resume,
then perhaps right thing to do is to integrate it into s2ram and
maintain it there.

Matthew, what do you think?

Luca, would you cook quick&hacky fork-and-exec patch? I do not have
machine that needs vbetool...
							Pavel
-- 
Thanks, Sharp!
