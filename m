Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932631AbVKXRqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932631AbVKXRqb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 12:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbVKXRqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 12:46:31 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:15370 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932432AbVKXRqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 12:46:30 -0500
Date: Thu, 24 Nov 2005 17:46:22 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Matt Mackall <mpm@selenic.com>
Cc: Hugh Dickins <hugh@veritas.com>, akpm@osdl.org, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org
Subject: Re: + shut-up-warnings-in-ipc-shmc.patch added to -mm tree
Message-ID: <20051124174622.GC18971@flint.arm.linux.org.uk>
Mail-Followup-To: Matt Mackall <mpm@selenic.com>,
	Hugh Dickins <hugh@veritas.com>, akpm@osdl.org,
	manfred@colorfullife.com, linux-kernel@vger.kernel.org
References: <200511230413.jAN4DboR013036@shell0.pdx.osdl.net> <Pine.LNX.4.61.0511241235450.3504@goblin.wat.veritas.com> <20051124160012.GQ31287@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051124160012.GQ31287@waste.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2005 at 08:00:12AM -0800, Matt Mackall wrote:
> Unfortunately Russell didn't tell us which function caused the error
> and I can't seem to find a tree that matches his line numbering.
> But it looks like it's shm_unlock.

To make it completely clear, a lot of my "fix warning" patches are
derived from the ARM Linux kernel autobuilder, which can be found
at http://armlinux.simtec.co.uk/kautobuild/

and I only really look at the latest builds on there.

> The current ({0;}) seems wrong to me. I'd expect that expression to be
> void. Hmm, looks like I'm wrong. It's quite ugly, not to mention confusing.

It seems that ({0;}) is used when something is expected to return zero.
However, if it is used in a void context, gcc 4 generates an annoying
warning.

> mm.h:
> #define shm_lock(a, b) empty_int()
> 
> The typechecking is nice in theory, but in practice I don't think it
> really makes a difference for stubbing things out.

Depends if you end up with "blah is unused" warnings instead.  It's
all round _far_ safer to use the inline function method from that
point of view.

Not that I particularly care, I just wanted to squash some of the
rediculous number of warnings in the kernel and decided to hit the
easy ones.  However, they're turning out to be real pigs instead. 8(

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
