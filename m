Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262593AbVA0M17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262593AbVA0M17 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 07:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262596AbVA0M17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 07:27:59 -0500
Received: from colin2.muc.de ([193.149.48.15]:61456 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262593AbVA0M15 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 07:27:57 -0500
Date: 27 Jan 2005 13:27:56 +0100
Date: Thu, 27 Jan 2005 13:27:56 +0100
From: Andi Kleen <ak@muc.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch 2/6 introduce helper infrastructure
Message-ID: <20050127122756.GA48931@muc.de>
References: <20050127101117.GA9760@infradead.org> <20050127101228.GC9760@infradead.org> <m1is5j40iq.fsf@muc.de> <20050127115829.GB10237@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050127115829.GB10237@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 11:58:29AM +0000, Arjan van de Ven wrote:
> On Thu, Jan 27, 2005 at 11:41:33AM +0100, Andi Kleen wrote:
> > Arjan van de Ven <arjan@infradead.org> writes:
> > > +unsigned int get_random_int(void)
> > > +{
> > > +	static unsigned int val = 0;
> > > +
> > > +	val += current->pid + jiffies;
> > 
> > Shouldn't there be some kind of locking for this? It's random,
> > but still random corruption sounds a bit too random.
> > 
> > Also you probably have a very hot cache line here, which
> > may hurt on the bigger machines.
> 
> 
> actually the static was ther from a previous revision where the ip rng was
> compiled out at times so it needed some RNG characteristic. Patch below just
> removes the static; it's good enough.

I guess the per MM prng would be still faster, but it's probably
not worth tweaking unless it shows up as a problem.

> +	if (end <= start + len)
> +		return 0;
> +	return PAGE_ALIGN(get_random_int() % range + start);

Division through variable is often quite slow, it would be good if you
avoided it somehow.

-Andi
