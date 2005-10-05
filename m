Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932576AbVJEIey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932576AbVJEIey (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 04:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932577AbVJEIey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 04:34:54 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:55241 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932576AbVJEIex (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 04:34:53 -0400
Date: Wed, 5 Oct 2005 10:33:41 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [swsusp] separate snapshot functionality to separate file
Message-ID: <20051005083341.GA22034@elf.ucw.cz>
References: <20051002231332.GA2769@elf.ucw.cz> <200510050047.45697.rjw@sisk.pl> <20051005000658.GJ18481@elf.ucw.cz> <200510051020.15400.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510051020.15400.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> OK, but if we decide to move some functions from one file to another,
> we'll have to wait for another "settle down" period, I think.

Yes...

> > > Well, aren't there any problems with handling kernel addresses from the user
> > > space and vice versa?
> > 
> > Nothing we could not handle. Kernel needs to use get_user, while
> > userspace needs to seek/read/write on /dev/kmem (when accessing "the
> > other" addresses).
> 
> Shouldn't we avoid using /dev/kmem?  Especially that some people wanted it
> to go already.

Well, I believe it is okay for suspend.

> > > Anyway, I think on resume we should send data from the user space to the
> > > kernel and let the kernel arrange them in memory instead of placing them in
> > > memory directly from the used space.  By symmetry, on suspend we should send
> > > data from the kernel to the user space instead of allowing the users space
> > > to read memory at will.  IMO the arrangement of the data in memory should
> > > not be visible to the user space at all.
> > 
> > I thought about that -- user/kernel interface would certainly be nicer
> > -- but I do not think it is feasible without writing a lot of code. 
> 
> I thought of two in-kernel subsystems with a well defined interface
> between them first, such that one of them could be replaced with a
> user space implementation (partially or as a whole) in the future.
> 
> I think I can come up with a proof-of-concept patch if that helps.

Yes, it would help. (But notice that I have proof-of-concenpt ready in
sw3 tree :-).

> > [I agree that assymetry I have in there is ugly, but I don't see a way
> > to do alloc_pagedir() in userspace, and I'd like to keep page
> > relocation in userspace.]
> 
> I'd think the page relocation is easier in the kernel, as we have access to
> zones and we can use swsusp_free() to clean things up if something goes
> wrong (of course that's after some changes).

It is quite a lot of ugly code, and being in kernel does not really
help. swsusp_free() will need to be exported, but we need it for
normal (non-error) code path, too, so that should not be big problem.

								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
