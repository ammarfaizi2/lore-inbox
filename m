Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbWA1W7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWA1W7V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 17:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbWA1W7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 17:59:21 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:46800 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750776AbWA1W7V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 17:59:21 -0500
Date: Sat, 28 Jan 2006 23:59:07 +0100
From: Pavel Machek <pavel@suse.cz>
To: Sridhar Samudrala <sri@us.ibm.com>
Cc: Matthew Dobson <colpatch@us.ibm.com>, Paul Jackson <pj@sgi.com>,
       clameter@engr.sgi.com, linux-kernel@vger.kernel.org, andrea@suse.de,
       linux-mm@kvack.org
Subject: Re: [patch 3/9] mempool - Make mempools NUMA aware
Message-ID: <20060128225907.GA1612@elf.ucw.cz>
References: <Pine.LNX.4.62.0601261525570.18810@schroedinger.engr.sgi.com> <43D96633.4080900@us.ibm.com> <Pine.LNX.4.62.0601261619030.19029@schroedinger.engr.sgi.com> <43D96A93.9000600@us.ibm.com> <20060127025126.c95f8002.pj@sgi.com> <43DAC222.4060805@us.ibm.com> <20060128081641.GB1605@elf.ucw.cz> <43DB9877.7020206@us.ibm.com> <20060128164158.GD1858@elf.ucw.cz> <43DBA1A0.6010708@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43DBA1A0.6010708@us.ibm.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >If sending routines can work with constant ammount of memory, why use
> >kmalloc at all? Anyway I thought we were talking receiving side
> >earlier in the thread.
> >
> >Ouch and wait a moment. You claim that GFP_KERNEL allocations can't
> >block/sleep? Of course they can, that's why they are GFP_KERNEL and
> >not GFP_ATOMIC.
> >  
> I didn't meant GFP_KERNEL allocations cannot block/sleep? When in 
> emergency, we
> want even the GFP_KERNEL allocations that are made by critical sockets 
> not to block/sleep.
> So my original critical sockets patches changes the gfp flag passed to 
> these allocation requests
> to GFP_KERNEL|GFP_CRITICAL.

Could we get description of what you are really trying to achieve?
I don't know what "critical socket" is, when you are "in emergency",
etc. When I am in emergency, I just dial 112...

[Having enough memory on the send side will not mean you'll be able to
send data at TCP layer.]

You seem to have some rather strange needs, that are maybe best served
by s/GFP_KERNEL/GFP_ATOMIC/ in network layer; but we can't / don't
want to do that in vanilla kernel -- your case is too specialized for
that. (Ouch and it does not work anyway without rewriting network
stack...)
								Pavel
-- 
Thanks, Sharp!
