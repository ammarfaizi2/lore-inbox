Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261754AbVBXCc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbVBXCc4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 21:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbVBXCc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 21:32:56 -0500
Received: from fire.osdl.org ([65.172.181.4]:10655 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261754AbVBXCcy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 21:32:54 -0500
Date: Wed, 23 Feb 2005 18:32:45 -0800
From: Chris Wright <chrisw@osdl.org>
To: Roland McGrath <roland@redhat.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] override RLIMIT_SIGPENDING for non-RT signals
Message-ID: <20050224023245.GA28536@shell0.pdx.osdl.net>
References: <421D1548.2080504@goop.org> <200502240145.j1O1jlab010606@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502240145.j1O1jlab010606@magilla.sf.frob.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Roland McGrath (roland@redhat.com) wrote:
> Indeed, I think your patch does not go far enough.  I can read POSIX to say
> that the siginfo_t data must be available when `kill' was used, as well.

How?  I only see reference to filling in SI_USER for rt signals?
Just curious...(I've only got SuSv3 and some crusty old POSIX rt docs).

> This patch makes it allocate the siginfo_t, even when that exceeds
> {RLIMIT_SIGPENDING}, for any non-RT signal (< SIGRTMIN) not sent by
> sigqueue (actually, any signal that couldn't have been faked by a sigqueue
> call).  Of course, in an extreme memory shortage situation, you are SOL and
> violate POSIX a little before you die horribly from being out of memory anyway.

> The LEGACY_QUEUE logic already ensures that, for non-RT signals, at most
> one is ever on the queue.  So there really is no risk at all of unbounded
> resource consumption; the usage can reach {RLIMIT_SIGPENDING} + 31, is all.

Good point.  Although it's RLIMIT_SIGPENDING + (31 * user_nprocs).  So
that could be 31 * 8k, for example.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
