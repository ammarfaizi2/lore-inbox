Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263353AbTCNOiT>; Fri, 14 Mar 2003 09:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263355AbTCNOiT>; Fri, 14 Mar 2003 09:38:19 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37338 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263353AbTCNOiS>;
	Fri, 14 Mar 2003 09:38:18 -0500
Date: Fri, 14 Mar 2003 14:48:59 +0000
From: Matthew Wilcox <willy@debian.org>
To: Eric Piel <Eric.Piel@Bull.Net>
Cc: davidm@hpl.hp.com, linux-ia64@linuxia64.org, linux-kernel@vger.kernel.org,
       Vitezslav Samel <samel@mail.cz>
Subject: Re: [Linux-ia64] Re: [BUG] nanosleep() granularity bumps up in 2.5.64 (was: [PATCH] settimeofday() not synchronised with gettimeofday())
Message-ID: <20030314144859.GJ29631@parcelfarce.linux.theplanet.co.uk>
References: <3E70B797.DFC260B@Bull.Net> <15984.58358.499539.299000@napali.hpl.hp.com> <3E71E87C.10CBC8F7@Bull.Net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E71E87C.10CBC8F7@Bull.Net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 14, 2003 at 03:34:36PM +0100, Eric Piel wrote:
> I think lines like that from patch-2.5.64 are very suspicious to be
> related to the bug:
> +	base->timer_jiffies = INITIAL_JIFFIES;
> +	base->tv1.index = INITIAL_JIFFIES & TVR_MASK;
> +	base->tv2.index = (INITIAL_JIFFIES >> TVR_BITS) & TVN_MASK;
> +	base->tv3.index = (INITIAL_JIFFIES >> (TVR_BITS+TVN_BITS)) & TVN_MASK;
> +	base->tv4.index = (INITIAL_JIFFIES >> (TVR_BITS+2*TVN_BITS)) &
> TVN_MASK;
> +	base->tv5.index = (INITIAL_JIFFIES >> (TVR_BITS+3*TVN_BITS)) &
> TVN_MASK;

No, I don't think so.  Those lines are for starting `jiffies' at a very
high number so we spot jiffie-wrap bugs early on.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
