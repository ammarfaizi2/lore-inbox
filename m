Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264925AbTA2G5Y>; Wed, 29 Jan 2003 01:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264920AbTA2G5Y>; Wed, 29 Jan 2003 01:57:24 -0500
Received: from are.twiddle.net ([64.81.246.98]:28549 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S264925AbTA2G5X>;
	Wed, 29 Jan 2003 01:57:23 -0500
Date: Tue, 28 Jan 2003 23:06:39 -0800
From: Richard Henderson <rth@twiddle.net>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrea Arcangeli <andrea@suse.de>,
       Andrew Morton <akpm@digeo.com>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (1/4) 2.5.59 fast reader/writer lock for gettimeofday
Message-ID: <20030128230639.A17385@twiddle.net>
Mail-Followup-To: Stephen Hemminger <shemminger@osdl.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@digeo.com>,
	Andi Kleen <ak@suse.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1043797341.10150.300.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1043797341.10150.300.camel@dell_ss3.pdx.osdl.net>; from shemminger@osdl.org on Tue, Jan 28, 2003 at 03:42:21PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2003 at 03:42:21PM -0800, Stephen Hemminger wrote:
> +static inline void fr_write_begin(frlock_t *rw)
> +{
> +	preempt_disable();
> +	rw->pre_sequence++;
> +	wmb();
> +}
> +
> +static inline void fr_write_end(frlock_t *rw)
> +{
> +	wmb();
> +	rw->post_sequence++;

These need to be mb(), not wmb(), if you want the bits in between
to actually happen in between, as with your xtime example.  At
present there's nothing stoping xtime from being *read* before
your read from pre_sequence happens.


r~
