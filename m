Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423908AbWKABTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423908AbWKABTI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 20:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423911AbWKABTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 20:19:08 -0500
Received: from ozlabs.org ([203.10.76.45]:35015 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1423908AbWKABTH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 20:19:07 -0500
Subject: Re: [patch 1/1] schedule removal of FUTEX_FD
From: Rusty Russell <rusty@rustcorp.com.au>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, drepper@redhat.com, mingo@elte.hu,
       tglx@linutronix.de
In-Reply-To: <200610312309.k9VN9mco015260@shell0.pdx.osdl.net>
References: <200610312309.k9VN9mco015260@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Wed, 01 Nov 2006 12:19:05 +1100
Message-Id: <1162343945.14769.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-31 at 15:09 -0800, akpm@osdl.org wrote:
> From: Andrew Morton <akpm@osdl.org>
> 
> Apparently FUTEX_FD is unfixably racy and nothing uses it (or if it does, it
> shouldn't).
> 
> Add a warning printk, give any remaining users six months to migrate off it.

This makes sense.  FUTEX_FD was for the NGPT project which did userspace
threading, and hence couldn't block.  It was always kind of a hack
(although unfixably racy isn't quite right, it depends on usage).

However, the existence of FUTEX_FD is what made Ingo complain that we
couldn't simply pin the futex page in memory, because now a process
could pin one page per fd.  Removing it would seem to indicate that we
can return to a much simpler scheme of (1) pinning a page when someone
does futex_wait, and (2) simply comparing futexes by physical address.

Now, I realize with some dismay that simplicity is no longer a futex
feature, but it might be worth considering?

Cheers,
Rusty.
PS.  I used to have a patch for "ratelim_printk()" which hashed on the
format string to reduce the chance that one message limit would clobber
other messages.  I'll dig it out...

