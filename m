Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbULEVaE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbULEVaE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 16:30:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbULEVaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 16:30:04 -0500
Received: from gprs215-105.eurotel.cz ([160.218.215.105]:29056 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261404AbULEV3y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 16:29:54 -0500
Date: Sun, 5 Dec 2004 22:29:40 +0100
From: Pavel Machek <pavel@suse.cz>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] Add support to resume swsusp from initrd
Message-ID: <20041205212940.GG1012@elf.ucw.cz>
References: <1102279686.9384.22.camel@tyrosine> <20041205211230.GC1012@elf.ucw.cz> <1102281698.9384.29.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102281698.9384.29.camel@tyrosine>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > echo -n "set 03:02" >/sys/power/resume
> > 
> > I'd prefer not to have this one. Is it actually usefull? Then resume
> > could be triggered by echo -n "03:02" > /sys/power/resume...
> 
> resume_device is set by swsusp_read, which requires name_to_dev_t to be
> working. At the point where that's called, the device driver hasn't been
> loaded and we don't have the information to get the dev_t. Once the
> driver has been loaded, name_to_dev_t has already been discarded (it's
> marked __init). So we need to set resume_device somehow.

What about move of resume_device setup somewhere sooner?

> Heh. Yes, that's no problem. A new bigdiff for -rc3 would be
> helpful.

Hmm, I'm still on 2.6.9, but this code did not change much. I'll
generate it.

> > You really need to make sure that userland processes are stopped
> > before swsusp-resume is started. You should do freeze_process(). Then
> > resume process depends on having enough memory available, so you
> > probably want to free_some_memory() and warn in documentation about
> > the fact.
> 
> Ok. I'll look into that. The main reason I want code like this is that
> Debian use modular IDE drivers that are stored in the initrd. The disks
> won't be touched until the root file system is mounted, and we'll
> trigger the resume before then, so there shouldn't be any risk of data
> loss. At this point, there shouldn't be any userspace running other than
> a single shell script - do you think it's still a problem?

Single shell script would probably do no harm, but then, you want this
to go into mainline, not into Debian kernel, right? ;-).

Actually freezing processes is good thing to do even for normal
resume. We pretty much know there are no harmfull processes running
there, but better safe than sorry.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
