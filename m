Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268069AbUIUVDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268069AbUIUVDH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 17:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268048AbUIUVDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 17:03:07 -0400
Received: from gprs214-135.eurotel.cz ([160.218.214.135]:44933 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S268069AbUIUVCj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 17:02:39 -0400
Date: Tue, 21 Sep 2004 23:02:18 +0200
From: Pavel Machek <pavel@suse.cz>
To: Alex Williamson <alex.williamson@hp.com>
Cc: Andi Kleen <ak@suse.de>, acpi-devel <acpi-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: [ACPI] Re: [PATCH/RFC] exposing ACPI objects in sysfs
Message-ID: <20040921210218.GJ30425@elf.ucw.cz>
References: <1095716476.5360.61.camel@tdi> <20040921122428.GB2383@elf.ucw.cz> <1095785315.6307.6.camel@tdi> <20040921172625.GA30425@elf.ucw.cz> <20040921190606.GE18938@wotan.suse.de> <1095794035.24751.54.camel@tdi> <20040921191826.GF18938@wotan.suse.de> <1095795954.24751.74.camel@tdi> <20040921195802.GF30425@elf.ucw.cz> <1095799248.24751.103.camel@tdi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095799248.24751.103.camel@tdi>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > If I were you, I'd just replace read and write with ioctl, and leave
> > the rest of design as it was. If we find that someone who bypasses
> > your userspace library, at least we have a way to deal with it. (And
> > "cat a file and kill machine" issue is gone, too).
> 
>    Again, I don't think that solves the problem (and there's no ioctl
> support in sysfs).  The pointer in the command structure is easy to work
> around, nothing uses it and data could easily be stuffed after the
> architected entries.  Switching to an ioctl would not solve the problem
> of passing ACPI data back and forth.  We don't just want to execute

At least we would know we are passing ACPI data from ioctl() argument.

> methods, we want to be able to provide arguments and get data back.
> That data is where I see the biggest 32/64 bit issue.  I'll switch to an
> evaluate on write model, but I'm not sold that an ioctl would solve
> enough problems to be worth it.  Is anyone even open to adding ioctls to
> sysfs bin files?  Thanks,

I do not know what the right solution is. ioctl() is ugly, passing
structures using write() is ugly, too. I think adding ioctl() to sysfs
is less dangerous, because writes can not be translated using compat
layer. Both solutions are ugly and you'll get flamed for both :-(.

Andrew, can you help? We want to call AML methods from userspace, and
defining interface is not fun.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
