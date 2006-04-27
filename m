Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965060AbWD0UIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965060AbWD0UIo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 16:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030213AbWD0UIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 16:08:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11437 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965072AbWD0UIo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 16:08:44 -0400
Date: Thu, 27 Apr 2006 13:11:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: checklist (Re: 2.6.17-rc2-mm1)
Message-Id: <20060427131100.05970d65.akpm@osdl.org>
In-Reply-To: <20060427124452.432ad80d.rdunlap@xenotime.net>
References: <20060427014141.06b88072.akpm@osdl.org>
	<p73vesv727b.fsf@bragg.suse.de>
	<20060427121930.2c3591e0.akpm@osdl.org>
	<200604272126.30683.ak@suse.de>
	<20060427124452.432ad80d.rdunlap@xenotime.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rdunlap@xenotime.net> wrote:
>
> 
> > > So at this point in time what I'd like to do is to encourage developers to
> > > do these very basic things.  That's the low-hanging fruit right now.
> > 
> > Write a checklist for that?
> 
> I've been meaning to write up one myself, so I'll give it a shot.
> 
> This is all above and beyond good patch log descriptions.
> 
> 
> 1.  Build cleanly with applicable or modified CONFIG options =y, =m, and =n.
>     No gcc warnings/errors, no linker warnings/errors.
> 
> 2.  Build on multiple CPU arch-es by using local cross-compile tools
>     or something like PLM at OSDL.
> 
> 3.  Check cleanly with sparse.
> 
> 4.  Make sure that any new or modified CONFIG options don't muck up
>     the config menu.
> 
> 5.  Use 'make checkstack' and 'make namespacecheck' and fix any
>     problems that they find.  Note:  checkstack does not point out
>     problems explicitly, but any one function that uses more than
>     512 bytes on the stack is a candidate for change.
> 
> 6.  Include kernel-doc to document global kernel APIs.  (Not required
>     for static functions, but OK there also.)  Use 'make htmldocs'
>     or 'make mandocs' to check the kernel-doc and fix any issues.
> 

A lot of these are pretty hard and labor-intensive for people to set up and
run.  It would be nice, but from a global perspective it's not efficient
for every member of the kernel team to do all these things.  It's OK I
think if a few specialists run these tools against lots of people's patches
all at once.

Which is basically what we're doing now, although I suspect we could be
more rigorous about it.

I should be doing more of these things myself, but it's plenty enough work
getting though the "applies, doesn't-ridicule-coding-style,
compiles-without-warnings, boots-on-several-arches" steps.  It's good that
Adrian does some of the other steps.  I'm not aware of anyone who is doing
regular sparse and kernel-doc checking on -mm.

That all being said, these are all good things to have in a list.

To your list I'd add

- Passes allnoconfig, allmodconfig

- Has been tested with CONFIG_PREEMPT, CONFIG_DEBUG_SLAB,
  CONFIG_DEBUG_PAGEALLOC, CONFIG_DEBUG_MUTEXES, CONFIG_DEBUG_SPINLOCK,
  CONFIG_DEBUG_SPINLOCK_SLEEP all simultaneously enabled.

- Has been build- and runtime tested with and without CONFIG_SMP and
  CONFIG_PREEMPT.

- If it affects IO/Disk, etc: has been tested with and without CONFIG_LBD.

- ppc64 is a good architecture for cross-compilation checking because it
  tends to use `unsigned long' for 64-bit quantities.

- Has been carefully reviewed wrt relevant Kconfig combinations.  This is
  very hard to get right with testing - brainpower pays off here.

- Matches kernel coding style(!)

- All new Kconfig options have help text


