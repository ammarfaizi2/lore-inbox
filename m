Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbVAMGg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVAMGg2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 01:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbVAMGg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 01:36:28 -0500
Received: from waste.org ([216.27.176.166]:28802 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261170AbVAMGgN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 01:36:13 -0500
Date: Wed, 12 Jan 2005 22:34:46 -0800
From: Matt Mackall <mpm@selenic.com>
To: "Jack O'Quin" <joq@io.com>
Cc: Ingo Molnar <mingo@elte.hu>, Chris Wright <chrisw@osdl.org>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>, arjanv@redhat.com,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050113063446.GV2940@waste.org>
References: <20050110212019.GG2995@waste.org> <200501111305.j0BD58U2000483@localhost.localdomain> <20050111191701.GT2940@waste.org> <20050111125008.K10567@build.pdx.osdl.net> <20050111205809.GB21308@elte.hu> <20050111131400.L10567@build.pdx.osdl.net> <20050111212719.GA23477@elte.hu> <87fz15j325.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fz15j325.fsf@sulphur.joq.us>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2005 at 11:44:34PM -0600, Jack O'Quin wrote:
> 
> One major problem: this `nice --20' hack affects every thread, not
> just the critical realtime ones.  That's not what we want.  Audio
> applications make very conscious choices which threads run with high
> priority and which do not.

I don't think it was intended as a final solution but rather as a
feasibility experiment.

> Plus, we maintain JACK for several platforms including GNU/Linux,
> FreeBSD, and Mac OS X.  IRIX support is planned soon, possibly Solaris
> some day.  I would really prefer for Linux to support genuine POSIX
> realtime with SCHED_FIFO scheduling.  Since that is our primary
> development platform, it makes our code a lot more portable.

Good realtime support is looking like a certainty at this point,
though it may take a while for all the bits to be fully merged.
 
> And, this is not just about JACK.  We could change to call nice()
> instead of pthread_setschedparam() on Linux, but that about all the
> other audio applications?  I don't think this is a reasonable thing to
> ask of people.  It would take a year just to get them all changed,
> like herding cats.

If we can get high priority SCHED_OTHER working sufficiently well,
that will be preferable in the long run as the security implications
are slightly less dire. It's already been noted that it doesn't solve
your privilege problem, but it's still interesting to us because it
has potential to address the deadlock issue.

Doesn't mean you have to use it (though you'll probably want to give
your users the option).

> This whole approach seems like a "dry well" to me.

It may turn out to be. Please continue testing it though - you've got
a good test case handy.

> Tomorrow, I'll try the test again after making a new kernel with
> STARVATION_LIMIT set to zero.  
> 
> Anything else I should try?

Testing feedback on the bits from Ingo that have gone to -mm will
probably help speed their acceptance in mainline.

-- 
Mathematics is the supreme nostalgia of our time.
