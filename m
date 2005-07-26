Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262310AbVGZXQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262310AbVGZXQP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 19:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbVGZXNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 19:13:51 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:11744 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262310AbVGZXNA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 19:13:00 -0400
Date: Wed, 27 Jul 2005 01:12:49 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, Andreas Steinmetz <ast@domdv.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [swsusp] encrypt suspend data for easy wiping
Message-ID: <20050726231249.GB29638@elf.ucw.cz>
References: <20050703213519.GA6750@elf.ucw.cz> <20050706020251.2ba175cc.akpm@osdl.org> <42DA7B12.7030307@domdv.de> <20050725201036.2205cac3.akpm@osdl.org> <20050726220428.GA7425@waste.org> <20050726221446.GA24196@elf.ucw.cz> <20050726225808.GL12006@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050726225808.GL12006@waste.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Well, "how long are my keys going to stay in swap after
> > swsusp"... that's pretty scary.
> 
> Either they're likely in RAM _anyway_ and are thus already trivially
> accessible to the attacker (for things like dm_crypt or IPSEC or
> ssh-agent), or the application took care to zero them out, or the
> application has a security bug.
> 
> There are about 4 attack cases, in order of likelihood:
> 
> 1) An attacker steals your suspended laptop. He has access to all your
> suspended data. This patch gets us exactly nothing.

Wrong. Without this Andreas' patch, he'll get access to your
half-a-year-old GPG passphrases, too.

> 2) An attacker breaks into your machine remotely while you're using
> it. He has access to all your RAM, which if you're actually using it,
> very likely including the same IPSEC, dm_crypt, and ssh-agent keys as
> are saved on suspend. Further, he can trivially capture your
> keystrokes and thus capture any keys you use from that point forward.
> This patch gets us very close to nothing.
> 
> 3) An attacker steals your unsuspended laptop. He has access to all
> your RAM, which in all likelihood includes your IPSEC, dm_crypt, and
> ssh-agent keys. Odds are good that he invokes swsusp by closing the
> laptop. This patch gets us very close to nothing.
> 
> 4) You suspend your laptop between typing your GPG key password and
> hitting enter, thus leaving your password in memory when it would
> otherwise be cleared. Then you resume your laptop and hit enter, thus
> clearing the password from RAM but leaving it on the suspend
> partition. Then an attacker steals your machine (without re-suspending
> it!) and manages to recover the swsusp image which contains the

Why without resuspending it? Position of critical data in swap is
pretty much random. 

What I'm worried is: attacker steals your laptop after you were using
swsusp for half a year. Now your swap partition contains random pieces
of GPG keys you were using for last half a year. That's bad.

Current GPG keys can be found in RAM; unfortunately your swap
partition can contain current and old GPG keys that were never
supposed to be on disk. That's bad and I think we can agree on
that. Andreas's patch solves it; if it was not supposed to go on disk,
it will be erased after you resume. You can not do much better.

It is equivalent of clearing swsusp data from swap after resume, just
implemented somewhat clever... 
								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
