Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261394AbULEVMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbULEVMr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 16:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbULEVMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 16:12:47 -0500
Received: from gprs215-105.eurotel.cz ([160.218.215.105]:27520 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261394AbULEVMo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 16:12:44 -0500
Date: Sun, 5 Dec 2004 22:12:31 +0100
From: Pavel Machek <pavel@suse.cz>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] Add support to resume swsusp from initrd
Message-ID: <20041205211230.GC1012@elf.ucw.cz>
References: <1102279686.9384.22.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102279686.9384.22.camel@tyrosine>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> These two patches do two things:
> 
> 1) The first removes __init declarations from swsusp code
> 2) The second allows for the resume device to be set from userspace (ie,
> without having to use name_to_dev_t) and also allows for resumes to be
> triggered from userspace.
> 
> A /sys/power/resume file is added. Doing
> 
> echo -n "set 03:02" >/sys/power/resume

I'd prefer not to have this one. Is it actually usefull? Then resume
could be triggered by echo -n "03:02" > /sys/power/resume...

> will set /dev/hda2 as the resume device. 
> 
> echo -n "resume 03:02" >/sys/power/resume
> 
> will attempt a resume from /dev/hda2. Patches are against
> 2.6.10-rc3.

Nice way to loose your data :-). [Note note note -- I'm not going to
merge it before my bigdiff goes to mainline, so expect to rediff it
when 2.6.10 is out. I can generate the big diff if you want to test it
now.]

You really need to make sure that userland processes are stopped
before swsusp-resume is started. You should do freeze_process(). Then
resume process depends on having enough memory available, so you
probably want to free_some_memory() and warn in documentation about
the fact.

Ugh, and you really should document "list of bad ideas with resume
from userspace". It is extremely easy to shoot yourself into the foot
with this one.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
