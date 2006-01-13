Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161400AbWAMGXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161400AbWAMGXc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 01:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbWAMGXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 01:23:32 -0500
Received: from canuck.infradead.org ([205.233.218.70]:63178 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1751505AbWAMGXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 01:23:32 -0500
Subject: Re: [PATCH] [5/6] Handle TIF_RESTORE_SIGMASK for i386
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, drepper@redhat.com,
       dhowells@redhat.com
In-Reply-To: <20060112221037.5dbc3dd9.akpm@osdl.org>
References: <1136923488.3435.78.camel@localhost.localdomain>
	 <1136924357.3435.107.camel@localhost.localdomain>
	 <20060112195950.60188acf.akpm@osdl.org>
	 <1137126606.3085.44.camel@localhost.localdomain>
	 <20060112205451.392c0c5c.akpm@osdl.org>
	 <20060112221037.5dbc3dd9.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 13 Jan 2006 06:23:28 +0000
Message-Id: <1137133408.3621.6.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-12 at 22:10 -0800, Andrew Morton wrote:
> rt_sigprocmask(SIG_BLOCK, [CHLD], [CHLD], 8) = 0
> rt_sigsuspend(~[HUP CHLD RTMIN RT_1])   = -1 EINVAL (Invalid argument)

OK, that makes it easier to track down -- thanks. Unfortunately my
scratch i386 box in the office hasn't rebooted onto my test kernel so
it'll have to wait until (a sensible hour in) the morning.

I suspect it might be the sigset size. We have a whole bunch of 

	/* XXX: Don't preclude handling different sized sigset_t's.  */
	if (sigsetsize != sizeof(sigset_t))
		return -EINVAL;

-- 
dwmw2

