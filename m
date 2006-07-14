Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030334AbWGNGbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030334AbWGNGbL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 02:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030222AbWGNGbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 02:31:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56034 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030334AbWGNGbJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 02:31:09 -0400
Date: Thu, 13 Jul 2006 23:27:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: andrea@cpushare.com
Cc: bruce@andrew.cmu.edu, alan@lxorguk.ukuu.org.uk, arjan@infradead.org,
       bunk@stusta.de, rlrevell@joe-job.com, linux-kernel@vger.kernel.org,
       alan@redhat.com, torvalds@osdl.org, mingo@elte.hu
Subject: Re: [PATCH] TIF_NOTSC and SECCOMP prctl
Message-Id: <20060713232727.ead103f8.akpm@osdl.org>
In-Reply-To: <20060714060932.GE18774@opteron.random>
References: <20060711141709.GE7192@opteron.random>
	<1152628374.3128.66.camel@laptopd505.fenrus.org>
	<20060711153117.GJ7192@opteron.random>
	<1152635055.18028.32.camel@localhost.localdomain>
	<p73wtain80h.fsf@verdi.suse.de>
	<20060712210732.GA10182@elte.hu>
	<20060712185103.f41b51d2.akpm@osdl.org>
	<44B5F9E6.8070501@andrew.cmu.edu>
	<20060713083441.GD28310@opteron.random>
	<20060713021818.b0c0093e.akpm@osdl.org>
	<20060714060932.GE18774@opteron.random>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2006 08:09:32 +0200
andrea@cpushare.com wrote:

> The only thing left worth discussing is why if I set TIF_NOTSC to 10
> instead of 19 the kernel was crashing hard... After I checked and
> rechecked everything else I deduced it had to be that number and after
> changing it to 19 everything works fine... I also verified the first
> rdtsc kills the task with a sigsegv. It would be nice to make sure
> it's not a bug in the below patch that 10 didn't work but just some
> hidden kernel "feature" ;).

Using a bit <= 15 will cause kernel to take the work_notifysig path
"pending work-to-be-done flags are in LSW".  I'm not sure what happens if
there's such a flag set but nothing is set up to handle it.  I guess it
stays set and processes never get out of the kernel again.

Perhaps TIF_SECCOMP should be >= 16 too - the special-case in
_TIF_ALLWORK_MASK looks odd.

