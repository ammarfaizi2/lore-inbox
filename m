Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751472AbWA1QmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbWA1QmH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 11:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbWA1QmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 11:42:07 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:11210 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751472AbWA1QmG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 11:42:06 -0500
Date: Sat, 28 Jan 2006 17:41:58 +0100
From: Pavel Machek <pavel@suse.cz>
To: Sridhar Samudrala <sri@us.ibm.com>
Cc: Matthew Dobson <colpatch@us.ibm.com>, Paul Jackson <pj@sgi.com>,
       clameter@engr.sgi.com, linux-kernel@vger.kernel.org, andrea@suse.de,
       linux-mm@kvack.org
Subject: Re: [patch 3/9] mempool - Make mempools NUMA aware
Message-ID: <20060128164158.GD1858@elf.ucw.cz>
References: <Pine.LNX.4.62.0601261511520.18716@schroedinger.engr.sgi.com> <43D95A2E.4020002@us.ibm.com> <Pine.LNX.4.62.0601261525570.18810@schroedinger.engr.sgi.com> <43D96633.4080900@us.ibm.com> <Pine.LNX.4.62.0601261619030.19029@schroedinger.engr.sgi.com> <43D96A93.9000600@us.ibm.com> <20060127025126.c95f8002.pj@sgi.com> <43DAC222.4060805@us.ibm.com> <20060128081641.GB1605@elf.ucw.cz> <43DB9877.7020206@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43DB9877.7020206@us.ibm.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>I still think some sort of reserve pool
> >>is necessary to give the networking stack a little breathing room when
> >>under both memory pressure and network load.
> >>    
> >
> >"Lets throw some memory there and hope it does some good?" Eek? What
> >about auditing/fixing the networking stack, instead?
> >  
> The other reason we need a separate critical pool is to satifsy critical 
> GFP_KERNEL allocations
> when we are in emergency. These are made in the send side and we cannot 
> block/sleep.

If sending routines can work with constant ammount of memory, why use
kmalloc at all? Anyway I thought we were talking receiving side
earlier in the thread.

Ouch and wait a moment. You claim that GFP_KERNEL allocations can't
block/sleep? Of course they can, that's why they are GFP_KERNEL and
not GFP_ATOMIC.
								Pavel
-- 
Thanks, Sharp!
