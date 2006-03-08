Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751013AbWCHVGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbWCHVGr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 16:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbWCHVGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 16:06:47 -0500
Received: from ns1.siteground.net ([207.218.208.2]:45256 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1750992AbWCHVGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 16:06:46 -0500
Date: Wed, 8 Mar 2006 13:07:26 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       davem@davemloft.net, netdev@vger.kernel.org, shai@scalex86.org
Subject: Re: [patch 1/4] net: percpufy frequently used vars -- add percpu_counter_mod_bh
Message-ID: <20060308210726.GD4493@localhost.localdomain>
References: <20060308015808.GA9062@localhost.localdomain> <20060308015934.GB9062@localhost.localdomain> <20060307181301.4dd6aa96.akpm@osdl.org> <20060308202656.GA4493@localhost.localdomain> <20060308203642.GZ5410@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060308203642.GZ5410@kvack.org>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2006 at 03:36:42PM -0500, Benjamin LaHaise wrote:
> On Wed, Mar 08, 2006 at 12:26:56PM -0800, Ravikiran G Thirumalai wrote:
> > +static inline void percpu_counter_mod_bh(struct percpu_counter *fbc, long amount)
> > +{
> > +	local_bh_disable();
> > +	fbc->count += amount;
> > +	local_bh_enable();
> > +}
> 
> Please use local_t instead, then you don't have to do the local_bh_disable() 
> and enable() and the whole thing collapses down into 1 instruction on x86.

But on non x86, local_bh_disable() is gonna be cheaper than a cli/atomic op no?
(Even if they were switched over to do local_irq_save() and
local_irq_restore() from atomic_t's that is).

And if we use local_t, we will add the overhead for the non bh 
percpu_counter_mod for non x86 arches.

Thanks,
Kiran
