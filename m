Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262597AbVBYCMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262597AbVBYCMd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 21:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbVBYCMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 21:12:33 -0500
Received: from fire.osdl.org ([65.172.181.4]:61648 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262597AbVBYCMT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 21:12:19 -0500
Date: Thu, 24 Feb 2005 18:12:09 -0800
From: Chris Wright <chrisw@osdl.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Roland McGrath <roland@redhat.com>, Chris Wright <chrisw@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] override RLIMIT_SIGPENDING for non-RT signals
Message-ID: <20050225021209.GU15867@shell0.pdx.osdl.net>
References: <200502240145.j1O1jlab010606@magilla.sf.frob.com> <421E8708.9090802@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <421E8708.9090802@goop.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jeremy Fitzhardinge (jeremy@goop.org) wrote:
> Roland McGrath wrote:
> 
> >Indeed, I think your patch does not go far enough.  I can read POSIX to say
> >that the siginfo_t data must be available when `kill' was used, as well.
> >This patch makes it allocate the siginfo_t, even when that exceeds
> >{RLIMIT_SIGPENDING}, for any non-RT signal (< SIGRTMIN) not sent by
> >sigqueue (actually, any signal that couldn't have been faked by a sigqueue
> >call).
> >
> Looks OK to me.  I'll give this a try soon.

Yeah, it fixes the issue, but opens the door to larger consumption of
pending signals.  Roland, what was your final preference?  I'm kind of
leaning towards Jeremy's original patch.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
