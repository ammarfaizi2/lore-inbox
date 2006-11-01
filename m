Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945971AbWKABXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945971AbWKABXs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 20:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946260AbWKABXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 20:23:48 -0500
Received: from smtp.osdl.org ([65.172.181.4]:61150 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1945971AbWKABXq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 20:23:46 -0500
Date: Tue, 31 Oct 2006 17:23:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, drepper@redhat.com, mingo@elte.hu,
       tglx@linutronix.de
Subject: Re: [patch 1/1] schedule removal of FUTEX_FD
Message-Id: <20061031172312.79748be5.akpm@osdl.org>
In-Reply-To: <1162343945.14769.16.camel@localhost.localdomain>
References: <200610312309.k9VN9mco015260@shell0.pdx.osdl.net>
	<1162343945.14769.16.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Nov 2006 12:19:05 +1100
Rusty Russell <rusty@rustcorp.com.au> wrote:

> On Tue, 2006-10-31 at 15:09 -0800, akpm@osdl.org wrote:
> > From: Andrew Morton <akpm@osdl.org>
> > 
> > Apparently FUTEX_FD is unfixably racy and nothing uses it (or if it does, it
> > shouldn't).
> > 
> > Add a warning printk, give any remaining users six months to migrate off it.
> 
> This makes sense.  FUTEX_FD was for the NGPT project which did userspace
> threading, and hence couldn't block.  It was always kind of a hack
> (although unfixably racy isn't quite right, it depends on usage).
> 
> However, the existence of FUTEX_FD is what made Ingo complain that we
> couldn't simply pin the futex page in memory, because now a process
> could pin one page per fd.  Removing it would seem to indicate that we
> can return to a much simpler scheme of (1) pinning a page when someone
> does futex_wait, and (2) simply comparing futexes by physical address.
> 
> Now, I realize with some dismay that simplicity is no longer a futex
> feature, but it might be worth considering?

Sure.  Perhaps we could accelerate the removal schedule if we want to do
this.  Let's see how many 2.6.19 users squeak first.

> Cheers,
> Rusty.
> PS.  I used to have a patch for "ratelim_printk()" which hashed on the
> format string to reduce the chance that one message limit would clobber
> other messages.  I'll dig it out...

I think the caller-provided-state thing will work OK?
