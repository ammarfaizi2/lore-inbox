Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261810AbVG0Hi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261810AbVG0Hi5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 03:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbVG0Hi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 03:38:57 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:28339 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261810AbVG0Hi4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 03:38:56 -0400
Date: Wed, 27 Jul 2005 09:38:19 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, Andreas Steinmetz <ast@domdv.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [swsusp] encrypt suspend data for easy wiping
Message-ID: <20050727073819.GB4115@elf.ucw.cz>
References: <20050703213519.GA6750@elf.ucw.cz> <20050706020251.2ba175cc.akpm@osdl.org> <42DA7B12.7030307@domdv.de> <20050725201036.2205cac3.akpm@osdl.org> <20050726220428.GA7425@waste.org> <20050726221446.GA24196@elf.ucw.cz> <20050726225808.GL12006@waste.org> <20050726231249.GB29638@elf.ucw.cz> <20050726235314.GM12006@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050726235314.GM12006@waste.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > 2) An attacker breaks into your machine remotely while you're using
> > > it. He has access to all your RAM, which if you're actually using it,
> > > very likely including the same IPSEC, dm_crypt, and ssh-agent keys as
> > > are saved on suspend. Further, he can trivially capture your
> > > keystrokes and thus capture any keys you use from that point forward.
> > > This patch gets us very close to nothing.
> > > 
> > > 3) An attacker steals your unsuspended laptop. He has access to all
> > > your RAM, which in all likelihood includes your IPSEC, dm_crypt, and
> > > ssh-agent keys. Odds are good that he invokes swsusp by closing the
> > > laptop. This patch gets us very close to nothing.
> > > 
> > > 4) You suspend your laptop between typing your GPG key password and
> > > hitting enter, thus leaving your password in memory when it would
> > > otherwise be cleared. Then you resume your laptop and hit enter, thus
> > > clearing the password from RAM but leaving it on the suspend
> > > partition. Then an attacker steals your machine (without re-suspending
> > > it!) and manages to recover the swsusp image which contains the
> > 
> > Why without resuspending it? Position of critical data in swap is
> > pretty much random. 
> 
> Typical swap partition sizes are about the same as RAM sizes. So the
> odds of any given thing in a previous suspend getting overwritten by
> the next one are high.

Well, if you suspend with 100MB of RAM used, then keep suspending half
a year with only 50MB of RAM used, you'll have that half-year-old data
in there.

> > What I'm worried is: attacker steals your laptop after you were using
> > swsusp for half a year. Now your swap partition contains random pieces
> > of GPG keys you were using for last half a year. That's bad.
> 
> And it's incredibly unlikely. Suspending while a supposedly
> short-lived key is in RAM should be rare. Surviving on disk after half
> a year of swapping and suspending should be negligible probability.

Disagreed.

> It's not worth even thinking about when we have real suspended laptops
> getting stolen every day in REAL LIFE. Anyone who cares about your
> highly contrived case also cares about 1000 times more about the real
> life case of the stolen laptop. Otherwise they're fooling themselves.
> 
> This code is bad. It attacks a very rare problem, gives its users (and
> apparently its authors) a false sense of security, reimplements
> dm_crypt functionality apparently without much attention to the
> subtleties of block device encryption and without serious review, and
> it stands in the way of doing things right.

Think about current code as really quick disk wiping method. Now, if
you feel that we are giving false sense of security... we should
not. Perhaps option should be renamed to CONFIG_SWSUSP_WIPE. Patches
would certainly be accepted and I believe Andreas is going to cook
some when he gets back online :-). I'd like to keep it there, because
it enables us to do it properly in future. Contrary to what you think,
I believe this is going to be part of a solution.
								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
