Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbVBRLY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbVBRLY2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 06:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261337AbVBRLY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 06:24:28 -0500
Received: from gprs214-36.eurotel.cz ([160.218.214.36]:57307 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261336AbVBRLYY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 06:24:24 -0500
Date: Fri, 18 Feb 2005 12:24:09 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Bernard Blackham <bernard@blackham.com.au>
Cc: dtor_core@ameritech.net, John M Flinchbaugh <john@hjsoft.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Swsusp, resume and kernel versions
Message-ID: <20050218112409.GB1341@elf.ucw.cz>
References: <200502162346.26143.dtor_core@ameritech.net> <20050217110731.GE1353@elf.ucw.cz> <20050217162847.GA32488@butterfly.hjsoft.com> <d120d5000502170930ccc3e9e@mail.gmail.com> <20050217195651.GB5963@openzaurus.ucw.cz> <20050218020220.GD30342@blackham.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050218020220.GD30342@blackham.com.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Just remember you're doing the mkswap if you decide to rearrange your
> > > > partitions at all, or code a script smart enough to grep your swap
> > > > partitions out of your fstab.
> > > 
> > > It could be a workaround. Still it will cause loss of unsaved work if
> > > I happen to load wrong kernel. Given that the code checking for swsusp
> > > image can be marked __init I don't understand the reasons gainst doing
> > > it.
> > 
> > How do you know which partitions to check? swsusp gets it from resume= parameter,
> > but if you do not have it compiled, you probably have wrong cmdline, too.
> 
> In many cases, you might have added the resume= line to every kernel
> that's booted (eg, LILO's global append= parameter, or Debian GRUB's
> magic kopts gear). Alternately (or additionally), you could examine
> the signature when sys_swapon is called on a swap partition (though
> the code couldn't be __init then).
> 
> These together I want to claim would catch many of these cases, and
> any effort to avoid severe filesystem corruption is a good thing.

Messing up the kernel to avoid fs corruption in some cases is bad
idea.

If you want to be 100% safe, add support to LILO/GRUB: just do not
allow selecting wrong kernel if last action was suspend. Bootloader
knows, it seen the command lines.

Or simply use Stefan's userland code.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
