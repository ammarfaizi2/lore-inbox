Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262174AbVHCJXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbVHCJXY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 05:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262173AbVHCJXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 05:23:24 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:18576 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262174AbVHCJXX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 05:23:23 -0400
Date: Wed, 3 Aug 2005 11:23:01 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Dave Jones <davej@redhat.com>, "Brown, Len" <len.brown@intel.com>,
       Linus Torvalds <torvalds@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       linux-kernel@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>,
       Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Ritz <daniel.ritz@gmx.ch>
Subject: Re: revert yenta free_irq on suspend
Message-ID: <20050803092301.GA1352@elf.ucw.cz>
References: <F7DC2337C7631D4386A2DF6E8FB22B3004311E37@hdsmsx401.amr.corp.intel.com> <20050731222751.GA28907@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050731222751.GA28907@redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  > But that believe would be total fantasy -- supsend/resume is not
>  > working on a large number of machines, and no distro is currently
>  > able to support it.  (I'm talking about S3 suspend to RAM primarily,
>  > suspend to disk is less interesting -- though Red Hat doesn't
>  > even support _that_)
> 
> After the 'swsusp works just fine' lovefest at OLS, I spent a little
> while playing with the current in-tree swsusp implementation last week.
> 
> The outcome: I'm no more enthusiastic about enabling this in Red Hat
> kernels than I ever was before.  It seems to have real issues with LVM
> setups (which is default on Red Hat/Fedora installs these days).
> After convincing it where to suspend/resume from by feeding it
> the major/minor of my swap partition, it did actually seem
> to suspend. And resume (though it did spew lots of 'sleeping whilst
> atomic warnings, but thats trivial compared to whats coming up
> next).

I do not know much about LVM. How exactly did you resume= command line
look like? You were not resuming from initrd, right?

You did not boot *anything* between suspend and resume, right?

> I rebooted, and fsck found all sorts of damage on my / partition.
> After spending 30 minutes pressing 'y', to fix things up, it failed
> to boot after lots of files were missing.
> Why it wrote anything to completely different lv to where I told it
> (and yes, I did get the major:minor right) I have no idea, but
> as it stands, it definitly isn't production-ready.

Could you try to suspend on plain old swap-partition, first, to verify
that your drivers cooperate?
								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
