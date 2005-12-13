Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932618AbVLMXLx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932618AbVLMXLx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 18:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932620AbVLMXLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 18:11:52 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:32680 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932618AbVLMXLv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 18:11:51 -0500
Subject: Re: [ckrm-tech] Re: [Lse-tech] [RFC][Patch 1/5] nanosecond
	timestamps and diffs
From: Matt Helsley <matthltc@us.ibm.com>
To: Jay Lan <jlan@engr.sgi.com>
Cc: john stultz <johnstul@us.ibm.com>, Shailabh Nagar <nagar@watson.ibm.com>,
       Christoph Lameter <clameter@engr.sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       lse-tech@lists.sourceforge.net,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Jay Lan <jlan@sgi.com>, Jens Axboe <axboe@suse.de>
In-Reply-To: <439F1455.7080402@engr.sgi.com>
References: <43975D45.3080801@watson.ibm.com>
	 <43975E6D.9000301@watson.ibm.com>
	 <Pine.LNX.4.62.0512121049400.14868@schroedinger.engr.sgi.com>
	 <439DD01A.2060803@watson.ibm.com>
	 <1134416962.14627.7.camel@cog.beaverton.ibm.com>
	 <439F1455.7080402@engr.sgi.com>
Content-Type: text/plain
Date: Tue, 13 Dec 2005 15:05:59 -0800
Message-Id: <1134515159.6617.196.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-13 at 10:35 -0800, Jay Lan wrote:
> john stultz wrote:
> > On Mon, 2005-12-12 at 19:31 +0000, Shailabh Nagar wrote:
> > 
> >>Christoph Lameter wrote:
> >>
> >>>On Wed, 7 Dec 2005, Shailabh Nagar wrote:
> >>>
> >>>
> >>>
> >>>>+void getnstimestamp(struct timespec *ts)
> >>>
> >>>
> >>>There is already getnstimeofday in the kernel.
> >>>
> >>
> >>Yes, and that function is being used within the getnstimestamp() being proposed.
> >>However, John Stultz had advised that getnstimeofday could get affected by calls to
> >>settimeofday and had recommended adjusting the getnstimeofday value with wall_to_monotonic.
> >>
> >>John, could you elaborate ?
> > 
> > 
> > I think you pretty well have it covered. 
> > 
> > getnstimeofday + wall_to_monotonic should be higher-res and more
> > reliable (then TSC based sched_clock(), for example) for getting a
> > timestamp.
> 
> How is this proposed function different from
> do_posix_clock_monotonic_gettime()?
> It calls getnstimeofday(), it also adjusts with wall_to_monotinic.
> 
> It seems to me we just need to EXPORT_SYMBOL_GPL the
> do_posix_clock_monotonic_gettime()?
> 
> Thanks,
>   - jay

Ah, yes. I should've searched for gettime rather than gettimeofday when
I was looking for a suitable function.

Two minor differences exist:

1) getnstimestamp does not fetch an unused copy of jiffies_64
2) getnstimestamp uses and advertises an explicit maximum resolution

	I don't think either of these really matter so I'll post a series of
patches:

1) EXPORTing (_SYMBOL_GPL) do_posix_clock_monotonic_gettime()
2) using do_posix_clock_monotonic_gettime() as a timestamp
3) removing getnstimestamp()

Thanks,
	-Matt Helsley

