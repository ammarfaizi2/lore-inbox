Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261399AbULEVmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbULEVmV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 16:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261403AbULEVmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 16:42:21 -0500
Received: from cavan.codon.org.uk ([213.162.118.85]:26313 "EHLO
	cavan.codon.org.uk") by vger.kernel.org with ESMTP id S261399AbULEVmP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 16:42:15 -0500
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041205212940.GG1012@elf.ucw.cz>
References: <1102279686.9384.22.camel@tyrosine>
	 <20041205211230.GC1012@elf.ucw.cz> <1102281698.9384.29.camel@tyrosine>
	 <20041205212940.GG1012@elf.ucw.cz>
Date: Sun, 05 Dec 2004 21:42:08 +0000
Message-Id: <1102282928.9384.35.camel@tyrosine>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-SA-Exim-Connect-IP: 213.162.118.93
X-SA-Exim-Mail-From: mjg59@srcf.ucam.org
Subject: Re: [PATCH/RFC] Add support to resume swsusp from initrd
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on cavan.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-12-05 at 22:29 +0100, Pavel Machek wrote:

> > resume_device is set by swsusp_read, which requires name_to_dev_t to be
> > working. At the point where that's called, the device driver hasn't been
> > loaded and we don't have the information to get the dev_t. Once the
> > driver has been loaded, name_to_dev_t has already been discarded (it's
> > marked __init). So we need to set resume_device somehow.
> 
> What about move of resume_device setup somewhere sooner?

Ah - we could always set resume_device, even if there's nothing to
resume. That way, it'd be set correctly for userspace later on. Ok, I
think I can make that work.

> > Heh. Yes, that's no problem. A new bigdiff for -rc3 would be
> > helpful.
> 
> Hmm, I'm still on 2.6.9, but this code did not change much. I'll
> generate it.

Thanks!

> > Ok. I'll look into that. The main reason I want code like this is that
> > Debian use modular IDE drivers that are stored in the initrd. The disks
> > won't be touched until the root file system is mounted, and we'll
> > trigger the resume before then, so there shouldn't be any risk of data
> > loss. At this point, there shouldn't be any userspace running other than
> > a single shell script - do you think it's still a problem?
> 
> Single shell script would probably do no harm, but then, you want this
> to go into mainline, not into Debian kernel, right? ;-).

Heh.

> Actually freezing processes is good thing to do even for normal
> resume. We pretty much know there are no harmfull processes running
> there, but better safe than sorry.

Ok, I'll deal with that once I've got the post 2.6.10 code to work with.

Thanks!
-- 
Matthew Garrett | mjg59@srcf.ucam.org

