Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262310AbTD3S5a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 14:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262318AbTD3S5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 14:57:30 -0400
Received: from mx12.arcor-online.net ([151.189.8.88]:41193 "EHLO
	mx12.arcor-online.net") by vger.kernel.org with ESMTP
	id S262310AbTD3S53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 14:57:29 -0400
From: Daniel Phillips <dphillips@sistina.com>
Reply-To: dphillips@sistina.com
Organization: Sistina
To: Linus Torvalds <torvalds@transmeta.com>,
       Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>
Subject: Re: [RFC][PATCH] Faster generic_fls
Date: Wed, 30 Apr 2003 21:15:33 +0200
User-Agent: KMail/1.5.1
Cc: <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0304300709300.7157-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0304300709300.7157-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304302115.33424.dphillips@sistina.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 April 2003 16:11, Linus Torvalds wrote:
> On 30 Apr 2003, Falk Hueffner wrote:
> > gcc 3.4 will have a __builtin_ctz function which can be used for this.
> > It will emit special instructions on CPUs that support it (i386, Alpha
> > EV67), and use a lookup table on others, which is very boring, but
> > also faster.
>
> Classic mistake. Lookup tables are only faster in benchmarks, they are
> almost always slower in real life. You only need to miss in the cache
> _once_ on the lookup to lose all the time you won on the previous one
> hundred calls.
>
> "Small and simple" is almost always better than the alternatives. I
> suspect that's one reason why older versions of gcc often generate code
> that actually runs faster than newer versions: the newer versions _look_
> like they do a better job, but..

I agree that this one lies in a gray area, being linearly faster (PIV 
notwithwstanding) but bigger too.

In the dawn of time, before God gave us Cache, my version would have been the 
fastest, because it executes the fewest instructions.  In the misty future, 
as cache continues to scale and processors sprout more parallel execution 
units, it will be clearly better once again.  For now, it's marginal, and 
after all, what's a factor of two between friends?

Regards,

Daniel
