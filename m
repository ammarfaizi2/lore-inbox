Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262044AbTCQHef>; Mon, 17 Mar 2003 02:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262062AbTCQHef>; Mon, 17 Mar 2003 02:34:35 -0500
Received: from proxy.povodiodry.cz ([62.77.115.11]:39608 "HELO pc11.op.pod.cz")
	by vger.kernel.org with SMTP id <S262044AbTCQHee>;
	Mon, 17 Mar 2003 02:34:34 -0500
From: "Vitezslav Samel" <samel@mail.cz>
Date: Mon, 17 Mar 2003 08:45:26 +0100
To: Matthew Wilcox <willy@debian.org>
Cc: Eric Piel <Eric.Piel@Bull.Net>, davidm@hpl.hp.com,
       linux-ia64@linuxia64.org, linux-kernel@vger.kernel.org
Subject: Re: [Linux-ia64] Re: [BUG] nanosleep() granularity bumps up in 2.5.64 (was: [PATCH] settimeofday() not synchronised with gettimeofday())
Message-ID: <20030317074526.GA21969@pc11.op.pod.cz>
Mail-Followup-To: Matthew Wilcox <willy@debian.org>,
	Eric Piel <Eric.Piel@Bull.Net>, davidm@hpl.hp.com,
	linux-ia64@linuxia64.org, linux-kernel@vger.kernel.org
References: <3E70B797.DFC260B@Bull.Net> <15984.58358.499539.299000@napali.hpl.hp.com> <3E71E87C.10CBC8F7@Bull.Net> <20030314144859.GJ29631@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030314144859.GJ29631@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 14, 2003 at 02:48:59PM +0000, Matthew Wilcox wrote:
> On Fri, Mar 14, 2003 at 03:34:36PM +0100, Eric Piel wrote:
> > I think lines like that from patch-2.5.64 are very suspicious to be
> > related to the bug:
> > +	base->timer_jiffies = INITIAL_JIFFIES;
> > +	base->tv1.index = INITIAL_JIFFIES & TVR_MASK;
> > +	base->tv2.index = (INITIAL_JIFFIES >> TVR_BITS) & TVN_MASK;
> > +	base->tv3.index = (INITIAL_JIFFIES >> (TVR_BITS+TVN_BITS)) & TVN_MASK;
> > +	base->tv4.index = (INITIAL_JIFFIES >> (TVR_BITS+2*TVN_BITS)) &
> > TVN_MASK;
> > +	base->tv5.index = (INITIAL_JIFFIES >> (TVR_BITS+3*TVN_BITS)) &
> > TVN_MASK;
> 
> No, I don't think so.  Those lines are for starting `jiffies' at a very
> high number so we spot jiffie-wrap bugs early on.

  The nanosleep() bug narrowed down to 2.5.63-bk2. That's version, the "initial
jiffies" patch went in. And yes, it's on i686 machine.

	Cheers,
		Vita
