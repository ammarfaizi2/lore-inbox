Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751618AbWCGU6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618AbWCGU6T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 15:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751626AbWCGU6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 15:58:18 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:31697 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751526AbWCGU6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 15:58:18 -0500
Date: Tue, 7 Mar 2006 14:58:01 -0600
From: Jack Steiner <steiner@sgi.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] - Allocate larger cache_cache if order 0 fails
Message-ID: <20060307205801.GA12136@sgi.com>
References: <20060307154805.GA3474@sgi.com> <84144f020603071136m21782038n8951c801627ae867@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84144f020603071136m21782038n8951c801627ae867@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2006 at 09:36:04PM +0200, Pekka Enberg wrote:
> Hi Jack,
> 
> On 3/7/06, Jack Steiner <steiner@sgi.com> wrote:
> > -       cache_estimate(0, cache_cache.buffer_size, cache_line_size(), 0,
> > -                      &left_over, &cache_cache.num);
> > +       for (order = 0; order < MAX_ORDER; order++) {
> > +               cache_estimate(order, cache_cache.buffer_size, cache_line_size(), 0,
> > +                       &left_over, &cache_cache.num);
> > +               if (cache_cache.num)
> > +                       break;
> > +       }
> 
> Any reason why you can't use calculate_slab_order() here?
> 
>                                    Pekka

I think either will work & the amount of code is about the same. 

I chose the above because it was easier to see that change had no effect 
on existing platforms.

Does anyone see a compelling reason for a different but equivalent implementation??

---
Jack
