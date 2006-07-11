Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751047AbWGKLTB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbWGKLTB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 07:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbWGKLTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 07:19:01 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4523 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751044AbWGKLTA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 07:19:00 -0400
Date: Tue, 11 Jul 2006 13:18:34 +0200
From: Pavel Machek <pavel@suse.cz>
To: Brad Campbell <brad@wasp.net.au>
Cc: suspend2-devel@lists.suspend2.net, lkml <linux-kernel@vger.kernel.org>
Subject: Re: /dev/rtc not suspending/resuming properly
Message-ID: <20060711111834.GB1670@elf.ucw.cz>
References: <44B24CEB.9010103@wasp.net.au> <20060710223629.GA7443@elf.ucw.cz> <44B359F7.3050500@wasp.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44B359F7.3050500@wasp.net.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2006-07-11 11:57:43, Brad Campbell wrote:
> Pavel Machek wrote:
> 
> >>I've had a pretty good look at drivers/char/rtc.c and I can't see 
> >>anywhere it would actually suspend/resume in the code, and investigation 
> >>shows it does not appear to re-init the hardware on resume.
> >
> >Well, you probably need to write suspend/resume support for it...
> 
> So it would seem..
> 
> I know absolutely nothing about the driver model (let alone C or kernel 
> voodo in general) and have been investigating Documentation/driver-model. 
> Would I be close if I were to suggest this needs to be a platform_driver? 
> I'll certainly have a crack at it if I'm on the right track.
> 
> I've been having a look at some of the other drivers that use 
> platform_driver however I'm a bit stumped at how I go about iterating 
> through the various sparc buses using the platform_driver resource 
> allocation functions.
> 
> #ifdef __sparc__
>         struct linux_ebus *ebus;
>         struct linux_ebus_device *edev;
> #ifdef __sparc_v9__
>         struct sparc_isa_bridge *isa_br;
>         struct sparc_isa_device *isa_dev;
> #endif
> #endif

So you are working on sparc?

> Or, do I just dodgy it up as the rtc is a legacy device, and leave the 
> probe/allocation code alone and just add the pm stuff?

I'd do that first, to get it working...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
